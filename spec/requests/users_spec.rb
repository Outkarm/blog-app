require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET' do
    describe '/users/index' do
      it('returns a success response') do
        get users_path
        expect(response).to have_http_status(200)
      end

      it('renders the index template') do
        get users_path
        expect(response).to render_template(:index)
      end

      it('includes placeholder text') do
        get users_path
        expect(response.body).to include('<h1>Users</h1>')
      end
    end

    describe 'get users from /users/:id' do
      it 'returns a successful response' do
        user = User.create!(name: 'Mark', photo: 'https://i.imgur.com/1.jpg', bio: 'Hey I am Mark.',
            posts_counter: 1)
        get "/users/#{user.id}"

        expect(response).to be_successful
        expect(response.body).to include('<h1>user 1</h1>')
        expect(response).to render_template(:show)
      end
    end
  end
end