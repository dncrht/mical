FactoryBot.define do
  sequence :position do |n|
    n * 10
  end

  factory :activity do
    name { 'Programming' }
    position
    color { '#0FF1CE' } # A cyan tint in http://en.wikipedia.org/wiki/Hexspeak
  end
end
