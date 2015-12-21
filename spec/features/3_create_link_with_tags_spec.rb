# As a user,
# So that I can refer to and organize my links,
# I'd like to be able to add subject tags to links.

feature 'creating links with tags' do
  scenario 'user creates link with single tag' do
    visit '/links/new'
    fill_in 'title', with: 'Google'
    fill_in 'url', with: 'https://google.co.uk/'
    fill_in 'tag', with: 'search'
    click_button 'CREATE'

    link = Link.first
    expect(link.tags.map(&:name)).to include 'search'
  end

  scenario 'user creates link with single tag' do
    visit '/links/new'
    fill_in 'title', with: 'Google'
    fill_in 'url', with: 'https://google.co.uk/'
    fill_in 'tag', with: 'search'
    click_button 'CREATE'

    expect(page).to have_selector('ul#links', text: 'search')
  end
end
