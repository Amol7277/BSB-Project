*** Settings ***
Library     SeleniumLibrary
Library     DateTime
#Resource    Resource_Schedule.robot
Resource        ../Schedule/Resource/Resource_Schedule.robot
Test Setup      Open the browser and open the URL   ${Portal_URL}     ${Browser}

*** Variables ***


*** Test Cases ***
Create Schedule

    ${Todays_Date}      get current date        exclude_millis=yes
    ${Schedule_date}    Add Time To Date     ${Todays_Date}    6 days    result_format=%m/%d/%Y

    Loing the Admin Account     ${U_Name}       ${Pwd}
    Go to the Schedule
    Create the Tournament Schedule
    Fill the all Details of Tournament Schedule     ${SE_Tournament_Name}${Todays_Date}     ${Prg_Name}    ${Schedule_date}
    Allocate the Teams
    location & Field
    Select Location
    5th Step
    6th Step
    7th Step
    8th Step

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

Create the Tournament Schedule
    wait until element is visible               //div[@id='newDiv']/a       50
    sleep       1
    click element                               //div[@id='newDiv']/a

    wait until element is visible               //a/span[contains(text(),'Tournament Bracketing')]       20
    sleep       1
    click element                               //a/span[contains(text(),'Tournament Bracketing')]

Fill the all Details of Tournament Schedule
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

#To Select Single Elimination
#    sleep       2
    click element                           //div[@id="scheduleDetailsTab"]/div[4]/div/img[1]

#To Select Double Elimination
#    sleep       2
#    click element                           //div[@id="scheduleDetailsTab"]/div[4]/div[1]/div/img[2]

#Date Picker
    clear element text                      id:scheduleDatailsStartDate
#    sleep       1
    input text                              id:scheduleDatailsStartDate     ${Schedule_date}

#Select Game Duration
#    sleep       2
    click element                           (//span[@aria-owns='GameDurationHours_listbox'])[2]
#    sleep       1
    click element                           (//ul[@id='GameDurationHours_listbox'])[2]/li[2]
#    sleep       1
    click element                           (//span[@aria-owns='GameDurationMins_listbox'])[2]
#    sleep       1
    click element                           (//ul[@id='GameDurationMins_listbox'])[2]/li[2]
#    sleep       1
#Time between Game
    click element                           (//span[@aria-owns='GameIntervalHours_listbox'])[2]
#    sleep       1
    click element                           (//ul[@id='GameIntervalHours_listbox'])[2]/li[2]
#    sleep       1
    click element                           (//span[@aria-owns='GameIntervalMins_listbox'])[2]
#    sleep       1
    click element                           (//ul[@id='GameIntervalMins_listbox'])[2]/li[2]

#Time Between Rounds
#    sleep       1
    click element                           (//span[@aria-owns='RoundIntervalDays_listbox'])[2]
#    sleep       1
    click element                           (//ul[@id='RoundIntervalDays_listbox'])[2]/li[2]
#    sleep       1
    click element                           (//span[@aria-owns='RoundIntervalHours_listbox'])[2]
#    sleep       1
    click element                           (//ul[@id='RoundIntervalHours_listbox'])[2]/li[2]
#    sleep       1
    click element                           (//span[@aria-owns='RoundIntervalMins_listbox'])[2]
#    sleep       1
    click element                           (//ul[@id='RoundIntervalMins_listbox'])[2]/li[2]
#    sleep       1
    execute javascript                      window.scrollTo(0,document.body.scrollHeight)
    click element                           nextNavigationLink

Allocate the Teams
    set selenium implicit wait            20s
    set selenium speed                    0.4
#    To allocation all team
    sleep       2
    click element                           (//a[contains(text(),'Allocate All')])[2]
    sleep       1
    click element                           nextNavigationLink
    sleep       2

location & Field
    set selenium implicit wait            20s
    set selenium speed                    0.4
    click element                           nextNavigationLink

Select Location
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

5th Step
    set selenium implicit wait            20s
    set selenium speed                    0.4

    execute javascript                      window.scrollTo(0,document.body.scrollHeight)
#    wait until element is visible           nextNavigationLink      10
#    sleep       2
    click element                           nextNavigationLink

6th Step
    set selenium implicit wait            20s
    set selenium speed                    0.4

#    wait until element is visible           generateScheduleLink      10
    execute javascript                      window.scrollTo(0,document.body.scrollHeight)
#    sleep       2
    click element                           generateScheduleLink

7th Step
    set selenium implicit wait            20s
    set selenium speed                    0.4
#    wait until element is visible           acceptScheduleLink      10
    sleep       2
    execute javascript                      window.scrollTo(0,document.body.scrollHeight)
    sleep       2
    click element                           acceptScheduleLink

8th Step
    set selenium implicit wait            20s
    set selenium speed                    0.4

#    wait until element is visible           finishLink      10
    execute javascript                      window.scrollTo(0,document.body.scrollHeight)
    sleep       2
    click element                           finishLink
