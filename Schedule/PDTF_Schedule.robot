*** Settings ***
Library     SeleniumLibrary
Library     DateTime
#Resource    Resource_Schedule.robot
Resource    ../Schedule/Resource/Resource_Schedule.robot
Test Setup      Open the browser and open the URL   ${Portal_URL}     ${Browser}

*** Variables ***


*** Test Cases ***
Create Schedule

    ${Todays_Date}      get current date        exclude_millis=yes
    ${Schedule_date}    Add Time To Date     ${Todays_Date}    4 days    result_format=%m/%d/%Y

    Loing the Admin Account     ${U_Name}       ${Pwd}
    Go to the Schedule
    Create the PDTF Schedule
    Fill the all Details of PDTF Schedule     ${PDTF_Name}${Todays_Date}     ${Prg_Name}    ${Schedule_date}
    PDTF Allocate the Teams
    PDTF location & Field
    PDTF Select Location
    PDTF 5th Step
    PDTF 6th Step
    PDTF 7th Step
    PDTF 8th Step

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
    wait until element is visible               //ul[@class='root-container']/li[6]          300
#    run keyword and continue on failure    wait until element is visible         //marketplace-toolbar[@class='hydrated']      100
    sleep       1
#    mouse over                                  //a/span[contains(text(),'Schedules')]
    mouse over                                  //ul[@class='root-container']/li[6]

    wait until element is visible               (//ul/li[6]/div/ul/li/a/span)[1]        10
    sleep       2
    click element                               (//ul/li[6]/div/ul/li/a/span)[1]

Create the PDTF Schedule
    wait until element is visible               //div[@id='newDiv']/a       50
    sleep       1
    click element                               //div[@id='newDiv']/a

    wait until element is visible               //a/span[contains(text(),'Pairing Date, Time, and Field')]       20
    sleep       1
    click element                               //a/span[contains(text(),'Pairing Date, Time, and Field')]

Fill the all Details of PDTF Schedule
    [Arguments]    ${schName}   ${Prg_Name}     ${Schedule_date}
    set selenium implicit wait            20s
    set selenium speed                    0.4
#    run keyword and continue on failure    wait until element is visible    //marketplace-toolbar[@class='hydrated']    100
    wait until element is visible               ScheduleName        10
    input text                                  ScheduleName            ${schName}
#    sleep    2
    click element                               //*[contains(text(),'Select Program')]
#    sleep       2
    click element                               (//ul/li[contains(text(),"${Prg_Name}")])[2]

    ${Division}     create list     Div 1   Div 2
#    ${Division}=     get webelements     (//ul[@id="DivisionList_listbox"])[2]/li
    FOR    ${i}     IN    @{Division}
#        sleep       2
        click element                               //span[@aria-owns='DivisionList_listbox']
#        sleep       2
        click element                               //ul/li[contains(text(),'${i}')]
#        sleep       2
        click element                               //a[contains(text(),'Division')]
    END

#Schedule Type
    click element                               //span[contains(text(),'Schedule Type')]

    click element                               (//ul/li[contains(text(),'Game')])[2]

#Date Picker
    clear element text                      id:scheduleDatailsStartDate
#    sleep       1
    input text                              id:scheduleDatailsStartDate     ${Schedule_date}

#Select Game Duration
#    sleep       2
    click element                           //span[@aria-owns='GameDurationHours_listbox']
#    sleep       1
    click element                           //ul[@id='GameDurationHours_listbox']/li[2]
#    sleep       1
    click element                           (//span[@aria-owns='GameDurationMins_listbox'])
#    sleep       1
    click element                           //ul[@id='GameDurationMins_listbox']/li[2]
#    sleep       1
#Time between Game
    click element                           //span[@aria-owns='GameIntervalHours_listbox']
#    sleep       1
    click element                           //ul[@id='GameIntervalHours_listbox']/li[2]
#    sleep       1
    click element                           //span[@aria-owns='GameIntervalMins_listbox']
#    sleep       1
    click element                           //ul[@id='GameIntervalMins_listbox']/li[2]

#Time Between Rounds
#    sleep       1
    click element                           //span[@aria-owns='RoundIntervalDays_listbox']
#    sleep       1
    click element                           //ul[@id='RoundIntervalDays_listbox']/li[2]
#    sleep       1
    click element                           //span[@aria-owns='RoundIntervalHours_listbox']
#    sleep       1
    click element                           //ul[@id='RoundIntervalHours_listbox']/li[2]
#    sleep       1
    click element                           //span[@aria-owns='RoundIntervalMins_listbox']
#    sleep       1
    click element                           //ul[@id='RoundIntervalMins_listbox']/li[2]
#    sleep       1
    execute javascript                      window.scrollTo(0,document.body.scrollHeight)
    click element                           nextNavigationLink

PDTF Allocate the Teams
    set selenium implicit wait            20s
    set selenium speed                    0.4
#    To allocation all team
    sleep       2
    click element                           //a[contains(text(),'Allocate All')]
    sleep       1
    click element                           nextNavigationLink
    sleep       2

PDTF location & Field
    set selenium implicit wait            20s
    set selenium speed                    0.4
    click element                           nextNavigationLink

PDTF Select Location
    set selenium implicit wait            20s
    set selenium speed                    0.4

#    sleep       2
    click element                           //span[@aria-owns='LocationList_listbox']
#    sleep       1
    click element                           (//ul[@id='LocationList_listbox'])[2]/li[contains(text(),'Test')]
#    sleep       2
    click element                           //a[contains(text(),'Assign All')]
#    sleep       2
    click element                           nextNavigationLink

PDTF 5th Step
    set selenium implicit wait            20s
    set selenium speed                    0.4

    execute javascript                      window.scrollTo(0,document.body.scrollHeight)
#    wait until element is visible           nextNavigationLink      10
#    sleep       2
    click element                           nextNavigationLink

PDTF 6th Step
    set selenium implicit wait            20s
    set selenium speed                    0.4

#    wait until element is visible           generateScheduleLink      10
    execute javascript                      window.scrollTo(0,document.body.scrollHeight)
#    sleep       2
    click element                           generateScheduleLink

PDTF 7th Step
    set selenium implicit wait            20s
    set selenium speed                    0.4
#    wait until element is visible           acceptScheduleLink      10
    sleep       2
    execute javascript                      window.scrollTo(0,document.body.scrollHeight)
    sleep       2
    click element                           acceptScheduleLink

PDTF 8th Step
    set selenium implicit wait            20s
    set selenium speed                    0.4

#    wait until element is visible           finishLink      10
    execute javascript                      window.scrollTo(0,document.body.scrollHeight)
    sleep       2
    click element                           finishLink
