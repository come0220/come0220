# coding: utf-8
class ApplicationController < ActionController::Base
  include Jpmobile::ViewSelector

  def hello
  end

  def bye
    require 'hpricot'
    require 'open-uri'

    doc = Hpricot(open("http://dka-hero.com/hm_01.html"))
    hrefs = (doc/:a).map  {|hrefs| hrefs[:href]}
    #for i in 100..110 do
    i =rand(100) + 1
    tmp = hrefs[i]
    doc2 = Hpricot(open("http://dka-hero.com/#{hrefs[i]}"))
    hrefs2 = (doc2/:img).map {|href| href[:src]}
    @href = Array.new();
    j=hrefs2.size-1
    for i in (0..j) do
    @href[i] = tmp[0,10] + hrefs2[i]
    i =+1
    end    
  end

  def authenticate
  authenticate_or_request_with_http_basic do |user_name, password|
    user_name == 'admin' && password == 'password'
  end
  end

  def test
  end

end
