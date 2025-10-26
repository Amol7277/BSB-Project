*** Settings ***
Library     SeleniumLibrary
Library     Collections
Test Setup       Open the browser and open the URL

*** Variables ***

${URL}      https://stagingsports.bsbtest.com/default.aspx?portalid=8575
${browser}      chrome

${ID}       amol.sonar+superadmin@stacksports.com
${Pwd}      Test@1234

${C_Name}       Coupon 4
${INDEX}        1
*** Test Cases ***
Coupon Creation
    Login into the Portal
    Open the registration Settings
    ${INDEX}    Set Variable    1
    repeat keyword      2 times     Create multiple coupon       ${C_Name}${INDEX}
    ${INDEX}    Evaluate    ${INDEX} + 1
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
    wait until element is visible                //marketplace-toolbar[@class='hydrated']       100
#    wait until element is visible                //*[contains(text(),'all-apps')]    300
    sleep       1
    mouse over                                   //ul/li/a/span[contains(text(), "Registration")]
    sleep       2
    click element                                //ul/li/a/span[contains(text(), "Settings")]

    wait until element is visible                //*[contains(text(),'Coupons')]        20
    sleep       2
    click element                                //*[contains(text(),'Coupons')]

Create multiple coupon
    [Arguments]    ${C_Name}
    sleep       2
    wait until element is visible                //span[contains(text(),'Add Coupon Discount')]     10
    click element                                //span[contains(text(),'Add Coupon Discount')]

    wait until element is visible           //input[@formcontrolname='couponNameControl']       10
    sleep    2
    input text                            //input[@formcontrolname='couponNameControl']      ${C_Name}
    sleep       2
    double click element                  //input[@formcontrolname='expirationDateControl']
    input text                            //input[@formcontrolname='expirationDateControl']     7/31/2024
    sleep       2
    input text                            //input[@formcontrolname='couponAmountControl']       5000
    sleep       2
    input text                            //input[@formcontrolname='numberOfUsesControl']       1000
    sleep       2
    click element                         //button[@iconname='save']/span/mat-icon
    sleep       2
    wait until element is visible         //span[contains(text(),'Add Coupon Discount')]     10
