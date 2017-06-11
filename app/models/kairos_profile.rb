class KairosProfile < ApplicationRecord
  belongs_to :user
  before_save :set_attribs

  validates :user, uniqueness: true

  def data
    @data ||= Facey.new(image_url)
  end

  def set_attribs
    self.chin_to_eye_height = data.chin_to_eye_height
    self.eye_width = data.eye_width
    self.face_proportion = data.face_proportion
    self.hispanic = data.races.hispanic
    self.asian = data.races.asian
    self.white = data.races.white
    self.black = data.races.black
    self.other = data.races.other
    self
  end

  def priorities

  end

  def attrib_priority(attrib)
    user.likes.kairos_profiles.map { |kp| send(attrib) }.to_data_collection.remove_outliers.standard_deviation
  end

end
