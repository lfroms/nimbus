# frozen_string_literal: true
class UseCaseService
  def self.execute(params = {})
    new.execute(params)
  end

  def execute(_params)
    raise NotImplementedError, '#execute must be implemented by the child class'
  end
end
