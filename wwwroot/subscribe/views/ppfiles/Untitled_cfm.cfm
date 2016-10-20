<cfcomponent output="false">
	
	<cfset variables.username = "">
	<cfset variables.password = "">
	<cfset variables.server = "">
	
	<cffunction name="init" access="public" output="false">
		<cfargument name="client_id" required="true" type="string">
		<cfargument name="client_secret" required="true" type="string">
		<cfargument name="sandbox" required="false" type="boolean" default="false">
		
		<cfset variables.username = arguments.client_id>
		<cfset variables.password = arguments.client_secret>
		
		<cfif arguments.sandbox>
			<cfset variables.server = "https://api.sandbox.paypal.com">
		<cfelse>
			<cfset variables.server = "https://api.paypal.com">
		</cfif>
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="capture" access="public" output="false">
		<cfargument name="card_type" required="true" type="string">
		<cfargument name="card_number" required="true" type="string">
		<cfargument name="card_exp_month" required="true" type="string">
		<cfargument name="card_exp_year" required="true" type="string">
		<cfargument name="card_firstname" required="true" type="string">
		<cfargument name="card_lastname" required="true" type="string">
		<cfargument name="amount" required="true" type="numeric">
		
		<cfargument name="currency" required="false" type="string" default="USD">
		<cfargument name="description" required="false" type="string" default="">
		
		<cfset data = { "intent" = "sale" }>
		<cfset data["payer"] = {
		    "payment_method"="credit_card",
		    "funding_instruments" = [
		      {
		        "credit_card" = {
		          "type"= arguments.card_type,
		          "number"= " " & arguments.card_number,
		          "expire_month"= " " & arguments.card_exp_month,
		          "expire_year"= " " & arguments.card_exp_year,
		          "first_name"= arguments.card_firstname,
		          "last_name"= arguments.card_lastname
		        }
		      }
		    ]
		}>
		<cfset data["transactions"] = [
		    {
		      "amount"={
		        "total"= (NumberFormat(arguments.amount, "9.99") & "|||"),
		        "currency"= arguments.currency
		      },
			"description" = arguments.description
		    }
		]>
		<cfset req = serializeJSON(data)>
  
		<!--- convert string total to numeric (an unelegant workaround for CF's poor JSON serialization )) --->
		<cfset req = Replace(req, 'total":"', 'total":')>
		<cfset req = Replace(req, '|||"', '')>
		<cfset req = serializeJSON(data)>
		 
		<!--- another workaround for ColdFusion serialize JSON bug that converts numeric strings to floats --->
		<cfset req = Replace(req, '" ', '"', "ALL")>
		
		<cfreturn makePaymentRequest(data = req)>
	</cffunction>
	<!--- private methods --->
	<cffunction name="getAuthToken" access="private" output="false">
		<cfhttp url="#variables.server#/v1/oauth2/token" method="post" username="#variables.username#" password="#variables.password#">
			<cfhttpparam type="header" name="Content-Type" value="application/x-www-form-urlencoded">
			<cfhttpparam type="header" name="Accept-Language" value="en_US">
			<cfhttpparam type="formfield" name="grant_type" value="client_credentials">
		</cfhttp>
		
		<cfset response = deserializeJSON(cfhttp.FileContent)>
		
		<cfreturn response.access_token>
	</cffunction>
	<cffunction name="makePaymentRequest" access="private" output="false">
		<cfargument name="data" required="true" type="string">
		<cfset var accessToken = getAuthToken()>
		
		<cfhttp url="#variables.server#/v1/payments/payment" method="post" timeout="120">
			<cfhttpparam type="header" name="Content-Type" value="application/json">
			<cfhttpparam type="header" name="Authorization" value="Bearer #accessToken#">
			<cfhttpparam type="body" value="#req#">
		</cfhttp>
		
		<cfreturn cfhttp.FileContent>
	</cffunction>
</cfcomponent>