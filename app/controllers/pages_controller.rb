class PagesController < ApplicationController
  
  def index
  rescue
    render :text => "woot!"
  end
  
end
