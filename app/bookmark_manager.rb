require 'sinatra/base'
require_relative 'models/link'

class BookmarkManager < Sinatra::Base

  get '/' do
    @links = Link.all
    erb :links
  end

  get '/new-bookmark' do
    erb :new 
  end

  post '/links' do
    title = params['title']
    url = params['url']
    Link.create(url: url, title: title)
    redirect '/'
  end
end
