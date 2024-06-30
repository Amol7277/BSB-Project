*** Settings ***
Library     SeleniumLibrary

*** Variables ***
#${URL}      http://leagues.bluesombrero.com/default.aspx?portalid=9003
${URL}      https://testing.bsbtest.com/default.aspx?portalid=1309
${browser}      chrome
#${ID}       amol.sonar+superadmin@stacksports.com
${ID}       itw.amols+superadmin@gmail.com
${Pwd}      Test@1234
${prg_name}     nontryout
${div}      Div1
${amt}      100
${regstartdate}     05/20/2024
${regclosedate}     06/25/2024
${seasonstart}      05/30/2024
${seasonend}        07/10/2024
${oldage}           1/1/2000
${youngdate}        1/1/2015

*** Test Cases ***
Test
#    open browser    http://leagues.bluesombrero.com/default.aspx?portalid=9003      Chrome
    open browser    ${URL}      ${browser}
    Maximize Browser Window
    click element  id:dnn_dnnLOGIN_cmdLogin
    wait until element is visible    name:email
#    sleep   2
    input text      name:email      ${ID}
    sleep   2
    click element   name:continue
    wait until element is visible   name:password
#    sleep   2
    input text      name:password     ${Pwd}
    sleep   2
    click element   name:continue

Registration form

    wait until element is visible   //ul/li/a/span[contains(text(), "Registration")]    45
    mouse over    //ul/li/a/span[contains(text(), "Registration")]

    click element    //ul/li/a/span[contains(text(), "Registration Forms")]

    wait until element is visible    //button/span[contains(text(), " Add Program ")]   10

    click element    //button/span[contains(text(), " Add Program ")]

    wait until element is visible   (//button/span[contains(text(), " Select")])[1]
    click element    (//button/span[contains(text(), " Select")])[1]

    wait until element is visible    //li/button/img[@alt='Basketball']     10
    click element    //li/button/img[@alt='Basketball']

    click element    //button/span[contains(text(), " Save & Continue")]
    set selenium page load timeout    30
#    click element    //div[contains(text(), "Program Settings")]
    sleep   2
    input text      //div/input[@id = 'mat-input-0']    ${prg_name}
    sleep   2
    click element    //div[@class='mat-select-value ng-tns-c151-27']
    sleep       1
    click element    //div/mat-option/span[contains(text(), "None")]
#    scroll element into view    //button/span[contains(text(), " Save & Continue ")]
#    wait until element is visible    //button/span[contains(text(), " Save & Continue ")]
#    click element    //button/span[contains(text(), " Save & Continue ")]

#program edit button
#    click element    (//button/span/mat-icon[contains(text(),'edit')])[1]
Division Creation
    go to    https://registration-setup-site-test.bsbtest.com/registration-admin/1309/program/40141333/2
    wait until element is visible       //button/span[contains(text(),' Add Division ')]    30
    click element       //button/span[contains(text(),' Add Division ')]
    wait until element is visible       //div/input[@id="mat-input-0"]
    input text    //div/input[@id="mat-input-0"]    ${div}
    input text    //div/input[@id="mat-input-7"]    ${amt}
    click element    //div/mat-select[@id="mat-select-0"]
    click element    //div/mat-option[@id="mat-option-2"]

    input text      //div/input[@id="mat-input-1"]      ${regstartdate}
    double click element      //div/input[@id="mat-input-1"]
    sleep   1

    input text      //div/input[@id="mat-input-2"]      ${regclosedate}
    double click element    //div/input[@id="mat-input-2"]
    sleep   1

    input text      //div/input[@id="mat-input-3"]      ${seasonstart}
    double click element    //div/input[@id="mat-input-3"]
    sleep   1

    input text      //div/input[@id="mat-input-4"]      ${seasonend}
    double click element    //div/input[@id="mat-input-4"]
    sleep   1

    input text      //div/input[@id="mat-input-5"]      ${oldage}
    double click element    //div/input[@id="mat-input-5"]
    sleep   1

    input text      //div/input[@id="mat-input-6"]      ${youngdate}
    double click element    //div/input[@id="mat-input-6"]

    sleep    2
    click element    //button[@type="submit"]


