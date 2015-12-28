# As a user,
# So that I can access my bookmark manager,
# I'd like to sign in.

feature 'user sign in' do
  let(:user) do
    User.create(name: 'Joe B',
                email: 'joe.bloggs@gmail.com',
                password: 'jo3ble0bl3',
                password_confirmation: 'jo3ble0bl3')
  end

  scenario 'with correct credentials and is redirected to their links page' do
    sign_in(email: user.email, password: user.password)
    expect(current_path).to eq('/links')
    expect(page).to have_content "Welcome, #{user.name}"
  end
end
