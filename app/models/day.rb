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

class Day < ActiveRecord::Base
  has_many :lectures, dependent: :destroy

  validates :date, :name, :display_size, presence: true

  validates :date, format: { with: /([0][1-9]|[12][0-9]|[3][01])\/([0][0-9]|[1][012])\/([2][0][0-2][0-9])/,
            message: " : Invalide date" }

  validates_uniqueness_of :date,  message: " : This date has already exist"

  def full_date
    " #{self.name} #{self.date} "
  end

end
