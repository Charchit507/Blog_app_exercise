require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:article) { Article.create(title: "Sample Title", text: "Lorem ipsum dolor sit amet.") }
  let(:user) { User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password", password_confirmation: "password") }
  subject { described_class.new(commenter: user.name, body: "Sample Comment", article: article, user: user) }

  describe 'associations' do
    it "should belong to article" do
      association = described_class.reflect_on_association(:article)
      expect(association.macro).to eq(:belongs_to)
    end

    it "should belong to user" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
