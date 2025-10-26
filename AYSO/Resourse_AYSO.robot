*** Settings ***
Library         SeleniumLibrary

*** Variables ***
${URL}      https://stagingayso.bsbtest.com/Default.aspx?portalid=14001
#${URL}      https://leagues.bluesombrero.com/default.aspx?portalid=9003
${browser}      chrome
#${browser}      firefox

${User_ID}       amol.sonar+superadmin@stacksports.com
${Pwd}          Test@1234

${Activity}         Soccer

${AYSO_NT_Program_Name}     NT_Soccer_

${Vol_Name}                  Volunteer -