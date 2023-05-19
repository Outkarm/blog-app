require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe 'GET /users' do
    it 'returns a successful response' do
      get users_path
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get users_path
      expect(response).to render_template(:index)
    end
  end
  describe 'GET /users/:id' do
    let(:user) { User.create(name: 'John Doe') }

    it 'returns a successful response' do
      get user_path(user)
      expect(response).to have_http_status(200)
    end

    it 'renders the show template' do
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it 'includes the correct user name in the response body' do
      get user_path(user)
      expect(response.body).to include('John Doe')
    end
  end
end
