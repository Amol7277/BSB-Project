*** Settings ***
Library         SeleniumLibrary

*** Variables ***
${URL}      https://stagingsports.bsbtest.com/default.aspx?portalid=8575
${browser}      chrome
#${browser}      firefox

${User_ID}          amol.sonar+superadmin@stacksports.com
${Pwd}              Test@1234

${Activity}         Basketball

${Free_Program_Name}     Free -

${Free_Div1_Name}            Division1
${Free_Div2_Name}            Waitlist Division

${OldDate}              01/01/2000
${YoungDate}            01/01/2015


${Vol_Name}     Volunteer-

*** Keywords ***
