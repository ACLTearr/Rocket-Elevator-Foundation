require 'spec_helper'
require 'rails_helper'

RSpec.describe Employee do
    subject {
        described_class.new(first_name: 'Kaelen',
                            last_name: 'Burroughs',
                            title: 'Developer',
                            email: 'test@test.ca',
                            user_id: 1)
    }

    context 'Check that employee' do
        # Testing that employee is valid when correct attributes are given
        it 'is valid with proper attributes' do
            expect(subject.email).to match(/\A[^@\s]+@[^@\s]+\z/)
            expect(subject).to be_valid
        end
        
        # Testing that employee is NOT valid when first name is blank
        it 'is invalid with no first name' do
            subject.first_name = nil
            expect(subject).to_not be_valid
            expect(subject.errors.messages[:first_name]).to eq ["can't be blank"]
        end
        
        # Testing that employee is NOT valid when last name is blank
        it 'is invalid with no last name' do
            subject.last_name = nil
            expect(subject).to_not be_valid
            expect(subject.errors.messages[:last_name]).to eq ["can't be blank"]
        end
        
        # Testing that employee is NOT valid when title is blank
        it 'is invalid with no title' do
            subject.title = nil
            expect(subject).to_not be_valid
            expect(subject.errors.messages[:title]).to eq ["can't be blank"]
        end
        
        # Testing that employee is NOT valid when email is nil
        it 'is invalid with no email' do
            subject.email = nil
            expect(subject).to_not be_valid
            expect(subject.errors.messages[:email]).to eq ["can't be blank", 'is invalid']
        end
        
        # Testing that employee is NOT valid when email is invalid
        it 'is invalid with invalid email formatting' do
            subject.email = 'invalidEmail'
            expect(subject).to_not be_valid
            expect(subject.errors.messages[:email]).to eq ['is invalid']
        end
        
        # Testing that employee is NOT valid when email is blank
        it 'is invalid with blank email' do
            subject.email = ''
            expect(subject).to_not be_valid
            expect(subject.errors.messages[:email]).to eq ["can't be blank", 'is invalid']
        end
    end
end