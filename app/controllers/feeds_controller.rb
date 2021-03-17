require 'open-uri'

class FeedsController < ApplicationController
  http_basic_authenticate_with name: "austin", password: "password", only: :show

  def index
  end

  def show
    @feed = Feed.find_by(id: params[:id])
  end

  def new
  end

  def create
    @feed = Feed.new
    @feed.title = params[:title]
    @feed.url = params[:url]

    begin
      old_feed = open(@feed.url, :http_basic_authentication=>["austin11793","Manwax12!"]).read
      @feed.new_feed = old_feed
      i_start = 1
      i_end   = 1

      while i_start and i_end
        i_start = (old_feed =~ /<item>/m)
        i_end   = (old_feed =~ /<\/item>/m) + 6
      end
    rescue

    ensure

    end
  end

end
