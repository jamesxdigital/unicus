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

FactoryGirl.define do
  factory :calendar do
    user_id 1
lectures_id 1
  end

end
