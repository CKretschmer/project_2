module Portfolio
  class Server < Sinatra::Base
    get "/" do
      erb :index
    end

    get "/contact" do
       erb :contact
    end

    post '/contact' do
      @email = params[:email]
      @name = params[:name]
      @message = params[:message]

      conn.exec_params("INSERT INTO contact_data (name, email, message) VALUES ($1, $2, $3)", [@name, @email, @message])

     @submitted = true
     erb :contact
    end

      def conn
        if ENV["RACK_ENV"] == "production"
            PG.connect(
                dbname: ENV["POSTGRES_DB"],
                host: ENV["POSTGRES_HOST"],
                password: ENV["POSTGRES_PASS"],
                user: ENV["POSTGRES_USER"]
             )
        else
            PG.connect(dbname: "portfolio")
        end
    end
  end
end
