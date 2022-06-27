require 'rails_helper'
include ControllerHelpers

RSpec.describe 'CardImport' do
  let(:user) {validUser}

  let(:file_path) { 'tmp/test.csv' }
  let!(:csv) do
    CSV.open(file_path, 'w') do |csv|
      csv << %w[board_name card_question card_answer]
      csv << ['Ruby', 'What is ruby?', '1']
      csv << ['Ruby', 'What is love?', '2']
    end
  end

  let(:file_path2) { 'tmp/test2.csv' }
  let!(:csv2) do
    CSV.open(file_path2, 'w') do |csv|
      csv << %w[board_name card_question card_answer]
      csv << ['Ruby', 'What is ruby?', '1']
      csv << ['Ruby']
    end
  end

  context 'with file structure matches table schema' do
    it 'creates table rows with csv rows' do
      upload = blob_for('test.csv')
      import_csv = Import.create(user_id: user.id, file: upload)
      CardImport.new(import: import_csv, user: user).call
      expect(Card.find_by(question: 'What is ruby?').answer).to eq '1'
    end

    it 'creates board' do
      upload = blob_for('test.csv')
      import_csv = Import.create(user_id: user.id, file: upload)
      CardImport.new(import: import_csv, user: user).call
      expect(Board.where(name: 'Ruby', user_id: user.id)).to be_present
    end
  end

  context 'with file structure does not match table schema' do
    it 'raise error' do
      upload = blob_for('test2.csv')
      import_csv = Import.create(user_id: user.id, file: upload)
      expect(CardImport.new(import: import_csv, user: user).call).to be(false)
    end
  end

  def blob_for(file)
    upload = ActiveStorage::Blob.create_and_upload!(
      io: File.open(Rails.root.join("tmp/#{file}")),
      filename: file.to_s,
      content_type: 'text/csv'
    )
    ActiveStorage::Blob.find_signed(upload.signed_id, purpose: :blob_id)
    upload
  end
end
