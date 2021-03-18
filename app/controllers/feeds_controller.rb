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
    start_reg = /<item>/m
    end_reg   = /<\/item>/m

    # Everything between quotes after "url="
    url_reg = /url=\"([^\"]*)\"/m

    # Everything between <guid> tags
    gui_reg = /<guid>([^<]*)</m

    @feed = Feed.new(feed_params)

    begin
      old_feed = open(@feed.url, :http_basic_authentication=>["austin11793","Manwax12!"]).read
      @feed.new_feed = old_feed
      #i_start = (old_feed =~ start_reg)
      #i_end   = (old_feed =~ end_reg) + 6

      #new_feed = old_feed[0...i_start]
      
      #while i_start and i_end
      #  episode = old_feed[i_start..i_end]
    
      #  if episode =~ url_reg
      #    ep_start = (episode =~ url_reg) + 5
      #    url_old = $1
      #    len_old = url_old.length
      #    ep_end = ep_start + len_old - 1
      #    url_new = url_old.gsub("&amp;", "&amp;amp;")
    
      #    episode[ep_start..ep_end] = url_new
      #  end
    
      #  if episode =~ gui_reg
      #    ep_start = (episode =~ gui_reg) + 6
      #    gui_old =  $1
      #    len_old = gui_old.length
      #    ep_end = ep_start + len_old - 1
      #    gui_new = gui_old.gsub("&amp;", "&amp;amp;")
    
      #    episode[ep_start..ep_end] = gui_new
      #  end
    
      #  new_feed += "#{episode}\n"
    
      #  old_feed = old_feed[i_end..-1]
      #  i_start = (old_feed =~ start_reg)
      #  if i_start
      #    i_end   = (old_feed =~ end_reg) + 6
      #  end
      #end

      #new_feed += "</channel>\n</rss>"
      #@feed.new_feed = new_feed

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
