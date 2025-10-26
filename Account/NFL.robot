*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    String
Library    Collections
Library    BuiltIn


*** Variables ***
${NFF checkbox}      (//span[@class="NormalTextBox converted"])[2]
${NFF unselected}    (//span[@class="NormalTextBox converted"])[2]/img[2]
${NFF selected}      (//span[@class="NormalTextBox converted"])[2]/img[1]

*** Test Cases ***

Non-NFL portal pop-up

    Log in as host
    Go to site setting
    Check for NFF portal

*** Keywords ***

Log in as host

    Open Browser    https://stagingsports.bsbtest.com/default.aspx?portalid=8585    Chrome
    Maximize Browser Window
    Click Link    id=dnn_dnnLOGIN_cmdLogin
    Wait Until Element Is Visible    //input[@placeholder='Email Address']
    Input Text   //input[@placeholder='Email Address']    ATHost@fakebsbemail.com
    Click Button    //button[normalize-space()='Continue']
    Sleep    5
    Wait Until Element Is Visible    //input[@placeholder='Password']
    Input Text    //input[@placeholder='Password']    ITW3546ctyz10@
    Click Button    //button[normalize-space()='Continue']



Go to site setting
    set selenium implicit wait            20s
    set selenium speed                    0.4
    run keyword and continue on failure     wait until element is visible         //marketplace-toolbar[@class='hydrated']      100
    wait until element is visible         //a/img[@class='logo-img']          300

#    Mouse Over    //a[contains(.,'Common')]
    Mouse Over    //a/span[contains(text(),'Common')]
    Sleep    5
    Wait Until Page Contains Element    //span[contains(.,'Site Settings')]
    Click Element    //span[contains(.,'Site Settings')]
    Sleep    15
    Wait Until Page Contains Element    //span[contains(.,'Basic Settings')]

Check for NFF portal
    set selenium implicit wait            20s
    set selenium speed                    0.4
    Scroll Element Into View    //span[.='BSB Settings']
    Click Element    //span[@id='pageSAYSoccerIcn']
    Wait Until Page Contains Element    (//div[contains(.,'NFF Portal:')])[22]
    Scroll Element Into View    //span[contains(text(),'Team Sports HQ')]
#    ${check for NFF}    Run Keyword And Return Status    is element enabled    ${NFF selected}
#    ${check for NFF}    Run Keyword And Return Status    checkbox should be selected    ${NFF checkbox}
    ${check for NFF}    Run Keyword And Return Status    element should be visible    ${NFF unselected}
    log to console      ${check for NFF}
#    Run Keyword If    ${check for NFF} == 'False'    Click Element    ${NFF checkbox}
    IF      ${check for NFF} == False
        click element    ${NFF checkbox}
    END
    Sleep    5
    Click Element    //a[.='Update']
    Sleep    10

#    Page Should Contain Element     ${NFF unselected}

