require 'test_helper'

class ProductTest < ActiveSupport::TestCase
     # Replace this with your real tests.
     test "the truth" do
	assert true
     end

     test "product attributes must not be empty" do
	product = Product.new
	assert product.invalid?
	assert product.errors[:title].any?
	assert product.errors[:description].any?
	assert product.errors[:price].any?
	assert product.errors[:image_url].any?
     end

     test "product price must be positive" do
	product = Product.new(:title => "My Book Title" ,
			:description => "yyy" ,
			:image_url => "zzz.jpg" )
	product.price = -1
	assert product.invalid?
	assert_equal "must be greater than or equal to 0.01" ,
	product.errors[:price].join('; ' )

	product.price = 0
	assert product.invalid?
	assert_equal "must be greater than or equal to 0.01" ,
	product.errors[:price].join('; ' )

	product.price = 1
	assert product.valid?
     end

     def new_product(image_url)
	Product.new(
	     :title => "coucou",
	     :description => "this is description",
	     :price => 12.23,
	     :image_url => image_url
	)
     end

   
     test "image_url" do

	good = %w{lala.jpg prout.gif zaza.png http://www.lalla.be/head.png}

	bad = %w{zozo.doc moncoco.pdf zouteke.xlsx}

	good.each do |name|
	     assert new_product(name).valid?,"#{name} should not be valid ! "
	end

	bad.each do |name|
	     assert new_product(name).invalid?,"#{name} should  be valid ! "
	end
     end

end
