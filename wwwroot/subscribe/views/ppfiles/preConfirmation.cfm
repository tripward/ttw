<cfset rc.title = "Authorize Payment" />

<cfoutput>
	<cfinclude template="/common/views/main/inc_validation.cfm" />
<form action="#buildURL('subscribe:main.createRecurringPaymentsProfile')#" method="post" target="_top">
	#application.securityutils.getCSRFTokenFormField(session,application)#
	<input type="hidden" name="userid" value="#listFirst(rc.userid)#">
	<input type="hidden" name="token" value="#URLEncodedFormat(rc.token)#">
<div class="col-md-6">
	<p class="lead">By selecting the "Authorize" button below you will be charged $#urldecode(rc.amount)# and will be fully subscribed to the Team to Win database.</p>
	<button type="submit" class="btn btn-primary">Authorize</button>
	<a class="btn btn-primary pull-right" href="#buildurl('subscribe:main.cancel')#">Cancel</a>
	
</div>
</form>				

	
	<!---<input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary"/>--->
<!---<input type="submit"  class="btn btn-primary" name="submit" value="Submit">--->
		



	
	
</cfoutput>