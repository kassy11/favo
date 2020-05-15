# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  scenario 'create new user with email and password' do
    visit root_path
    click_link '新規登録'
    expect do
      fill_in '名前', with: '孫悟空'
      fill_in 'Eメール', with: 'kotaro11kassy@gmail.com'
      fill_in 'パスワード', with: 'kotarotest11'
      fill_in 'パスワード確認', with: 'kotarotest11'
      click_button '新規登録'
    end.to change(User, :count).by(1)
    expect(page).to have_content('孫悟空')
  end

  # TODO: やり方がわからないので飛ばす（モック使う？？）
  xit 'create new user with twitter account' do
  end

  scenario 'view my fav list' do
    user = create(:user)
    sign_in user
    visit root_path
    expect(page).to have_content(user.name)
  end

  scenario 'view other users fav list' do
    user = create(:user)
    other_user = create(:user)
    sign_in user
    visit root_path
    visit user_path(other_user)
    expect(page).to have_content(other_user.name)
  end
end
