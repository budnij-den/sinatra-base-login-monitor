#from http://sinatrarb.com/intro.html

require 'sinatra/base'

class LoginScreen < Sinatra::Base
  enable :sessions
  enable :static

  get '/' || '/login' do
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
      halt "Access denied, please <a href='/'>login</a>."
    end
  end

  get('/greeting') do
    "Hello #{session['user_name']}. <br><blockquote class=\"blockquote\"> #{session.inspect}</blockquote>"
  end
end

Sinatra::Base::MyApp.run!