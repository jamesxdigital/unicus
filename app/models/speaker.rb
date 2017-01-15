# == Schema Information
#
# Table name: speakers
#
#  id                  :integer          not null, primary key
#  speaker_title       :string
#  forename            :string
#  surname             :string
#  organisation        :string
#  biography           :string
#  academic_background :string
#  email               :string
#  website             :string
#  facebook            :string
#  twitter             :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar              :string
#  linkedIn            :string
#  display_email       :string
#  to_display          :string
#

class Speaker < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader


  validates_uniqueness_of :email,  message: " address used by another speaker"

  def full_name
    "#{self.forename} #{self.surname}"
  end
end
