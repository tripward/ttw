<cfset rc.title = "Contact" />

<cfoutput>
<div class="row">
	
	<!---#rc.obj.publicProfile()#--->
	#rc.obj.getProfile().getPublicDisplay()#
	
</div>
	
</cfoutput>