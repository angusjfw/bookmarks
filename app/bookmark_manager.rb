ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'
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
    erb :new_link
  end

  post '/links' do
    p params
    link = Link.new(url: params[:url], title: params[:title])
    tags = params[:tags].split(', ')
    tags.each do |tag|
      link.tags << Tag.create(name: tag.downcase)
    end
    link.save
    redirect '/links'
  end

  get '/tags' do
    @tags = Tag.all
    erb :tags
  end

  get "/tags/:name" do
    @tag = Tag.first(name: params[:name].downcase)
    @links = @tag ? @tag.links : []
    erb :tag_links
  end
end
