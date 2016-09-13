class Bird
  include Mongoid::Document

  field :name, type: String
  field :family, type: String
  field :continents, type: Array
  field :visible, type: Boolean, default: false
  field :added, type: String, default: Time.now.utc.strftime("%F")

  index( visible: 1 )

  validates_presence_of :name, :family, :continents, :visible, :added

  before_create :unique_continents

  scope :visible_birds, -> { where(visible: true) }

  private

  def unique_continents
    self.continents.uniq!
  end

end