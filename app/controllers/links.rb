class BookmarkManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
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
end
