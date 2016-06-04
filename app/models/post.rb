class Post < ActiveRecord::Base
  has_many :subs,
  through: :post_subs,
  source: :sub

  belongs_to :author,
    class_name: :User,
    foreign_key: :user_id,
    primary_key: :id

  has_many :post_subs,
    foreign_key: :post_id,
    primary_key: :id,
    class_name: :PostSub

  has_many :comments, as: :commentable

end
