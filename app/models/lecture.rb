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

class Lecture < ActiveRecord::Base

  belongs_to :day
  belongs_to :speaker
  has_many :calendar
  validates :lecture_title, :day_id, :start_time, :end_time, :column_name,  presence: true

  validates :key_speaker, :location, presence: true, :unless => Proc.new { |a| a.is_break }

  validates :column_name, uniqueness: { scope: :start_time,
            message: ": This column already had lectures in the same time, please change column option or change the time" }


  validates :start_time, format: { with: /([01][0-9]|2[0-3]):([0-5][0-9])/,
            message: "Incorrect time format" },
            :if => Proc.new { |a| a.start_time.present? }

  validates :end_time, format: { with: /([01][0-9]|2[0-3]):([0-5][0-9])/,
            message: "Incorrect time format" },
            :if => Proc.new { |a| a.end_time.present? }

  validate :start_must_be_before_end_time,
         :unless => Proc.new { |a| a.errors[:start_time].any? || a.errors[:end_time].any? }

  validate :same_position_when_time_overlap,
           :unless => Proc.new { |a| a.is_break || a.errors[:location].any? }

  validate :same_speaker_when_time_overlap,
           :unless => Proc.new { |a| a.is_break || a.errors[:key_speaker].any?}


  validate :break_cannot_be_plenary_session

  def lecture_day
     "#{Day.where(id: self.day_id).take.full_date}"
  end

  def plenary_session?
    if column_name == "Plenary Session"
      return true
    else
      return false
    end
  end



  private

  def break_cannot_be_plenary_session
    if is_break && column_name == "Plenary Session"
      errors.add(:base, "Cannot put a break time to plenary session!")
    end
  end

  def same_position_when_time_overlap
    Lecture.where(location: location, day_id: day_id).each do |lec|
      if lec.id != id && (lec.start_time.to_f - end_time.to_f) * (start_time.to_f - lec.end_time.to_f) > 0
          errors.add(:location, "is not available in select time")
      end
    end
  end

  def same_speaker_when_time_overlap
   Lecture.where(key_speaker: key_speaker, day_id: day_id).each do |lec|
    if lec.id != id && (lec.start_time.to_f - end_time.to_f) * (start_time.to_f - lec.end_time.to_f) > 0
        errors.add(:base, "This speaker is not available in select time")
     end
    end
  end

  def start_must_be_before_end_time
    errors.add(:end_time, "is before Start time") unless start_time < end_time
  end



end
