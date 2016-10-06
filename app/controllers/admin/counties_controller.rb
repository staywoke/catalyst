class Admin::CountiesController < Admin::BaseController
  before_filter :set_county, only: [:edit, :update, :destroy]

  def index
    @counties = County.all
  end

  def new
    @county = County.new
  end

  def create
    @county = County.new(county_params)

    if @county.save
      flash[:notice] = 'New county successfully created'
      redirect_to admin_counties_path
    else
      render :new
    end
  end

  def update
    @county.assign_attributes(county_params)

    if @county.save
      flash[:notice] = 'County successfully updated'
      redirect_to admin_counties_path
    else
      render :edit
    end
  end

  def destroy
    if @county.destroy
      flash[:notice] = 'County successfully deleted'
      redirect_to admin_counties_path
    else
      flash[:alert] = 'There was an error destroying that county'
    end
  end

  private

  def set_county
    @county = County.find(params[:id])
  end

  def county_params
    @_county_params ||= params.require(:county).permit(
      :latitude,
      :longitude,
      :name,
      :state,
    )
  end
end
