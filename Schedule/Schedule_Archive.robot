*** Settings ***
Library         SeleniumLibrary


*** Variables ***
${browser}      Chrome
${Url}          http://leagues.bluesombrero.com/default.aspx?portalid=9003
${UID}          amol.sonar+superadmin@stacksports.com
${Pwd}          Test@1234

*** Test Cases ***
Archive the Schedules
    Open the browser & URL
    Login the Site
    Navigate to the Manage schedule
    Click on the Archive button

*** Keywords ***
Open the browser & URL
    open browser        ${Url}      ${browser}
    maximize browser window

Login the Site
    click element

Navigate to the Manage schedule

Click on the Archive button
