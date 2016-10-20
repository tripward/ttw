<cfcomponent displayname="searchServices" extends="common.model.services.BaseServices" persistent="false" accessors="true" hint="" output="false">

	<cfproperty name="objectType" type="string" default="Usersf" persistent="false" />

	<cffunction name="getNew" access="public" returntype="any">
		<cfset local.obj = createObject("component","search.model.beans.Searches" ) />
		<cfreturn local.obj />
	</cffunction>

	
	<cffunction name="setComplexProperties" access="public" returntype="any">
		<cfargument name="info" type="any" default="" required="true">
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->
		
		
		<!---this is just a shorcut set so we don't have to repeat all those dots--->
		<cfset local.obj = arguments.info.obj />
		<cfset local.obj.setOrganization(arguments.info.user.getOrganization()) />
		<!---<cfset arguments.info.user.getOrganization().addContract(local.obj ) />--->

		<cfreturn local.obj />
	</cffunction>
	
	<cffunction name="getSearchStats" access="public" returntype="any">
		
		
		<cfset local.searchStats = EntityLoad("searchstats",{},true) />
		
		<cfif isNull(local.searchStats)>
			
			<cfset local.newSearchStatObject = EntityNew("searchstats") />
			<cfdump var="#local.newSearchStatObject#" label="cgi" abort="false" top="3" />
			<cfset this.persist(local.newSearchStatObject) />
			<cfset local.searchStats = EntityLoad("searchstats",{},true) />
		</cfif>

		<cfreturn local.searchStats />
	</cffunction>
	
	<cffunction name="incrementSearchCount" access="public" returntype="void">
		
		
		<cfquery name="local.getCount">
			SELECT searchCount
			FROM SearchStats s
		</cfquery>
		
		<cfset local.newCount = local.getCount.searchCount + 1 />
		
		<cfquery name="local.incrementCount">
			UPDATE SearchStats
			SET searchCount = #local.newCount#
		</cfquery>


		<cfreturn  />
	</cffunction>
	
	<cffunction name="doSearchQry" access="public" returntype="any">
		<cfargument name="info" type="any" default="" required="true">
		<!---<cfdump var="#arguments#" label="cgi" abort="false" top="3" />--->
		<!---<cfquery name="local.searchQry">
			
			SELECT o.organizationid
			    FROM Organizations o
			    LEFT JOIN Organizations_To_SDBTypes osdb ON osdb.organizationid = o.organizationid
			    WHERE osdb.SDBTypeid IN (#arguments.info.SDBTypeid#)
			
			
		</cfquery>
		<cfdump var="#local.searchQry#" label="cgi" abort="false" top="100" />--->
		
		<cfset this.incrementSearchCount() />
		
		<cfquery name="local.searchQry">
			
			SELECT c.contractID
			FROM contracts c
			LEFT JOIN Contracts_To_DepartmentOrganizations cdo ON cdo.contractID = c.contractID
			LEFT JOIN Contracts_To_Departments cd ON cd.contractID = c.contractID
			LEFT JOIN Contracts_To_GovTypes cgt ON cgt.contractID = c.contractID
			WHERE 1 = 1 
			<cfif structKeyExists(arguments.info,"SDBTypeid") AND len(arguments.info.SDBTypeid)>
				AND c.organizationid IN
				   (SELECT o.organizationid
				    FROM Organizations o
				    LEFT JOIN Organizations_To_SDBTypes osdb ON osdb.organizationid = o.organizationid
				    WHERE osdb.SDBTypeid IN (#arguments.info.SDBTypeid#))
			</cfif>
			    
			<cfif structKeyExists(arguments.info,"DEPARTMENTORGANIZATIONID") AND len(arguments.info.DEPARTMENTORGANIZATIONID)>
				AND cdo.departmentOrganizationid IN (#arguments.info.DEPARTMENTORGANIZATIONID#)
			</cfif>
			
			<cfif structKeyExists(arguments.info,"DEPARTMENTID") AND len(arguments.info.DEPARTMENTID)>
				AND cd.DEPARTMENTID IN (#arguments.info.DEPARTMENTID#)
			</cfif>
			
			<cfif structKeyExists(arguments.info,"GOVERNMENTTYPEID") AND len(arguments.info.GOVERNMENTTYPEID)>
				AND cgt.GOVERNMENTTYPEID IN (#arguments.info.GOVERNMENTTYPEID#)
			</cfif>
			
			<cfif structKeyExists(arguments.info,"KEYWORDS") AND len(arguments.info.KEYWORDS)>
				<cfset local.keywordString = replaceNoCase(arguments.info.KEYWORDS," ",",") />
				
				<cfloop  list="#local.keywordString#" index="local.listIdx">
					AND c.DescriptionofWork LIKE '%#local.listIdx#%'
				</cfloop>
				
				
				
			</cfif>
				
			
			
			
		</cfquery>
		<!---<cfdump var="#local.searchQry#" label="cgi" abort="true" top="100" />--->
		
		<!---<cfquery name="local.searchQry">
			
			SELECT c.* FROM
				(
				   SELECT conttractid AS a, SUM(column2)
				   
				   FROM table
				   LEFT JOIN Organizations o ON o.organizationid = c.organizationid
				LEFT JOIN Organizations_To_SDBTypes osdb ON osdb.organizationid = o.organizationid
				)
			
			
			
		</cfquery>
		<cfdump var="#local.searchQry#" label="cgi" abort="true" top="100" />--->
		
		<!---<cfquery name="local.searchQry">
			
			Select c.*,o.*
			FROM contracts c, Organizations o
			LEFT JOIN Contracts_To_DepartmentOrganizations cdo ON cdo.contractID = c.contractID
			LEFT JOIN Contracts_To_Departments cd ON cd.contractID = c.contractID
			LEFT JOIN Contracts_To_GovTypes cgt ON cgt.contractID = c.contractID
			LEFT JOIN Organizations o ON o.organizationid = c.organizationid
			LEFT JOIN Organizations_To_SDBTypes osdb ON osdb.organizationid = o.organizationid
			WHERE 1 =1 
			<cfif structKeyExists(arguments.info,"DEPARTMENTORGANIZATIONID") AND len(arguments.info.DEPARTMENTORGANIZATIONID)>
				AND cdo.departmentOrganizationid IN (#arguments.info.DEPARTMENTORGANIZATIONID#)
			</cfif>
			
			<cfif structKeyExists(arguments.info,"DEPARTMENTID") AND len(arguments.info.DEPARTMENTID)>
				AND cd.DEPARTMENTID IN (#arguments.info.DEPARTMENTID#)
			</cfif>
			
			<cfif structKeyExists(arguments.info,"GOVERNMENTTYPEID") AND len(arguments.info.GOVERNMENTTYPEID)>
				AND cgt.GOVERNMENTTYPEID IN (#arguments.info.GOVERNMENTTYPEID#)
			</cfif>
			
			<cfif structKeyExists(arguments.info,"SDBTypeid") AND len(arguments.info.SDBTypeid)>
				AND osdb.SDBTypeid IN (#arguments.info.SDBTypeid#)
			</cfif>
			
			<cfif structKeyExists(arguments.info,"KEYWORDS") AND len(arguments.info.KEYWORDS)>
				AND c.DescriptionofWork LIKE %#arguments.info.KEYWORDS#%
			</cfif>
			
			
			
		</cfquery>
		<cfdump var="#local.searchQry#" label="cgi" abort="true" top="100" />--->
		
		<cfreturn local.searchQry />
	</cffunction>
	


</cfcomponent>