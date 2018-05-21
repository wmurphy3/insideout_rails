class DeclineMatch::Form < Rectify::Form
  mimic :decline_match

  attribute :asker_id,            Integer
  attribute :accepter_id,         Integer

end
