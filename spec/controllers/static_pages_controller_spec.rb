# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe '#home' do
    context 'as an authorized user' do
      before do
        @user = create(:user)
      end

      # rspecのバグでbe_successが使えないようなので一旦pending
      xit 'response successfully' do
        sign_in @user
        get :home
        expect(response).to be_successful
      end

      it 'return a 302 response' do
        sign_in @user
        get :home
        expect(response).to have_http_status '302'
      end

      it 'redirect to user_path' do
        sign_in @user
        get :home
        expect(response).to redirect_to user_path(@user)
      end
    end

    context 'as a guest' do
      xit 'response successfully' do
        get :home
        expect(response).to be_successful
      end

      it 'return a 200 response' do
        get :home
        expect(response).to have_http_status '200'
      end
    end
  end
end
