class ConcertsController < ApplicationController
  before_action :current_user_must_be_concert_user, :only => [:show, :edit, :update, :destroy]

  def current_user_must_be_concert_user
    concert = Concert.find(params[:id])

    unless current_user == concert.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = current_user.concerts.ransack(params[:q])
      @concerts = @q.result(:distinct => true).includes(:user, :artist, :venue).page(params[:page]).per(10)

    render("concerts/index.html.erb")
  end

  def show
    @concert = Concert.find(params[:id])

    render("concerts/show.html.erb")
  end

  def new
    @concert = Concert.new

    render("concerts/new.html.erb")
  end

  def create
    @concert = Concert.new

    @concert.date = Chronic.parse(params[:date])
    @concert.artist_id = params[:artist_id]
    @concert.venue_id = params[:venue_id]
    @concert.notes = params[:notes]
    @concert.user_id = params[:user_id]

    save_status = @concert.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/concerts/new", "/create_concert"
        redirect_to("/concerts")
      else
        redirect_back(:fallback_location => "/", :notice => "Concert created successfully.")
      end
    else
      render("concerts/new.html.erb")
    end
  end

  def edit
    @concert = Concert.find(params[:id])

    render("concerts/edit.html.erb")
  end

  def update
    @concert = Concert.find(params[:id])

    @concert.date = params[:date]
    @concert.artist_id = params[:artist_id]
    @concert.venue_id = params[:venue_id]
    @concert.notes = params[:notes]
    @concert.user_id = params[:user_id]

    save_status = @concert.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/concerts/#{@concert.id}/edit", "/update_concert"
        redirect_to("/concerts/#{@concert.id}", :notice => "Concert updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Concert updated successfully.")
      end
    else
      render("concerts/edit.html.erb")
    end
  end

  def destroy
    @concert = Concert.find(params[:id])

    @concert.destroy

    if URI(request.referer).path == "/concerts/#{@concert.id}"
      redirect_to("/", :notice => "Concert deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Concert deleted.")
    end
  end
end
