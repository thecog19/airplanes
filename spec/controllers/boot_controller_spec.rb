require 'rails_helper'

RSpec.describe BootController, type: :controller do
  context "visiting the landing page" do
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
