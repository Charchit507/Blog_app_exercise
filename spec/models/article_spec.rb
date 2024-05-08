require 'rails_helper'

RSpec.describe Article, type: :model do
  subject { described_class.new(title: "Sample Title", text: "Lorem ipsum dolor sit amet.") }

  describe 'validations' do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a title" do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with a title less than 5 characters" do
      subject.title = "Shor"
      expect(subject).to_not be_valid
    end

    it "is valid with a title of 5 characters or more" do
      subject.title = "Long enough title"
      expect(subject).to be_valid
    end
  end

  describe 'associations' do
    it "should have many comments" do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe 'custom methods' do
    describe '.ransackable_attributes' do
      it 'returns an array with title and text' do
        expect(Article.ransackable_attributes).to eq(%w(title text))
      end
    end
  end

  describe 'pagination' do
    it 'should paginate 15 items per page' do
      expect(Article.default_per_page).to eq(15)
    end
  end
end
