<cfset rc.title = "Subscription Confirmation" />

<cfoutput>
	
	<div class="col-md-6">
		<p class="lead"><strong>Congratulations!</strong></p>
		<p>You are now part of the Team to Win database and teaming partners will be able to immediately search for your past performance contract information once you've added them.</p>
		<p>Please visit <a href="#buildurl('profile:main&Userid=#session.user.getUserID()#')#">your profile</a> where you can fill out the rest of your company and contact information as well as add contracts to the database.</p>
		<hr>
		<p>You are subscribed with the information show below.</p>
		<p><label>Company Name:</label> #rc.user.getOrganization().getOrganizationname()#</p>
		<p><label>Name:</label> #rc.user.getFirstName()# #rc.user.getLastName()#</p>
		<p><label>Email Address:</label> #rc.user.getprimaryEmail()#</p>
		<p>You will use the email address above and the password you selected to log in.</p>
		<p>You can <a href="javascript:window.print()">print this page</a> for your records.</p>
		<p>If you have questions or problems you can contact us directly at <a href="tel:+1-855-533-3889">1-855-5-FEDTTW</a> (<a href="tel:+1-855-533-3889">1-855-533-3889</a>) or send us an email at <a href="mailto:help@fedttw.com">help@fedttw.com</a>.  We will respond to your inquiry within 24 hours.</p>
	</div>
	
</cfoutput>