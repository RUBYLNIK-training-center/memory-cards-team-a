require 'rails_helper'

RSpec.describe ImportsController, type: :controller do
  let(:user) do
    User.create(email: 'test@example.com', name: 'Test', surname: 'Tester', password: '123456',
                password_confirmation: '123456')
  end

  let(:correct_file) do
    fixture_file_upload(Rails.root.join("tmp/test.csv"), 'text/csv')
  end

  let(:incorrect_file) do
    fixture_file_upload(Rails.root.join("tmp/test2.csv"), 'text/csv')
  end
  
  before do
    sign_in user
  end

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

  describe "GET index" do
    it "returns a successful response" do
      get :index
      expect(response).to be_successful
    end
 
    it "assigns @imports" do
      upload = blob_for('test.csv')
      import = Import.create(user_id: user.id, file: upload)
      get :index
      expect(assigns(:imports)).to eq([import])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET show" do
    it "renders the show template" do
      upload = blob_for('test.csv')
      import = Import.create(user_id: user.id, file: upload)
      get :show, params: { id: import.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "GET edit" do
    it "renders the edit template" do
      upload = blob_for('test.csv')
      import = Import.create(user_id: user.id, file: upload)
      get :edit, params: { id: import.id }
      expect(response).to render_template(:edit)
    end
  end

  describe "POST create" do
    context 'with valid structure of csv' do
      it "creates new import" do
        expect{
          post :create, params: { :import => { user_id: user.id, file: correct_file } }
        }.to change(Import, :count).by(1)
      end
    end

    context 'with inalid structure of csv' do
      it 'redirects to imports path' do
        expect(
          post :create, params: { :import => { user_id: user.id, file: incorrect_file } }
        ).to redirect_to(imports_url)
      end
    end

    context 'with incorrect params' do
      it "renders the new template" do
        expect(
          post :create, params: { :import => { user_id: User.last.id + 1, file: correct_file } }
        ).to render_template(:new)
      end
    end
  end

  describe "PUTCH update" do
    it "updates import" do
      upload = blob_for('test.csv')
      import = Import.create(user_id: user.id, file: upload)
      expect(
        patch :update, params: { id: import.id, :import => { user_id: user.id, file: correct_file } }
      ).to redirect_to :action => :show, :id => assigns(:import).id
    end

    context 'with incorrect params' do
      it "renders the edit template" do
        upload = blob_for('test.csv')
        import = Import.create(user_id: user.id, file: upload)
        expect(
          patch :update, params: { id: import.id, :import => { user_id: User.last.id + 1, file: correct_file } }
        ).to render_template(:edit)
      end
    end
  end

  describe "DELETE import" do
    it "removes import" do
      upload = blob_for('test.csv')
      import = Import.create(user_id: user.id, file: upload)
      expect{
        delete :destroy, params: { id: import.id }
      }.to change(Import, :count).by(-1)
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