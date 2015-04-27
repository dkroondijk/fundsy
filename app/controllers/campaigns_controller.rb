class CampaignsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @campaigns = Campaign.all
  end

  def new
    @campaign = Campaign.new
    3.times { @campaign.reward_levels.build }
  end

  def create
    @campaign = Campaign.new(campaign_params)
    @campaign.user = current_user

    if @campaign.save
      flash[:notice] = "Campaign Created"
      redirect_to campaign_path(@campaign)
    else
      flash[:alert] = "Can't Create Campaign"
      render :new
    end
  end

  def show
    @campaign = Campaign.find(params[:id])
  end

  def edit
    @campaign = current_user.campaigns.find(params[:id])
  end

  def update
    @campaign = current_user.campaigns.find(params[:id])

    if @campaign.update(campaign_params)
      redirect_to campaign_path(@campaign), notice: "Campaign Updated!"
    else
      flash[:alert] = "Can't Update Campaign!"
      render :edit
    end
  end

  def destroy
    @campaign = current_user.campaigns.find(params[:id])
    @campaign.destroy
    redirect_to campaigns_path, notice: "Campaign Deleted"
  end


  private

  def campaign_params
    params.require(:campaign).permit(:title, :description, :goal, :ends_on,
                    {reward_levels_attributes: [:amount, :description, :id, :_destroy]} )
  end
end
