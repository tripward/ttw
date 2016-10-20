<!---<cfinclude template="/common.cfm" />--->

<!---User Defined--->
<cfset request.envSettings.forceSSL=0 />
<!---<cfdump var="#request.envSettings#" label="cgi" abort="true" />--->

<!---Overwrite common--->

<cfset request.appName = "fedTTW" />
<cfset request.datasource = "fedttw_prod" />
<cfset request.adminemail = "trip.ward@icfi.com" />
<cfset request.showTrace = FALSE />
<cfset request.reloadOnEveryRequest = FALSE />