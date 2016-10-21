class Admin::ResponsesController < Admin::BaseController
  before_filter :set_response, only: [:show, :update]

  def index
    @responses = Responses::Base.unreviewed
  end

  def update
    raise if params[:reject] && params[:approve]

    if params[:reject]
      @response.reject!(propagate: true)
      flash[:notice] = 'Response rejected'
    end

    if params[:approve]
      @response.approve!(propagate: true)
      flash[:notice] = 'Response approved'
    end

    redirect_to admin_responses_path
  end

  private

  def set_response
    @response = Responses::Base.find_by_token(params[:token])
  end
end
