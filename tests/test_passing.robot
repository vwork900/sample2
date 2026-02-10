*** Settings ***
Resource    ../resources/keywords.robot

*** Test Cases ***
Addition Should Succeed
    ${result}=    Add Two Numbers    10    5
    Should Be Equal As Numbers    ${result}    15

Subtraction Should Succeed
    ${result}=    Subtract Two Numbers    20    8
    Should Be Equal As Numbers    ${result}    12

String Uppercase Check Pass
    String Should Be Uppercase    HELLO

List Length Check Pass
    @{items}=    Create List    a    b    c
    List Should Have Length    ${items}    3

Simple Equality Pass
    Should Be Equal    hello    hello

Log Message Pass
    Log    This test always passes
    Should Be True    True
