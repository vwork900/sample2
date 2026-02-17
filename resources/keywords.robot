*** Settings ***
Library    String
Library    Collections

*** Keywords ***
Add Two Numbers
    [Arguments]    ${a}    ${b}
    ${result}=    Evaluate    ${a} + ${b}
    [Return]    ${result}

Subtract Two Numbers
    [Arguments]    ${a}    ${b}
    ${result}=    Evaluate    ${a} - ${b}
    [Return]    ${result}

String Should Be Uppercase
    [Arguments]    ${text}
    ${upper}=    Convert To Upper Case    ${text}
    Should Be Equal    ${text}    ${upper}

List Should Have Length
    [Arguments]    ${list}    ${expected_length}
    ${length}=    Get Length    ${list}
    Should Be Equal As Numbers    ${length}    ${expected_length}

Divide Numbers
    [Arguments]    ${a}    ${b}
    ${result}=    Evaluate    ${a} / ${b}
    [Return]    ${result}

Multiply Two Numbers
    [Arguments]    ${a}    ${b}
    ${result}=    Evaluate    ${a} * ${b}
    [Return]    ${result}
