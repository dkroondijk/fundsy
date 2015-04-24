require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  # let(:user) { FactoryGirl.create(:user) }
  # we can just use 'create' here because we 
  # added FactoryGirl to the RSpec rails_helper file
  # config.include FactoryGirl::Syntax::Methods
  let(:user) { create(:user) }

  describe "#new" do
    before { get :new }

    it "renders the new template" do
      expect(response).to render_template(:new)
    end

  end

  describe "#create" do
    context "succesful login" do
      def valid_request
        post :create, {email: user.email, password: user.password}
      end

      before { valid_request }

      it "sets the session user_id to be the id of the user" do
        expect(session[:user_id]).to eq(user.id)
      end

      it "redirects to the home page" do
        expect(response).to redirect_to(root_path)
      end

      it "shows an alert message that displays login succesful" do
        expect(flash[:notice]).to be
      end

    end

    context "unsuccessful login" do
      def invalid_request
        post :create, {email: user.email, password: user.password + "sdfsd"}          
      end

      before { invalid_request }

      it "doesn't set the session user_id" do
        expect(session[:user_id]).to eq(nil)
      end

      it "renders the new template" do
        expect(response).to render_template(:new)
      end

      it "sets a flash message" do
        expect(flash[:alert]).to be
      end

    end

  end

  describe "#destroy" do

    def valid_request
      delete :destroy
    end

    it "sets the session id to nil" do
      request.session[:user_id] = user.id
      valid_request
      expect(session[:user_id]).to be_nil
    end

    it "sets a flash message" do
      valid_request
      expect(flash[:notice]).to be
    end

    it "redirects to the root path" do
      valid_request
      expect(response).to redirect_to(root_path)
    end

  end

end
