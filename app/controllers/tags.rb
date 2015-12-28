class BookmarkManager < Sinatra::Base
  get '/tags' do
    @tags = Tag.all
    erb :'tags/index'
  end

  get "/tags/:name" do
    @tag = Tag.first(name: params[:name].downcase)
    @links = @tag ? @tag.links : []
    erb :'tags/tag_links'
  end
end
