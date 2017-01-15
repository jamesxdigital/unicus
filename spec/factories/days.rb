# == Schema Information
#
# Table name: days
#
#  id           :integer          not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  display_size :integer
#  date         :string
#  ddatey       :string
#  ddatem       :string
#  ddated       :string
#

FactoryGirl.define do
  factory :day do
    date "MyString"
name "MyString"
column 1
  end

end
