ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'
require_relative 'models/link'

class BookmarkManager < Sinatra::Base
  enable :sessions

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    erb :index
  end

  get '/users/new' do
    erb :sign_up
  end

  post '/users' do
    name = params[:name]
    email = params[:email]
    password = params[:password]
    fail if User.all.map(&:email).include? email
    user = User.create(name: name, email: email, password: password)
    session[:user_id] = user.id
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
    link = Link.new(url: params[:url], title: params[:title])
    tags = params[:tags].split(', ')
    tags.each do |tag|
      existing = Tag.first(name: tag.downcase)
      link.tags << (existing ? existing : Tag.create(name: tag.downcase))
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
