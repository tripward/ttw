<!---<cfinclude template="/common.cfm" />--->

<!---User Defined--->
<cfset request.forceSSL=0 />
<!---<cfdump var="#request.envSettings#" label="cgi" abort="true" />--->

<!---Overwrite common--->
<cfset request.appName = "localfedTTW" />
<cfset request.datasource = "fedttw_test" />
<cfset request.adminemail = "trip.ward@icfi.com" />
<cfset request.showTrace = FALSE />
<cfset request.reloadOnEveryRequest = TRUE />