# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with name, email and password' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without name' do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors.messages[:name]).to include('が入力されていません。')
  end

  it 'is invalid without email' do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors.messages[:email]).to include('が入力されていません。')
  end

  it 'is invalid without password' do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors.messages[:password]).to include('が入力されていません。')
  end

  it 'is invalid with short password' do
    password_length_bound = 5
    user = build(:user, password: 'a' * password_length_bound)
    user.valid?
    expect(user.errors.messages[:password]).to include('は6文字以上に設定して下さい。')
  end

  it 'is invalid with duplicate email' do
    create(:user, email: 'kotaro11kassy@gmail.com')
    user2 = build(:user, email: 'kotaro11kassy@gmail.com')
    user2.valid?
    expect(user2.errors.messages[:email]).to include('は既に使用されています。')
  end

  it 'is invalid with email without @ mark' do
    user = build(:user, email: 'kotaro11kassygmail.com')
    user.valid?
    expect(user.errors.messages[:email]).to include('は有効でありません。')
  end
end
