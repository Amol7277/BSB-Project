*** Settings ***
Library     SeleniumLibrary
Test Setup       Open the browser and open the URL


*** Variables ***

${URL}      https://stagingsports.bsbtest.com/default.aspx?portalid=8575
${browser}      chrome

${ID}       amol.sonar+superadmin@stacksports.com
${Pwd}      Test@1234

*** Test Cases ***
Coupon Creation
    Login into the Portal
    Open the registration Settings

*** Keywords ***
Open the browser and open the URL
    open browser    ${URL}      ${browser}
    maximize browser window

Login into the Portal
    click element                                id:dnn_dnnLOGIN_cmdLogin
    wait until element is visible                name:email
    input text                                   name:email      ${ID}
    sleep   2
    click element                                name:continue
    wait until element is visible                name:password      10
    input text                                   name:password     ${Pwd}
    sleep   2
    click element                                name:continue

Open the registration Settings
    wait until element is visible                //ul/li/a/span[contains(text(), "Registration")]    300
    sleep       3
    mouse over                                   //ul/li/a/span[contains(text(), "Registration")]
    sleep       2
    click element                                //ul/li/a/span[contains(text(), "Settings")]

    wait until element is visible                //*[contains(text(),'Coupons')]        20
    sleep       2
    click element                                //*[contains(text(),'Coupons')]

    wait until element is visible                //span[contains(text(),'Add Coupon Discount')]     10
    click element                                //span[contains(text(),'Add Coupon Discount')]

    wait until element is visible           //input[@formcontrolname='couponNameControl']       10
    sleep    2
    input text                            //input[@formcontrolname='couponNameControl']      A1
    sleep       2
    double click element                  //input[@formcontrolname='expirationDateControl']
    input text                            //input[@formcontrolname='expirationDateControl']     7/31/2024
    sleep       2
    input text                            //input[@formcontrolname='couponAmountControl']       5000
    sleep       2
    input text                            //input[@formcontrolname='numberOfUsesControl']       1000
    sleep       2
    click element                         //span[contains(text(),'Save')]
