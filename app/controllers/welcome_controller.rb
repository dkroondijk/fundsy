class WelcomeController < ApplicationController
  def index
    @campaigns = Campaign.most_recent(3)
  end
end
