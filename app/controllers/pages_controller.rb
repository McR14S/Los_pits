class PagesController < ApplicationController
  skip_before_action :protect_pages, only: [:home, :about_us]

  def home

  end

  def about_us

  end
end
