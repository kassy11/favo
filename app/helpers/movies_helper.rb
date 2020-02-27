module MoviesHelper
  def set_opt(movie_name)
    opt = {
        q: movie_name + " 予告",
        type: 'video',
        max_results: 3
    }
  end
end
