Feature: Notify when changed
  In order to keep track of changes to files
  As an admin
  I want Filewatcher to send me an email after N amount of changed files

  Scenario: Change four files
    Given an empty file named "spots/Noord-Holland/Wijk aan Zee"
    And an empty file named "spots/Noord-Holland/IJmuiden"
    And an empty file named "spots/Gelderland/Strand Horst"
    And an empty file named "spots/Zeeland/Brouwersdam"
    And I set the environment variables to:
      | variable       | value |
      | FW_BUFFER_PATH | .     |
      | FW_BUFFER_SIZE | 3     |
    When I run `filewatcher spots/Noord-Holland/Wijk aan Zee`
    And I run `filewatcher spots/Noord-Holland/IJmuiden`
    Then a file matching %r<buffer/.+> should exist
    When I run `filewatcher spots/Gelderland/Strand Horst`
    Then a file matching %r<email/.*/plain.html> should exist
    And a file matching %r<buffer/.+> should not exist
    When I run `filewatcher spots/Zeeland/Brouwersdam`
    Then a file matching %r<buffer/.+> should exist

