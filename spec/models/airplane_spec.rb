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

  context "#enqueue" do
    let(:valid_params) {
      {
        name: "Flight 283",
        cargo_type: "passenger",
        size: "large"
      }
    }
    context "invalid params" do
      it "Returns errors if given invalid parameters" do 
        expect(Airplane.enqueue({})).to be_a(ActiveModel::Errors)
      end
    end
    context "valid params" do
      it "returns a new airplane record" do 
        expect(Airplane.enqueue(valid_params)).to be_a(Airplane)
      end
      it "the record is persisted to the db" do
        expect{Airplane.enqueue(valid_params)}.to change{Airplane.count}.by(1)
      end
      it "the record has a priority" do 
        expect(Airplane.enqueue(valid_params).priority).to be_a(Integer)
      end
    end

    context "#calculate priority" do 
      it "priority 1 if"
      it "priority 2 if"
      it "priority 3 if"
      it "priority 4 if"
    end 
  end
end
 