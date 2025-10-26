*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Resource    Resource_report.robot
Test Setup        Open Browser and portal URL   ${Portal_URL}     ${Browser}

*** Variables ***
${Edit_Path}=   //mat-icon[contains(text(),'edit')]

${Folder}=      Report-03.08.2024 1655

*** Test Cases ***
Report test case
    Login Admin User     ${U_Name}       ${Pwd}
    Open Report Module
    In Save tab Create New folder, Rename, Move, Archive & Delete the Folder

*** Keywords ***
Open Browser and portal URL
    [Arguments]         ${Portal_URL}     ${Browser}
    Open Browser                    ${Portal_URL}     ${Browser}
    maximize browser window

Login Admin User
   [Arguments]    ${UserName}      ${Password}
    click element                              ID:dnn_dnnLOGIN_cmdLogin
    wait until element is visible              email
    input text                                 Name:email                      ${UserName}
    click element                              Name:continue
    wait until element is visible              password                        20
    input password                             Name:password                   ${Password}
    click element                              Name:continue

Open Report Module
    set selenium implicit wait            20s
    set selenium speed                    0.4
    run keyword and continue on failure    wait until element is visible         //marketplace-toolbar[@class='hydrated']      300

    click element                               //li/a[contains(text(),'Reports')]

    run keyword and continue on failure    wait until element is visible         //marketplace-toolbar[@class='hydrated']      100


In Save tab Create New folder, Rename, Move, Archive & Delete the Folder

    set selenium implicit wait             20s
    set selenium page load timeout         0.4

    click element                    //div/a[contains(text(),'Saved')]
    sleep    2
    execute javascript              window.scrollTo(0,document.body.scrollHeight)
#    scroll element into view        (//mat-icon[contains(text(),'edit')])[5]
#    execute javascript              window.scrollTo(0,document.body.scrollHeight)
#    sleep       3
#    click element                   (//mat-icon[contains(text(),'edit')])[10]

#    ${mat-icons}=   get webelements     //mat-icon[contains(text(),'edit')]

    ${maticons}=   get webelements     //a[@class="folder-name"]/span
    ${Count}=  get length    ${maticons}
    log to console    count = ${Count}
    ${index}    set variable    1
    FOR   ${maticon}     IN    @{maticons}
        scroll element into view        ${maticon}
        Exit For Loop If    '${Folder}'=='${maticon.text}'
        log to console    Folder Names - ${maticon}
        ${index}=   evaluate    ${index} + 1
    END
    click element    (//button/span/mat-icon[contains(text(),"edit")])[${index}]
#    execute javascript              window.scrollTo(0,document.body.scrollHeight)
#    log to console    index number = ${index}
#    sleep       1
#    double click element    (//button/span/mat-icon[contains(text(),"edit")])[${index}]
#    Execute JavaScript    document.querySelectorAll('.scrollbar-thumb')[2].scrollTop = 1000;
#    sleep       5
#    click element    (//button/span/mat-icon[contains(text(),"edit")])[${index}]