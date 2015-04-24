require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#new" do
    it "instantiates a new user variable" do
      get :new
      # assign is RSpec method to instantiate new instance
      # be_a_new Rspec 
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do

    context "with valid parameters" do

      def valid_request
        # we can also do
        # attributes = attributes_for(:user)
        post :create, {user: {
                        first_name: "Diederik",
                        last_name: "Kroondijk",
                        email: "dkroondijk@hotmail.com",
                        password: "1234abcd",
                        password_confirmation: "1234abcd"
                      }}
      end

      it "creates a user in the database" do
        expect { valid_request }.to change { User.count }.by(1)
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end

      it "redirects to the root path of the application" do
        valid_request
        expect(response).to redirect_to(root_path)
      end        
       
    end

    context "with invalid parameters" do

      def invalid_request
        post :create, {user: {
                        first_name: "Diederik",
                        last_name: "Kroondijk",
                        email: "dfdsgsdgsgsg",
                        password: "1234abcd",
                        password_confirmation: "1234abcd"
                      }}
      end

      it "doesn't create a user record in the database" do
        expect { invalid_request }.to_not change { User.count }
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end

      it "sets an alert flash message" do
        invalid_request
        expect(flash[:alert]).to be
      end

    end    
  end

end
