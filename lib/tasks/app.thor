require "thor/rails"

class App < Thor
  include Thor::Rails

  desc "env", "print environment"
  def env
    say ::Rails.env
  end
end
