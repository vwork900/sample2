*** Settings ***
Library    Collections
Library    String
Resource   ../resources/keywords.robot

*** Test Cases ***
Addition Should Succeed
    Log    ===== Step 1: Perform Addition =====
    ${result}=    Add Two Numbers    10    5

    Log    ===== Step 2: Validate Addition Result =====
    Should Be Equal As Numbers    ${result}    15


Subtraction Should Succeed
    Log    ===== Step 1: Perform Subtraction =====
    ${result}=    Subtract Two Numbers    20    8

    Log    ===== Step 2: Validate Subtraction Result =====
    Should Be Equal As Numbers    ${result}    12


String Uppercase Check Pass
    Log    ===== Step 1: Validate Uppercase String =====
    String Should Be Uppercase    HELLO


List Length Check Pass
    Log    ===== Step 1: Create List =====
    @{items}=    Create List    a    b    c

    Log    ===== Step 2: Validate List Length =====
    List Should Have Length    ${items}    3


Simple Equality Pass
    Log    ===== Step 1: Compare Two Strings =====
    Should Be Equal    hello    hello


Multiplication Should Succeed
    Log    ===== Step 1: Perform Multiplication =====
    ${result}=    Multiply Two Numbers    6    7

    Log    ===== Step 2: Validate Multiplication Result =====
    Should Be Equal As Numbers    ${result}    42


Division Should Succeed
    Log    ===== Step 1: Perform Division =====
    ${result}=    Divide Numbers    20    4

    Log    ===== Step 2: Validate Division Result =====
    Should Be Equal As Numbers    ${result}    5


Zero Addition Identity
    Log    ===== Step 1: Add Zero to Number =====
    ${result}=    Add Two Numbers    100    0

    Log    ===== Step 2: Validate Result Unchanged =====
    Should Be Equal As Numbers    ${result}    100


List With Five Items
    Log    ===== Step 1: Create List of Five Elements =====
    @{items}=    Create List    one    two    three    four    five

    Log    ===== Step 2: Validate List Length =====
    List Should Have Length    ${items}    5


Empty List Length Check
    Log    ===== Step 1: Create Empty List =====
    @{empty}=    Create List

    Log    ===== Step 2: Validate Length Is Zero =====
    List Should Have Length    ${empty}    0


String Contains Substring
    Log    ===== Step 1: Get Main String =====
    ${text}=    Set Variable    Robot Framework is great

    Log    ===== Step 2: Verify Substring Present =====
    Should Contain    ${text}    Framework


Multiplication By One
    Log    ===== Step 1: Multiply by One =====
    ${result}=    Multiply Two Numbers    999    1

    Log    ===== Step 2: Validate Result Unchanged =====
    Should Be Equal As Numbers    ${result}    999


Log Message Pass
    Log    ===== Step 1: Log Information =====
    Log    This test always passes

    Log    ===== Step 2: Validate Boolean =====
    Should Be True    True
