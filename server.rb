module Portfolio
  class Server < Sinatra::Base
    get "/" do
      erb :index
    end
#creating a route for contact
#create a form see contact.erb
    get "/contact" do

#this will return falsey because there has been no submission which equates to nil
      erb :contact
    end
#test to see if route works with binding pry...then params puts it into hash{}
    post '/contact' do
      @email = params[:email]
      @name = params[:name]
      @message = params[:message]

      conn.exec_params ("INSERT INTO contact_data (name, email, message) VALUES ($1, $2, $3), ('#{@name}', '#{@email}', '#{@message}')")
#creating a var for a conditional...see contact.erb
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
  end #ends class
end #ends module
