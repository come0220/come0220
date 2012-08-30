# -*- coding: utf-8 -*-
class MemolistsController < ApplicationController

before_filter :authenticate

  def index
    @memodb = Memodb.all(:order => "created_at DESC")
  end

  def destroy
    name = params[:name]
    Memodb.delete_all("name='"+name+"'")
    #render :action => 'hello'
    render json: { memodb: @memodb }
  end

  def show
      @memodb = Memodb.all(:order => "created_at DESC")
  end
    
  def getdata
	  require 'hpricot'
      require 'open-uri' 

      #名前、ページ数取得
      @name = params[:name][:name]
      @number = params[:number].to_i
      if @name !~ /[0-9A-Za-z]+$/ then
        render :action => 'error'  and return
      end
      unless @name.blank?
      #スペースをプラスに置換
      @name = @name.gsub(/(\s)/,"+")
      #Hpricot
      doc = Hpricot(open("http://www.xvideos.com/?k=#{@name}&p=#{@number}&sort=rating")) 
      tmp = (doc/"a.miniature").map {|href| href[:href]}
      @img = (doc/"img").map {|img| img[:src]}
      @img.delete("http://img100.xvideos.com/videos/thumbs/xvideos.gif")
      #ページ数取得
      page = (doc/"div#pag"/:a).map {|href| href[:href]}
      @page = page.length/2
      i=0
       @result = Array.new();
        #url取得
        tmp.each do |tmp|
        tmp2 = tmp[28,7]
        if tmp2[tmp2.length-1] == "/" then
           tmp2 = tmp[28,6]
        end
        @result[i] = "http://www.xvideos.com/sitevideos/flv_player_site_v4.swf?id_video=#{tmp2}"
        i+=1
        end
        render :action => 'confirm'  
        else
        render :action => 'error'
        end
    end

    def rescue_action_in_public(exception)
        case exception
           when ActiveRecord::RecordNotFound, ::ActionController::UnknownAction, ::ActionController::RoutingError, ActionView::TemplateError, NoMethodError
          render :action => 'error'
          end
    end

    def create
      name = params[:name]
      url  = params[:url]
      memodb = Memodb.new
      memodb.name = name
      memodb.url = url
      memodb.save
          render :action => 'hello'  
    end

end
