# As a user,
# So that I can use the links I have created,
# I'd like to view my list of links.

feature 'viewing book marks' do
  scenario 'see list of bookmark links on homepage' do
    Link.create(url: 'http://makersacademy.com', title: 'Makers Academy')
    visit '/links'
    expect(page).to have_selector('ul#links', text: 'Makers Academy')
  end
end





