# As a user,
# So that I can leave my bookmark manager safely,
# I'd like to sign out.

feature 'user sign out' do
  let(:user) do
    User.create(name: 'Joe B',
                email: 'joe.bloggs@gmail.com',
                password: 'jo3ble0bl3',
                password_confirmation: 'jo3ble0bl3')
  end

  scenario 'session deleted and goodbye message dislayed' do
    sign_in(email: user.email, password: user.password)
    click_button 'Sign out'    
    expect(current_path).to eq '/'
    expect(page).to have_content 'Goodbye'
    expect(page).to_not have_content "Welcome, #{user.name}"
  end
end
