<cfcomponent displayname="Payments" hint="I model a single Profiles." extends="common.model.beans.baseBean" persistent="TRUE" accessors="true" output="false">

	<cfproperty name="Paymentid" fieldtype="id" generator="increment" />
	<cfproperty name="active" type="boolean" default="1" />
	<cfproperty name="ammount" type="numeric" default="0" />

	<cfproperty name="requiredFields" type="string" default="name,active" persistent="false" />

	<!---Relationships--->
	<cfproperty name="profile" fieldtype="many-to-one" fkcolumn="profileid" lazy="true" cfc="Profiles" cascade="save-update">
	<!---<cfproperty name="artist" fieldtype="many-to-one" fkcolumn="artistid" cfc="Artist">--->
	
	  <cfproperty name="PaymentTypes" fieldtype="one-to-one" cfc="PaymentTypes" mappedby="Payments"> 
	
	
	


	<cffunction name="displayListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<td><a href="#arguments.thePath#&Paymentid=#this.getPaymentid()#">#this.getName()#</a></td>
				<td>#this.getActive()#</td>
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	<cffunction name="displayListShortEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<a href="#arguments.thePath#&Paymentid=#this.getPaymentid()#">#this.getName()#</a>
				<!---<td>#this.getActive()#</td>--->
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	<cffunction name="form" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>

				<input type="hidden" name="Paymentid" value="#this.getPaymentid()#" />
				<div class="form-group"><label for="name">Name</label><input type="text" class="form-control" name="name" value="#this.getName()#" size="25" /></div>

				#this.getActiveSelect()#

			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

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