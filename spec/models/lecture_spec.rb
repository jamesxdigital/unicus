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

require 'rails_helper'

RSpec.describe Lecture, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
