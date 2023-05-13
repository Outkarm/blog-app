require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET' do
    describe '/posts/index' do
      before(:each) do
        user = User.create!(name: 'Mark', photo: 'https://i.imgur.com/1.jpg', bio: 'Hey I am Mark.',
                            posts_counter: 1)
        get "/users/#{user.id}/posts"
      end

      it('returns a success response') do
        expect(response).to have_http_status(200)
      end

      it('renders index template') do
        expect(response).to render_template(:index)
      end

      it('includes placeholder text') do
        expect(response.body).to include('<h1>Posts</h1>')
      end
    end

    describe '/posts/show' do
      before(:each) do
        user = User.create!(name: 'Mark', photo: 'https://i.imgur.com/1.jpg', bio: 'Hey I am Mark.',
                            posts_counter: 1)
        post = Post.create!(author: user, title: 'First Post', text: 'This is a the first post.',
                            comments_counter: 0, likes_counter: 0)
        get "/users/#{user.id}/posts/#{post.id}"
      end

      it('returns a success response') do
        expect(response).to have_http_status(200)
      end

      it('renders show template') do
        expect(response).to render_template(:show)
      end

      it('includes placeholder text') do
        expect(response.body).to include('<h1>Here is a list of posts for a given user<h1>')
      end
    end
  end
end
