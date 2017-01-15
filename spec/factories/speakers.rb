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

FactoryGirl.define do
  factory :speaker do
    speaker_title "MyString"
forename "MyString"
surname "MyString"
organisation "MyString"
biography "MyString"
academic_background "MyString"
email "MyString"
website "MyString"
facebook "MyString"
twitter "MyString"
  end

end
