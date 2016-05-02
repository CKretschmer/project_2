require 'pg'
require 'pry'
module Sinatra
  class Server < Sinatra::Base
    set :method_override, true
    db = PG.connect(dbname: ENV["POSTGRES_DB"]) #variable that connects to postgres db for you

    get "/" do
      erb :index
    end

    get '/users' do
      @users = db.exec("SELECT * FROM users;")
      erb :Users
    end

    post '/users' do
      @text = params[:text]
    db.exec_params("INSERT INTO comments (text) VALUES $1", [@text])
    end



    # get "/" do
    #   erb :signup
    # end


    # get "/login" do
    #   if conn.exec(SELECT * FROM users)
    # => erb :logout
    # else
    #   erb :login
    # end

    # post "/signup" do
    #   @email = params[:email]
    #   @password =  BCrypt::Password::create(params[:password])

    #   conn.exec_params(
    #     "INSERT INTO users (email, password) VALUES ($1, $2)",
    #     [@email, @password]
    #   )
    # end

    # post "/login" do
    #   @email = params[:email]
    #   @password = params[:password]


    #   @user = conn.exec_params(
    #     "SELECT * FROM users WHERE email=$1 LIMIT 1",
    #     [@email]
    #   ).first


    #   if @user && BCrypt::Password::new(@user["password"]) == params[:password]
    #     "You have successfully logged in"
    #     session[:user_id] = @user.use_id
    #   else
    #     "Incorrect email or password!"
    #   end
    # end


    # def conn
    #   PG.connect(dbname: "signup")
    # end


    get '/topics' do
      @topics = db.exec("SELECT * FROM topics;")
      erb :topics
    end

    get '/topics/:id' do
      id = params[:id]
      @topics = db.exec_params("SELECT * FROM topics WHERE user_id = $1",[id])
      erb :topics
    end

    post '/topics' do
      @title = params[:title]
      @text = params[:text]
      db.exec_params("INSERT INTO topics (title, text) VALUES ($1, $2)", [@title, @text])
      # Pry.start(binding)
    redirect to('/topics')
    "Topic created!"
    end

    delete '/topics' do
        id = params['topic_id'].to_i
        db.exec_params("DELETE FROM topics WHERE id = $1",[id])
        redirect to ('/topics')
    end

    put '/topics' do
      id = params[:topic_id].to_i
      title = params[:title]
      text = params[:text]
    end

    get '/comments' do
      @comments = db.exec("SELECT * FROM comments;")
      erb :comments
    end

    get '/comments/:text' do
    @text = params[:text]

    @comments = db.exec_params("SELECT * FROM comments WHERE user_id = $1",[text])
    erb :comments
    end

    post '/comments' do
      @comments = params[:comments]
      @user_id = params[:user_id]
      @topic_id = params[:topic_id]
      @date = params[:date]
      db.exec_params("INSERT INTO comments (comments, user_id, topic_id, date) VALUES ($1, $2, $3, $4)", [@comments, @user_id, @topic_id, @tdate])
      "Well done!"

     # delete '/comments' do
     #    id = params['user_id'].to_i
     #    db.exec_params("DELETE FROM comments WHERE user_id = $1",[id])
     #    redirect to ('/topics')

    end

end
end
