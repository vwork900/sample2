*** Settings ***
Resource    ../resources/keywords.robot
Library     Collections

*** Test Cases ***
Passing Case In Mixed Suite
    Log    ===== Step 1: Perform Addition (1 + 1) =====    INFO
    ${result}=    Add Two Numbers    1    1
    Log    Actual Result: ${result}    INFO

    Log    ===== Step 2: Validate Result Should Be 2 =====    INFO
    Should Be Equal As Numbers    ${result}    2


Failing Case In Mixed Suite
    Log    ===== Step 1: Compare Two Strings =====    INFO
    Log    Expected Value: bar    INFO
    Log    Actual Value: foo    INFO

    Log    ===== Step 2: Validation (This Will Fail) =====    WARN
    Log    ERROR: Values do not match    ERROR
    Should Be Equal    foo    bar    Values do not match


Another Passing Case
    Log    ===== Step 1: Create List =====    INFO
    @{list}=    Create List    x    y
    ${length}=    Get Length    ${list}
    Log    Created List: ${list}
