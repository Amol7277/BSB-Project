install selenium
install robotframework
install robotframework-seleniumlibrary
Install plugin=> intellibot @seleniumlibrary patched

4 stage of robot framework
*** Settings ***
Library     SeleniumLibrary
*** Variables ***
in variable we can set variables by using ${} sign.
like - ${url}, ${browser}

*** Test Cases ***
tutorial

to open browser and maximize the browser
    create webdriver
    open browser    provide url     browser names                  - to open browser(put driver in script folder of python)
    maximize browser window                                        - to maximize the browser
Wait for the statement execution
    sleep   5                                                      - for simple wait to execute each statement
    log to console                                                 - use to print, use variable for statement to print (${})
    get selenium speed                                             - To get default selenium speed of execution. use variable if want to print.
    set selenium speed  5 seconds                                  - In this selenium speed method, it will waiting for execute each statement up to provided time.
    set selenium timeout    10 seconds                             - This method will wait up to provided time to check below condition, like to check register name is appear or not in 10 seconds.
    wait until page contains  register                             - This is the condition to check anything is provided is appears on web page or not, by default it will wait for 5 seconds.
    get selenium timeout                                           - to get default selenium timeout, use variable if want to print.
    set selenium implicit wait      10 seconds                     - This method is use to wait up to the provided time to find locator,
    set selenium implicit wait      10 seconds                     - if locator not find by provided time it will throw the error and if the locaot found with in the minimum time execution will move forward.
    get selenium implicit wait                                     - To get default implicit wait (default is 0 seconds), use variable if want to print.

Visibility and enable checked
    title should be     fintechsolution                            - To get title of the webpage
    click link      xpath or name or id of etc.                    - To click on any link, with provide xpath, id or name locator like xpath://a[@class='icon-Login']
    element should be visible    xpath or name or id of etc.       - To check the field is visible or not.
    element should not be visible    xpath or name or id of etc.   - To check the field is invisible or not.
    element should be enabled    xpath or name or id of etc.       - To check the field is enable or not.
    element should be disabled   xpath or name or id of etc.       - To check the field is disable or not

to fill input and close the broewer or browser tab
    input text      xpath or name or id of etc.     value.         - To enter the value in any text field or input box
    clear element text    xpath or name or id of etc.              - To clear the already filled field.
    close browser                                                  - To close the browser
    close all browsers                                             - To close the all opened browser
    close window                                                   - To close the focused window of the browser.

Handle radio button and checkbox
    select radio button     name    value                          - To click on radio button, must required 2 arguments
    select checkbox     name                                       - To select check box, must required 1 argument
    unselect checkbox   name                                       - To unselect check box, must required 1 argument
    set selenium speed    enter time(like 2seconds)                - To wait for the every line execution. applying for below code of the command

Handle Dropdown and Listbox

    select from list by value      name     value                  - To select dropdown or Listbox by value
    select from list by index      name     index number           - To select dropdown or Listbox by index number (index number start from 0)
    select from list by label      name     lable                  - To select dropdown or Listbox by lable(text in Black font color)

Handle Alerts and Frames
    handle alert        accept                                     - It will click the ok or accept button in alert
    handle alert        dismiss                                    - It will click the cancel or dismiss button in alert
    handle alert        leave                                      - It will leave the alert as it is.
    alert should be present      enter text content in alert       - It will check the alert is present or not and if present and accept automatically.
    alert should not be present  enter text content in alert       - It will check the alert is present or not and if present then it will fail the test.

    select frame    enter name, id or xpath of the frame           - When webpage is made in multiple frame used this command to select frame and do the action
    unselect frame  no argument need                               - Once the frame is select and all action are completed then must be unselect the frame, for that use this command. for this command no argument is needed.

Switch on Tab window and multiple Browser
    select window      title=enter webpage name                    - when one or more tab open and want to switch and work on another tab, use this command
    switch browser      give the index number                      - when more then 1 browser open and want to switch and work on another browser, use this command and give index number (in this case index number start from 1) if 3 browser open then totla index number count is 3.

Navigational Tools
    go to    enter the name of URL                                 - to open new URL in same opened browser
    go back       no argument need                                 - To go back from the current page
    get location                                                   - use variable if want to print.

capture screenshot
    capture element screenshot  enter name, id or xpath of element - To capture screen shot of particular element
    capture page screenshot   give location (optional)             - To capture the screen shot of full page.

Mouse Action
    open context menu     enter the name,id or xpath               - To click right click, use this command (1 argument must)
    double click element    enter the name, id or xpath            - To double click, use this command (1 argument must)
    drag and drop     enter drag attribute and drop attribute      - To drag and drop use this command (2 argument must)
    mouse over      enter id, name or xpath                        - To hover over on element`
`
Handle Scrolling of webpage
    execute javascript      window.scrollTo(H-pixel,V-pixel)                        - To scroll up to the set pixel
    scroll element into view    enter id,name or xpath of element                   - To scroll up to the element find
    execute javascript      window.scrollTo(H-pixel,document.body.scrollHeight)     - To scroll up to the end of the page
    execute javascript      window.scrollTo(H-pixel,-document.body.scrollHeight)    - To scroll from bottom to top

Link Count
    get element count   enter lable of the all links (like xpath://a)   - To get total link count in a web page. to print use variable.


For loop syntax
    @{listvariable}     create list   1  2  3  4  5                 - When give 1 space between the value, it print in single line
    FOR     ${i}    IN  enter value or list variable                - When give 2 space between the value, it print in all value in saperate line
    END                                                             - To end the For loop

Handle Table
    get element count  enter the xpath for Row(xpath://table[@name='BookTable']/tbody/tr)           - It will gives all rows in table, Use variable to print
    get element count  enter the xpath for column(xpath://table[@name='BookTable']/tbody/tr/th)     - It will gives all column in table, Use variable to print

    get text    enter xpath(xpath://table[@name='BookTable']/tbody/tr[7]/td[1])                     - It will gives specific data, Use variable to print
    table column should contain     xpath of table     column no.    verifying value                - It will verify the specific value is available or not in column
    table row should contain        xpath of table     row no.    verifying value                   - It will verify the specific value is available or not in Row
    table cell should contain    xpath of table     row no.   column no.    verifying value         - It will verify the specific value is available or not on given location.
    table header should contain     xpath of  table    verifying value                              - It will verify the specific value is available or not on header.

Setup and Teardown
    Suite Setup            - It is execute before exuction all Testcase
    Suite Teardown         - It is execute after complete exuction all Testcase
    Test Setup             - It is execute before every Testcase
    Test Teardown          - It is execute after complete every Testcase

Grouping TestCase
    [Tags]    enter any tag name            - To use for execute the specific testcase from the multiple testcases.
    To execute the test case use command in terminal,
    robot --include=tag name    directoryname/filename.robot    - This command use for the execute specific tag testcase.
    robot -i tag name -i tag name  directoryname/filename.robot    - This command use for the execute multiple testcases.
    robot -e tag name  directoryname/filename.robot       - This command use for the execute multiple testcases with excluding specify tag name testcase.
    robot -e tag name -i tag name  directoryname/filename.robot     - This command use for the execute specify tag name testcase with include and exclude tag

Upload Photo
    choose file     enter name,id or xpath      enter the file location with forward slash(/)

***Parallel Execution***

Parallel Execution of All Robot File
        ==> Install robotframework-pabot
        To run directory in parallel
        command is - pabot [directory's name]       ==> it will execute all robot file in side the directory

Parallel Execution of the perticural file's Different TestCases
    Command Is => pabot --testlevelsplit [path of the file]


To Execute any browser in Headless Mode

${Variable_Name}=   headlessChrome
${Variable_Name}=   headlessFireFox
${Variable_Name}=   headlessEdge


*** Keywords ***
