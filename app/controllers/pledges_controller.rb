class PledgesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @campaign         = Campaign.find(params[:campaign_id])    
    @pledge           = Pledge.new(pledge_params)
    @pledge.user      = current_user
    @pledge.campaign  = @campaign

    if @pledge.save
      redirect_to campaign_path(@campaign), notice: "Pledged!"
    else
      render "campaigns/show"
      flash[:alert] = "Can't Pledge!"
    end
  end

  def destroy
    @campaign = Campaign.find(params[:campaign_id])
    @pledge = current_user.pledges.find params[:id]
    @pledge.destroy
    redirect_to campaign_path(@campaign), notice: "Pledge Deleted!"
  end


  private

  def pledge_params
    params.require(:pledge).permit(:amount)
  end

end
