# == Schema Information
#
# Table name: calendars
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  lectures_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  ddate       :string
#  ltime       :string
#  ddatem      :string
#  ddated      :string
#

class Calendar < ActiveRecord::Base

  validates :lectures_id, uniqueness: { scope: :user_id,
    message: "already added"}

end
