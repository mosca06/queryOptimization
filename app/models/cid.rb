class Cid < ApplicationRecord
  has_many :user_cids
  has_many :user, through: :user_cids
end
