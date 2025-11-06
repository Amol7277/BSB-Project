*** Settings ***
Library     SeleniumLibrary
Test Setup      Open the browser and open the URL

*** Variables ***
${User_ID}      amol.sonar+superadmin@stacksports.com
${Pwd}          Test@1234
${URL}      https://leagues.bluesombrero.com/default.aspx?portalid=9003
${Go to URL}      https://registration.bluesombrero.com/9003/order-summary?userId=86714206&playerId=85338135
${browser}      chrome

*** Test Cases ***
ROKT Handle
    Login into the Portal       ${User_ID}       ${Pwd}
    Handle ROKT popup


*** Keywords ***
Open the browser and open the URL
    open browser    ${URL}      ${browser}
    maximize browser window

Login into the Portal
    [Arguments]    ${User_ID}       ${Pwd}
    set selenium implicit wait            20s
    set selenium speed                    0.4

    run keyword and continue on failure    wait until element is visible          (//div[@class ="ot-sdk-row"])[1]         100
    sleep     2
    run keyword and continue on failure     click element                          onetrust-accept-btn-handler
    sleep     3

#    click element                                //a[@id='dnn_dnnLOGINLL_cmdLogin']
    click element                                //a[@id='dnn_dnnLOGIN_cmdLogin']
    wait until element is visible                name:email
    input text                                   name:email      ${User_ID}
    sleep   2
    click element                                name:continue
    wait until element is visible                name:password      10
    input text                                   name:password     ${Pwd}
#    sleep   2
    click element                                name:continue

Handle ROKT popup
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible           //a[@title="My Account"]        100

    go to       ${Go to URL}

    wait until element is visible           //iframe[@title="Rokt placement"]     100

    select frame            //iframe[@title="Rokt placement"]

    log to console          frame selected

    wait until element is visible          //button[@title="Close"]/span        100
    sleep       10
    run keyword and ignore error        click element           //button/span[contains(text(),'Close')]
    log to console          Rokt popup closed

    unselect frame