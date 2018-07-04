require 'rails_helper'

RSpec.describe Admin::ArticlesController, type: :controller do

  # this lets us inspect the rendered results
  render_views

  let(:article) { create(:article) }

  let(:valid_attributes) do
    attributes_for :article
  end

  let(:invalid_attributes) do
    { title: '', announcement: '' }
  end

  describe "GET index" do
    it 'returns http success' do
      article
      get :index
      expect(response).to have_http_status(:success)
    end
    it 'assigns the article' do
      get :index
      expect(assigns(:articles)).to include(article)
    end
  end

  describe "GET new" do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST create" do
    context "with valid params" do
      it "creates a new Article" do
        expect {
          post :create, params: { article: valid_attributes }
        }.to change(Article, :count).by(1)
      end

      it "assigns a newly created article as @article" do
        post :create, params: { article: valid_attributes }
        expect(assigns(:article)).to be_a(Article)
        expect(assigns(:article)).to be_persisted
      end

      it "redirects to the created article" do
        post :create, params: { article: valid_attributes }
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(admin_article_path(Article.last))
      end

      it 'should create the article' do
        post :create, params: { article: valid_attributes }
        article = Article.last

        expect(article.title).to eq(valid_attributes[:title])
        expect(article.announcement).to  eq(valid_attributes[:announcement])
      end
    end

    context "with invalid params" do
      it 'invalid_attributes return http success' do
        post :create, params: { article: invalid_attributes }
        expect(response).to have_http_status(:success)
      end

      it "assigns a newly created but unsaved article as @article" do
        post :create, params: { article: invalid_attributes }
        expect(assigns(:article)).to be_a_new(Article)
      end

      it 'invalid_attributes do not create a Article' do
        expect do
          post :create, params: { article: invalid_attributes }
        end.not_to change(Article, :count)
      end
    end
  end
end
