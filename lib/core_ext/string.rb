# frozen_string_literal: true
class String
  def to_unix
    to_date.to_time.to_i
  end
end
