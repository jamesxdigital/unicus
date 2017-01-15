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

require 'rails_helper'

RSpec.describe Calendar, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
