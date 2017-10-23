class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def home
    res = ""
    if request.xhr?  
      @res = params[:sum].to_i.currency_to_words
    end

    respond_to do |format|
        format.js
        format.html
      end
  end


end
