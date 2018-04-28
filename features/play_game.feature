Feature: Player can resuem old games, play through game, enter next round

  As a player
  So that I can interact with other players and enter next round
  I want to resume old games, input information in the round

Background: Users have been created
  Given the following users exist:
  | email             | password  |
  | user1@example.com | topsecret |
  | user2@example.com | topsecret |
  | user3@example.com | topsecret |
  And the following documents exist:
  | title       | content                                                      |
  | dummy title | This is a single dummy document meant to be tested by rspec. |
  And the following games exist:
  | document_id |
  | 1           |
  And the following game_players exist:
  | game_id | user_id | role    | questioner |
  | 1       | 1       | judge   | false      |
  | 1       | 2       | reader  | true       |
  | 1       | 3       | guesser | false      |

Scenario: Players can resume old games
  Given I am in user1 browser
  And I am on the sign in page
  When I sign in as "user1@example.com/topsecret"
  Then I should see "Active Games"
  And I should see "document: dummy title"
  And I should see "role: judge"
  And I should see "round: 1"
  And I should see "score: 0"
  And I should see "New Game"
  When I follow "Resume"
  Then I should be on the game page

#Scenario: Players can see other players status
#  Given I am in user2 browser
#  And I am on the game page
#  When I sign in as "user2@example.com/topsecret"
#  Then I should see user2 online
#  And I should see user1 offline
#  And I should see user3 offline
#  Given I am in user3 browser
#  And I am on the game page
#  When I sign in as "user3@example.com/topsecret"
#  Then I should see user2 online
#  And I should see user3 online
#  And I should see user1 offline

@javascript
Scenario: Players can play a complete round
  Given I am in user2 browser
  And I am on the game page
  When I sign in as "user2@example.com/topsecret"
  Then I should see "Questioner of this round: Yes"
  And I fill in "Your Question" with "You shall not pass!"
  And I hit "enter" in "question_content"
  Given I am in user3 browser
  And I am on the game page
  When I sign in as "user3@example.com/topsecret"
  Then I should see "You shall not pass!"
  And I fill in "Your Answer" with "Why not?"
  And I hit "enter" in "answer_content"
  Given I am in user2 browser
  Then I should see "One answer has been submitted."
  And I should see "Waiting the other answer to be submitted..."
  And I fill in "Your Answer" with "Indeed no one can pass."
  And I hit "enter" in "answer_content"
  Given I am in user1 browser
  And I am on the game page
  When I sign in as "user1@example.com/topsecret"
  Then I should see "One answer has been submitted." for "2" times
  And I press "1_submit_button"
  Given I am in user2 browser
  Then I should see "Judge made the choice"
  When I press "Next Round"
  Then I should be on the game page
  And I should see "Game Round: 2"
  And I should see "Congratulations!"
  And I should see "Score: 1"
  Given I am in user3 browser
  And I am on the game page
  When I press "Next Round"
  Then I should see "Sorry!"
  And I should see "Score: -1"
