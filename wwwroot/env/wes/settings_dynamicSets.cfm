<cfinclude template="/common.cfm" />

<!---User Defined--->
<cfset request.envSettings.forceSSL=0 />
<!---<cfdump var="#request.envSettings#" label="cgi" abort="true" />--->

<!---Overwrite common--->
<cfset request.envSettings.datasource = "muraPlay" />
<cfset request.envSettings.adminemail = "trip.ward@icfi.com" />