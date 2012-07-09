Feature: Users can see listing of top websites on the category front page

Background: User is on the Category front page for shoppping
	
	Given "shopping" is a category
	Given "men's" is a subcategory of "shopping"
	Given "women's" is a subcategory of "shopping"
	Given "children's" is a subcategory of "shopping"
	Given "misc" is a subcategory of "shopping" 
	Given "default" is a community
	Given the following websites exist:
	|website_name|website_url|subcategory_name|community_name|score|
	|amazon      |amazon.com |misc            |default       |3    |
	|ebay        |ebay.com   |misc            |default       |2    |
	|zappos      |zappos.com |misc            |default       |1    |
	
	Given I am at the Category front page for "shopping"
	Then I should see "men's"
	Then I should see "women's"
	Then I should see "children's"
	
