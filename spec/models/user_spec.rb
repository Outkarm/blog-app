require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(name: 'John Doe', posts_counter: 2) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).not_to be_valid
    end

    it 'is not valid with a negative posts_counter' do
      subject.posts_counter = -1
      expect(subject).not_to be_valid
    end
  end

  describe 'recent_post' do
    let!(:user) { User.create(name: 'John Doe', posts_counter: 2) }

    it 'returns the 3 most recent posts for the user' do
      post1 = Post.create(author: user, title: 'Post 1', text: 'This is post 1')
      post2 = Post.create(author: user, title: 'Post 2', text: 'This is post 2')
      post3 = Post.create(author: user, title: 'Post 3', text: 'This is post 3')
      post4 = Post.create(author: user, title: 'Post 4', text: 'This is post 4')

      expect(user.recent_post).to eq([post4, post3, post2])
    end

    it 'returns less than 3 posts if there are not enough posts' do
      post4 = Post.create(author: user, title: 'Post 1', text: 'This is post 1')

      expect(user.recent_post).to eq([post4])
    end
  end
end
