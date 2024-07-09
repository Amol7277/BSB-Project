*** Settings ***
Library     SeleniumLibrary
Resource    Resource_Schedule.robot
Test Setup      Open the browser and open the URL   ${Portal_URL}     ${Browser}

*** Variables ***


*** Test Cases ***
Create Schedule
    Loing the Admin Account     ${U_Name}       ${Pwd}
    Go to the Schedule
    Create the Tournament Schedule
    Fill the all Details of Tournament Schedule     ${sch_Name}

*** Keywords ***
Open the browser and open the URL
    [Arguments]         ${Portal_URL}     ${Browser}
    Open Browser                    ${Portal_URL}     ${Browser}
    maximize browser window

Loing the Admin Account
    [Arguments]    ${UserName}      ${Password}
    click element                              ID:dnn_dnnLOGIN_cmdLogin
    wait until element is visible              email
    input text                                 Name:email                      ${UserName}
    click element                              Name:continue
    wait until element is visible              password                        20
    input password                             Name:password                   ${Password}
    click element                              Name:continue

Go to the Schedule
    wait until element is visible               //a/span[contains(text(),'Schedules')]          300
    sleep       2
    mouse over                                  //a/span[contains(text(),'Schedules')]
    sleep       1
    click element                               //a/span[contains(text(),'Manage Schedules')]

Create the Tournament Schedule
    wait until element is visible               //div[@id='newDiv']/a       50
    sleep       1
    click element                               //div[@id='newDiv']/a

    wait until element is visible               //a/span[contains(text(),'Tournament Bracketing')]       20
    sleep       1
    click element                               //a/span[contains(text(),'Tournament Bracketing')]

Fill the all Details of Tournament Schedule
    [Arguments]    ${schName}
    input text                                  ScheduleName            ${schName}
    sleep    2
    click element                               //span[@aria-owns='ProgramList_listbox']/span
    sleep       2
    click element                               (//ul/li[contains(text(),'16_05_TC')])[2]

    click element                               //span[@aria-owns='DivisionList_listbox']
    click element                               //ul/li[contains(text(),'PPT')]
    click element                               //a[contains(text(),'Division')]