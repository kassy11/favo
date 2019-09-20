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
      reverse: true,
      separator: '|',
      og: defalut_og,
      twitter: default_twitter_card
    }
  end

  private

  def defalut_og
    {
      title: :full_title,         
      description: :description,   
      url: request.url,
      image: 'https://example.com/hoge.png'
    }
  end

  def default_twitter_card
    {
      card: 'summary_large_image', 
      site: '@hogehoge'            
    }
  end
end
