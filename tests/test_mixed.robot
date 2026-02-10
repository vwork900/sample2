*** Settings ***
Resource    ../resources/keywords.robot

*** Test Cases ***
Passing Case In Mixed Suite
    ${result}=    Add Two Numbers    1    1
    Should Be Equal As Numbers    ${result}    2

Failing Case In Mixed Suite
    Should Be Equal    foo    bar    Values do not match

Another Passing Case
    @{list}=    Create List    x    y
    List Should Have Length    ${list}    2
