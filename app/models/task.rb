class Task < ApplicationRecord
  belongs_to :user
  belongs_to :department

  belongs_to :lawyer,
           class_name: "User",
           foreign_key: :lawyer_id,
           optional: true
end
