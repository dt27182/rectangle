Feature: Users can see listing of top websites on the category front page

Background: User is on the Category front page for shoppping
	
	Given "shopping" is a category
	Given "men's" is a subcategory of "shopping"
	Given "women's" is a subcategory of "shopping"
	Given "children's" is a subcategory of "shopping"
	Given "misc" is a subcategory of "shopping" 
	Given "default" is a community
	Given the following websites exist:
	|website_name|website_url|subcategory_name|community_name|trending_score|quality_score|
	|zappos      |zappos.com |misc            |default       |1             |1            |
	|amazon      |amazon.com |misc            |default       |3             |3            |
	|ebay        |ebay.com   |misc            |default       |2             |2            |

	
	Given I am at the Category front page for "shopping"
	Then I should see "men's"
	Then I should see "women's"
	Then I should see "children's"
	
	Then I should see "amazon" before "ebay"
	Then I should see "ebay" before "zappos"
