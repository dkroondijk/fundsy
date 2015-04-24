require 'rails_helper'

RSpec.describe Campaign, type: :model do

  def valid_attributes(new_attributes = {})
    attributes = {title: "pancakes", 
                  goal: 15, 
                  description: "delicious pancakes", 
                  ends_on: "2015-06-01 [12:00:00]"}
    attributes.merge(new_attributes)
  end

  describe "Validations" do

    it "requires a title" do
      c = Campaign.new(valid_attributes({title: nil}))
      expect(c).to be_invalid
    end

    it "requires a description" do
      c = Campaign.new(valid_attributes({description: nil}))
      expect(c).to be_invalid
    end

    it "requires a goal" do
      c = Campaign.new(valid_attributes({goal: nil}))
      expect(c).to be_invalid
    end

    it "requires goal greater than 10" do
      c = Campaign.new(valid_attributes({goal: 5}))
      c.save
      expect(c.errors.messages).to have_key(:goal)
    end

    # it "requires ends_on greater than current timedate" do
    #   c = Campaign.new(valid_attributes({ends_on: "2014-06-01 [12:00:00]"}))
    #   expect(c).to be_invalid
    # end

  end

end
