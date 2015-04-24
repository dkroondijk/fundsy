require 'rails_helper'

# Rspec 'describe' takes either a class such as User or UserController
# which will make it easier to integrate with it
# You can also just gve it a string, which means there is no specific integration
# This way it can be used to group things together
RSpec.describe User, type: :model do

  def valid_attributes(new_attributes = {})
    attributes = {first_name: "Diederik", 
                  last_name: "Kroondijk", 
                  email: "dkroondijk@hotmail.com",
                  password: "abcd1234"}
    attributes.merge(new_attributes)
  end

  describe "Validations" do

    # 'it' is used to define a test case
    # 'specify' can be used as an alias for 'it'
    it "requires an email" do
      user = User.new(valid_attributes({email: nil}))
      # be_invalid is an RSpec matcher
      expect(user).to be_invalid
    end

    it "requires a unique email" do
      User.create(valid_attributes)
      user = User.new(valid_attributes)
      user.save
      expect(user.errors.messages).to have_key(:email)
    end

    it "requires a first_name" do
      user = User.new(valid_attributes({first_name: nil}))
      expect(user).to be_invalid
    end

    it "requires a valid email" do
      user = User.new(valid_attributes({email: "ljefln"}))
      expect(user).to be_invalid
    end

  end

  describe "Hashing password" do

    it "generates password digest if given a password" do
      user = User.new(valid_attributes)
      user.save
      expect(user.password_digest).to be
    end

  end

  describe ".full_name" do
    it "returns the concatenated first name and last name if both are given" do
      user = User.new(valid_attributes)      
      expect(user.full_name).to eq("#{valid_attributes[:first_name]} #{valid_attributes[:last_name]}")
    end

    it "returns the first name only if only the first name is given" do
      user = User.new(valid_attributes({last_name: nil}))
      expect(user.full_name).to eq("#{valid_attributes[:first_name]}")
    end

  end

end
