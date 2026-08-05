class LeaveRequest < ApplicationRecord
  belongs_to :user
  belongs_to :parent,
             class_name: "User",
             foreign_key: :parent_id,
             optional: true
end
