class Admin::DomainsController < Admin::BaseController
  before_action :set_domain, only: [:edit, :update, :destroy]

  def index
    @domains = Domain.all
  end

  def new
    @domain = Domain.new
  end

  def create
    @domain = Domain.new(name: params[:domain][:name])

    if @domain.save
      @domain.set(
        params[:domain][:cities].select { |x| x.present? }.map { |x| x.to_i }
      )

      flash[:notice] = 'New domain successfully created'
      redirect_to admin_domains_path
    else
      render :new
    end
  end

  def update
    @domain.name = params[:domain][:name]

    if @domain.save
      @domain.set(
        params[:domain][:cities].select { |x| x.present? }.map { |x| x.to_i }
      )

      flash[:notice] = 'Domain successfully updated'
      redirect_to admin_domains_path
    else
      render :edit
    end
  end

  def destroy
    if @domain.destroy
      flash[:notice] = 'Domain successfully deleted'
      redirect_to admin_domain_path
    else
      flash.now[:alert] = 'There was an error destroying that domain'
    end
  end

  private

  def set_domain
    @domain = Domain.find(params[:id])
  end
end
