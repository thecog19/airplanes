require 'rails_helper'

RSpec.describe AirplanesController, type: :controller do
  context "#index" do
    it "renders the index" do 
      get :index
      expect(response).to render_template("index")
    end

    it "has a list of airplanes" do 
      plane = Airplane.create(name: "test", 
                              cargo_type: "passenger",
                              size: "large",
                              priority: 1)
      get :index
      expect(assigns(:airplanes)).to eq([plane])
    end

    it "the planes are ordered by priority" do
      plane = Airplane.create(name: "test", 
                              cargo_type: "passenger",
                              size: "large",
                              priority: 1)
      plane2 = Airplane.create(name: "test2", 
                              cargo_type: "passenger",
                              size: "small",
                              priority: 2)

      get :index
      expect(assigns(:airplanes)).to eq([plane, plane2])
    end

    it "if priority is tied order by created_at" do
      plane2 = Airplane.create(name: "test2", 
                              cargo_type: "passenger",
                              size: "large",
                              priority: 1)
      plane = Airplane.create(name: "test", 
                              cargo_type: "passenger",
                              size: "large",
                              priority: 1)

      get :index
      expect(assigns(:airplanes)).to eq([plane2, plane])
    end
  end

  context "visiting the new page" do
    it "renders the new page" do
      get :new
      expect(response).to render_template("new")
    end
  end

  context "#create" do
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

  context "#destroy" do
    let(:plane) {{name: "aaaa", id: 4}}
    it "calls the dequeue method on Airplane" do
      expect(Airplane).to receive(:dequeue).and_return(plane)
      delete :destroy, id: 1 
    end

    context "no planes left" do
      it "redirects to new" do 
        allow(Airplane).to receive(:dequeue).and_return(false)
        delete :destroy, id: 1  
        expect(response).to redirect_to(new_airplane_path) 
        expect(response).to_not redirect_to(airplanes_path)
      end

      it "sets a failure flash" do
        allow(Airplane).to receive(:dequeue).and_return(false)
        delete :destroy, id: 1  
        expect( subject.request.flash[:danger] ).to_not be_nil
      end
    end

    context "there are planes in the queue" do 
      it "redirects to new" do 
        allow(Airplane).to receive(:dequeue).and_return(plane)
        delete :destroy, id: 1  
        expect(response).to redirect_to(new_airplane_path) 
        expect(response).to_not redirect_to(airplanes_path)
      end

      it "sets a success flash" do
        allow(Airplane).to receive(:dequeue).and_return(plane)
        delete :destroy, id: 1  
        expect( subject.request.flash[:success] ).to_not be_nil
      end
      

    end
  end
end
