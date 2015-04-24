require 'rails_helper'

RSpec.describe Pledge, type: :model do

  describe "#validations" do

    it "only allow amount of 1 or more" do
      pledge = Pledge.new(amount: 0)
      expect(pledge).to be_invalid
    end

  end

end
