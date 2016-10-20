<cfhttp url="#application.ppAPIPath#" method="post" result="local.result" charset="utf-8"> 
    <cfhttpparam type="formfield" name="USER" value="wes_api1.fedttw.com"> 
    <cfhttpparam type="formfield" name="PWD" value="VXT476YGMHQAJ352"> 
    <cfhttpparam type="formfield" name="SIGNATURE" value="AFcWxV21C7fd0v3bYYYRCpSSRl31AVuNzsbI5z9RFghx2uvrco.3l74o"> 
    <cfhttpparam type="formfield" name="METHOD" value="SetExpressCheckout"> 
    <cfhttpparam type="formfield" name="VERSION" value="#Application.ppAPIVersion#">
    <cfhttpparam type="formfield" name="RETURNURL" value="https://www.fedttw.com/outside/testcallaction.cfm?userid=9443F4C9-7EC6-40EC-A806-F0801D73DBE0">
    <cfhttpparam type="formfield" name="CANCELURL" value="https://www.fedttw.com/?action=subscribe:main.cancel">
    <cfhttpparam type="formfield" name="PAYMENTACTION" value="Authorization">
    <cfhttpparam type="formfield" name="AMT" value="#Application.fullAmmount#">
    <cfhttpparam type="formfield" name="L_BILLINGAGREEMENTDESCRIPTION0" value="For Subscription To FedTTW"> 
    <cfhttpparam type="formfield" name="CURRENCYCODE" value="USD">    
    <cfhttpparam type="formfield" name="L_BILLINGTYPE0" value="RecurringPayments">
</cfhttp>

<!---<cfdump var="#local.result#" label="cgi" abort="true" top="3" />--->
<cfset local.mystruct = transformFileContentToStruct(local.result.filecontent) />
<!---<cfdump var="#local.mystruct#" label="cgi" abort="true" top="3" />--->
		
<cflocation url="https://www.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=#trim(local.mystruct.token)#" >


<cffunction name="transformFileContentToStruct" access="public" returntype="struct">
	<cfargument name="theFileContent" >
	
	<cfset local.fileContentStruct = structNew() />
	<cfloop list="#arguments.theFileContent#" index="local.key" delimiters="&">
		<cfset structInsert(local.fileContentStruct,listFirst(local.key,"="),listLast(local.key,"=")) />
	</cfloop>
	
	<cfreturn local.fileContentStruct />
</cffunction>