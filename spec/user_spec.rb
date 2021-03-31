require 'rails_helper'

describe User do

    email = "test@test.com"
    password = "123456"
    newPassword = "654321"

    user = User.create(email: email, password: password)

    context 'Create User' do
        it 'should create a new user' do

            # Testing that email gets set and is valid
            expect(user.email).to eq(email)
            expect(user.email).to match(/\A\w+@\w+\.\w{2,3}\Z/)

            # Testing that password gets set and is within length requirements
            expect(user.password).to eq(password)
            expect(user.password.length).to be_between(6, 20).inclusive

        end
    end

    context 'Update User' do
        it 'should change users password' do

            user.update(password: newPassword)

            # Testing that password updates
            expect(user.password).to eq(newPassword)

        end
    end
end