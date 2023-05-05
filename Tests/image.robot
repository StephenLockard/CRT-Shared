*** Settings ***
Library         QWeb
Library         QImage
Suite Setup     OpenBrowser     about:blank     chrome
Suite Teardown  CloseAllBrowsers

*** Test Cases ***
Verify Boat Color
    GoTo                        https://www.lundboats.com/build/boat-configurator.Z17IXSS.html
    # capture first boat image
    ${boat1}=     CaptureIcon                 //img[@alt\="boat-color"] 
    
    # select another boat color
    ClickItem     Cobalt Blue / Silver Stone  tag=label
    Sleep         2  # make sure new boat image is loaded
    ${boat2}=     CaptureIcon                 //img[@alt\="boat-color"] 

    CompareImages     ${boat1}       ${boat2}   tolerance=0.99  