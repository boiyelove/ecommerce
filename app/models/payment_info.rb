class PaymentInfo < ApplicationRecord
  belongs_to :user
  belongs_to :order, optional: true
end