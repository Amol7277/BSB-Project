*** Settings ***
Library         SeleniumLibrary
Resource        Resource.robot
Test Setup      Open the Browser & Open the Portal URL      ${Portal_URL}     ${Browser}

*** Variables ***


*** Test Cases ***
Free Program Creation
#    Open the Browser & Open the Portal URL      ${Portal_URL}     ${Browser}
    Login in the Portal     ${U_Name}       ${Pwd}
    Go to the Regitration forms
    Click the Add Program button and Select Free Program option
    Select the Activity     ${Activity_Name}
    Complete the Program setting form       ${Program_Name}
    Creation the Division 1 in Division Settings    ${Div1_Name}       ${RegOpenDate}     ${RegClose_Date}    ${SeasonStartDate}     ${SeasonEndDate}
    ...     ${OldDate}     ${YoungDate}
    Create the Division 2 for wait list in Division Settings    ${Div2_Name}       ${RegOpenDate}     ${RegClose_Date}    ${SeasonStartDate}     ${SeasonEndDate}
    ...     ${OldDate}     ${YoungDate}
    Go to the Advance settings of the Division 2 and Enable the waitlist
    Go to the Registration Question and Add question
#    Verify that only 3 question should be allow to select
    Go to the Discount & Fees and varify is should not allow to assess for this program
    Go to the Team Staff Add Standard & Custom Team Staff       ${Vol_Name}
    Go to the Confirmation note and add some note into it

*** Keywords ***
Open the Browser & Open the Portal URL
    [Arguments]         ${Portal_URL}     ${Browser}
    Open Browser                    ${Portal_URL}     ${Browser}
    maximize browser window

Login in the Portal
    [Arguments]    ${UserName}      ${Password}
    click element                   ID:dnn_dnnLOGIN_cmdLogin
    wait until element is visible       email
    input text                      Name:email                      ${UserName}
    click element                   Name:continue
    wait until element is visible       password
    input password                  Name:password                   ${Password}
    click element                   Name:continue

Go to the Regitration forms
    wait until element is visible       //a/img[@class='logo-img']          300
    mouse over                          //a/span[contains(text(),'Registration')]
    click element                       //a/span[contains(text(),'Registration Forms')]

Click the Add Program button and Select Free Program option
    wait until element is visible           //button/span[contains(text(),' Add Program')]      10
    click element                           //button/span[contains(text(),' Add Program')]
    sleep       2
    execute javascript                      window.scrollTo(0,document.body.scrollHeight)
    sleep       1
    click element                           (//button/span[contains(text(),' Select ')])[4]

Select the Activity
    [Arguments]     ${Activity}
    wait until element is visible           //button[contains(text(),'${Activity}')]            10
    click element                           //button[contains(text(),'${Activity}')]
    sleep       2
    click element                           //button/span[contains(text(),' Save & Continue ')]

Complete the Program setting form
    [Arguments]    ${Prg_Name}
    wait until element is visible           //input[@formcontrolname='nameCtrl']        10
    input text                              //input[@formcontrolname='nameCtrl']            ${Prg_Name}
#    run keyword and continue on failure     element should be disabled              //mat-select[@formcontrolname='ngbCtrl']
    run keyword and continue on failure     input text      CSS:.ql-editor          Free program Creation
    execute javascript                      window.scrollTo(0,document.body.scrollHeight)
    sleep       1
    click element                           //button/span[contains(text(),'Save & Continue')]

Creation the Division 1 in Division Settings
    [Arguments]       ${Div_Name}       ${RegOpen_Date}     ${RegClose_Date}    ${SeasonStart_Date}     ${SeasonEnd_Date}
    ...     ${Old_Date}     ${Young_Date}
    sleep       2
    wait until element is visible           //button/span[contains(text(),' Add Division ')]        20
    click element                           //button/span[contains(text(),' Add Division ')]

    sleep       2
    input text                              (//input[@formcontrolname='nameCtrl'])[1]                ${Div_Name}
    run keyword and continue on failure     element should be disabled          //input[@formcontrolname='priceCtrl']
    sleep       1
    click element                           //mat-select[@formcontrolname='genderCtrl']
    click element                           //mat-option[@value="C"]

    sleep       1
    input text                               (//input[@formcontrolname='openDateCtrl'])[1]        ${RegOpen_Date}
    double click element                     (//input[@formcontrolname='openDateCtrl'])[1]

    sleep       1
    input text                              (//input[@formcontrolname='closeDateCtrl'])[1]        ${RegClose_Date}
    double click element                    (//input[@formcontrolname='closeDateCtrl'])[1]

    sleep       1
    input text                              (//input[@formcontrolname='startDateCtrl'])[1]        ${SeasonStart_Date}
    double click element                    (//input[@formcontrolname='startDateCtrl'])[1]

    sleep       1
    input text                              (//input[@formcontrolname='endDateCtrl'])[1]          ${SeasonEnd_Date}
    double click element                    (//input[@formcontrolname='endDateCtrl'])[1]


    sleep       1
    input text                              (//input[@formcontrolname='ageStartCtrl'])[1]          ${Old_Date}
    double click element                    (//input[@formcontrolname='ageStartCtrl'])[1]

    sleep       1
    input text                              (//input[@formcontrolname='ageEndCtrl'])[1]          ${Young_Date}
    double click element                    (//input[@formcontrolname='ageEndCtrl'])[1]

    sleep    1
    double click element                         //h3/span[contains(text(), "Age Range")]
    sleep    1
    double click element                         //div/h3[contains(text(), "Season Dates")]
    sleep    1

    sleep       1
    click element                           //span/mat-icon[contains(text(),'save')]

Create the Division 2 for wait list in Division Settings
    [Arguments]       ${Div_Name}       ${RegOpen_Date}     ${RegClose_Date}    ${SeasonStart_Date}     ${SeasonEnd_Date}
    ...     ${Old_Date}     ${Young_Date}
    sleep       2
    wait until element is visible           //button/span[contains(text(),' Add Division ')]        10
    click element                           //button/span[contains(text(),' Add Division ')]
    input text                              //input[@formcontrolname='nameCtrl']                ${Div_Name}
    run keyword and continue on failure     element should be disabled          //input[@formcontrolname='priceCtrl']
    sleep       1
    click element                           //mat-select[@formcontrolname='genderCtrl']
    click element                           //mat-option[@value="C"]

    sleep       1
    input text                               (//input[@formcontrolname='openDateCtrl'])[1]        ${RegOpen_Date}
    double click element                     (//input[@formcontrolname='openDateCtrl'])[1]

    sleep       1
    input text                              (//input[@formcontrolname='closeDateCtrl'])[1]        ${RegClose_Date}
    double click element                    (//input[@formcontrolname='closeDateCtrl'])[1]

    sleep       1
    input text                              (//input[@formcontrolname='startDateCtrl'])[1]        ${SeasonStart_Date}
    double click element                    (//input[@formcontrolname='startDateCtrl'])[1]

    sleep       1
    input text                              (//input[@formcontrolname='endDateCtrl'])[1]          ${SeasonEnd_Date}
    double click element                    (//input[@formcontrolname='endDateCtrl'])[1]


    sleep       1
    input text                              (//input[@formcontrolname='ageStartCtrl'])[1]          ${Old_Date}
    double click element                    (//input[@formcontrolname='ageStartCtrl'])[1]

    sleep       1
    input text                              (//input[@formcontrolname='ageEndCtrl'])[1]          ${Young_Date}
    double click element                    (//input[@formcontrolname='ageEndCtrl'])[1]

    sleep    1
    double click element                         //h3/span[contains(text(), "Age Range")]
    sleep    1
    double click element                         //div/h3[contains(text(), "Season Dates")]
    sleep    1

    sleep       1
    click element                           //span/mat-icon[contains(text(),'save')]

Go to the Advance settings of the Division 2 and Enable the waitlist
    wait until element is visible                           (//span[contains(text(),'Advanced')])[2]
    sleep       1
    click element                           (//span[contains(text(),'Advanced')])[2]

    wait until element is visible           //input[@formcontrolname='maxPlayersCtrl']      10
    sleep       2
    clear element text                      //input[@formcontrolname='maxPlayersCtrl']
    input text                              //input[@formcontrolname='maxPlayersCtrl']          0

    execute javascript                      window.scrollTo(0,document.body.scrollHeight)
    click element                           //div[contains(text(),'Yes')]

    execute javascript                      window.scrollTo(0,document.body.scrollHeight)
    click element                           //span/span[contains(text(),'Save')]

    execute javascript                      window.scrollTo(0,-document.body.scrollHeight)
    click element                           //span/mat-icon[contains(text(),'clear')]

    sleep       2
    click element                           //button/span[contains(text(),' Save & Continue ')]

Go to the Registration Question and Add question
    sleep       5
    click element                           //button/span[contains(text(),' Display Standard Questions ')]

    ${Reg_Questions}=   Get WebElements     //span/span[contains(text(),'Add')]
#    ${index}=   set variable    1
    FOR    ${RegQ}   IN RANGE    3
#        ${Status}       run keyword and return status    element should be disabled    ${RegQ}
#        Exit For Loop If    ${Status} == 'False'
        sleep       1
        click element       ${Reg_Questions}[${RegQ}]
        sleep       1
#        ${index}=   evaluate    ${index} + 1
    END
    execute javascript                      window.scrollTo(0,document.body.scrollHeight)
    sleep       2
    click element                           (//button/span[contains(text(),'Save')])[2]
    wait until element is visible           (//button/span[contains(text(),' Save & Continue ')])[2]        10
    click element                           (//button/span[contains(text(),' Save & Continue ')])[2]

Go to the Discount & Fees and varify is should not allow to assess for this program
    wait until element is visible           //mat-dialog-actions/button/span[contains(text(),'Continue')]        10

    Click Element                           //mat-dialog-actions/button/span[contains(text(),'Continue')]

Go to the Team Staff Add Standard & Custom Team Staff
    [Arguments]    ${Cpos_Name}
    wait until element is visible                   //button/span[contains(text(),' Display Standard Positions ')]    10
    click element                                   //button/span[contains(text(),' Display Standard Positions ')]
#    click element                                   //button/span[contains(text(),' Add Team Staff Position ')]
#    click element                                   //div/button[contains(text(),'Available Position')]

#    standard position selection
    wait until element is visible                   //label[@class='mat-checkbox-layout']       10
    click element                                   (//label[@class='mat-checkbox-layout'])[2]
    click element                                   (//label[@class='mat-checkbox-layout'])[3]
    click element                                   (//label[@class='mat-checkbox-layout'])[4]
    scroll element into view                        //*[@id="select-team-personnel"]/tshq-program-wizard-nav/div/div/button/span
    sleep    1
    click element                                   //*[@id="select-team-personnel"]/tshq-program-wizard-nav/div/div/button/span

#   Custom position Add
    sleep       1
    wait until element is visible                   //button/span[contains(text(),' Add Team Staff Position ')]    10
    click element                                   //button/span[contains(text(),' Add Team Staff Position ')]
    sleep       2
    click element                                   //div/button[contains(text(),'Custom Position')]

    wait until element is visible                   //div/input[@formcontrolname='roleName']       20
    input text                                      //div/input[@formcontrolname='roleName']       ${Cpos_Name}
    sleep     1
    input text                                      //div/input[@formcontrolname='roleDescription']    it's custom position
    sleep     1
    input text                                      //div/input[@formcontrolname='displayName']     ${Cpos_Name}
    sleep     1
    click element                                   (//div[@class='tshq-program-wizard-nav']/button/span)[4]
#    click element                                  //*[@class="edit-team-personnel"]/div/div/div[2]/tshq-program-wizard-nav/div/div/button/span
    sleep   2
    execute javascript                              window.scrollTo(0,document.body.scrollHeight)
    sleep     3
    wait until element is visible                   (//div[@class='tshq-program-wizard-nav']/button/span)[4]      10
    click element                                   (//div[@class='tshq-program-wizard-nav']/button/span)[4]
    sleep     2

    wait until element is visible                   (//button/span[contains(text(), " Save & Continue ")])[4]       20
#    wait until element is visible                  (//div[@class='tshq-program-wizard-nav']/button/span)[4]       20
    sleep   2
    click element                                   (//button/span[contains(text(), " Save & Continue ")])[4]
#    click element                                  (//div[@class='tshq-program-wizard-nav']/button/span)[4]

Go to the Confirmation note and add some note into it
    wait until element is visible       //quill-editor[@formcontrolname='teamStaffConfirmationEmail']       10
    sleep       1
    input text        //quill-editor[@formcontrolname='confirmationEmail']/div[2]/div       Order Confirmation Notes
    sleep       1
    input text        //quill-editor[@formcontrolname='teamStaffConfirmationEmail']/div[2]/div      Team Staff Confirmation Notes

    scroll element into view                        //button/span[contains(text(), " Save & Finish ")]
    sleep       1
    click element                                   //button/span[contains(text(), " Save & Finish ")]