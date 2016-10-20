<cfset rc.title = "Profile" />
<!---<cfdump var="#rc.user#" label="rc1" abort="true" top="2"  />
<cfdump var="#session.user#" label="cgi1" abort="true"  top="2" />--->
<cfoutput>

	#rc.user.getProfile().getDisplay()#
</cfoutput>