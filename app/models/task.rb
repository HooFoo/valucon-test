class Task < ApplicationRecord

  validates :name, presence: true,
                   length: {min:2,max:50}

  belongs_to :user
  mount_uploader :file, TaskUploader

  state_machine :state, :new => :finished do
    state :new do

    end
    state :started do

    end
    state :finished do

    end
  end

end
