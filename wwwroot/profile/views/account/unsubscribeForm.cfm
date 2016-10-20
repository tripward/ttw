<cfset rc.title = "Unsubscribe" />
<!---<cfdump var="#rc.user#" label="rc1" abort="true" top="2"  />
<cfdump var="#session.user#" label="cgi1" abort="true"  top="2" />--->
<cfoutput>
	<p>If you having an issue please let us know before canceling. Else please submit the form below</p>
<form action="#buildurl('profile:account.unsubscribe')#" method="post">
	#application.securityutils.getCSRFTokenFormField(session,application)#
	<input type="hidden" name="Userid" value="#rc.user.getUserid()#" />
	<p>I agree that this cancel my account with TTW and deactivate the recurrng paypal charge associated with my ttw account</p>
<input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary"/>
<input type="submit"  class="btn btn-primary" name="submit" value="Submit">
</form>

</cfoutput>