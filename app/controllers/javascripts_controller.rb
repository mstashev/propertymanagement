class JavascriptsController < ApplicationController
  def dynamic_units
    @units = Unit.find(:all)
  end
end