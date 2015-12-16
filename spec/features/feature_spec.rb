describe 'Bookmark Manager Features' do

  feature 'list of bookmark links' do
    scenario 'user can see a list of links on links page' do
      Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
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
end
