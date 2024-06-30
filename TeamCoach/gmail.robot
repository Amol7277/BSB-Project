*** Settings ***
Library     ImapLibrary2
Library     BuiltIn


*** Variables ***
${IMAP_SERVER}    imap.gmail.com
${IMAP_PORT}      993
${EMAIL}          your-email@gmail.com
${PASSWORD}       your-app-password
${SUBJECT}        Verification Code
${TIMEOUT}        60s

*** Test Cases ***
Verify Email
    [Documentation]    Connect to the IMAP server, search for the verification email, and extract the verification code.
    open mailbox
    Open Mailbox    ${IMAP_SERVER}    ${EMAIL}    ${PASSWORD}    ${IMAP_PORT}    SSL
#    Run Keyword If    '${result[0]}' == 'PASS'    Process Email
#    Run Keyword If    '${result[0]}' == 'FAIL'    Log    Failed to connect to the IMAP server: ${result[1]}

*** Keywords ***
Process Email
    ${email_id}=    Wait For Email    SUBJECT ${SUBJECT}    timeout=${TIMEOUT}
    ${email_body}=  Get Message Body    ${email_id}
    Log    ${email_body}
    ${verification_code}=    Extract Verification Code    ${email_body}
    Log    Verification code: ${verification_code}
    Close Mailbox

Wait For Email
    [Arguments]    ${criterion}    ${timeout}
    Wait Until Keyword Succeeds    ${timeout}    10s    ${email_id}=    List Messages    ${criterion}
    [Return]    ${email_id}

Get Message Body
    [Arguments]    ${email_id}
    ${message}=    Get Message    ${email_id}
    ${body}=    Get Body Plain    ${message}
    [Return]    ${body}

Extract Verification Code
    [Arguments]    ${email_body}
    ${pattern}=    Create Regexp    Verification Code: (\d{6})
    ${matches}=    Get Regexp Matches    ${pattern}    ${email_body}
    Should Not Be Empty    ${matches}
    ${verification_code}=    Get From List    ${matches}    0
    [Return]    ${verification_code}
