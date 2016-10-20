<cfcomponent displayname="accountManagement controller" hint="accountManagement controller" extends="common.controllers.baseController" output="false" accessors="TRUE">
	<!---
		ALERT: All properties setting up services are in the baseController. You have access to any service simply by calling it's property name
		Example: accountManagementServices.getUser(rc)
	--->
	
	<cffunction name="getMyServices" access="public" returntype="any">
		<!---<cfdump var="#this#" label="cgi" abort="true" top="3" />--->
		<cfreturn reportingServices />
	</cffunction>

	<cffunction name="default" access="public" returntype="any">
		<cfargument name="rc" >
		<!---<cfset rc.user = accountManagementServices.getUser(rc) />--->

	</cffunction>
	
	<cffunction name="ListSubscribersForm" access="public" returntype="any">
		
	</cffunction>
	
	<cffunction name="displayListSubscribersresults" access="public" returntype="any">
		
		<cfset rc.objs = arrayNew(1) />
		<cfset rc.startobjs = this.getMyServices().getSubscribersforPayReport(rc) />
		
		
		<cfloop array="#rc.startobjs#" index="local.objIdx">
			<cfset rc.obj = this.getMyServices().getByPk(local.objIdx.getUserID()) />
			
			<cfif len(rc.obj.getppprofileID())>
				<cfset local.profileDetails = this.getMyServices().getRecurringPaymentsProfileDetails(local.objIdx.getppprofileID()) />
				<!---<cfdump var="#local.profileDetails#" label="cgi" abort="true" top="3" />--->
				<cfif local.profileDetails.status IS NOT rc.obj.getpppayerStatus() >
					<cfset rc.obj.setpppayerStatus(local.profileDetails.status) />
					<cfset this.userServices.persist(rc.obj) />
				</cfif>
				<cfset arrayAppend(rc.objs,rc.obj) />
				
			</cfif>
			<!---#local.objIdx.displayReportListEntry()#<br />--->
			
		</cfloop>
	
	
	</cffunction>

</cfcomponent>