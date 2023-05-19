require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  before :each do
    @user = User.create(name: 'KoyOutkarm', photo: 'https://picsum.photos/200/300', bio: 'I am a software engineer',
                        posts_counter: 0)
    @post = Post.create(title: 'This is my first post!!', text: 'I like it!! it is a good post', author_id: @user.id,
                        comments_counter: 0, likes_counter: 0)

    @comment = Comment.create(text: 'I enjoyed watching football games!!', author_id: @user.id, post_id: @post.id)
  end

  describe 'when i visit post index page' do
    it "shows the user's username" do
      visit user_posts_path(@user.id)
      expect(page).to have_content(@user.name)
      expect(page).to have_selector('.user-cont', count: 1)
    end

    it "shows the user's profile picture" do
      visit user_posts_path(@user.id)
      expect(page).to have_selector('.u-img-cont', count: 1)
    end

    it 'shows the number of posts the user has written' do
      visit user_posts_path(@user.id)
      expect(page).to have_content(@user.posts_counter)
      expect(page).to have_selector('.post-num', count: 1)
    end

    it "shows the post's title" do
      visit user_posts_path(@user.id)
      expect(page).to have_text(@post.title)
    end

    it "shows some of the post's body" do
      visit user_posts_path(@user.id)
      expect(page).to have_text(@post.text.truncate(10, omission: ''))
    end

    it 'shows the first comments on a post' do
      visit user_posts_path(@user.id)
      expect(page).to have_text(@comment.text)
    end

    it 'shows how many comments a post has' do
      visit user_posts_path(@user.id)
      expect(page).to have_text(@post.comments_counter)
      expect(page).to have_selector('.stats', count: 1)
    end

    it 'shows how many likes a post has' do
      visit user_posts_path(@user.id)
      expect(page).to have_text(@post.likes_counter)
      expect(page).to have_selector('.stats', count: 1)
    end

    it 'shows a section for pagination if there are more posts than fit on the view' do
      visit user_posts_path(@user.id)
      expect(page).to have_button('Create new post')
    end
  end

  describe 'Click events on index page' do
    context 'When I click a post' do
      it "should redirects me to that post's show page" do
        visit user_posts_path(@user.id)
        click_link @post.title
        sleep(1)
        expect(page.current_path).to eq(user_post_path(@user.id, @post))
      end
    end
  end
end
