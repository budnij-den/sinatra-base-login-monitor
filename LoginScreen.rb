#from http://sinatrarb.com/intro.html

require 'sinatra/base'

class LoginScreen < Sinatra::Base
  enable :sessions

  get '/*' do
    erb :login
  end

  post('/login') do
    if params['name'] == 'admin' && params['password'] == 'secret'
      session['user_name'] = params['name']
      redirect '/greeting'
    else
      @error = 'wrong or blank enter'
      erb :login
    end
  end
end

class MyApp < Sinatra::Base
  # middleware will run before filters
  use LoginScreen

  before do
    unless session['user_name']
      halt "Access denied, please <a href='/login'>login</a>. <br><blockquote  class=\"blockquote\"> #{session.inspect}</blockquote>"
    end
  end

  get('/greeting') do
    "Hello #{session['user_name']}. <br><blockquote class=\"blockquote\"> #{session.inspect}</blockquote>"
  end
end

# run! if app_file == $0

#run Sinatra::Base::MyApp.run!

#Sinatra::Base::MyApp.run!