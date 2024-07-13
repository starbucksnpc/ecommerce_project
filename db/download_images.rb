# db/download_images.rb

require 'csv'
require 'open-uri'
require 'uri'

failed_downloads = []

CSV.foreach(Rails.root.join('db', 'ecommerce.csv'), headers: true) do |row|
  image_url = row['image']
  product_link = row['product-link']
  next unless image_url.present? && product_link.present?

  # 이미지 파일 이름을 product-link로 지정
  filename = "#{product_link}.jpg"
  filepath = Rails.root.join('db', 'images', filename)

  # 이미지 다운로드
  begin
    File.open(filepath, 'wb') do |file|
      file.write(URI.open(image_url).read)
    end
  rescue => e
    puts "Failed to download #{image_url}: #{e.message}"
    failed_downloads << { product_link: product_link, image_url: image_url, error: e.message }
  end
end

puts "Images downloaded successfully!"
puts "Failed downloads: #{failed_downloads.size}"
failed_downloads.each do |failure|
  puts "Failed to download image for product '#{failure[:product_link]}': #{failure[:image_url]} (Error: #{failure[:error]})"
end
