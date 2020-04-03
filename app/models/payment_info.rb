class PaymentInfo < ApplicationRecord
  belongs_to :user
  belongs_to :order, optional: true
  validates :card_number, :card_exp, :card_pin, presence: true
end
