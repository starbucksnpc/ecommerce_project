class StaticPagesController < ApplicationController
  def contact
    @page_content = AdminPageContent.get_contact_page_content
  end

  def about
    @page_content = AdminPageContent.get_about_page_content
  end
end
