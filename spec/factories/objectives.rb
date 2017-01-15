# == Schema Information
#
# Table name: objectives
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string
#  description :text
#  completed   :boolean          default(FALSE)
#  deadline    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :integer          default(0)
#

FactoryGirl.define do
  factory :objective do
    
  end

end
