require 'rails_helper'

RSpec.describe AirplanesController, type: :controller do
  context "visiting the index page" do
    it "renders the index"
    it "has a list of airplanes"
  end

  context "visiting the new page" do
    it "renders the new page"
  end

  context "creating a new plane" do
    it "allows for a name"
    it "allows for a size"
    it "allows for a cargo size"
    it "returns the created object"
    it "returns the error message on failure"
  end
end
