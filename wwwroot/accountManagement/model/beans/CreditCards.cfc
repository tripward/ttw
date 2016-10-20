<cfcomponent displayname="CreditCard" hint="I model a single Profiles." extends="Payments" table="CreditCardPayment" joinColumn="paymentId" persistent="TRUE" accessors="true" output="false">

	<cfproperty name="CreditCardid" fieldtype="id" generator="increment" />
	<cfproperty name="active" type="boolean" default="1" />
	<cfproperty name="cardType" type="numeric" />
	<cfproperty name="cardNo" type="numeric" default="5555555555554444" />
	<cfproperty name="securityCode" type="numeric" default="123" />
	<cfproperty name="expMonth" type="numeric" />
	<cfproperty name="expYear" type="numeric" />        
  
  <cfproperty name="nameonCard" type="string" />

	<cfproperty name="requiredFields" type="string" default="cardNo,securityCode,expMonth,expYear" persistent="false" />

	<!---Relationships--->

	 <cfproperty name="Payments" fieldtype="one-to-one" cfc="Payments" fkcolumn="Paymentid"> 

	<cffunction name="displayListEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<td><a href="#arguments.thePath#&CreditCardid=#this.getCreditCardid()#">#this.getName()#</a></td>
				<td>#this.getActive()#</td>
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	<cffunction name="displayListShortEntry" access="public" returntype="string" output="false">
		<cfargument name="thePath" >

		<cfsavecontent variable="local.content">
			<cfoutput>
				<a href="#arguments.thePath#&CreditCardid=#this.getCreditCardid()#">#this.getName()#</a>
				<!---<td>#this.getActive()#</td>--->
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>

	<cffunction name="form" access="public" returntype="string" output="false">
		<cfargument name="thePath" >


		<cfsavecontent variable="local.content">
			<cfoutput>


				<input type="hidden" name="CreditCardid" value="#this.getCreditCardid()#" />
				
				<div class="form-group"><label for="name">Name On Card</label><input type="text" class="form-control" name="nameonCard" value="#this.getnameonCard()#" size="25" /></div>
				<div class="form-group"><label for="name">Card Number</label><input type="text" class="form-control" name="cardNo" value="#this.getcardNo()#" size="25" /></div>
				<div class="form-group"><label for="name">Security Code</label><input type="text" class="form-control" name="securityCode" value="#this.getsecurityCode()#" size="25" /></div>
				<div class="form-group"><label for="name">Expiration</label><input type="text" class="form-control" name="expMonth" value="#this.getexpMonth()#" size="2" /> / <input type="text" class="form-control" name="expYear" value="#this.getexpYear()#" size="25" /></div>


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

		
		<cfreturn this />
	</cffunction>


</cfcomponent>