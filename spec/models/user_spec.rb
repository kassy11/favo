require 'rails_helper'

describe User do
  it 'is valid with name, email and password' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without name'
  it 'is invalid without email'
  it 'is invalid without password'
  it 'is invalid with duplicate email'
end