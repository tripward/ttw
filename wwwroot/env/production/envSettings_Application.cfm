<!---todo: refactor: this should be n the application scope--->
<cfset application.environment ="Prod" />

<!---todo: refactor: this should be n the application scope--->
<cfset application.mainDSN ="fedttw_prod" />

<!---CWIGFunctions Plugin debug stuff--->
<!---// if TRUE, then additional information is returned by the Application.onError() method--->
<cfset Application.functionsdebugMode = TRUE />
<!---if TRUE, then additional information is returned by the Application.onError() method--->
<cfset Application.functionsreloadApplicationOnEveryRequest = TRUE />
<!---if true, will print out debugging/tracing info at the bottom of ea. page (within the Plugin's Administration area only) --->
<cfset Application.functions = FALSE />

<cfset application.isErrorEmailsEnabled = TRUE />
<cfset Application.isShowSecurityDebugging = true />


<!---sandbox creds --->
<!---<cfset Application.paypalDomain = 'https://www.sandbox.paypal.com' />

<cfset Application.ppAPIPath = 'https://api-3t.sandbox.paypal.com/nvp' />
<cfset Application.ppAPIUserName = 'wes-facilitator_api1.fedttw.com' />
<cfset Application.ppAPIPassword = '6Y8SAW5HSSLRZYGR' />
<cfset Application.ppAPISIGNATURE = 'AmiCQwohrSlcgg74TFhPQUQ-lMoaADNB3zzIH6IiTmRA6lE.IY3ae6sL' />
<cfset Application.ppAPIVersion = '64' />
<cfset Application.ppAPIbaseDomain = 'http://www.fedttw.com' />
<cfset Application.fullAmmount = '2.00' />
<cfset Application.trialAmount = '1.00' />--->


<!---prod  moonclerk creds --->
<cfset Application.apiDomain = 'https://api.moonclerk.com/' />
<cfset Application.apikey = 'd3973d29f8d62ac2a40b0a628ee084f9' />

