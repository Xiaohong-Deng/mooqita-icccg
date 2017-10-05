Feature: User can join game waiting room, start a new game with other users

  As a icccg user
  So that I can start playing game with other users
  I want to join the game waiting room and start playing

Background: Users have been created
  Given the following users exist:
  | email             | password  |
  | user1@example.com | topsecret |
  | user2@example.com | topsecret |
  | user3@example.com | topsecret |
  And the following documents exist:
  | title       | content                                                      |
  | dummy title | This is a single dummy document meant to be tested by rspec. |

@javascript
Scenario: Users enter the game waiting room
  Given I am in user1 browser
  And I am on the sign in page
  When I sign in as "user1@example.com/topsecret"
  And I follow "Play Game"
  Then I should see "There are currently 1 player waiting"
  Given I am in user2 browser
  And I am on the sign in page
  When I sign in as "user2@example.com/topsecret"
  Then I follow "Play Game"
  Then I should see "There are currently 2 players waiting"
  Given I am in user3 browser
  And I am on the sign in page
  When I sign in as "user3@example.com/topsecret"
  Then I follow "Play Game"
  Given I am in user1 browser
  Then I should see "We have 3 players. redirecting to game...."
  And I should be on the game page
  Given I am in user2 browser
  Then I should be on the game page
  Given I am in user3 browser
  Then I should be on the game page
