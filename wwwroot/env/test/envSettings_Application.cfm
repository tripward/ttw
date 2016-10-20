<!---todo: refactor: this should be n the application scope--->
<cfset application.environment ="test" />

<!---todo: refactor: this should be n the application scope--->
<cfset application.mainDSN ="fedttw_test" />

<!---CWIGFunctions Plugin debug stuff--->
<!---// if TRUE, then additional information is returned by the Application.onError() method--->
<cfset Application.functionsdebugMode = TRUE />
<!---if TRUE, then additional information is returned by the Application.onError() method--->
<cfset Application.functionsreloadApplicationOnEveryRequest = TRUE />
<!---if true, will print out debugging/tracing info at the bottom of ea. page (within the Plugin's Administration area only) --->
<cfset Application.functions = FALSE />

<cfset application.isErrorEmailsEnabled = FALSE />

<!---prod creds --->
<!---<cfset Application.paypalDomain = 'https://www.paypal.com' />

<cfset Application.ppAPIPath = 'https://api-3t.paypal.com/nvp' />
<cfset Application.ppAPIUserName = 'wes_api1.fedttw.com' />
<cfset Application.ppAPIPassword = 'VXT476YGMHQAJ352' />
<cfset Application.ppAPISIGNATURE = 'AFcWxV21C7fd0v3bYYYRCpSSRl31AVuNzsbI5z9RFghx2uvrco.3l74o' />
<cfset Application.ppAPIVersion = '64' />
<cfset Application.ppAPIbaseDomain = 'http://www.fedttw.com' />
<cfset Application.fullAmmount = '2.00' />
<cfset Application.trialAmount = '1.00' />

<cfset Application.isShowSecurityDebugging = true />--->




<!---<cfset Application.paypalDomain = 'https://www.sandbox.paypal.com' />

<cfset Application.ppAPIPath = 'https://api-3t.sandbox.paypal.com/nvp' />
<cfset Application.ppAPIUserName = 'wes-facilitator_api1.fedttw.com' />
<cfset Application.ppAPIPassword = '6Y8SAW5HSSLRZYGR' />
<cfset Application.ppAPISIGNATURE = 'AmiCQwohrSlcgg74TFhPQUQ-lMoaADNB3zzIH6IiTmRA6lE.IY3ae6sL' />
<cfset Application.ppAPIVersion = '64' />
<cfset Application.ppAPIbaseDomain = 'http://test.fedttw.com' />
<cfset Application.fullAmmount = '100.00' />
<cfset Application.trialAmount = '90.00' />

<cfset Application.isShowSecurityDebugging = true />--->

<!---prod  moonclerk creds --->
<cfset Application.apiDomain = 'https://api.moonclerk.com/' />
<cfset Application.apikey = 'd3973d29f8d62ac2a40b0a628ee084f9' />



