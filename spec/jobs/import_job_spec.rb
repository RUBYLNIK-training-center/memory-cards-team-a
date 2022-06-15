require 'rails_helper'

RSpec.describe ImportJob, :type => :job do
  let(:user) do
    User.create(email: 'test@example.com', name: 'Test', surname: 'Tester', password: '123456',
                password_confirmation: '123456')
  end

  let(:file_path) { 'tmp/test.csv' }
  let(:csv) do
    CSV.open(file_path, 'w') do |csv|
      csv << %w[board_name card_question card_answer]
      csv << ['Ruby', 'What is ruby?', '1']
      csv << ['Ruby', 'What is love?', '2']
    end
  end

  let(:file_path2) { 'tmp/test2.csv' }
  let(:csv2) do
    CSV.open(file_path2, 'w') do |csv|
      csv << %w[board_name card_question card_answer]
      csv << ['Ruby', 'What is ruby?', '1']
      csv << ['Ruby']
    end
  end

  describe "#perform" do
    context 'with file structure matches table schema' do
      it 'returns true' do
        upload = blob_for('test.csv')
        import_csv = Import.create(user_id: user.id, file: upload)
        expect(ImportJob.new.perform(simport: import_csv, suser: user)).to be(true)
      end
    end

    context 'with file structure does not match table schema' do
      it 'returns false' do
        upload = blob_for('test2.csv')
        import_csv = Import.create(user_id: user.id, file: upload)
        expect(ImportJob.new.perform(simport: import_csv, suser: user)).to be(false)
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
end
