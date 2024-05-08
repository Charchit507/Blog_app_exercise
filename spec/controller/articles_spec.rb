require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password", password_confirmation: "password") }
  let!(:articles) { Article.create(title: "Sample Title", text: "Sample Text") }
  
  before do
    sign_in user
  end
  
  describe "GET #index" do
    # it "assigns @articles" do
    #   get :index
    #   expect(assigns(:articles)).to eq(Article.all)
    # end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "assigns @article" do
      article = articles
      get :show, params: { id: article.id }
      
      expect(assigns(:article)).to eq(article)
    end

    it "renders the show template" do
      article = articles
      get :show, params: { id: article.id }
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    it "assigns a new Article to @article" do
      get :new
      expect(assigns(:article)).to be_a_new(Article)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "GET #edit" do
    it "assigns the requested article to @article" do
      article = articles
      get :edit, params: { id: article.id }
      expect(assigns(:article)).to eq(article)
    end

    it "renders the edit template" do
      article = articles
      get :edit, params: { id: article.id }
      expect(response).to render_template("edit")
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new article" do
        expect {
          post :create, params: { article: { title: "New Article", text: "This is a new article." } }
        }.to change(Article, :count).by(1)
      end

      it "redirects to the created article" do
        post :create, params: { article: { title: "New Article", text: "This is a new article." } }
        expect(response).to redirect_to(Article.last)
      end
    end

    context "with invalid params" do
      it "does not save the new article" do
        expect {
          post :create, params: { article: { title: "", text: "" } }
        }.to_not change(Article, :count)
      end

      it "re-renders the new template" do
        post :create, params: { article: { title: "", text: "" } }
        expect(response).to render_template("new")
      end
    end
  end

  describe "PATCH #update" do
    let(:article) { articles }

    context "with valid params" do
      it "updates the requested article" do
        patch :update, params: { id: article.id, article: { title: "Updated Title", text: "Updated Text" } }
        article.reload
        expect(article.title).to eq("Updated Title")
        expect(article.text).to eq("Updated Text")
      end

      it "redirects to the article" do
        patch :update, params: { id: article.id, article: { title: "Updated Title", text: "Updated Text" } }
        expect(response).to redirect_to(article)
      end
    end

    context "with invalid params" do
      it "does not update the article" do
        patch :update, params: { id: article.id, article: { title: "", text: "" } }
        article.reload
        expect(article.title).to_not eq("")
        expect(article.text).to_not eq("")
      end

      it "re-renders the edit template" do
        patch :update, params: { id: article.id, article: { title: "", text: "" } }
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:article) { articles }

    it "destroys the requested article" do
      expect {
        delete :destroy, params: { id: article.id }
      }.to change(Article, :count).by(-1)
    end

    it "redirects to the articles list" do
      delete :destroy, params: { id: article.id }
      expect(response).to redirect_to(articles_path)
    end
  end
end