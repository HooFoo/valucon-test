class Task < ApplicationRecord
  belongs_to :user
  mount_uploader :file, TaskUploader
end
