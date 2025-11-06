*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${UserName}     amol.sonar+superadmin@stacksports.com
${Password}     Test@1234

*** Test Cases ***
Order
    Open the browser and open the URL
    Login the Admin Account
    Go to the Order - Summary


*** Keywords ***
Open the browser and open the URL
    Open Browser                    https://leagues.bluesombrero.com/default.aspx?portalid=9003     Chrome
    maximize browser window

Login the Admin Account
    sleep       2
    click element                              dnn_dnnLOGIN_cmdLogin
    wait until element is visible              email
    input text                                 Name:email                      ${UserName}
    click element                              Name:continue
    wait until element is visible              password                        20
    input password                             Name:password                   ${Password}
    click element                              Name:continue

Go to the Order - Summary
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible           //div/span[contains(text(),'Dashboard')]        200

    go to    https://registration.bluesombrero.com/9003/order-summary?userId=86714206&playerId=85338138

    wait until element is visible       //span[contains(text(),' Payment Options')]     100

    sleep       2
    click element       //span[contains(text(),'Payment Options')]
    sleep       2
    click element       //button/span[contains(text(),'Select')]
    sleep       2
    click element       //button/span[contains(text(),'Continue')]

    wait until element is visible    //span/mat-panel-title[contains(text(),'Coupon Code')]     100

    repeat keyword    3 times   scroll element into view    //div[@class="check-option"]/mat-radio-button/label/div[1]

    sleep       3

    click element       //*[@id="mat-radio-4"]/label/div[1]/div[1]
