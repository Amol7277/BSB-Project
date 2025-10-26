*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Resource    Resource_report.robot
Test Setup        Open Browser and portal URL   ${Portal1_URL}      ${Browser}

*** Variables ***

*** Test Cases ***
Report test case
    1 Login Admin User     ${U_Name}       ${Pwd}
    2 Open Report Module
    3 Open the Enrollment Detail Report
    4 Select the Program from All Program dropdown        ${Program_Name}
    5 Export all formats of report file
    6 Select All program option from the left dropdown
    7 Add the Condition
    8 Add the Columns
    9 Apply Filter and short then export the file         ${Program_Name}
    ${Date_NF_NR}                    get current date        result_format=%d.%m.%Y %H%M
    10 Save the report in New folder     ${Report_Name}${Date_NF_NR}      ${Folder_Name}${Date_NF_NR}
    11 Share the Report to Any User            ${User_Email}
    12 Navigate to Reports Home Page & Verify Recent report
    13 Verify Most Visited report       ${Visited Report}
    ${Date_NF_SaveTab}        get current date        result_format=%d.%m.%Y %H%M%S
    14 In Save tab Create New folder, Rename, Move, Archive & Delete the Folder          ${Folder_Name}${Date_NF_SaveTab}
    15 Navigate to shared report and varify the Report & Remove the report    ${Report_Name}${Date_NF_NR}     ${User_Email}
    16 Navigate Archived Tab check Unarchive and Delete
    17 Access static report(Shopping Cart Report)
    18 Access static report(Uniform Report)     ${Program_Name}
    19 Open Any Billing Report(Division Summary)

*** Keywords ***
Open Browser and portal URL
    [Arguments]         ${Portal_URL}     ${Browser}
    Open Browser                    ${Portal_URL}     ${Browser}
    maximize browser window

1 Login Admin User
    [Arguments]    ${UserName}      ${Password}
    click element                              ID:dnn_dnnLOGIN_cmdLogin
    wait until element is visible              email
    input text                                 Name:email                      ${UserName}
    click element                              Name:continue
    wait until element is visible              password                        20
    input password                             Name:password                   ${Password}
    click element                              Name:continue

2 Open Report Module
    set selenium implicit wait            20s
    set selenium speed                    0.4
    run keyword and continue on failure    wait until element is visible         //marketplace-toolbar[@class='hydrated']      300

    click element                               //li/a[contains(text(),'Reports')]

    run keyword and continue on failure    wait until element is visible         //marketplace-toolbar[@class='hydrated']      100


3 Open the Enrollment Detail Report
    set selenium implicit wait            10
    set selenium speed                    0.4

    click element                               //mat-panel-title[@title='Standard Reports']

    click element                               //mat-panel-title[@title='Registration']

    ${Visited Report}           get text        //div/a[@title='Enrollment Details']
    log to console              Recent visited Report - ${Visited Report}
    set suite variable    ${Visited Report}
    set global variable    ${Visited Report}
    click element                               //div/a[@title='Enrollment Details']

    wait until element is visible               //div/span[@title='Enrollment Details']         100

4 Select the Program from All Program dropdown
    [Arguments]         ${Prg_Name}
    set selenium implicit wait            10s
    set selenium speed                    0.4

    click element                               //mat-select[@formcontrolname='selectedProgramId']

    input text                                  //input[@formcontrolname='filterInput']         ${Prg_Name}

    click element                               //mat-option/span[contains(text(),'${Prg_Name}')]

    wait until element is visible               //div/span[@title='Enrollment Details']         100

5 Export all formats of report file
    set selenium implicit wait            20s
    set selenium speed                    0.4
    wait until element is not visible           //mat-spinner[@role='progressbar']      10

    click element                               //span[contains(text(),'Export')]

    click element                               //button[contains(text(),' CSV ')]

    click element                               //span[contains(text(),'Export')]

    click element                               //button[contains(text(),'Excel')]

6 Select All program option from the left dropdown
    set selenium implicit wait            15
    set selenium speed                    0.4
    click element                               //mat-select[@formcontrolname='selectedProgramId']

    click element                               //mat-option/span[contains(text(),'All Programs')]
    wait until element is visible               //div/span[@title='Enrollment Details']         100

7 Add the Condition
    set selenium implicit wait            20s
    set selenium speed                    0.4

    execute javascript                          window.scrollTo(0,document.body.scrollHeight)

    click element                               //div[@class='condition-actions']/button/span

    wait until element is visible               //div[@class='ngx-customscrollbar-wrapper']/div/form        20

    click element                               //span[contains(text(),'Additional Player Info')]

    click element                               //span[contains(text(),'Divisions')]

    click element                               //mat-select[@formcontrolname="column"]

    click element                               //mat-option/span[contains(text(),' Division Price ')]

    click element                               (//mat-select[@formcontrolname="operator"])[4]

    click element                               //mat-option/span[contains(text(),' is greater than ')]

    input text                                  (//input[@formcontrolname="operatorValue"])[3]           0

    click element                               //button/span[contains(text(),'Save')]
    wait until element is visible               //div/span[@title='Enrollment Details']         100

8 Add the Columns
    set selenium implicit wait            20s
    set selenium speed                    0.4

    click element                               //div[@class='column-actions']/button/span
    wait until element is visible               //div[@class='ngx-customscrollbar-wrapper']/div/form        20
    click element                               //span[contains(text(),'Additional Player Info')]

    click element                               //span[contains(text(),'Divisions')]

    click element                               //span[contains(text(),'Add All')]

    click element                               //button/span[contains(text(),' Save ')]
    wait until element is visible               //div/span[@title='Enrollment Details']         100

9 Apply Filter and short then export the file
    [Arguments]         ${Prg_Name}
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is visible               (//th[@role='columnheader']/div/span/mat-icon)[1]       10

    click element                               (//th[@role='columnheader']/div/span/mat-icon)[1]

    click element                               //mat-select[@formcontrolname='sortValue']

    click element                               //mat-option/span[contains(text(),'Sort Z to A')]

    run keyword and continue on failure    wait until element is visible         //marketplace-toolbar[@class='hydrated']      100
    wait until element is visible               (//th[@role='columnheader']/div/span/mat-icon)[1]       10

    click element                               (//th[@role='columnheader']/div/span/mat-icon)[1]

    input text                                  //input[@formcontrolname='searchValue']         ${Prg_Name}

    click element                               //button/span[contains(text(),'Apply')]

    wait until element is not visible           //mat-spinner[@role='progressbar']      10
    click element                               //span[contains(text(),'Export')]

    click element                               //button[contains(text(),' CSV ')]


10 Save the report in New folder
    [Arguments]     ${Report_Name}      ${Folder_Name}
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is not visible           //mat-spinner[@role='progressbar']      10

    click element                               //span[contains(text(),'Save')]

    click element                               //button[contains(text(),'Save As')]

    wait until element is visible               //h1[contains(text(),'Save custom report')]         100

    input text                                  //input[@formcontrolname='name']        ${Report_Name}
    sleep       1s

    click element                               //mat-select[@formcontrolname='folder']
    click element                               //span[contains(text(),' New Folder ')]

    input text                                  //input[@formcontrolname='folderName']      ${Folder_Name}

    click element                               //span[contains(text(),'Create & Save')]

11 Share the Report to Any User
    [Arguments]     ${User_Email}
    set selenium implicit wait            20s
    set selenium speed                    0.4

    wait until element is not visible           //mat-spinner[@role='progressbar']      15

    click element                               //span[contains(text(),'Share')]

    input text                                  //input[@formcontrolname='searchInput']     ${User_Email}

    wait until element is visible               //div[@role='listbox']      10

    run keyword and continue on failure         click element                               //div[@role='listbox']

    input text                                  //textarea[@formcontrolname='message']      Report send

    click element                               //button/span[contains(text(),'Send')]

12 Navigate to Reports Home Page & Verify Recent report
    set selenium implicit wait            10s
    set selenium speed                    0.4

    wait until element is visible               //div[@class='report-header-name']/span         10

    sleep       2
    ${New Report Name}      get text            //div[@class='report-header-name']
    log to console      New Report Name - ${New Report Name}

    click element                               //div/a[contains(text(),'Reports')]

    wait until element is visible               //thead[@role='rowgroup']               100

    wait until element is not visible           //mat-spinner[@role='progressbar']      10
    sleep       2
    ${Recent_Report}    get text                //tbody[@role='rowgroup']/tr[1]

    log to console    Recent Report Name - ${Recent_Report}
    ${Recent_Report_Name}     get text              //tbody[@role='rowgroup']/tr[1]/td
    should be equal          ${Recent_Report_Name}      ${New Report Name}

13 Verify Most Visited report
    [Arguments]    ${Visited Report}
    set selenium implicit wait            10s
    set selenium speed                    0.4

    click element                               //div/a[contains(text(),'Reports')]

    click element                               //div/a[contains(text(),' Most Visited ')]

    wait until element is not visible           //mat-spinner[@role='progressbar']      10
    sleep       2s
    ${Most_Visited_Report}    get text          //tbody[@role="rowgroup"]/tr[1]/td/a
    log to console       Most visited Report Name - ${Most_Visited_Report}
    sleep       1
    log to console    Recent visited Report - ${Visited Report}
    should be equal      ${Most_Visited_Report}      ${Visited Report}

14 In Save tab Create New folder, Rename, Move, Archive & Delete the Folder
    [Arguments]    ${Folder_Name}
    set selenium implicit wait             10s
    set selenium page load timeout         0.4

#    wait until element is not visible           //mat-spinner[@role='progressbar']      15
#    click element                               //div/a[contains(text(),'Reports')]

    click element                    //div/a[contains(text(),'Saved')]
    wait until element is not visible           //mat-spinner[@role='progressbar']      5

#Create New Folder
    click element                    //span[contains(text(),'New Folder')]
    sleep       2
    click element                    //span[contains(text(),'New Folder')]

    log to console        ${Folder_Name}
    input text                   //input[@formcontrolname="folderName"]      ${Folder_Name}
    click element                    //button/span[contains(text(),'Create')]

    wait until element is not visible           //mat-spinner[@role='progressbar']      8

#Rename Folder

    ${First_Folder}=    get text        (//a[@class='folder-name']/span)[1]
    ${Folder_Names}         get webelements       //a[@class='folder-name']/span

    ${index}=    set variable      1
    FOR     ${F_Name}     IN     @{Folder_Names}

        scroll element into view    ${F_Name}
        log to console    Folder Name - ${F_Name.text}
        log to console    Folder Name 1 - ${Folder_Name}

        Exit For Loop If    '${First_Folder}' == '${F_Name.text}'
        ${index}=   evaluate    ${index} + 1
    END
#    click image          (//tbody/tr/td[3]/div/button[1]/span/mat-icon[@role="img"])[${index}]
    click element           (//button/span/mat-icon[contains(text(),"edit")])[${index}]
    sleep       1
    clear element text      //input[@formcontrolname="folderName"]
    ${Current_DateTime}                   get current date        result_format=%d.%m.%Y
    sleep       1
    input text            //input[@formcontrolname="folderName"]        ${Folder_Name}${Current_DateTime}
    click element         //button/span[contains(text(),'Update')]

#Move folder
    wait until element is not visible           //mat-spinner[@role='progressbar']      5

    click element       (//button/span/mat-icon[contains(text(),'drive_file_move')])[${index}]

    click element       //mat-select[@formcontrolname="folder"]
    click element       (//span/mat-option[@role="option"])[1]

    click element       //span[contains(text(),'Update')]
    wait until element is not visible           //mat-spinner[@role='progressbar']      5

#Archive the Folder
    click element            (//button/span/mat-icon[contains(text(),"delete")])[${index}]
    click element             (//button/span[contains(text(),"Archive")])
    wait until element is not visible           //mat-spinner[@role='progressbar']      5

#Delete the Folder
    click element            (//button/span/mat-icon[contains(text(),"delete")])[${index}]
    click element             (//button/span[contains(text(),"Delete")])
    wait until element is not visible           //mat-spinner[@role='progressbar']      5

15 Navigate to shared report and varify the Report & Remove the report
    [Arguments]    ${Report_Name}      ${User_Email}
    set selenium implicit wait             10s
    set selenium page load timeout         0.4

#    wait until element is not visible           //mat-spinner[@role='progressbar']      15
#    click element                               //div/a[contains(text(),'Reports')]

    click element                    //div/a[contains(text(),'Shared')]
    wait until element is not visible           //mat-spinner[@role='progressbar']      5

    log to console    Report Name-> ${Report_Name}
    ${Shared_Reports}       get webelements      //a[@class='report-name']
    ${index}=   set variable      1
    FOR     ${shared}   IN    @{Shared_Reports}
        Exit For Loop If    '${Report_Name}'=='${shared.text}'
        ${index}=   evaluate    ${index} + 1
    END
    Log     Shared report varified.
    click element    (//a[@class='report-name'])[${index}]
    wait until element is not visible           //mat-spinner[@role='progressbar']      8

    ${Users}    get webelements     //span[@class='email-address']
    ${index1}=   set variable      1
    FOR    ${Shared_User}   IN    @{Users}
        exit for loop if    '${User_Email}'=='${Shared_User.text}'
        ${index1}=   evaluate    ${index1}+1
    END
    Log     Shared user varified
    mouse over    (//span[@class='email-address'])[${index1}]
    click element       (//label[@class='mat-checkbox-layout']/div)[${index1}+1]
    click element       //span[contains(text(),'Remove')]
    click element       //span[contains(text(),'Confirm')]

16 Navigate Archived Tab check Unarchive and Delete
    set selenium implicit wait             10s
    set selenium page load timeout         0.4

    click element                    //div/a[contains(text(),'Archived')]
    wait until element is not visible           //mat-spinner[@role='progressbar']      5

    run keyword and continue on failure     click element                   (//tbody/tr/td[3]/span)[1]
    run keyword and continue on failure     click element                   //button[contains(text(),'Unarchive')]
    run keyword and continue on failure     wait until element is not visible           //mat-spinner[@role='progressbar']      3

    run keyword and continue on failure    click element                   (//tbody/tr/td[3]/span)[1]
    run keyword and continue on failure    click element                   //button[contains(text(),'Delete')]
    run keyword and continue on failure    wait until element is not visible           //mat-spinner[@role='progressbar']      3

17 Access static report(Shopping Cart Report)
    set selenium implicit wait            10s
    set selenium speed                    0.4

    click element                               //mat-panel-title[@title='Standard Reports']

    click element                               //mat-panel-title[@title='Registration']
    click element                               //div/a[@title='Shopping Cart Report']

    wait until element is not visible           //mat-spinner[@role='progressbar']      5

    page should not contain                     //span[contains(text(),'Columns')]
    page should not contain                     //span[contains(text(),'Conditions')]

18 Access static report(Uniform Report)
    [Arguments]    ${Prg_Name}
    set selenium implicit wait            10s
    set selenium speed                    0.4

    click element                               //div/a[@title='Uniform Report']

    click element                 (//mat-select[@formcontrolname="operatorValue"])[1]
    click element               //span[contains(text(),'${Prg_Name}')]

    click element               //span[contains(text(),'View Report')]

    click element                 (//mat-select[@formcontrolname="operatorValue"])[2]
    click element                 (//mat-option[@role="option"])[2]
    click element                 //span[contains(text(),'Update')]

    wait until element is not visible           //mat-spinner[@role='progressbar']      10

19 Open Any Billing Report(Division Summary)
    set selenium implicit wait            10s
    set selenium speed                    0.4

    click element                               //mat-panel-title[@title='Billing Reports']
    click element                               //div/a[@title='Account Summary']

    click element                               //span[contains(text(),'View Report')]

    wait until element is visible               //*[contains(text(),'Account Summary Report')]     30
    sleep       2
    page should contain                         Account Summary Report

    click element                               //span[contains(text(),'View Order Details')]

    run keyword and continue on failure    wait until element is visible     //td[contains(text(),'New Registrations')]     50
    sleep       2
    run keyword and continue on failure    page should contain                          Order Details