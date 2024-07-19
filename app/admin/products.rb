ActiveAdmin.register Product do
  permit_params :name, :description, :price, :sale_price, :stock_quantity, :category_ids, images: []

  # 필터링 제거
  config.filters = false

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :stock_quantity
    column :sale_price
    column "Images" do |product|
      if product.images.attached?
        product.images.each do |image|
          span do
            image_tag url_for(image.variant(resize: "100x100"))
          end
        end
      else
        "No Images"
      end
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :stock_quantity
      row :sale_price
      row "Images" do |product|
        if product.images.attached?
          product.images.each do |image|
            span do
              image_tag url_for(image.variant(resize: "200x200"))
            end
          end
        else
          "No Images"
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :sale_price, hint: "Sale price should be less than the regular price"
      f.input :categories, as: :check_boxes
      f.input :images, as: :file, input_html: { multiple: true }, hint: f.object.images.attached? ? image_tag(url_for(f.object.images.first.variant(resize: "100x100"))) : content_tag(:span, "Upload JPG/PNG/GIF image")
    end
    f.actions
  end
end
