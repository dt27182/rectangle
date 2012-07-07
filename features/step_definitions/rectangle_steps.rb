Then /^I should be at the Category front page for "(.*)"$/ do |category_name|
	current_path = URI.parse(current_url).path
	if current_path.respond_to? :should
    current_path.should == show_category_path(category_name)
  else
    assert_equal show_category_path(category_name), current_path
  end
end

Given /^I am at the Category front page for "(.*)"$/ do |category_name|
	visit show_category_path(category_name)
end

Given /^"(.*)" is a category$/ do |category_name|
	Category.create!(:name => category_name)
end

Given /^"(.*?)" is a subcategory of "(.*?)"$/ do |subcategory_name, category_name|
	Subcategory.create!(:name => subcategory_name, :category_id => Category.find_by_name(category_name).id)
end

Given /^"(.*?)" is a website under subcategory "(.*?)"$/ do |website_name, subcategory_name|
	Website.create!(:name => website_name, :subcategory_id => Subcategory.find_by_name(subcategory_name).id)
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
	page.body.index(e1).should < page.body.index(e2)
end
