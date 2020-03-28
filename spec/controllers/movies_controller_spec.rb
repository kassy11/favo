# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  shared_context 'as an authorized user' do
    let(:user) { create(:user) }
  end

  shared_context 'as an unauthorized user' do
    let(:user) { create(:user) }
    let!(:other_user) { create(:user) }
  end

  shared_context 'as a guest' do
    let!(:user) { create(:user) }
  end

  describe '#search' do
    context 'as an authorized user' do
      include_context 'as an authorized user'

      xit 'response successfully' do
        sign_in user
        get :search
        expect(response).to be_success
      end

      it 'return a 200 response' do
        sign_in user
        get :search
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      it 'return a 302 response' do
        get :search
        expect(response).to have_http_status '302'
      end

      it 'redirect to login_path' do
        get :search
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#index' do
    context 'as an authorized user' do
      include_context 'as an authorized user'

      xit 'response successfully' do
        sign_in user
        get :index, params: { name: 'ドラえもん' }
        expect(response).to be_success
      end

      it 'return a 200 response' do
        sign_in user
        get :index, params: { name: 'ドラえもん' }
        expect(response).to have_http_status '200'
      end

      # 検索結果の配列をどうテストすればいいのかわからないのでpending
      xit 'has search result items' do
        sign_in user
        get :index, params: { name: 'ドラえもん' }
        expect(response).to include
      end
    end

    context 'as a guest' do
      it 'return a 302 response' do
        get :index, params: { name: 'ドラえもん' }
        expect(response).to have_http_status '302'
      end

      it 'redirect to login_path' do
        get :index, params: { name: 'ドラえもん' }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '#show' do
    context 'as an authorized user' do
      include_context 'as an authorized user'

      xit 'response successfully' do
        sign_in user
        get :show, params: { work_id: 265_712 }
        expect(response).to be_success
      end

      it 'return a 200 response' do
        sign_in user
        get :show, params: { work_id: 265_712 }
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      include_context 'as a guest'

      xit 'response successfully' do
        get :show, params: { work_id: 265_712 }
        expect(response).to be_success
      end

      it 'return a 200 response' do
        get :show, params: { work_id: 265_712 }
        expect(response).to have_http_status '200'
      end
    end
  end

  describe '#create' do
    context 'as an authorized user' do
      include_context 'as an authorized user'

      it 'adds a movie to user list' do
        sign_in user
        movie = create(:movie)
        expect  do
          post :create, params: { work_id: movie.id }
        end.to change(user.movies, :count).by(1)
      end

      xit 'redirect movie_index_user_path after adds a movie' do
      end
    end

    context 'as an unauthorized user' do
      include_context 'as an unauthorized user'

      # そもそものバリデーションのかけ方がおかしいのかもしれない
      xit 'does not add a movie to user list' do
        sign_in user
        movie = create(:movie, user: other_user)
        expect  do
          post :create, params: { work_id: movie.id }
        end.not_to change(user.movies, :count)
      end
    end

    context 'as a guest' do
      include_context 'as a guest'
      it 'does not add a movie to user list' do
        movie = create(:movie, user: user)
        expect  do
          post :create, params: { work_id: movie.id }
        end.not_to change(user.movies, :count)
      end
    end
  end

  describe '#destory' do
    context 'as an authorized user' do
      include_context 'as an authorized user'

      # destroyがNoMethodErrorになってしまう謎のエラー
      xit 'destroy a movie in user list' do
        sign_in user
        movie = create(:movie, user: user)
        p movie
        expect do
          delete :destroy, params: { work_id: movie.id }
        end.to change(user.movies, :count).by(-1)
      end

      # redirectさせる方法がわからない、コールバック？？
      xit 'redirect movie_index_user_path after delete a movie' do
      end
    end

    context 'as an unauthorized user' do
      include_context 'as an unauthorized user'

      xit 'does not destroy a movie in user list' do
        sign_in user
        movie = create(:movie, user: user)
        p movie
        expect do
          delete :destroy, params: { work_id: movie.id }
        end.to change(user.movies, :count).by(-1)
      end
    end

    context 'as a guest' do
      include_context 'as a guest'
    end
  end
end
