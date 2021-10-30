class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def about
  end

  def setup
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
end
