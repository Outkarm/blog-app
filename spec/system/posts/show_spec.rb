require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  before :each do
    @user = User.create(name: 'KoyOutkarm', photo: 'https://picsum.photos/200/300', bio: 'I am a software engineer',
                        posts_counter: 0)
    @post = Post.create(title: 'This is my first post!!', text: 'I like it!! it is a good post', author_id: @user.id,
                        comments_counter: 0, likes_counter: 0)

    @comment = Comment.create(text: 'I enjoyed watching football games!!', author_id: @user.id, post_id: @post.id)
    @comment2 = Comment.create(text: 'Just another comment', author_id: @user.id, post_id: @post.id)
  end

  describe 'when i visit show post page, it' do
    it 'shows who wrote the post' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content(@user.name)
    end
    it "shows the post's title" do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_text(@post.author.name)
    end
    it 'shows how many comments it has' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_text(@post.comments_counter)
      expect(page).to have_selector('.pd-postH', count: 1)
    end
    it 'shows how many likes it has' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_text(@post.likes_counter)
      expect(page).to have_selector('.pd-postH', count: 1)
    end
    it "shows the post's body" do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_text(@post.text)
    end
    it 'shows the username of each commentor.' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_content(@comment.author.name)
      expect(page).to have_content(@comment2.author.name)
    end
    it 'shows the comment each commentor left' do
      visit user_post_path(@user.id, @post.id)
      expect(page).to have_text(@comment.text)
      expect(page).to have_text(@comment.text)
    end
  end
end
