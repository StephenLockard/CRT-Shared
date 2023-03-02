*** Settings ***
Documentation           Ensure that a mobile user can submit a request for a demo at https://copado.com
Library    DataDriver    reader_class=TestDataApi    name=mobileDeviceList.xlsx
Suite Setup             Open Browser                about:blank                 chrome
Suite Teardown          Close All Browsers
Test Template     Example Test