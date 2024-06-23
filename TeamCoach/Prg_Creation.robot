*** Settings ***
Library     SeleniumLibrary
Test Setup  Open the browser and open the URL

*** Variables ***
${URL}      https://stagingsports.bsbtest.com/default.aspx?portalid=8575
${browser}      chrome
${ID}       amol.sonar+superadmin@stacksports.com
${Pwd}      Test@1234

${prg_name}     01_06_TC

${div}      PPT Div
${amt}      10000
${regstartdate}     06/01/2024
${regclosedate}     06/25/2024
${seasonstart}      06/10/2024
${seasonend}        07/10/2024
${oldage}           1/1/2000
${youngdate}        1/1/2015

*** Test Cases ***
TeamCoach Program Creation
    Login into the Portal
    Open the registration form
#    Create the TeamCoach Program and Complete the 1st step
    Create Divisions

*** Keywords ***
Open the browser and open the URL
    open browser    ${URL}      ${browser}
    maximize browser window

Login into the Portal
    click element  id:dnn_dnnLOGIN_cmdLogin
    wait until element is visible    name:email
    input text      name:email      ${ID}
    sleep   2
    click element   name:continue
    wait until element is visible   name:password
    input text      name:password     ${Pwd}
    sleep   2
    click element   name:continue

Open the registration form
    wait until element is visible   //ul/li/a/span[contains(text(), "Registration")]    300
    mouse over    //ul/li/a/span[contains(text(), "Registration")]
    click element    //ul/li/a/span[contains(text(), "Registration Forms")]

Create the TeamCoach Program and Complete the 1st step
    wait until element is visible    //button/span[contains(text(), " Add Program ")]   20
    click element    //button/span[contains(text(), " Add Program ")]
    wait until element is visible   (//button/span[contains(text(), " Select")])[1]
    scroll element into view    (//button/span[contains(text(), " Select")])[3]
    sleep    1
    click element    (//button/span[contains(text(), " Select")])[3]
    wait until element is visible    //li/button/img[@alt='Basketball']     10
    click element    //li/button/img[@alt='Basketball']
    click element    //button/span[contains(text(), " Save & Continue")]
    set selenium page load timeout    30
    sleep   2
    input text      //div/input[@id = 'mat-input-0']    ${prg_name}
    sleep   2
    click element    //div[@class='mat-select-value ng-tns-c151-27']
    sleep   1
    click element    //div/mat-option/span[contains(text(), "None")]
    scroll element into view    //button/span[contains(text(), " Save & Continue ")]
    wait until element is visible    //button/span[contains(text(), " Save & Continue ")]
#    click element    //button/span[contains(text(), " Save & Continue ")]

Create Divisions
    go to   https://registration-setup-site-stage.bsbtest.com/registration-admin/8575/program/130096348/2
#    wait until element is visible       //button/span[contains(text(),' Add Division ')]    30
#    click element       //button/span[contains(text(),' Add Division ')]
#    wait until element is visible       //div/input[@id="mat-input-0"]
#    input text    //div/input[@id="mat-input-0"]    ${div}
#    input text    //div/input[@id="mat-input-7"]    ${amt}
#    click element    //div/mat-select[@id="mat-select-0"]
#    click element    //div/mat-option[@id="mat-option-2"]
#
#    input text      //div/input[@id="mat-input-1"]      ${regstartdate}
#    sleep   1
#    double click element      //div/input[@id="mat-input-1"]
#    sleep   1
#
#    input text      //div/input[@id="mat-input-2"]      ${regclosedate}
#    sleep   1
#    double click element    //div/input[@id="mat-input-2"]
#    sleep   1
#
#    input text      //div/input[@id="mat-input-3"]      ${seasonstart}
#    double click element    //div/input[@id="mat-input-3"]
#    sleep   1
#
#    input text      //div/input[@id="mat-input-4"]      ${seasonend}
#    double click element    //div/input[@id="mat-input-4"]
#    sleep   1
#
#    input text      //div/input[@id="mat-input-5"]      ${oldage}
#    double click element    //div/input[@id="mat-input-5"]
#    sleep   1
#
#    input text      //div/input[@id="mat-input-6"]      ${youngdate}
#    double click element    //div/input[@id="mat-input-6"]
#    sleep    1
#    double click element    //h3/span[contains(text(), "Age Range")]
#    Log     Clicked
#    sleep    1
#    double click element    //div/h3[contains(text(), "Season Dates")]
#    sleep    1
#    Log     Clicked
#    execute javascript      window.scrollTo(0,-100)
##    scroll element into view        //div[@class='program-name ng-tns-c428-24']
##    click element       //div[@class='program-name ng-tns-c428-24']
#    sleep    1
##    sleep    2
#    Log     Amol Sonar
##    scroll element into view        //button[@iconclass='save-icon']
#    click element    //button[@iconclass='save-icon']
#    click element    //button[@type="submit"]

    wait until element is visible       //button/span/span[contains(text(),"Advanced")]     30
#    DIvision Advanced setting
    click element       //button/span/span[contains(text(),"Advanced")]
    sleep   3
#    Division level fee & Discount
    click element       //div[@id='mat-tab-label-0-1']
    wait until element is visible       //div/input[@formcontrolname='earlyBirdDiscountAmountCtrl']     20
#    earlybirth amount
    input text          //div/input[@formcontrolname='earlyBirdDiscountAmountCtrl']     1000
    wait until element is visible    //div/input[@formcontrolname='earlyBirdDiscountEndDateCtrl']       10

#    earlybirth date
    double click element         //div/input[@formcontrolname='earlyBirdDiscountEndDateCtrl']
    input text          //div/input[@formcontrolname='earlyBirdDiscountEndDateCtrl']     06/15/2024

    wait until element is visible       //div/input[@formcontrolname='lateFeeAmountCtrl']       10
#    Late free amount
    input text          //div/input[@formcontrolname='lateFeeAmountCtrl']     1000

    wait until element is visible       //div/input[@formcontrolname='lateFeeStartDateCtrl']     10
#    Late Fee Date
    double click element       //div/input[@formcontrolname='lateFeeStartDateCtrl']
    input text          //div/input[@formcontrolname='lateFeeStartDateCtrl']     06/15/2024
