require 'rails_helper'

describe User do

    let!(:email){Faker::Internet.email}
    let!(:password){Faker::Internet.password}

    context 'Create User' do
        it 'should create a new user' do

            user = User.create(email: email, password: password)

            # Testing that email gets set and is valid format
            expect(user.email).to eq(email)
            expect(user.email).to match(/\A[^@\s]+@[^@\s]+\z/)

            # Testing that password gets set and is within length requirements
            expect(user.password).to eq(password)
            expect(user.password.length).to be_between(6, 20).inclusive

        end
    end

    context 'Update User' do
        it 'should change users email and password' do

            user = User.create(email: email, password: password)

            user.update(email: 'new@new.ca', password: 'newPassword')

            # Testing that email and password update
            expect(user.password).to eq('newPassword')
            expect(user.email).to eq('new@new.ca')

        end
    end
end