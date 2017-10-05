Feature: Player can play through game, enter next round

  As a player
  So that I can interact with other players and enter next round
  I want to input information in the round

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

@javascript
Scenario: Players can play a complete round
  Given I am in user2 browser
  And I am on the game page
  When I sign in as "user2@example.com/topsecret"
  Then I should see "Questioner of this round: Yes"
  And I fill in "question_content" with "You shall not pass!"
  And I hit "enter" in "question_content"
  Given I am in user3 browser
  And I am on the game page
  When I sign in as "user3@example.com/topsecret"
  Then I should see "You shall not pass!"
  And I fill in "answer_content" with "Why not?"
  And I hit "enter" in "answer_content"
  Given I am in user2 browser
  Then I should see "Why not?"
  And I fill in "answer_content" with "Indeed no one can pass."
  And I hit "enter" in "answer_content"
  Given I am in user1 browser
  And I am on the game page
  When I sign in as "user1@example.com/topsecret"
  Then I should see "Indeed no one can pass."
  And I press "0_submit_button"
  Given I am in user2 browser
  Then I should see "Judge made his choice"
  When I press "Next Round"
  Then I should be on the game page
  And I should see "Game Round: 2"
