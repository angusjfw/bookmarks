class BookmarkManager < Sinatra::Base
  register Sinatra::Flash
  use Rack::MethodOverride

  enable :sessions
  set :session_secret, 'super secret'

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    erb :index
  end
end
