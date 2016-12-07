class VenuesController < ApplicationController

  def address_to_geo(location)
    require 'open-uri'
    url = 'http://maps.googleapis.com/maps/api/geocode/json?address=' + URI.encode(location)
    parsed_data = JSON.parse(open(url).read)
    lat = parsed_data["results"][0]["geometry"]["location"]["lat"]
    lng = parsed_data["results"][0]["geometry"]["location"]["lng"]
    return [lat,lng]
  end

  def index
    @q = Venue.ransack(params[:q])
    @venues = @q.result(:distinct => true).includes(:concerts).page(params[:page]).per(10)

    render("venues/index.html.erb")
  end

  def show
    @concert = Concert.new
    @venue = Venue.find(params[:id])

    render("venues/show.html.erb")
  end

  def new
    @venue = Venue.new

    render("venues/new.html.erb")
  end

  def create
    @venue = Venue.new

    @venue.name = params[:name]
    @venue.location = params[:location]
    @venue.notes = params[:notes]

    latlng = address_to_geo(params[:location])
    @venue.lat = latlng[0]
    @venue.lng = latlng[1]

    save_status = @venue.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/venues/new", "/create_venue"
        redirect_to("/venues")
      else
        redirect_back(:fallback_location => "/", :notice => "Venue created successfully.")
      end
    else
      render("venues/new.html.erb")
    end
  end

  def edit
    @venue = Venue.find(params[:id])

    render("venues/edit.html.erb")
  end

  def update
    @venue = Venue.find(params[:id])

    @venue.name = params[:name]
    @venue.location = params[:location]
    @venue.notes = params[:notes]

    save_status = @venue.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/venues/#{@venue.id}/edit", "/update_venue"
        redirect_to("/venues/#{@venue.id}", :notice => "Venue updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Venue updated successfully.")
      end
    else
      render("venues/edit.html.erb")
    end
  end

  def destroy
    @venue = Venue.find(params[:id])

    @venue.destroy

    if URI(request.referer).path == "/venues/#{@venue.id}"
      redirect_to("/", :notice => "Venue deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Venue deleted.")
    end
  end
end
