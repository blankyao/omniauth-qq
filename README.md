OmniAuth-Qq
===
为omniauth实现的 [QQ登录](http://connect.qq.com/intro/login/) 策略

Basic Usage
---
In your Gemfile:

```ruby
gem 'omniauth-qq',  :git => 'git://github.com/blankyao/omniauth-qq.git'
```

A sample app:

```ruby
# encoding: utf-8
require 'sinatra'
require 'omniauth-qq'

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :qq, ENV['APP_KEY'], ENV['APP_SECRET']
end

get '/' do
  <<-HTML
    <a href="/auth/qq">Login Using QQ</a>
  HTML
end

get '/auth/qq/callback' do
  auth = request.env['omniauth.auth']

  <<-HTML
    <ul>
      <li>qq_openid: #{auth.uid}</li>
      <li>nickname: #{auth.info.nickname}</li>
      <li>gender: #{auth.info.gender}</li>
      <li>avatar: <img src="#{auth.info.avatar}"/></li>
    </ul>
  HTML
end
```