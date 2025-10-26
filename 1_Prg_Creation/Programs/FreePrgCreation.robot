*** Settings ***
Library          SeleniumLibrary
Library          DateTime
#Resource        ../1_Resource/Resource_FreePrg.robot
Resource         ../1_Resource/Resource_All_Prg.robot
Test Setup       Open the browser and open the URL
#Test Teardown    Close Browser

*** Variables ***


*** Test Cases ***
Free Program Creation
    ${Current_Date_Time}       get current date                                   exclude_millis=yes

    ${current_date}            get current date                                   result_format=%Y-%m-%d
    ${Div_regi_startdate}=     Add Time To Date     ${current_date}    -3 days    result_format=%m-%d-%Y
    ${Div_regi_closedate}=     Add Time To Date     ${current_date}    30 days    result_format=%m-%d-%Y
    ${Div_SeasonStart}=        Add Time To Date     ${current_date}    2 days     result_format=%m-%d-%Y
    ${Div_SeasonEnd}=          Add Time To Date     ${current_date}    45 days    result_format=%m-%d-%Y

    Handle One Trust Popup
    Login in the Portal     ${User_ID}       ${Pwd}
    Go to the Regitration forms
    Click the Add Program button and Select Free Program option
    Select the Activity     ${Activity}
    Complete the Program setting form       ${Free_Program_Name}${Current_Date_Time}
    Create Division 1    ${Free_Div1_Name}    ${Div_regi_startdate}     ${Div_regi_closedate}    ${Div_SeasonStart}    ${Div_SeasonEnd}
    ...     ${OldDate}     ${YoungDate}
    Create Division 2    ${Free_Div2_Name}       ${Div_regi_startdate}     ${Div_regi_closedate}    ${Div_SeasonStart}    ${Div_SeasonEnd}
    ...     ${OldDate}     ${YoungDate}
    Division 2 Advance Settings
    Go to the Registration Question and Add question
    Go to the Discount & Fees and varify is should not allow to assess for this program
    Go to the Team Staff Add Standard & Custom Team Staff       ${Vol_Name}
    Go to the Confirmation note and add some note into it

*** Keywords ***

#Login in the Portal
#    [Arguments]    ${UserName}      ${Password}
#    set selenium implicit wait            20s
#    set selenium speed                    0.4
#
#    run keyword and continue on failure         click element                     ID:dnn_dnnLOGIN_cmdLogin
#    click element                         ID:dnn_dnnLOGINLL_cmdLogin
#    wait until element is visible         email
#    input text                            Name:email                      ${UserName}
#    click element                         Name:continue
#    wait until element is visible         password
#    input password                        Name:password                   ${Password}
#    click element                         Name:continue

Go to the Regitration forms
    set selenium implicit wait            20s
    set selenium speed                    0.4
    wait until element is visible         //a/img[@class='logo-img']          300
    run keyword and continue on failure     wait until element is visible         //marketplace-toolbar[@class='hydrated']      100
    mouse over                            //a/span[contains(text(),'Registration')]
    click element                         //a/span[contains(text(),'Registration Forms')]

Click the Add Program button and Select Free Program option
    set selenium implicit wait            20s
    set selenium speed                    0.4
    wait until element is visible         //button/span[contains(text(),' Add Program')]      10
    click element                         //button/span[contains(text(),' Add Program')]

    execute javascript                    window.scrollTo(0,document.body.scrollHeight)

    click element                         (//button/span[contains(text(),' Select ')])[4]

Select the Activity
    [Arguments]     ${Activity}
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible         //button[contains(text(),'${Activity}')]            10
    click element                         //button[contains(text(),'${Activity}')]

    click element                         //button/span[contains(text(),' Save & Continue ')]

Complete the Program setting form
    [Arguments]    ${Prg_Name}
    set selenium implicit wait            20s
    set selenium speed                    0.4
    wait until element is visible         //input[@formcontrolname='nameCtrl']        10
    input text                            //input[@formcontrolname='nameCtrl']            ${Prg_Name}
#    run keyword and continue on failure     element should be disabled              //mat-select[@formcontrolname='ngbCtrl']
    run keyword and continue on failure    input text      CSS:.ql-editor          Free program Creation

    execute javascript                    window.scrollTo(0,document.body.scrollHeight)

    click element                         //button/span[contains(text(),'Save & Continue')]

Create Division 1
    [Arguments]       ${Div_Name}       ${RegOpen_Date}     ${RegClose_Date}    ${SeasonStart_Date}     ${SeasonEnd_Date}
    ...     ${Old_Date}     ${Young_Date}
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible         //button/span[contains(text(),' Add Division ')]        20
    click element                         //button/span[contains(text(),' Add Division ')]

    input text                            (//input[@formcontrolname='nameCtrl'])[1]                ${Div_Name}
    run keyword and continue on failure     element should be disabled          //input[@formcontrolname='priceCtrl']

    click element                         //mat-select[@name='genderCtrl']
    click element                         //mat-option[@value="select-all"]

    double click element                   //div/h3[contains(text(), "Division Information")]

    input text                            (//input[@formcontrolname='openDateCtrl'])[1]        ${RegOpen_Date}
    double click element                  //h3/span[contains(text(), "Age Range")]

    input text                            (//input[@formcontrolname='closeDateCtrl'])[1]        ${RegClose_Date}
    double click element                  //div/h3[contains(text(), "Season Dates")]

    input text                            (//input[@formcontrolname='startDateCtrl'])[1]        ${SeasonStart_Date}
    double click element                  //h3/span[contains(text(), "Age Range")]

    input text                            (//input[@formcontrolname='endDateCtrl'])[1]          ${SeasonEnd_Date}
    double click element                  //div/h3[contains(text(), "Season Dates")]

    input text                            (//input[@formcontrolname='ageStartCtrl'])[1]          ${Old_Date}
    double click element                  //div/h3[contains(text(), "Season Dates")]

    input text                            (//input[@formcontrolname='ageEndCtrl'])[1]          ${Young_Date}
    double click element                  //div/h3[contains(text(), "Season Dates")]

    click element                         //span/mat-icon[contains(text(),'save')]

Create Division 2
    [Arguments]       ${Div_Name}    ${RegOpen_Date}     ${RegClose_Date}    ${SeasonStart_Date}     ${SeasonEnd_Date}
    ...     ${Old_Date}    ${Young_Date}
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible         //button/span[contains(text(),' Add Division ')]        10
    click element                         //button/span[contains(text(),' Add Division ')]
    input text                            //input[@formcontrolname='nameCtrl']                ${Div_Name}
    run keyword and continue on failure     element should be disabled          //input[@formcontrolname='priceCtrl']

    click element                         //mat-select[@name='genderCtrl']
    click element                         //mat-option[@value="select-all"]

    double click element                   //div/h3[contains(text(), "Division Information")]

    input text                            (//input[@formcontrolname='openDateCtrl'])[1]        ${RegOpen_Date}
    double click element                  //h3/span[contains(text(), "Age Range")]

    input text                            (//input[@formcontrolname='closeDateCtrl'])[1]        ${RegClose_Date}
    double click element                  //div/h3[contains(text(), "Season Dates")]

    input text                            (//input[@formcontrolname='startDateCtrl'])[1]        ${SeasonStart_Date}
    double click element                  //h3/span[contains(text(), "Age Range")]

    input text                            (//input[@formcontrolname='endDateCtrl'])[1]          ${SeasonEnd_Date}
    double click element                  //div/h3[contains(text(), "Season Dates")]

    input text                            (//input[@formcontrolname='ageStartCtrl'])[1]          ${Old_Date}
    double click element                  //div/h3[contains(text(), "Season Dates")]

    input text                            (//input[@formcontrolname='ageEndCtrl'])[1]          ${Young_Date}
    double click element                  //div/h3[contains(text(), "Season Dates")]

    click element                         //span/mat-icon[contains(text(),'save')]

Division 2 Advance Settings
    set selenium implicit wait            20s
    set selenium speed                    0.4
    wait until element is visible         (//span[contains(text(),'Advanced')])[2]
    click element                         (//span[contains(text(),'Advanced')])[2]

    wait until element is visible         //input[@formcontrolname='maxPlayersCtrl']      10
    clear element text                    //input[@formcontrolname='maxPlayersCtrl']
    input text                            //input[@formcontrolname='maxPlayersCtrl']          0

    execute javascript                    window.scrollTo(0,document.body.scrollHeight)
    click element                         //div[contains(text(),'Yes')]

    execute javascript                    window.scrollTo(0,document.body.scrollHeight)
    click element                         //span/span[contains(text(),'Save')]

    execute javascript                    window.scrollTo(0,-document.body.scrollHeight)
    click element                         //span/mat-icon[contains(text(),'clear')]

    click element                         //button/span[contains(text(),' Save & Continue ')]

Go to the Registration Question and Add question
    set selenium implicit wait            20s
    set selenium speed                    0.4

    click element                         //button/span[contains(text(),' Display Standard Questions ')]

    ${Reg_Ques}=    Get WebElements       //span/span[contains(text(),'Add')]

    FOR    ${RegQ}   IN RANGE    3
        click element       ${Reg_Ques}[${RegQ}]
    END
    execute javascript                    window.scrollTo(0,document.body.scrollHeight)

    click element                         (//button/span[contains(text(),'Save')])[2]

    wait until element is visible         (//button/span[contains(text(),' Save & Continue ')])[2]        10
    click element                         (//button/span[contains(text(),' Save & Continue ')])[2]

Go to the Discount & Fees and varify is should not allow to assess for this program
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible         //mat-dialog-actions/button/span[contains(text(),'Continue')]        10

    Click Element                         //mat-dialog-actions/button/span[contains(text(),'Continue')]

Go to the Team Staff Add Standard & Custom Team Staff
    [Arguments]    ${Cpos_Name}
    set selenium implicit wait            20s
    set selenium speed                    0.4
    wait until element is visible         //button/span[contains(text(),' Display Standard Positions ')]    10
    click element                         //button/span[contains(text(),' Display Standard Positions ')]

    ${Avail_TeamStaff}=   Get WebElements     //label[@class='mat-checkbox-layout']

    FOR    ${RegQ}   IN RANGE   1    4
        click element       ${Avail_TeamStaff}[${RegQ}]
    END
    scroll element into view              //*[@id="select-team-personnel"]/tshq-program-wizard-nav/div/div/button/span

    click element                         //*[@id="select-team-personnel"]/tshq-program-wizard-nav/div/div/button/span

#   Custom position Add

    wait until element is visible         //button/span[contains(text(),' Add Team Staff Position ')]    10
    click element                         //button/span[contains(text(),' Add Team Staff Position ')]

    click element                         //div/button[contains(text(),'Custom Position')]

    wait until element is visible         //div/input[@formcontrolname='roleName']       20
    ${Current_Date_Time}            get current date        exclude_millis=yes
    input text                            //div/input[@formcontrolname='roleName']       ${Cpos_Name}${Current_Date_Time}

    input text                            //div/input[@formcontrolname='roleDescription']    it's custom position

    input text                            //div/input[@formcontrolname='displayName']     ${Cpos_Name}${Current_Date_Time}

    click element                         (//div[@class='tshq-program-wizard-nav']/button/span)[4]

    execute javascript                    window.scrollTo(0,document.body.scrollHeight)
    sleep       1
    execute javascript                    window.scrollTo(0,document.body.scrollHeight)

    wait until element is visible         (//div[@class='tshq-program-wizard-nav']/button/span)[4]      10
    click element                         (//div[@class='tshq-program-wizard-nav']/button/span)[4]

    wait until element is visible         (//button/span[contains(text(), " Save & Continue ")])[4]       20

    click element                         (//div[@class='tshq-program-wizard-nav']/button/span)[4]

Go to the Confirmation note and add some note into it
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible         //*[@formcontrolname='teamStaffConfirmationEmail']       10
    input text                            //*[@formcontrolname='confirmationEmail']/div[2]/div       Order Confirmation Notes
    input text                            //*[@formcontrolname='teamStaffConfirmationEmail']/div[2]/div      Team Staff Confirmation Notes

    scroll element into view              //button/span[contains(text(), " Save & Finish ")]

    click element                         //button/span[contains(text(), " Save & Finish ")]