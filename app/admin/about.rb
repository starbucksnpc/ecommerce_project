ActiveAdmin.register_page "About" do
  content do
    panel "About Page" do
      render 'admin/static_pages_form', page: :about
    end
  end
end