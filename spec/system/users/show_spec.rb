require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before :each do
    @user = User.create(name: 'KoyOutkarm', photo: 'https://picsum.photos/200/300', bio: 'I am a software engineer',
                        posts_counter: 0)
    @post = Post.create(title: 'This is my first post!!', text: 'I like it!!', author_id: @user.id,
                        comments_counter: 0, likes_counter: 0)
  end

  describe 'when i visit show user page' do
    it "shows the user's username" do
      visit user_path(@user.id)
      expect(page).to have_content(@user.name)
      expect(page).to have_selector('.user-details', count: 1)
    end

    it "shows the user's profile picture" do
      visit user_path(@user.id)
      expect(page).to have_selector('.u-img-cont', count: 1)
    end

    it 'shows the number of posts the user has written' do
      visit user_path(@user.id)
      expect(page).to have_content(@user.posts_counter)
      expect(page).to have_selector('.postno', count: 1)
    end

    it "shows the user's bio" do
      visit user_path(@user.id)
      expect(page).to have_text(@user.bio)
    end

    it "shows the user's first 3 posts" do
      visit user_path(@user.id)
      expect(page).to have_selector('.all-user-post', maximum: 3)
    end

    it "shows a button that lets me view all of a user's posts" do
      visit user_path(@user.id)
      expect(page).to have_link('See all posts')
    end
  end

  describe 'Click events on show page' do
    context "When I click a user's post" do
      it "should redirects me to that post's show page" do
        visit user_path(@user.id)
        click_link @post.title
        sleep(1)
        expect(page.current_path).to eq(user_post_path(@user.id, @post))
      end
    end

    context 'When I click to see all posts,' do
      it "should redirect me to the user's post's index page" do
        visit user_path(@user.id)
        click_link 'See all posts'
        sleep(1)
        expect(page.current_path).to eq(user_posts_path(@user.id))
      end
    end
  end
end
