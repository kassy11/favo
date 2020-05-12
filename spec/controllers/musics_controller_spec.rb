require 'rails_helper'

RSpec.describe MusicsController, type: :controller do
  shared_context 'as an authorized user' do
    let(:user) { create(:user) }
  end

  shared_context 'as an unauthorized user' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }
  end

  shared_context 'as a guest' do
    let!(:user) { create(:user) }
  end

  describe '#index' do

  end

  describe '#create' do

  end

  describe '#destroy' do

  end

  describe '#show' do
    context 'as an authorized user' do
      include_context 'as an authorized user'
      ## ここでRSpotifyの認証エラーになってしまう
      xit 'response successfully' do
        sign_in user
        get :show, params: {work_id: "2kQnsbKnIiMahOetwlfcaS".to_i }
        expect(response).to be_successful
      end

      xit 'return a 200 response' do
        sign_in user
        get :show, params: {work_id: "2kQnsbKnIiMahOetwlfcaS"}
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      include_context 'as a guest'
      xit 'response successfully' do
        get :show, params: { work_id: "2kQnsbKnIiMahOetwlfcaS"}
        expect(response).to be_successful
      end

      xit 'return a 200 response' do
        get :show, params: { work_id: "2kQnsbKnIiMahOetwlfcaS"}
        expect(response).to have_http_status '200'
      end
    end
  end

  describe '#search' do
    context 'as an authorized user' do
      include_context 'as an authorized user'

      xit 'response successfully' do
        sign_in user
        get :search
        expect(response).to be_successful
      end

      it 'return a 200 response' do
        sign_in user
        get :search
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      xit 'redirect to new_user_session_path' do
        get :search
        expect(response).to redirect_to new_user_session_path
      end

      it 'return a 302 response' do
        get :search
        expect(response).to have_http_status '302'
      end
    end
  end
end