class Admin::CitiesController < Admin::BaseController
  before_filter :set_city, only: [:edit, :update, :destroy]

  def index
    @cities = City.all
  end

  def show
    @city = City.find(params[:id])
    @tasks = Task.where(city: @city)
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(city_params)

    if @city.save
      flash[:notice] = 'New city successfully created'
      redirect_to admin_cities_path
    else
      render :new
    end
  end

  def update
    @city.assign_attributes(city_params)

    if @city.save
      flash[:notice] = 'City successfully updated'
      redirect_to admin_cities_path
    else
      render :edit
    end
  end

  def destroy
    if @city.destroy
      flash[:notice] = 'City successfully deleted'
      redirect_to admin_cities_path
    else
      flash.now[:alert] = 'There was an error destroying that city'
    end
  end

  private

  def set_city
    @city = City.find(params[:id])
  end

  def city_params
    @_city_params ||= params.require(:city).permit(
      :latitude,
      :longitude,
      :name,
      :state,
    )
  end
end
