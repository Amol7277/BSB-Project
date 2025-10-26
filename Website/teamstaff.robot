*** Settings ***
Library     SeleniumLibrary

*** Variables ***
#${URL}  https://leagues.bluesombrero.com/Default.aspx?portalid=9003
${URL}  http://ayso.bluesombrero.com/default.aspx?portalid=14001

${Position_Name}   Custom Position

*** Test Cases ***
Extra Team Staff Delete
    Open the Browser
    Login the Site
    Go to the Website > Team Staff
    Delete the unwanted volunteers

*** Keywords ***

Open the Browser
    open browser       ${URL}     Chrome
    maximize browser window

Login the Site
    set selenium implicit wait            20s
    set selenium speed                    0.4
    wait until element is visible           ID:dnn_dnnLOGIN_cmdLogin            100
    click element       ID:dnn_dnnLOGIN_cmdLogin

    input text          NAME:email      amol.sonar+superadmin@stacksports.com
    click element       NAME:continue
    input text          NAME:password       Test@1234
    click element       NAME:continue

Go to the Website > Team Staff
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible           (//a/span[contains(text(),'Registration')])[1]           100
    mouse over      (//a/span[contains(text(),'Registration')])[1]
    click element       //a/span[contains(text(),'Team Staff ')]

Delete the unwanted volunteers
    set selenium implicit wait            20s
    set selenium speed                    0.4

    ${Program}=  get webelements    //button/span[contains(text(),'Programs')]
    ${Delete}=    Get WebElements    //button[@class='program-icon delete-button mat-icon-button']/span/mat-icon

    ${count}=   get length    ${Delete}

    FOR    ${Dlt}    IN    @{Delete}
        sleep       3
        scroll element into view        ${Dlt}
        sleep       2
        click element    ${Dlt}
        Log    Pass
        sleep       3
        click element       //button/span[contains(text(),'Delete')]
        log     pass
    END