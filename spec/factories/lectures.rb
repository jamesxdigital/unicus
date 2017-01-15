# == Schema Information
#
# Table name: lectures
#
#  id            :integer          not null, primary key
#  lecture_title :string           not null
#  column_name   :string           not null
#  start_time    :string           not null
#  end_time      :string           not null
#  description   :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  location      :string           not null
#  day_id        :integer
#  upavatar      :string
#  key_speaker   :string
#  is_break      :boolean
#
# Indexes
#
#  index_lectures_on_day_id  (day_id)
#

FactoryGirl.define do
  factory :lecture do
    lecture_title "MyString"
lecture_day "MyString"
column 1
start_time "MyString"
end_time "MyString"
registered_speakers "MyString"
guest_speakers "MyString"
description "MyString"
  end

end
