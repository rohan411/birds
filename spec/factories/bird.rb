FactoryGirl.define do
  factory :bird, :class => Bird do
    name "Pigeon"
    family "Birds"
    continents ["Asia", "Euorope"]
    visible true
    added "2016-10-12"
  end
end