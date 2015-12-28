# As a user,
# So that I can start using the bookmark manager,
# I'd like to sign up.

feature 'user sign up' do
  scenario 'user names, emails and passwords are stored on valid signup' do
    expect{sign_up(email: 'joe.bloggs@gmail.com')}.to change(User, :count).by 1
    expect(User.first.email).to eq 'joe.bloggs@gmail.com'
  end

  scenario 'flash error if user password and confirmation do not match' do
    expect{sign_up(password_confirmation: 'wrong')}.to_not change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content 'Password does not match the confirmation'
  end

  scenario 'flash error if user signs up without a blank email' do
    expect{sign_up(email: '')}.to_not change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Email must not be blank'
  end

  scenario 'flash error if user signs up with invalid email' do
    expect{sign_up(email: 'invalid@email')}.to_not change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content 'Email has an invalid format'
  end

  scenario 'flash error if sign up email already exists in database' do
    sign_up(email: 'joe.bloggs@gmail.com')
    expect{sign_up(email: 'joe.bloggs@gmail.com')}.to_not change(User, :count)
    expect(current_path).to eq '/users'
    expect(page).to have_content 'Email is already taken'       
  end
end
