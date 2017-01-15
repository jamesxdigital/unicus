# == Schema Information
#
# Table name: company_values
#
#  id            :integer          not null, primary key
#  company_value :string
#  icon          :string
#  colour        :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryGirl.define do
  factory :company_value do
    company_value "MyString"
icon "MyText"
colour "MyText"
  end

end
