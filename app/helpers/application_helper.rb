module ApplicationHelper
  def find_artist(artist_id)
    RSpotify::Artist.find(artist_id)
  end

  def search_artist(artist_id)
    RSpotify::Artist.search(artist_id)
  end

  def default_meta_tags
    {
      site: 'FAVO',
      title: 'FAVO',
      description: 'FAVOは映画・音楽・書籍のお気に入りリストを作成できるサイトです。TwitterやFacebookなどのSNSであなたのお気に入りリストを共有して趣味をアピールしたり、友達のお気に入りリストを覗いて新たな作品に出会うこともできます。',
      charset: 'utf-8',
      reverse: true,
      icon: image_url('favo_logo.png'),
      noindex: ! Rails.env.production?,
      separator: '|'
    }
  end
end
