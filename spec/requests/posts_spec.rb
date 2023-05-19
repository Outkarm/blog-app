require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:user_id/posts' do
    let(:user) { User.create(name: 'John Doe') }
    let!(:post1) { Post.create(title: 'First Post', text: 'This is the first post', author: user) }
    let!(:post2) { Post.create(title: 'Second Post', text: 'This is the second post', author: user) }

    it 'renders the index template' do
      get "/users/#{user.id}/posts"
      expect(response).to render_template(:index)
    end

    it 'returns a success response' do
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(:success)
    end

    it 'displays the titles of all posts' do
      get "/users/#{user.id}/posts"
      expect(response.body).to include(post1.title)
      expect(response.body).to include(post2.title)
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    let(:user) { User.create(name: 'John Doe') }
    let(:post) { Post.create(title: 'Sample Post', text: 'This is a sample post', author: user) }

    it 'renders the show template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template(:show)
    end

    it 'returns a success response' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to have_http_status(:success)
    end
    it 'returns a status 200' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.status).to eq(200)
    end
  end

  # Add tests for other actions (index, new, create) here
end
