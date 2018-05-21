class Match::Form < Rectify::Form
  mimic :match

  attribute :asker_id,            Integer
  attribute :accepter_id,         Integer
  attribute :accepted,            Boolean, default: false
  attribute :asker_next_step,     Boolean, default: false
  attribute :accepter_next_step,  Boolean, default: false

end
