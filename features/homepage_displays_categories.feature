Feature: Users can see main categories on homepage

Background: User is on the home page
	
	Given I am on the home page
	Given "shopping" is a category
	Given "entertainment" is a category
	Given "productivity" is a category
	Given "misc" is a category
Scenario: User wants to go to the shopping category

	When I follow "shopping"
	Then I should be at the Category front page for "shopping"
	
Scenario: User wants to go to the entertainment category

	When I follow "entertainment"
	Then I should be at the Category front page for "entertainment"
	
Scenario: User wants to go to the productivity category

	When I follow "productivity"
	Then I should be at the Category front page for "productivity"
	
Scenario: User wants to go to the misc category

	When I follow "misc"
	Then I should be at the Category front page for "misc"
