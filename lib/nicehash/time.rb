require 'time'

class Time
  # Converts a Time value to an integer number of miliseconds, since the
  # Unix epoch
  def to_ms
    (self.to_f * 1000).truncate
  end
end
