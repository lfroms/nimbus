# frozen_string_literal: true
class String
  def to_unix
    Date.parse(self).to_time.to_i
  end
end
