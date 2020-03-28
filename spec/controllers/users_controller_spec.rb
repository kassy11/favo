# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
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

  describe '#show' do
    context 'as an authorized user' do
      include_context 'as an authorized user'

      xit 'response successfully' do
        sign_in user
        get :show, params: { id: user.id }
        expect(response).to be_success
      end

      it 'return a 200 response' do
        sign_in user
        get :show, params: { id: user.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'as an unauthorized user' do
      include_context 'as an unauthorized user'

      xit 'response successfully' do
        sign_in user
        get :show, params: { id: other_user.id }
        expect(response).to be_success
      end

      it 'return a 200 response' do
        sign_in user
        get :show, params: { id: other_user.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      include_context 'as a guest'

      xit 'response successfully' do
        get :show, params: { id: user.id }
        expect(response).to be_success
      end

      it 'return a 200 response' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status '200'
      end
    end
  end

  describe '#music_index' do
    context 'as an authorized user' do
      include_context 'as an authorized user'

      xit 'response successfully' do
        sign_in user
        get :music_index, params: { id: user.id }
        expect(response).to be_success
      end

      it 'return a 200 response' do
        sign_in user
        get :music_index, params: { id: user.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'as an unauthorized user' do
      include_context 'as an unauthorized user'

      xit 'response successfully' do
        sign_in user
        get :music_index, params: { id: other_user.id }
        expect(response).to be_success
      end

      it 'return a 200 response' do
        sign_in user
        get :music_index, params: { id: other_user.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      include_context 'as a guest'

      xit 'response successfully' do
        get :music_index, params: { id: user.id }
        expect(response).to be_success
      end
    end
  end

  describe '#movie_index' do
    context 'as an authorized user' do
      include_context 'as an authorized user'

      xit 'response successfully' do
        sign_in user
        get :movie_index, params: { id: user.id }
        expect(response).to be_success
      end

      it 'return a 200 response' do
        sign_in user
        get :movie_index, params: { id: user.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'as an unauthorized user' do
      include_context 'as an unauthorized user'

      xit 'response successfully' do
        sign_in user
        get :movie_index, params: { id: other_user.id }
        expect(response).to be_success
      end

      it 'return a 200 response' do
        sign_in user
        get :movie_index, params: { id: other_user.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      include_context 'as a guest'

      xit 'response successfully' do
        get :movie_index, params: { id: user.id }
        expect(response).to be_success
      end
    end
  end

  describe 'book_index' do
    context 'as an authorized user' do
      include_context 'as an authorized user'

      xit 'response successfully' do
        sign_in user
        get :book_index, params: { id: user.id }
        expect(response).to be_success
      end

      it 'return a 200 response' do
        sign_in user
        get :book_index, params: { id: user.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'as an unauthorized user' do
      include_context 'as an unauthorized user'

      xit 'response successfully' do
        sign_in user
        get :book_index, params: { id: other_user.id }
        expect(response).to be_success
      end

      it 'return a 200 response' do
        sign_in user
        get :book_index, params: { id: other_user.id }
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      include_context 'as a guest'

      xit 'response successfully' do
        get :book_index, params: { id: user.id }
        expect(response).to be_success
      end
    end
  end
end
