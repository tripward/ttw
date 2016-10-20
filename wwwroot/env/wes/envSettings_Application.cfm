<!---<cfinclude template="../envSettings_Application.cfm" />--->



<!---todo: refactor: this should be n the application scope--->
<cfset application.environment ="wes" />

<!---todo: refactor: this should be n the application scope--->
<cfset application.mainDSN ="fedttw_test" />

<!---CWIGFunctions Plugin debug stuff--->
<!---// if TRUE, then additional information is returned by the Application.onError() method--->
<cfset Application.functionsdebugMode = TRUE />
<!---if TRUE, then additional information is returned by the Application.onError() method--->
<cfset Application.functionsreloadApplicationOnEveryRequest = TRUE />
<!---if true, will print out debugging/tracing info at the bottom of ea. page (within the Plugin's Administration area only) --->
<cfset Application.functions = FALSE />

<cfset Application.paypalDomain = 'https://www.sandbox.paypal.com' />