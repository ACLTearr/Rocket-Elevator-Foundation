class Employee < ApplicationRecord
  belongs_to :user, optional: true
  has_many :batteries, dependent: :destroy
  validates_presence_of :first_name, :last_name, :title, :email
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
end
