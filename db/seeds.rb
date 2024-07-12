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
if Rails.env.development?
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