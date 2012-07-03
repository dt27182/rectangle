Feature: Users can see listing of top websites on the category front page

Background: User is on the Category front page for shoppping
	
	Given "shopping" is a category
	Given I am at the Category front page for "shopping"
	Given "men's" is a subcategory of "shopping"
	Given "women's" is a subcategory of "shopping"
	Given "children's" is a subcategory of "shopping"
	Then I should see "men's"
	Then I should see "women's"
	Then I should see "children's"
	
