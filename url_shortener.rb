require 'bitly'

class UrlShortener
  def initialize
    Bitly.use_api_version_3
    @bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
  end

  def shorten(original_url)
    @bitly.shorten(original_url).short_url
  end
end
