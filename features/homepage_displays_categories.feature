Feature: Users can see main categories on homepage

Background: User is on the home page
	
	Given I am on the home page
	
Scenario: User wants to go to the shopping category

	When I follow "shopping"
	Then I should be on the Category page for "shopping"
	
Scenario: User wants to go to the music/entertainment category

	When I follow "music/entertainment"
	Then I should be on the Category page for "music/entertainment"
	
Scenario: User wants to go to the productivity category

	When I follow "productivity"
	Then I should be on the Category page for "productivity"
	
Scenario: User wants to go to the misc category

	When I follow "misc"
	Then I should be on the Category page for "misc"
