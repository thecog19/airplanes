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
      it "Returns airplane record" do 
        expect(Airplane.enqueue({})).to be_a(Airplane)
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

      it "priority for big passenger" do
        params = {"size" => "big", "cargo_type" => "passenger"}
        expect(Airplane.calculate_priority(params)).to eq(1)
      end
      
      it "priority for small passenger" do
       params = {"size" => "small", "cargo_type" => "passenger"}
        expect(Airplane.calculate_priority(params)).to eq(2)
      end

      it "priority for big cargo" do 
        params = {"size" => "big", "cargo_type" => "cargo"}
        expect(Airplane.calculate_priority(params)).to eq(3)
      end
      
      it "priority for small cargo" do 
        params = {"size" => "small", "cargo_type" => "cargo"}
        expect(Airplane.calculate_priority(params)).to eq(4)
      end
    end 
  end
end
 