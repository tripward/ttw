<cfset rc.title = "Company and Login Information" />

<cfoutput>
 <p class="lead">Please fill in the fields below to complete the subscription process. Upon selecting subscribe you will be fully registered with Team to Win and can immediately begin adding past performance records.</p>
 <!---<p class="lead">An annual subscription to the Team To Win database is only one hundred dollars per month. This subscription provides you with access to add your firm's past performance.  Once a past performance record is posted it is accessible to the Team to Win search engine.  </p>
	<p class="plb"><a href="contract-fields.html" onclick="window.open('/outside/contactFields.cfm', 'newwindow', config='width=400, height=600,toolbar=no, menubar=no, scrollbars=no, resizable=no,location=no, directories=no, status=no'); return false;">Click here to see a description of what information you can provide for a past performance record.</a></p>
	<p class="plb">Fill out the information below in order to subscribe. <b>All fields are required.</b></p>--->
	
<!---<cfdump var="#rc.user#" label="cgi" abort="true" top="3" />--->
<cfinclude template="/common/views/main/inc_validation.cfm" />

<form action="#buildURL('subscribe:main.submitStepTwo')#" method="post" target="_top" id="userform" onSubmit="return validate()">
	#application.securityutils.getCSRFTokenFormField(session,application)#
	<div class="col-md-6">
		
		#rc.organization.subscriptionform()#
		#rc.user.getSubscribeForm()#
		#rc.user.getPasswordFields()#
		<!---<div class="form-group"><label for="agentcode">Promotion Code</label><input type="text" class="form-control" name="agentcode" value="" /></div>--->
		
	
		
		<!---<div class="form-group"><label for="agentcode">Promocode</label><input type="text" class="form-control" name="agentcode" value="" /></div>--->
		<input type="submit" class="btn btn-primary" value="Subscribe"><!---Subscribe</button>--->
		<!---<img class="text-center" style="width:160px; height=20px; margin-left:10px;" src="https://www.paypalobjects.com/webstatic/en_US/i/buttons/cc-badges-ppmcvdam.png" alt="Subscribe now with PayPal" />--->
		<a class="btn btn-primary pull-right" href="/">Cancel</a>
		<!---<input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary pull-right" />---><!---#buildurl('subscribe:main.cancel')# --->
		<!---<button class="btn btn-primary pull-right" /><a href="/">Cancel</a></button>---><!---#buildurl('subscribe:main.cancel')# --->
		<input type="hidden" name="cmd" value="_s-xclick">
		<input type="hidden" name="hosted_button_id" value="VGBK5FXZZGYCQ">
		
		<!---<input type="image" src="https://www.paypalobjects.com/en_US/i/btn/btn_subscribeCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!">--->
		<img alt="" border="0" src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1" height="1">
			
			<p class="mt">The Team To Win service is provided on the condition that the subscriber agrees to the <a href="#buildurl('home:main.SubscribeTC')#">Subscriber Terms and Conditions</a> of our subscription agreement and the materials referenced herein between subscriber and Team To Win. By hitting the submit button above, subscriber acknowledges it has read, understands and agrees to be bound by this agreement.</p>
		
	</div>
</form>
<div class="col-md-3">

</div>

	
	
</cfoutput>