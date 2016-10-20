<cfinclude template="/common.cfm" />

<!---User Defined--->
<cfset request.envSettings.forceSSL=0 />
<cfset request.envSettings.indexfileinurls=0 />
<!---<cfdump var="#request.envSettings#" label="cgi" abort="true" />--->

<!---Overwrite common--->
<cfset request.envSettings.datasource = "childwelfare_mura" />
<cfset request.envSettings.adminemail = "trip.ward@icfi.com" />
<cfset request.envSettings.debuggingenabled=FALSE />


<!---<cfdump var="#application#" label="cgi" abort="true" />--->