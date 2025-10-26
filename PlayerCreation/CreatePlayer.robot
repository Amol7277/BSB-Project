*** Settings ***
Library         SeleniumLibrary
Resource        Resource_PlayerCreate.robot
Test Setup      Open the Browser and Open URL

*** Variables ***


*** Test Cases ***
Player Creation
    Login in to Account         ${U_Name}       ${Pwd}
    Login very 1st time Select the Registration Type
    Login Very 1st time Fill up the Account Holder Details      ${F_Name}   ${L_Name}   ${Cell_Number}    ${Street}     ${City}     ${Zip}
    Add more player in the account
#    Login 2nd time
#    Login 2nd time click Gear and Fill up account details    ${F_Name}   ${L_Name}   ${Cell_Number}    ${Street}     ${City}     ${Zip}
#    Select the number of player and Enter the First Name then Continue      ${Player1}
#    Fill All Details of Player and Click Save   ${Last_Name}

*** Keywords ***
Open the Browser and Open URL
    open browser        ${URL}      ${Browser}
    maximize browser window

Login in to Account
    [Arguments]    ${UserName}      ${Password}
#    click element                   ID:dnn_dnnLOGIN_cmdLogin
    click element                   ID:dnn_dnnLOGINLL_cmdLogin
    wait until element is visible       email
    input text                      Name:email                      ${UserName}
    click element                   Name:continue
    wait until element is visible       password
    input password                  Name:password                   ${Password}
    click element                   Name:continue

Login very 1st time Select the Registration Type
    set selenium implicit wait          20s
    set selenium speed                  2s
    wait until element is visible    //span[contains(text(),'Register a Player')]       50
    click element                   //span[contains(text(),'Register a Player')]

    scroll element into view        //h2[contains(text(),'Register Myself')]
    click element                   //h2[contains(text(),'Register Myself')]

    scroll element into view        //h2[contains(text(),'Player')]
    click element                   //h2[contains(text(),'Player')]

Login Very 1st time Fill up the Account Holder Details
    [Arguments]     ${FN}   ${LN}   ${Cell}    ${Street}    ${City}     ${Zip}
    set selenium implicit wait          20s
    set selenium speed                  0.4s
#    wait until element is visible       //input[@formcontrolname='firstName']       20
    input text                      //input[@formcontrolname='firstName']           ${FN}
    input text                      (//input[@formcontrolname='lastName'])[1]       ${LN}

    click element                   //mat-select[@formcontrolname="gender"]
    click element                   //mat-option[@value="M"]

    double click element            //input[@formcontrolname='dateOfBirth']
    input text                      //input[@formcontrolname='dateOfBirth']   07/15/2008

    click element                   //mat-select[@formcontrolname='relationship']
    click element                   //mat-option[@value='Guardian']

    scroll element into view        //input[@formcontrolname='mobile']
    input text                      //input[@formcontrolname='mobile']          ${Cell}

    scroll element into view        //input[@formcontrolname='street']
    input text                      //input[@formcontrolname='street']          ${Street}
    input text                      //input[@formcontrolname='city']            ${City}
    click element                   //mat-select[@formcontrolname='state']

    click element                   //mat-option/span[contains(text(),'California')]

    input text                      //input[@formcontrolname='zip']             ${Zip}


    execute javascript              window.scrollTo(0,document.body.scrollHeight)

    click element                   //button/span[contains(text(),'Continue')]

    wait until element is visible       //*[@class='mat-toolbar-row']/img       30
    click element                      //*[@class='mat-toolbar-row']/img
    click element                      //a[contains(text(),'Account')]

Add more player in the account
    set selenium implicit wait          20s
    set selenium speed                  0.4s
    wait until element is visible       //span[contains(text(),'Add Player')]       100
    click element                   //span[contains(text(),'Add Player')]
    input text                      //input[@formcontrolname='firstName']           Amol
    input text                      (//input[@formcontrolname='lastName'])[1]       Sonar

    click element                   //mat-select[@formcontrolname="gender"]
    click element                   //mat-option[@value="M"]

    double click element            //input[@formcontrolname='dateOfBirth']
    input text                      //input[@formcontrolname='dateOfBirth']         07/15/2008

    run keyword and continue on failure
    ...     choose file         //div/div/div[contains(text(),'Birth Certificate')]       C:/Users/HP/Downloads/2024-08-06.jpg

    click element                   //span[contains(text(),'Continue')]







Login 2nd time
    wait until element is visible       //a[@class='setting-link']      20
    click element                       //a[@class='setting-link']

Login 2nd time click Gear and Fill up account details
    [Arguments]     ${FN}   ${LN}   ${Cell}    ${Street}    ${City}     ${Zip}
    wait until element is visible       //input[@formcontrolname='firstName']       20
    input text                      //input[@formcontrolname='firstName']           ${FN}
    input text                      (//input[@formcontrolname='lastName'])[1]       ${LN}

    sleep       1
    click element                   (//mat-select[@formcontrolname='gender'])[1]
    click element                   (//mat-option[@value='M'])[1]

    double click element    //input[@formcontrolname='dateOfBirth']
    input text    //input[@formcontrolname='dateOfBirth']   07/15/2008

    click element                   //mat-select[@formcontrolname="relationship"]
    click element                   //mat-option[@value='Guardian']

    sleep       1
    scroll element into view        //input[@formcontrolname='mobile']
    input text                      //input[@formcontrolname='mobile']          ${Cell}

    sleep       1
    scroll element into view        //input[@formcontrolname='street']
    input text                      //input[@formcontrolname='street']          ${Street}
    input text                      //input[@formcontrolname='city']            ${City}
    click element                   //mat-select[@formcontrolname='state']
    sleep       1
    click element                   //mat-option/span[contains(text(),'California')]
    sleep       1
    input text                      //input[@formcontrolname='zip']             ${Zip}

    sleep       1
    execute javascript              window.scrollTo(0,document.body.scrollHeight)
    sleep       1
    click element                   //button/span[contains(text(),' Save')]

Select the number of player and Enter the First Name then Continue
    [Arguments]    ${P1}
    wait until element is visible    //a/span[contains(text(),'Register a Player')]     50
    click element                   //a/span[contains(text(),'Register a Player')]
    sleep       1
    wait until element is visible    //h2[contains(text(),'Register My Players')]       50
    click element                   //h2[contains(text(),'Register My Players')]

    sleep      2
    wait until element is visible           (//*[@role='group']/div)[1]    50
    mouse over                              (//*[@role='group']/div)[1]
    sleep       1
    click element                           (//*[@role='group']/div)[1]

    input text                              //input[@formcontrolname='name']        ${P1}
    sleep       1
    click element                           //button[@buttonarrows='right']/span

Fill All Details of Player and Click Save
    [Arguments]    ${LN}
    wait until element is visible           //input[@formcontrolname='lastName']        50

    input text                              //input[@formcontrolname='lastName']        ${LN}

    click element                           //mat-select[@formcontrolname='gender']
    click element                           //mat-option[@value='M']

    double click element    //input[@formcontrolname='dateOfBirth']
    input text    //input[@formcontrolname='dateOfBirth']   01/01/2008
#    input text                              //input[@formcontrolname='dateOfBirth']         01/01/2008
    sleep       1
    execute javascript              window.scrollTo(0,document.body.scrollHeight)
    sleep       2
    click element                   //button/span[contains(text(),'Continue')]