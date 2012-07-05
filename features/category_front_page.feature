Feature: Users can see listing of top websites on the category front page

Background: User is on the Category front page for shoppping
	
	Given "shopping" is a category
	Given "men's" is a subcategory of "shopping"
	Given "women's" is a subcategory of "shopping"
	Given "children's" is a subcategory of "shopping"
	Given "misc" is a subcategory of "shopping"
	Given "amazon" is a website under subcategory "misc"
	Given "ebay" is a website under subcategory "misc"
	Given "zappos" is a website under subcategory "women's"
	
	Given I am at the Category front page for "shopping"
	Then I should see "men's"
	Then I should see "women's"
	Then I should see "children's"
	
