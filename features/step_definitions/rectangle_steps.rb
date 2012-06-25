Then /^I should be on the Category page for "(.*)"$/ do |category_name|
	current_path = URI.parse(current_url).path
	if current_path.respond_to? :should
    current_path.should == show_category_path(category_name)
  else
    assert_equal show_category_path(category_name), current_path
  end
end
