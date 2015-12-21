# As a user,
# So that I can expand my list of links with new and interesting ones,
# I'd like to be able to add links with a title.

feature 'adding links to bookmarks list' do
  scenario 'user can add link to the list using a form' do
    visit '/links/new'
    fill_in 'title', with: 'XKCD'
    fill_in 'url', with: 'https://xkcd.com/'
    click_button 'CREATE'
    expect(page).to have_selector('ul#links', text: 'XKCD')
  end
end
