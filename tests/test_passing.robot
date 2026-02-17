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


Log Message Pass
    Log    ===== Step 1: Log Information =====
    Log    This test always passes

    Log    ===== Step 2: Validate Boolean =====
    Should Be True    True
