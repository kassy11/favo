# frozen_string_literal: true

require 'rails_helper'

describe Music do
  it 'is valid with user_id and artist_id' do
    music = build_stubbed(:music)
    expect(music).to be_valid
  end

  it 'is invalid without artist_id' do
    music = build_stubbed(:music, artist_id: nil)
    music.valid?
    expect(music).to be_invalid
  end

  it 'is invalid without user_id' do
    music = build_stubbed(:music, user_id: nil)
    music.valid?
    expect(music).to be_invalid
  end

  it 'is invalid with duplicate artist_id' do
    music1 = create(:music, artist_id: '24ce8dbd-ce7d-4352-ad3f-7dff62fbf5a9')
    music2 = build_stubbed(:music, artist_id: '24ce8dbd-ce7d-4352-ad3f-7dff62fbf5a9')
    music2.valid?
    expect(music2).to be_invalid
  end
end
