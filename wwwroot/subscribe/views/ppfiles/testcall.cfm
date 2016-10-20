
<cfset options.business = "wes@fedttw.com"> 
<cfset options.item_name = "subscription"> 
<cfset options.a3 = "100"> 
<cfset options.p3 = "12"> 
<cfset options.t3 = "M">
<cfset options.src = "1">
<cfset options.srt = "12">
<cfset options.sra = "1">
<cfset options.custom = "custom">    
<cfset options.invoice = "1">    
<cfset options.modify = "2	">    
<cfset options.usr_manage = "1">





<cfscript>
config = structNew();
config.path = "paypal.wpp.NVPGateway";
config.username = "wes_api1.fedttw.com";
config.password= "VXT476YGMHQAJ352";
config.signature= "AFcWxV21C7fd0v3bYYYRCpSSRl31AVuNzsbI5z9RFghx2uvrco.3l74o";
config.returnURL = "http://localhost/cfpayment/api/gateway/paypal/wpp/tests/NVPGatewayTest.cfc?method=runTestRemote&method=testCompleteExpressCheckout";
config.cancelURL = "http://localhost/cfpayment/api/gateway/paypal/wpp/tests/NVPGatewayTest.cfc?method=runTestRemote&method=testCancelExpressCheckout";
cfpayment = createObject("component", "cfpayment.api.core").init(config=config);
gateway = cfpayment.getGateway();

validCustomer.firstName= 'Jeff';
validCustomer.lastName= 'Lebowski';
validCustomer.address= '609 Venenzia Ave.';
validCustomer.city= 'Venice';
validCustomer.region= 'CA';
validCustomer.postalCode= '90291';

validCard.account= "4111111111111111";
validCard.expMonth= "10";
validCard.expYear= "2010";
validCard.verificationValue= "000";

</cfscript>

<cfset cc = cfpayment.createCreditCard() />

<!---<cfset cc.getProperties().firstname = 'trip' />--->


<cfset cc.setAccount(validCard.account) />
<cfset cc.setMonth(validCard.expMonth) />
<cfset cc.setYear(validCard.expYear) />
<cfset cc.setFirstName(validCustomer.firstName) />
<cfset cc.setLastName(validCustomer.lastName) />
<cfset cc.setAddress(validCustomer.address) />
<cfset cc.setPostalCode(validCustomer.postalCode) />


<cfdump var="#cc#" label="cgi" abort="false" top="3" />
<cfdump var="#cfpayment#" label="cgi" abort="false" top="3" />
<cfdump var="#gateway#" label="cgi" abort="true" top="3" />
<!---<cfdump var="#cc#" label="cgi" abort="true" top="3" />--->


<!---<cffunction name="createValidCard" access="private" returntype="any" output="false">
	<cfset var account = variables.core.createCreditCard() />
	<cfset var validCustomer = readProperties("validCustomer") />
	<cfset var validCard = readProperties("validCard") />

	<cfset account.setAccount(validCard.account) />
	<cfset account.setMonth(validCard.expMonth) />
	<cfset account.setYear(validCard.expYear) />
	<cfset account.setFirstName(validCustomer.firstName) />
	<cfset account.setLastName(validCustomer.lastName) />
	<cfset account.setAddress(validCustomer.address) />
	<cfset account.setPostalCode(validCustomer.postalCode) />
	<cfreturn account />
</cffunction>
--->
<!---<cfset money = variables.core.createMoney(cents=purchase.amount, currency=purchase.currency) />
<cfset response = variables.gateway.purchase(money=money, account=createValidCard(), options=options) />--->









<!---<cfhttp url="https://api-3t.sandbox.paypal.com/nvp" method="post" result="request.result" charset="utf-8"> 
    <cfhttpparam type="formfield" name="business" value="wes@fedttw.com"> 
    <cfhttpparam type="formfield" name="item_name" value="subscription"> 
    <cfhttpparam type="formfield" name="a3" value="100"> 
    <cfhttpparam type="formfield" name="p3" value="12"> 
    <cfhttpparam type="formfield" name="t3" value="M">
    <cfhttpparam type="formfield" name="src" value="1">sra
    <cfhttpparam type="formfield" name="srt" value="12">
    <cfhttpparam type="formfield" name="sra" value="1">
    <cfhttpparam type="formfield" name="custom" value="custom">    
    <cfhttpparam type="formfield" name="invoice" value="1">    
    <cfhttpparam type="formfield" name="modify" value="2	">    
    <cfhttpparam type="formfield" name="usr_manage" value="1">            
</cfhttp>
<cfdump var="#request.result#" label="cgi" abort="true" top="3" />--->