describe 'Bookmark Manager Features' do
  let(:tag) { [Tag.new(name: 'education')]}

  feature 'list of bookmark links' do
    scenario 'user can see a list of links on links page' do
      Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy',
                  tags: tag)
      visit '/links'
      expect(page).to have_selector('ul#links', text: 'Makers Academy') 
    end
  end

  feature 'adding links to bookmarks list' do
    scenario 'user can add a link to the list using a form' do
      visit '/links/new'
      fill_in 'title', with: 'XKCD'
      fill_in 'url', with: 'https://xkcd.com/'
      click_button 'CREATE'
      expect(page).to have_selector('ul#links', text: 'XKCD') 
    end
  end

  feature 'adding tags to links' do
    scenario 'I can add a single tag to a new link' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tag',  with: 'education'

    click_button 'CREATE'
    link = Link.first
    expect(link.tags.map(&:name)).to include('education')
  end

    scenario 'user can add a tag to links added' do
      visit '/links/new'
      fill_in 'title', with: 'XKCD'
      fill_in 'url', with: 'https://xkcd.com/'
      fill_in 'tag', with: 'favourites'
      click_button 'CREATE'
      expect(page).to have_selector('ul#links', text: 'favourites')
    end
  end
end
