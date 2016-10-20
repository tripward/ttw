



<!---<div id="formMsg" class="error msg">--->

<cfif structKeyExists(rc,'OrgValidationResults')
OR structKeyExists(rc,'userValidationResults')
OR structKeyExists(rc,'ValidationResults')>

<cfoutput>
<!---<div class="col-md-12">--->
<p class="notification">
	Validation Warning
<ul>
	<cfif structKeyExists(rc,'OrgValidationResults')>
		#rc.OrgValidationResults.getRequiredLenElements()#
	</cfif>
	
	<cfif structKeyExists(rc,'userValidationResults')>
		#rc.userValidationResults.getRequiredLenElements()#
	</cfif>
	
	<cfif structKeyExists(rc,'ValidationResults')>
		#rc.ValidationResults.getRequiredLenElements()#
	</cfif>
</ul>

<ul>
	<cfif structKeyExists(rc,'OrgValidationResults')>
		#rc.OrgValidationResults.getRequiredTypeElements()#
	</cfif>
	
	<cfif structKeyExists(rc,'userValidationResults')>
		#rc.userValidationResults.getRequiredTypeElements()#
	</cfif>
	
	<cfif structKeyExists(rc,'ValidationResults')>
		#rc.ValidationResults.getRequiredTypeElements()#
	</cfif>
</ul>

<ul>
	<cfif structKeyExists(rc,'OrgValidationResults')>
		#rc.OrgValidationResults.getCustomElements()#
	</cfif>
	
	<cfif structKeyExists(rc,'userValidationResults')>
		#rc.userValidationResults.getCustomElements()#
	</cfif>
	
	<cfif structKeyExists(rc,'ValidationResults')>
		#rc.ValidationResults.getCustomElements()#
	</cfif>
</ul>
<!---</div>--->
</p>
</cfoutput>

</cfif>


<!---<cfif structKeyExists(rc,'OrgValidationResults')>
	#rc.OrgValidationResults.getDisplay()#
</cfif>

<cfif structKeyExists(rc,'userValidationResults')>
	#rc.userValidationResults.getDisplay()#
</cfif>

<cfif structKeyExists(rc,'ValidationResults')>
	#rc.ValidationResults.getDisplay()#
</cfif>--->
