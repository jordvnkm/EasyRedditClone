class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  has_many :child_comments,
  primary_key: :id,
  foreign_key: :parent_comment_id,
  class_name: :Comment
  belongs_to :parent,
  primary_key: :id,
  foreign_key: :parent_comment_id,
  class_name: :Comment
end
