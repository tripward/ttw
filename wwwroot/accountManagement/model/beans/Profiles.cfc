<cfcomponent displayname="Profiles" hint="I model a single Profiles." extends="common.model.beans.baseBean" persistent="TRUE" accessors="true" output="false">

	<cfproperty name="Profileid" type="string" fieldtype="id" generator="guid" />
	<cfproperty name="active" type="boolean" default="1" />

	<cfproperty name="requiredFields" type="string" default="name,active" persistent="false" />

	<!---Relationships--->
	
	<cfproperty name="User" fieldtype="one-to-one" cfc="Users" fkcolumn="Userid">
	
	
	<cfproperty name="Payments" fieldtype="one-to-many" fkcolumn="profileID" lazy="true" type="array" cfc="Payments" cascade="save-update" singularname="payment">
	<!---<cfproperty name="art" type="struct" fieldtype="one-to-many" cfc="Art" fkcolumn="ARTISTID" structkeytype="int" structkeycolumn="ArtID"> --->


	<cffunction name="getDisplay" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				
				<div class="">#this.getUser().getOrganization().getContractDisplay()#</div>
				
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getProfileForm" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				
				
				<!---<table>
					<tr>
						<td>
							<h3>Company Information</h3>
							<div class="">#this.getUser().getOrganization().getprofileDisplay()#</div>
						</td>
						<td>
							
							<h3>Account Information</h3>
							<div class="">#this.getUser().getProfileForm()#</div>

						</td>
					</tr>
				</table>--->
				
				
				
				<!---<div class=""><a href="/?action=profile:organization.get&organizationID=#session.user.getOrganization().getorganizationid()#">Edit Company Information</a></div>--->
				
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getPublicDisplay" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				
				
				
							<h3>Company Information</h3>
							<div class="">#this.getUser().getOrganization().getMastHeadDisplay()#</div>
							<h3>Contact Information</h3>
							<div class="">#this.getUser().getPublicProfileDisplay()#</div>
			

			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	<cffunction name="displayListShortEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<a href="#arguments.thePath#&id=#this.getProfileid()#">#this.getName()#</a>
				<!---<td>#this.getActive()#</td>--->
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	<!---<cffunction name="form" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>

				<style>
					form div {
						padding: 5px 0 5px 0;
						border: 0px solid red;}

						label {
							padding: 0 5px 0 5px;}


				</style>



				<input type="hidden" name="Profileid" value="#this.getProfileid()#" />
				<div class="form-group"><label for="name">Name</label><input type="text" class="form-control" name="name" value="#this.getName()#" size="25" /></div>

				#this.getActiveSelect()#

			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>--->

		<cffunction name="validate" access="public" returntype="any" output="false">
		<cfargument name="rc" required="true" />

		<cfset local.basicvalidationResults = SUPER.validate(arguments.rc)>
		<!---<cfdump var="#local.validationResults#" label="local.validationResults" abort="true" top="3" />--->

		<!--- Custom validation --->
		<!---
		<cfif "a" Is NOT "b">
			<cfset structInsert(local.validationResults.getCustom(),"businessRule","If you select a, you must also select b")>
		</cfif>
		--->

		<!---<cfdump var="#this#" label="this (validationobject?)" abort="true" />--->
		<cfreturn this />
	</cffunction>


</cfcomponent>