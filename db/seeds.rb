# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Create an admin user only in development environment if it doesn't exist
=begin if Rails.env.development?
  AdminUser.find_or_create_by!(email: 'admin@example.com') do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end
end


Category.create([
  { name: 'Necklaces' },
  { name: 'Bracelets' },
  { name: 'Rings' },
  { name: 'Nails' }  
])

Product.create([
  {
    name: 'Gold Letter Necklace',
    description: 'Beautiful gold necklace with intricate design.',
    price: 209.99,
    stock_quantity: 15
  },
  {
    name: 'Gold Letter Bracelet',
    description: 'Beautiful gold bracelet with intricate design.',
    price: 199.99,
    stock_quantity: 20
  },
  {
    name: 'Gold Gemini Necklace',
    description: 'Beautiful gold gemini necklace for july-er.',
    price: 499.99,
    stock_quantity: 10
  },
  {
    name: 'Black and Silver Nails',
    description: '100% Hand crafted nails',
    price: 59.99,
    stock_quantity: 8
  },
  {
    name: 'Gold Customized Necklace',
    description: 'Design your own necklace.',
    price: 299.99,
    stock_quantity: 12
  },
  {
    name: 'Cute Summer Necklace',
    description: 'Casual pearl necklace for summer.',
    price: 69.99,
    stock_quantity: 25
  },
  {
    name: 'Heart Ring',
    description: 'Exquisite heart shape ring with a vintage setting.',
    price: 39.99,
    stock_quantity: 7
  },
  {
    name: 'Pearl Necklace',
    description: 'Luxurious pearl necklace fit for royalty.',
    price: 599.99,
    stock_quantity: 5
  },
  {
    name: 'Lisa Bracelet',
    description: 'Chic gold Bracelet for Lisa',
    price: 159.99,
    stock_quantity: 3
  },
  {
    name: 'Star and Moon Ring',
    description: 'Be my star, I will be your moon.',
    price: 59.99,
    stock_quantity: 10
  }
])


ProductCategory.create([
  { product_id: 1, category_id: 1 },  
  { product_id: 2, category_id: 2 },  
  { product_id: 3, category_id: 1 },  
  { product_id: 4, category_id: 4 },  
  { product_id: 5, category_id: 1 },  
  { product_id: 6, category_id: 1 },  
  { product_id: 7, category_id: 3 }, 
  { product_id: 8, category_id: 1 },  
  { product_id: 9, category_id: 2 },  
  { product_id: 10, category_id: 3 }  
]) 



about_page_content = <<-CONTENT.strip_heredoc
  <p>This is our About Us page content.</p>
  <p>You can add any HTML content here.</p>
CONTENT

contact_page_content = <<-CONTENT.strip_heredoc
  <p>This is our Contact Us page content.</p>
  <p>You can add any HTML content here.</p>
CONTENT

# Create or update StaticPage records
about_page = StaticPage.find_or_initialize_by(title: 'About Us')
about_page.update(content: about_page_content)

contact_page = StaticPage.find_or_initialize_by(title: 'Contact')
contact_page.update(content: contact_page_content)





require 'csv'
require 'open-uri'  # 이미지를 Active Storage에 저장할 경우 사용

# Clear existing data
ProductCategory.delete_all
Product.delete_all
Category.delete_all

# Create new categories
categories = %w[Earrings Rings Necklaces Bracelets]
categories.each do |category_name|
  Category.create!(name: category_name)
end

# Import products from CSV
CSV.foreach(Rails.root.join('db', 'ecommerce.csv'), headers: true) do |row|
  product = Product.new(
    name: row['name'],
    description: row['description'],
    price: row['price'].to_f,
    image_url: row['image'],  
    stock_quantity: 10,  # 임의로 수량 설정, 필요에 따라 수정
    sale_price: 0.0,  # CSV에 sale_price와 new_arrival이 없으므로 임의 값 설정
    new_arrival: false
  )

  product.save!

  # Assign categories
  category_name = row['category-link']  
  category = Category.find_by(name: category_name)
  if category
    ProductCategory.create!(product: product, category: category)
  else
    puts "Category '#{category_name}' not found for product '#{row['name']}'"
  end
end

puts "Seed data imported successfully!"
=end


# db/seeds.rb

require 'csv'
require 'open-uri'

# Clear existing data
ProductCategory.delete_all
Product.delete_all
Category.delete_all

# Create new categories
categories = %w[Earrings Rings Necklaces Bracelets]
categories.each do |category_name|
  Category.create!(name: category_name)
end

# Import products from CSV
batch_size = 100
products = []

CSV.foreach(Rails.root.join('db', 'ecommerce.csv'), headers: true) do |row|
  # product-link 값을 그대로 파일 이름으로 설정
  filename = "#{row['product-link']}.jpg"

  products << {
    name: row['name'],
    description: row['description'],
    price: row['price'].to_f,
    stock_quantity: 10,
    sale_price: 0.0,
    new_arrival: false,
    image_filename: filename,
    category_name: row['category-link']
  }

  if products.size >= batch_size
    Product.transaction do
      products.each do |product_data|
        product = Product.new(
          name: product_data[:name],
          description: product_data[:description],
          price: product_data[:price],
          stock_quantity: product_data[:stock_quantity],
          sale_price: product_data[:sale_price],
          new_arrival: product_data[:new_arrival]
        )

        # Attach image from local file using Active Storage
        image_filepath = Rails.root.join('db', 'images', product_data[:image_filename])
        if File.exist?(image_filepath)
          product.images.attach(io: File.open(image_filepath), filename: product_data[:image_filename])
          puts "Image attached for product '#{product_data[:name]}'"
        else
          puts "Image file not found for product '#{product_data[:name]}'"
        end

        product.save!

        # Assign categories
        category = Category.find_by(name: product_data[:category_name])
        if category
          ProductCategory.create!(product: product, category: category)
        else
          puts "Category '#{product_data[:category_name]}' not found for product '#{product_data[:name]}'"
        end
      end
    end
    products.clear
  end
end

# 마지막 남은 제품들 저장
unless products.empty?
  Product.transaction do
    products.each do |product_data|
      product = Product.new(
        name: product_data[:name],
        description: product_data[:description],
        price: product_data[:price],
        stock_quantity: product_data[:stock_quantity],
        sale_price: product_data[:sale_price],
        new_arrival: product_data[:new_arrival]
      )

      # Attach image from local file using Active Storage
      image_filepath = Rails.root.join('db', 'images', product_data[:image_filename])
      if File.exist?(image_filepath)
        product.images.attach(io: File.open(image_filepath), filename: product_data[:image_filename])
        puts "Image attached for product '#{product_data[:name]}'"
      else
        puts "Image file not found for product '#{product_data[:name]}'"
      end

      product.save!

      # Assign categories
      category = Category.find_by(name: product_data[:category_name])
      if category
        ProductCategory.create!(product: product, category: category)
      else
        puts "Category '#{product_data[:category_name]}' not found for product '#{product_data[:name]}'"
      end
    end
  end
end

puts "Seed data imported successfully!"
