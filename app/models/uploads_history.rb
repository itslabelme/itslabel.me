class UploadsHistory < ApplicationRecord
  validates :admin_user, presence: true
  validates :file_path, presence: true
 end