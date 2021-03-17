require 'open-uri'

class FeedsController < ApplicationController
  #http_basic_authenticate_with name: "austin", password: "password", only: :show

  def index
  end

  def show
    @feed = Feed.find_by(id: params[:id])
  end

  def new
  end

  def create
    @feed = Feed.new(feed_params)

    begin
      old_feed = open(@feed.url, :http_basic_authentication=>["austin11793","Manwax12!"]).read
      @feed.new_feed = old_feed.gsub("&amp;", "&")

      if @feed.save
        flash[:success] = "Feed added"
      else
        flash[:danger] = "URL opened but feed not saved"
      end
    rescue
      flash[:danger] = "Bad credentials to open GaS feed."
    ensure
      redirect_to feeds_url
    end
  end

  private

    def feed_params
      params.require(:feed).permit(:title, :url)
    end

end
