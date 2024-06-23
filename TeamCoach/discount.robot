*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}      https://stagingsports.bsbtest.com/default.aspx?portalid=8575
${browser}      chrome

${ID}       amol.sonar+superadmin@stacksports.com
${Pwd}      Test@1234

${Program_Name}     22_06_TC

*** Test Cases ***
Fees And discount
    open the browser and login in the portal
    go to the registration form list
    click on the edit button of the program     ${Program_Name}
    click on the advanve button for the division 1 & Add custom disocunt
    Add custom fee for the Division 1
#    Add the custom fees and discount



*** Keywords ***
open the browser and login in the portal
    open browser        ${URL}          ${browser}
    maximize browser window
    wait until element is visible       dnn_dnnLOGIN_cmdLogin       10
    click element       dnn_dnnLOGIN_cmdLogin

    wait until element is visible       email       10
    input text          email       ${ID}
    click element       continue

    wait until element is visible    password       10
    input text          password        ${Pwd}
    click element       continue

go to the registration form list
    wait until element is visible       //a/span[contains(text(),"Registration")]       300
    mouse over      //a/span[contains(text(),"Registration")]
    click element    //a/span[contains(text(),"Registration Forms")]

click on the edit button of the program
    [Arguments]    ${Prg_Name}
    sleep      5
    execute javascript      window.scrollTo(0,document.body.scrollHeight)
    sleep      3
    execute javascript      window.scrollTo(0,-document.body.scrollHeight)

    sleep    2
    ${Program_Name_Element} =    get webelements    css:.list-title
    ${index}=   set variable    1
    FOR     ${P_Name}   IN    @{Program_Name_Element}
        scroll element into view    ${P_Name}
        Log     ${P_Name.text}
        Exit For Loop If   '${Prg_Name}' == '${P_Name.text}'
        ${index}=   evaluate    ${index} + 1
    END
    click element        (//button/span/mat-icon[contains(text(),"edit")])[${index}]
    sleep       1

click on the advanve button for the division 1 & Add custom disocunt
    click element         //button[contains(text(),"Division Settings")]
    wait until element is visible          (//button/span/span[contains(text(),'Advanced')])[1]     10
    sleep       1
    click element         (//button/span/span[contains(text(),'Advanced')])[1]
    sleep       1
    click element         //div/span[contains(text(),'Discounts & Fees')]
    sleep       1
    click element         //button/span[contains(text(),'Add Custom Discount Or Fee Question')]
    sleep       1
    click element         //button[contains(text(),'Discount')]
    sleep       1
    input text            //div/input[@formcontrolname='prompt']    DD
    sleep       2
    input text            //div/input[@formcontrolname='amount']    1000
    sleep       2
    input text            //div/input[@formcontrolname='name']      DD
    sleep       1
    click element         (//*[@formcontrolname='applyOnOption']/mat-radio-button/label)[1]
    sleep       1
    click element          (//button[@iconclass='save-icon']/span)[1]

Add custom fee for the Division 1
    click element         //button/span[contains(text(),'Add Custom Discount Or Fee Question')]
    sleep       1
    click element         //button[contains(text(),'Fees')]
    sleep       1
    input text            //div/input[@formcontrolname='prompt']    DD
    sleep       2
    input text            //div/input[@formcontrolname='amount']    1000
    sleep       2
    input text            //div/input[@formcontrolname='name']      DD
    sleep       1
    click element         (//*[@formcontrolname='applyOnOption']/mat-radio-button/label)[1]
    sleep       1
    click element          (//button[@iconclass='save-icon']/span)[1]