*** Settings ***
Resource    ../resources/keywords.robot

*** Test Cases ***
Addition Should Fail Wrong Result
    ${result}=    Add Two Numbers    10    5
    Should Be Equal As Numbers    ${result}    99

Subtraction Should Fail
    ${result}=    Subtract Two Numbers    20    8
    Should Be Equal As Numbers    ${result}    100

String Uppercase Check Fail
    [Documentation]    Fails because 'hello' is not uppercase
    String Should Be Uppercase    hello

List Length Check Fail
    @{items}=    Create List    a    b    c
    List Should Have Length    ${items}    5

Simple Equality Fail
    Should Be Equal    actual    expected

Boolean Assertion Fail
    Should Be True    False    This assertion is designed to fail
