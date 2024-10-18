module Admin::MoviesHelper
  def valid_url?(url)
      url =~ /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/
  end
end
