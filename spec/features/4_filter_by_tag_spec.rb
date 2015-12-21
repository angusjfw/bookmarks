# As a user,
# So that Ican find specific links,
# I'd like to filter links by tags.

feature 'filter links by tag' do
  scenario 'user can view all links with a particular tag' do
    news_tag = Tag.create(name: 'news')
    gaming_tag = Tag.create(name: 'Gaming')
    Link.create(url: 'http://bbc.com', title: 'BBC', tags: [news_tag])
    Link.create(url: 'http://sky.com', title: 'Sky', tags: [news_tag])
    Link.create(url: 'http://game.com', title: 'Game', tags: [gaming_tag])
    visit '/tags/news'

    within 'ul#links' do
      expect(page).to have_content 'BBC Sky'
      expect(page).to_not have_content 'Game'
    end
  end
end
