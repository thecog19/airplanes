require 'rails_helper'

RSpec.describe AirplanesController, type: :controller do
  context "visiting the index page" do
    it "renders the index" do 
      get :index
      expect(response).to render_template("index")
    end
    it "has a list of airplanes"
  end

  context "visiting the new page" do
    it "renders the new page" do
      get :new
      expect(response).to render_template("new")
    end
  end

  context "creating a new plane" do
    let(:params) {{airplane: {name: "aaaa", size: "large", cargo_type: "passenger", elephant: "green"}}}
    it "accepts expected parameters" do
      post :create, params
      expect(controller.airplane_params[:size]).to_not be_nil
      expect(controller.airplane_params[:cargo_type]).to_not be_nil
    end

    it "rejects invalid params"  do 
      post :create, params
      expect(controller.airplane_params[:elephant]).to be_nil
    end

    it "raises an error if params misformated" do
      expect do
        post :create, {green: "Tea"}
      end.to raise_error(ActionController::ParameterMissing)
    end
    
    context "invalid params" do
      let(:params) {{airplane: {name: "aaaa", size: "large"}}}
      it "renders an error flash " do
        post :create, params
        expect( subject.request.flash[:danger] ).to_not be_nil
      end
    end

    context "valid params" do 
      let(:params) {{airplane: {name: "aaaa", size: "large", cargo_type: "passenger"}}}
      it "returns a success flash" do
        post :create, params
        expect( subject.request.flash[:success] ).to_not be_nil
      end
    end

    it "redirects to the new page" do
      post :create, airplane: {name: "aaaa"}
      expect(response).to redirect_to(new_airplane_path) 
      expect(response).to_not redirect_to(airplanes_path)
    end
  end
end
