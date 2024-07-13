ActiveAdmin.register_page "Contact" do
  content do
    panel "Contact Page" do
      render 'admin/static_pages_form', page: :contact
    end
  end
end