module Portfolio
  class Server < Sinatra::Base
    get "/" do
      erb :index

      get "/contact" do
        erb :contact
    end

    post '/contact' do
      binding.pry     #goes into params# 1 reason why we have middleWare
  end
end
end
