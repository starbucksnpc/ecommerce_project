# app/admin/static_page.rb
ActiveAdmin.register StaticPage do
  permit_params :title, :content

  index do
    selectable_column
    id_column
    column :title
    actions
  end

  form do |f|
    f.inputs "Static Page Details" do
      f.input :title
      f.input :content, as: :text
    end
    f.actions
  end
end
