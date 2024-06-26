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
    Click on the advanve button for the division 1 & Add custom disocunt
    Add custom fee for the Division 1
    Add Mandatory fee for the Division 1
    Go to the Program level Fees & Discount
    Add Program level discount
    Add Program Level Fees
    Add Program level Mandatory Fees

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
    click element         //button[contains(text(),"Division Settings")]
    sleep     2
Click on the advanve button for the division 1 & Add custom disocunt
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
    input text            //div/input[@formcontrolname='prompt']    DD1
    sleep       2
    input text            (//div/input[@formcontrolname='amount'])    1000
    sleep       2
    input text            //div/input[@formcontrolname='name']      DD1
    sleep       1
    click element         (//*[@formcontrolname='applyOnOption']/mat-radio-button/label)[1]
    sleep       1
    click element          (//button[@iconclass='save-icon']/span)[1]

Add custom fee for the Division 1
    sleep       2
    click element         //button/span[contains(text(),'Add Custom Discount Or Fee Question')]
    sleep       1
    click element         //button[contains(text(),'Fee')]
    sleep       1
    input text            //div/input[@formcontrolname='prompt']    DF
    sleep       2
    input text            (//div/input[@formcontrolname='amount'])[2]    1000
    sleep       2
    input text            //div/input[@formcontrolname='name']      DF
    sleep       1
#    click element         (//*[@formcontrolname='applyOnOption']/mat-radio-button/label)[1]
#    sleep       1
    click element          (//button[@iconclass='save-icon']/span)[1]

Add Mandatory fee for the Division 1
    sleep       2
    click element         //button/span[contains(text(),'Add Custom Discount Or Fee Question')]
    sleep       1
    click element         //button[contains(text(),' Mandatory Fee ')]
    sleep       1
    input text            //div/input[@formcontrolname='prompt']    MDF
    sleep       2
    input text            (//div/input[@formcontrolname='amount'])[3]    1000
    sleep       2
    input text            //div/input[@formcontrolname='name']      DMF
    sleep       1
    click element          (//button[@iconclass='save-icon']/span)[1]
    sleep       1
    click element          //button/span/span[contains(text(),'Save')]
    sleep    1
    execute javascript      window.scrollTo(0, -200)
    sleep    2
    click element           //button/span/mat-icon[contains(text(),'clear')]

Go to the Program level Fees & Discount
    sleep    1
    click element       //div[contains(text(),'Discounts & Fees')]
    sleep    1
    execute javascript      window.scrollTo(0,document.body.scrollHeight)

Add Program level discount
    sleep       1
    click element         //button/span[contains(text(),'Add Custom Discount Or Fee Question')]
    sleep       1
    click element         //button[contains(text(),'Discount')]
    sleep       1
    input text            //div/input[@formcontrolname='prompt']    PL-D
    sleep       2
    input text            (//div/input[@formcontrolname='amount'])    1000
    sleep       2
    input text            //div/input[@formcontrolname='name']      PL-D
    sleep       1
    click element         (//*[@formcontrolname='applyOnOption']/mat-radio-button/label)[1]
    sleep       1
    click element          (//button[@iconclass='save-icon']/span)[1]

Add Program Level Fees
    sleep       2
    click element         //button/span[contains(text(),'Add Custom Discount Or Fee Question')]
    sleep       1
    click element         //button[contains(text(),'Fee')]
    sleep       1
    input text            //div/input[@formcontrolname='prompt']    PL-F
    sleep       2
    input text            (//div/input[@formcontrolname='amount'])[2]    1000
    sleep       2
    input text            //div/input[@formcontrolname='name']      PL-F
    sleep       1
#    click element         (//*[@formcontrolname='applyOnOption']/mat-radio-button/label)[1]
#    sleep       1
    click element          (//button[@iconclass='save-icon']/span)[1]

Add Program level Mandatory Fees
    sleep       2
    click element         //button/span[contains(text(),'Add Custom Discount Or Fee Question')]
    sleep       1
    click element         //button[contains(text(),' Mandatory Fee ')]
    sleep       1
    input text            //div/input[@formcontrolname='prompt']    PL-MF
    sleep       2
    input text            (//div/input[@formcontrolname='amount'])[3]    1000
    sleep       2
    input text            //div/input[@formcontrolname='name']      PL-MF
    sleep       1
    click element          (//button[@iconclass='save-icon']/span)[1]
    sleep       1
    click element          //button/span/span[contains(text(),'Save')]
