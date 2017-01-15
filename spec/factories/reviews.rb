# == Schema Information
#
# Table name: reviews
#
#  id                :integer          not null, primary key
#  objective_id      :integer
#  comments          :text
#  managers_comments :text
#  title             :string
#  completed         :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

FactoryGirl.define do
  factory :review do
    objective_id 1
comments "MyText"
managers_comments "MyText"
title "MyString"
completed false
  end

end
