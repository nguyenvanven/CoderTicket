require 'rails_helper'

RSpec.describe Region, type: :model do
  describe "Region Creation" do
    it "Name must be in  ['Ho Chi Minh', 'Ha Noi', 'Binh Thuan', 'Da Nang', 'Lam Dong']" do
      @region = Region.new(name:'Random')
      expect(@region.save).to be_falsey
      expect(@region.errors.full_messages.to_sentence).to eq("Name is not included in the list")
      @region.name = 'Ho Chi Minh'
      expect(@region.save).to be_truthy

      @region1 = Region.new(name:'Ha Noi')
      expect(@region1.save).to be_truthy

      @region1.name = 'Binh Thuan'
      expect(@region1.save).to be_truthy

      @region1.name = 'Da Nang'
      expect(@region1.save).to be_truthy

      @region1.name = 'Lam Dong'
      expect(@region1.save).to be_truthy

    end

    it "Name must be unique" do
      @region1 = Region.new(name:'Lam Dong')
      expect(@region1.save).to be_truthy
      @region2 = Region.new(name:'Lam Dong')
      expect(@region2.save).to be_falsey
      expect(@region2.errors.full_messages.to_sentence).to eq("Name has already been taken")

      @region2.name = 'Da Nang'
      expect(@region2.save).to be_truthy
    end
  end
end
