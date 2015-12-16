ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'models/link'

class BookmarkManager < Sinatra::Base

  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb :links
  end

  get '/links/new' do
    erb :new 
  end

  post '/links' do
    title = params['title']
    url = params['url']
    Link.create(url: url, title: title)
    redirect '/links'
  end
end
