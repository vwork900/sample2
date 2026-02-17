*** Settings ***
Resource    ../resources/keywords.robot
Library     Collections
Library     String

*** Test Cases ***
Addition Should Fail Wrong Result
    Log    ===== Step 1: Perform Addition (10 + 5) =====    INFO
    ${result}=    Add Two Numbers    10    5
    Log    ERROR: Expected 99 but got ${result}    ERROR
    Should Be Equal As Numbers    ${result}    99


Subtraction Should Fail
    Log    ===== Step 1: Perform Subtraction (20 - 8) =====    INFO
    ${result}=    Subtract Two Numbers    20    8
    Log    ERROR: Expected 100 but got ${result}    ERROR
    Should Be Equal As Numbers    ${result}    100


String Uppercase Check Fail
    [Documentation]    Fails because 'hello' is not uppercase
    Log    ===== Step 1: Validate Uppercase =====    INFO
    Log    ERROR: Value 'hello' is not uppercase    ERROR
    String Should Be Uppercase    hello


List Length Check Fail
    Log    ===== Step 1: Create List =====    INFO
    @{items}=    Create List    a    b    c
    ${length}=    Get Length    ${items}
    Log    ERROR: Expected length 5 but got ${length}    ERROR
    List Should Have Length    ${items}    5


Simple Equality Fail
    Log    ===== Step 1: Compare Strings =====    INFO
    Log    ERROR: Expected 'expected' but got 'actual'    ERROR
    Should Be Equal    actual    expected


Boolean Assertion Fail
    Log    ===== Step 1: Validate Boolean =====    INFO
    Log    ERROR: Expected True but got False    ERROR
    Should Be True    False    This assertion is designed to fail
