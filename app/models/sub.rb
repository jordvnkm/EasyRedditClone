class Sub < ActiveRecord::Base
  validates :title, :description, :user_id, presence: true

  belongs_to :user,
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id


  has_many :post_subs,
    foreign_key: :sub_id,
    primary_key: :id,
    class_name: :PostSub

  has_many :posts,
  through: :post_subs,
  source: :post
end
