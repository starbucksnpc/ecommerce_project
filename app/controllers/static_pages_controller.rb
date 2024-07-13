class StaticPagesController < ApplicationController
  def about
    @about_page = StaticPage.find_by(title: "About Us")
  end

  def contact
    @contact_page = StaticPage.find_by(title: "Contact")
  end
end
