Feature: User can join game waiting room and see other users in the room

  As a icccg user
  So that I can start playing game with other users
  I want to join the game waiting room

Background: Users have been created
  Given the following users exist:
  | email             | password  |
  | user1@example.com | topsecret |
  | user2@example.com | topsecret |
  | user3@example.com | topsecret |

@javascript
Scenario: Users enter the game waiting room
  Given I am in user1 browser
  And I am on the sign in page
  When I sign in as "user1@example.com/topsecret"
  Then I should see "Play Game"
  When I follow "Play Game"
  Then I should see "There are currently 1 player waiting"
  Given I am in user2 browser
  And I am on the sign in page
  When I sign in as "user2@example.com/topsecret"
  Then I follow "Play Game"
  Then I should see "There are currently 2 players waiting"
