# frozen_string_literal: true

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

  shared_context 'as an authorized user who has fav list' do
    let(:user) { create(:user, :with_fav_musics) }
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
        get :index, params: { name: 'oasis' }
        expect(response).to be_success
      end

      it 'return a 200 response' do
        sign_in user
        get :index, params: { name: 'oasis' }
        expect(response).to have_http_status '200'
      end

      # 検索結果の配列をどうテストすればいいのかわからないのでpending
      # TODO:そもそもこれはcontroller specではなくフィーチャースペック（Capybara）でやるのかも
      xit 'has search result items' do
        sign_in user
        get :index, params: { name: 'oasis' }
        expect(response).to
      end
    end

    context 'as a guest' do
      it 'return a 302 response' do
        get :index, params: { name: 'oasis' }
        expect(response).to have_http_status '302'
      end

      it 'redirect to login_path' do
        get :index, params: { name: 'oasis' }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  # TODO: AuthenticationErrorになるため、ここはモック・スタブをつくる
  describe '#show' do
    context 'as an authorized user' do
      include_context 'as an authorized user'

      xit 'response successfully' do
        sign_in user
        get :show, params: { work_id: 'MMh_tgEACAAJ' }
        expect(response).to be_success
      end

      xit 'return a 200 response' do
        sign_in user
        get :show, params: { work_id: 'MMh_tgEACAAJ' }
        expect(response).to have_http_status '200'
      end
    end

    context 'as a guest' do
      xit 'response successfully' do
        get :show, params: { work_id: 265_712 }
        expect(response).to be_success
      end

      xit 'return a 200 response' do
        get :show, params: { work_id: 265_712 }
        expect(response).to have_http_status '200'
      end
    end
  end

  describe '#create' do
    context 'as an authorized user' do
      include_context 'as an authorized user'

      it 'adds an artist to user list' do
        sign_in user
        music = create(:music)
        expect  do
          post :create, params: { work_id: music.artist_id }
        end.to change(user.musics, :count).by(1)
      end

      it 'redirect music_index_user_path after adds an artist' do
        sign_in user
        music = create(:music)
        expect(post(:create, params: { work_id: music.id })).to redirect_to music_index_user_path(user)
      end

      # TODO: これもほぼバリデーションのテストなのでコントローラスペックに書くのは違う気がする
      xit 'cannot add same artists to user list' do
        sign_in user
        music = create(:music)
        post :create, params: { work_id: music.id }
        expect(post(:create, params: { work_id: music.id })).to be_falsey
      end
    end

    context 'as an unauthorized user' do
      include_context 'as an unauthorized user'

      it 'does not add an artist to user list' do
        sign_in user
        music = create(:music)
        expect  do
          post :create, params: { work_id: music.artist_id }
        end.not_to change(other_user.musics, :count)
      end
    end

    context 'as a guest' do
      include_context 'as a guest'
      it 'does not add an artist to user list' do
        music = create(:music, user: user)
        expect  do
          post :create, params: { work_id: music.id }
        end.not_to change(user.musics, :count)
      end
    end
  end

  describe '#destory' do
    context 'as an authorized user who has fav list' do
      include_context 'as an authorized user who has fav list'

      # TODO: destroyがnil呼び出しになってる（作品がないから）問題を解決する
      xit 'destroy an artist in user list' do
        sign_in user
        music = user.musics.first
        expect do
          post :destroy, params: { work_id: music.id }
        end.to change(user.musics, :count).by(-1)
      end

      xit 'redirect music_index_user_path after destroy an artist' do
        sign_in user
        music = create(:music, user: user)
        expect(post(:destroy, params: { work_id: music.id })).to redirect_to music_index_user_path(user)
      end
    end

    context 'as an unauthorized user' do
      include_context 'as an unauthorized user'

      xit 'does not destroy an artist in user list' do
        sign_in user
        music = create(:music, user: user)
        p music
        expect do
          delete :destroy, params: { work_id: music.id }
        end.to change(user.musics, :count).by(-1)
      end
    end

    context 'as a guest' do
      xit 'does not destroy an artist in user list' do
        sign_in user
        music = create(:music, user: user)
        p music
        expect do
          delete :destroy, params: { work_id: music.id }
        end.to change(user.musics, :count).by(-1)
      end
    end
  end
end
