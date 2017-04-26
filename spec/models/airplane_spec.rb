require 'rails_helper'

RSpec.describe Airplane, type: :model do
  let(:plane) {Airplane.new(name: "green", priority: 3, cargo_type: "Passenger", size: "Small")}
  context "invalid inputs" do 

    it "for priority" do 
      plane.priority = nil 
      expect(plane.valid?).to be false
    end

    it "for size" do
      plane.size = nil 
      p plane
      expect(plane.valid?).to be false
    end

    it "for cargo type" do 
      plane.cargo_type = nil 
      expect(plane.valid?).to be false
    end

  end

  context "valid inputs" do
    it "is valid when cargo_type, size and priority are present" do
      expect(plane.valid?).to be true
    end
  end
end
 