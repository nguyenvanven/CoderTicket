require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "Category Creation" do
    it "Name must be in  ['Entertainment','Learning','Everything Else']" do
      @category = Category.new(name:"Random")
      expect(@category.save).to be_falsey
      expect(@category.errors.full_messages.to_sentence).to eq("Name is not included in the list")
      @category.name = 'Entertainment'
      expect(@category.save).to be_truthy

      @category = Category.new(name:'Learning')
      expect(@category.save).to be_truthy

      @category.name = 'Everything Else'
      expect(@category.save).to be_truthy

    end

    it "Name must be unique" do
      @category1 = Category.new(name:'Learning')
      expect(@category1.save).to be_truthy
      @category2 = Category.new(name:'Learning')
      expect(@category2.save).to be_falsey
      expect(@category2.errors.full_messages.to_sentence).to eq("Name has already been taken")

      @category2.name = 'Entertainment'
      expect(@category2.save).to be_truthy
    end
  end
end
