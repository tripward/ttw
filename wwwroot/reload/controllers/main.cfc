<cfcomponent displayname="accountManagement controller" hint="accountManagement controller" extends="common.controllers.baseController" output="false" accessors="TRUE">
	<!---
		ALERT: All properties setting up services are in the baseController. You have access to any service simply by calling it's property name
		Example: accountManagementServices.getUser(rc)
	--->

	<cffunction name="default" access="public" returntype="any">
		
	</cffunction>
	
	<cffunction name="reloadBaseData" access="public" returntype="any">

				<cfset baseInfoSetup() />
				
	</cffunction>
	
	<cffunction name="baseInfoSetup" access="public" returntype="any">
		
		<!---<cfdump var="#this#" label="cgi" abort="true" top="3" />--->
		
		<cfif arrayLen(this.sdbTypeServices.get())>
			<div class="">WOOOOOOOOOOOOOOOOOOOOOOOOOOO - the base data already exists. I have to stop you!</div>
			<cfdump var="Yes, I just saved you from yourself" label="cgi" abort="true" top="3" />
		</cfif>
		
		
		
		
		
		<cfset local.sdbtype1 = this.sdbTypeServices.getNew() />
		<cfset local.sdbtype1.setName('8(a)') />
		<cfset local.sdbtype1 = this.sdbTypeServices.persist(local.sdbtype1) />
		
		<cfset local.sdbtype2 = this.sdbTypeServices.getNew() />
		<cfset local.sdbtype2.setName('Woman-Owned') />
		<cfset local.sdbtype2 = this.sdbTypeServices.persist(local.sdbtype2) />
		
		<cfset local.sdbtype3 = this.sdbTypeServices.getNew() />
		<cfset local.sdbtype3.setName('HUBZone') />
		<cfset local.sdbtype3 = this.sdbTypeServices.persist(local.sdbtype3) />
		
		<cfset local.sdbtype4 = this.sdbTypeServices.getNew() />
		<cfset local.sdbtype4.setName('Service-Disabled Veteran-Owned') />
		<cfset local.sdbtype4 = this.sdbTypeServices.persist(local.sdbtype4) />
		
		
		<cfset local.contractType1 = this.ContractTypeServices.getNew() />
		<cfset local.contractType1.setName('Prime Contractor') />
		<cfset local.contractType1 = this.ContractTypeServices.persist(local.contractType1) />
		
		<cfset local.contractType2 = this.ContractTypeServices.getNew() />
		<cfset local.contractType2.setName('Subcontractor') />
		<cfset local.contractType2 = this.ContractTypeServices.persist(local.contractType2) />
		
		<cfset local.role1 = this.getuserroleServices().getNew() />
		<cfset local.role1.setName('Admin') />
		<cfset local.role1 = this.getuserroleServices().persist(local.role1) />
		
		
		<cfset local.role2 = this.getuserroleServices().getNew() />
		<cfset local.role2.setName('AccountManager') />
		<cfset local.role2 = this.getuserroleServices().persist(local.role2) />
		
		<cfset local.role3 = this.getuserroleServices().getNew() />
		<cfset local.role3.setName('General') />
		<cfset local.role3 = this.getuserroleServices().persist(local.role3) />
		
		<cfset local.role4 = this.getuserroleServices().getNew() />
		<cfset local.role4.setName('Agent') />
		<cfset local.role4 = this.getuserroleServices().persist(local.role4) />
		
		
		<cfset local.org1 = this.getOrganizationServices().getNew() />
		<cfset local.org1.setorganizationName('TTW') />
		<cfset local.org1.setActive(1) />
		<cfset local.org1 = this.getOrganizationServices().persist(local.org1) />
		
		
		<cfset local.user1 = entityNew(this.getUserServices().getObjectType()) />
		<cfset local.user1.setUsername('wes') />
		<cfset local.user1.setFirstName('Wes') />
		<cfset local.user1.setLastName('Colton') />
		<cfset local.user1.setprimaryEmail('w@strangepath.co') />
		<cfset local.user1.setActive(1) />
		<cfset local.user1.setPassword(1) />
		<cfset local.user1.addUserRole(local.role1) />
		<cfset local.user1.addUserRole(local.role2) />
		<cfset local.user1.addUserRole(local.role3) />
		<!---<cfdump var="#this#" label="cgi" abort="true" top="3" />--->
		<cfset local.profile1 = this.getprofileServices().getNew() />
		<cfset local.profile1.setUser(local.user1) />
		<cfset local.user1.setProfile(local.profile1) />
		
		<cfset local.user1.setOrganization(local.org1) />
		<cfset local.org1.addUser(local.user1) />
		<cfset local.user1 = this.getUserServices().persist(local.user1) />
		
		<cfset local.user2 = this.getUserServices().getNew() />
		<cfset local.user2.setUsername('trip') />
		<cfset local.user2.setFirstName('Trip') />
		<cfset local.user2.setLastName('Ward') />
		<cfset local.user2.setprimaryEmail('king@werwards.com') />
		<cfset local.user2.setActive(1) />
		<cfset local.user2.setPassword(1) />
		<cfset local.user2.addUserRole(local.role1) />
		<cfset local.user2.addUserRole(local.role2) />
		<cfset local.user2.addUserRole(local.role3) />
		
		<cfset local.profile2 = this.getprofileServices().getNew() />
		<cfset local.profile2.setUser(local.user2) />
		<cfset local.user2.setProfile(local.profile2) />

		<cfset local.user2.setOrganization(local.org1) />
		<cfset local.org1.addUser(local.user2) />
		<cfset local.user2 = this.getUserServices().persist(local.user2) />
		
		<cfset local.org1 = this.getOrganizationServices().persist(local.org1) />
		
	</cffunction>

	
</cfcomponent>