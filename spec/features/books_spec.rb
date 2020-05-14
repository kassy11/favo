# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Books', type: :feature do
  scenario 'user search books and creates a new book favorite' do
    user = create(:user)

    visit root_path
    click_link 'ログイン'
    fill_in 'Eメール', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'

    expect{
      within '.book-fav-btns' do
        click_link('追加する')
      end

      fill_in 'search-form-id', with: '村上春樹'
      click_button '検索'

      expect(page).to have_content('村上春樹の検索結果')
      first(".list-btns").click_link('詳細')
      expect(page).to have_content('著者')
      click_link('リストに追加する')

    }.to change(user.books, :count).by(1)

  end
end
