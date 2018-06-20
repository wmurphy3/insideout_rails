class PromoteJob < ActiveJob::Base
  queue_as :transmit_promote_job

  def max_attempts
    3
  end

  def perform(data)
    Shrine::Attacher.promote(data)
  end

end
