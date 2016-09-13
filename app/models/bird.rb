class Bird
  include Mongoid::Document

  field :name, type: String
  field :family, type: String
  field :continents, type: Array
  field :visible, type: Boolean, default: false
  field :added, type: String

  index( visible: 1 )

  scope :visible_birds, -> { where(visible: true) }

end