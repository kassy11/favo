# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Movies', type: :feature do
  scenario 'user search movies and creates a new movie favorite' do
    user = create(:user)
    sign_in user
    visit root_path
    expect{
      within '.movie-fav-btns' do
        click_link('追加する')
      end

      fill_in 'search-form-id', with: 'ドラえもん'
      click_button '検索'

      expect(page).to have_content('ドラえもんの検索結果')
      first(".list-btns").click_link('詳細')
      expect(page).to have_content('ジャンル')
      click_link('リストに追加する')

    }.to change(user.movies, :count).by(1)

  end
end
