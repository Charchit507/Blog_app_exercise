require 'rails_helper'
RSpec.describe CommentsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password", password_confirmation: "password") }
  let(:article) { Article.create(title: "Sample Title", text: "Lorem ipsum dolor sit amet.") }

  before do
    sign_in user
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new comment" do
        expect {
          post :create, params: { article_id: article.id, comment: { commenter: "John Doe", body: "Sample Comment" } }
        }.to change(Comment, :count).by(1)
      end

      it "redirects to the article page" do
        post :create, params: { article_id: article.id, comment: { commenter: "John Doe", body: "Sample Comment" } }
        expect(response).to redirect_to(article_path(article))
      end
    end

    context "with invalid params" do
      it "does not create a new comment" do
        expect {
          post :create, params: { article_id: article.id, comment: { commenter: nil, body: nil } }
        }.to_not change(Comment, :count)
      end

      it "redirects back to the article page" do
        post :create, params: { article_id: article.id, comment: { commenter: "John Doe", body: nil } }
        expect(response).to redirect_to(article_path(article))
      end
    end
  end

#   describe "DELETE #destroy" do
#     let(:comment) { article.comments.create(commenter: "John Doe", body: "Sample Comment") }

#     it "destroys the requested comment" do
#       comment 
#       expect {
#         delete :destroy, params: { article_id: article.id, id: comment.id }
#       }.to change(Comment, :count).by(-1)
#     end

#     it "redirects to the article page" do
#       delete :destroy, params: { article_id: article.id, id: comment.id }
#       expect(response).to redirect_to(article_path(article))
#     end
#   end
end