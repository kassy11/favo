require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "#home" do
    context "as an authenticate user" do
      before do
        @user = create(:user)
      end

      it 'return a 302 response' do
        sign_in @user
        get :home
        expect(response).to have_http_status "302"
      end

      it 'redirect to user_path' do
        sign_in @user
        get :home
        expect(response).to redirect_to user_path(@user)
      end

    end

    context "as a guest" do
      it 'return a 200 response' do
        get :home
        expect(response).to have_http_status "200"
      end
    end

  end
end
