class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  has_many :children, class_name: "Comment", foreign_key: "parent_id"

  belongs_to :parent, class_name: "Comment"
end
