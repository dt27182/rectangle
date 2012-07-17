Then /^I should be at the Category front page for "(.*)"$/ do |category_name|
	current_path = URI.parse(current_url).path
	if current_path.respond_to? :should
    current_path.should == show_category_path(category_name, "trending")
  else
    assert_equal show_category_path(category_name), current_path
  end
end

Given /^I am at the Category front page for "(.*)"$/ do |category_name|
	visit show_category_path(category_name, "trending")
end

Given /^"(.*)" is a category$/ do |category_name|
	Category.create!(:name => category_name)
end

Given /^"(.*?)" is a subcategory of "(.*?)"$/ do |subcategory_name, category_name|
	category_id = Category.find_by_name(category_name).id
	Subcategory.create!(:name => subcategory_name, :category_id => category_id)
end

Given /^"(.*?)" is a website under subcategory "(.*?)"$/ do |website_name, subcategory_name|
	subcategory_id = Subcategory.find_by_name(subcategory_name).id
	Website.create!(:name => website_name, :subcategory_id => subcategory_id)
end

Given /^the following websites exist:$/ do |websites_table|
	websites_table.hashes.each do |website|
		subcategory_id = Subcategory.find_by_name(website["subcategory_name"]).id
		community_id = Community.find_by_name(website["community_name"]).id
		website_id = Website.create!(:name => website["website_name"], :url => website["web_url"], :subcategory_id => subcategory_id).id
		Rating.create!(:trending_score => website["trending_score"], :quality_score => website["quality_score"], :website_id => website_id, :community_id => community_id)
	end
end
# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
	page.body.index(e1).should < page.body.index(e2)
end

Given /"(.*)" is a community/ do |community_name|
	Community.create!(:name => community_name)
end
