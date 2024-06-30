*** Settings ***
Library         SeleniumLibrary

*** Variables ***
${Portal_URL}       https://stagingsports.bsbtest.com/default.aspx?portalid=8575
${Browser}          Chrome

${U_Name}       amol.sonar+superadmin@stacksports.com
${Pwd}          Test@1234

${Activity_Name}         Basketball

${Program_Name}     30_06_2024_FreePrg 8

${Div1_Name}            Division1
${Div2_Name}            Waitlist Division
${RegOpenDate}          07/28/2024
${RegClose_Date}        08/30/2024
${SeasonStartDate}      08/15/2024
${SeasonEndDate}        09/15/2024
${OldDate}              01/01/2000
${YoungDate}            01/01/2015


${Vol_Name}     Volunteer 3006


*** Keywords ***
