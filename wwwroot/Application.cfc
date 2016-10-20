<cfcomponent extends="framework.one" displayname="application" hint="" >

<cfif cgi.server_name IS "fedttw.loc">
	<cfset request.baseEnvPath = "trip" />
<cfelseif cgi.server_name IS "test.fedttw.com">
	<cfset request.baseEnvPath = "test" />
<cfelse>
	<cfset request.baseEnvPath = "production" />
</cfif>
<!---<cfdump var="#request.baseEnvPath#" label="cgi" abort="true"  />--->
<cfinclude template="/env/#request.baseEnvPath#/settings_dynamicSets.cfm" />


<cfscript>
	// Either put the framework folder in your webroot or create a mapping for it!

	this.name = '#request.appName#';
	this.sessionManagement = true;
	this.sessiontimeout = CreateTimeSpan(0,1,0,0);

	// mappings
	this.ormLocs = ["/accountmanagement/model","/subscribe/model","/search/model","/common/model","/datamanager/model","/profile/model","/reload/model"];


	// ORM settings
	this.datasource = request.datasource;
	this.ormEnabled = true;
	this.ormSettings = { logsql : true, cfclocation : this.ormLocs , Dbcreate  : 'update', flushatrequestend : false};	// logsql: defaults to <cf_home>\cfusion\logs\hibernatesql.log

	this.invokeImplicitAccessor = true;	// Allows access to cfc properties by this.property instead of this.getProperty(). Added in CF10, sorry CF9ers.



	// FW/1 - configuration:
	variables.framework = {
		usingSubsystems = true,
		siteWideLayoutSubsystem = 'common',
		//home = 'main.default',
		//applicationKey = 'framework.one',
		SESOmitIndex = TRUE,
		generateSES = FALSE,
		reload = 'reload',
		password = 'FALSE',
		error = 'home:main.error',
        diLocations = "/accountmanagement/model,/search/model,/subscribe/model,/datamanager/model,/common/model,/profile/model,/reload/model", // to account for the variety of D/I locations in our examples
        // that allows all our subsystems to automatically have their own bean factory with the base factory as parent
        trace = request.showTrace,
        reloadApplicationOnEveryRequest = true,
        unhandledPaths = '/upload,/outside'
	};

	/*variables.framework = {
	  action = 'action',
	  usingSubsystems = false,
	  defaultSubsystem = 'home',
	  defaultSection = 'main',
	  defaultItem = 'default',
	  subsystemDelimiter = ':',
	  siteWideLayoutSubsystem = 'common',
	  home = 'main.default', // defaultSection & '.' & defaultItem
	  // or: defaultSubsystem & subsystemDelimiter & defaultSection & '.' & defaultItem
	  error = 'main.error', // defaultSection & '.error'
	  // or: defaultSubsystem & subsystemDelimiter & defaultSection & '.error'
	  reload = 'reload',
	  password = 'true',

	  generateSES = false,
	  SESOmitIndex = false,
	  // base = omitted so that the framework calculates a sensible default
	  baseURL = 'useCgiScriptName',
	  // cfcbase = omitted so that the framework calculates a sensible default
	  suppressImplicitService = true, // this used to be false in FW/1 1.x
	  suppressServiceQueue = true, // false restores the FW/1 2.2 behavior
	  enableGlobalRC = false, // true restores the FW/1 2.2 behavior
	  unhandledExtensions = 'cfc',
	  unhandledPaths = '/flex2gateway',
	  unhandledErrorCaught = false,
	  preserveKeyURLKey = 'fw1pk',
	  maxNumContextsPreserved = 10,
	  cacheFileExists = false,
	  applicationKey = 'org.corfield.framework', // will be 'framework.one' in 3.0
	  trace = false
	};*/



</cfscript>

	<cffunction name="setupApplication" access="public" returntype="any">

		<cfset application.envPath = "/env/#request.baseEnvPath#/" />
		
		<!--- Environment Mapping required! (somewhere under [project]/env/envname) --->
		<cfinclude template="#application.envPath#/envSettings_Application.cfm" >

		<cfset application.udf = getBeanFactory().getBean('globalUDFs') />
		<cfset application.SecurityUtils = getBeanFactory().getBean('SecurityUtils') />
		
		<cfset application.am = this.getBeanFactory().getBean('accountManagementServices') />
		<cfset application.agentServices = this.getBeanFactory().getBean('agentServices') />
		
		<!---<cfset application.bf = this.setbeanfactory(application['framework.one'].factory) />--->
		
	</cffunction>
	
	


	<cffunction name="setupSession" access="public" returntype="any">

		<!--- HANDLE SESSION MANAGEMENT MANUALLY WITH TRUE PER-SESSION COOKIES --->
		<cflock timeout="5" throwontimeout="no" type="readonly" scope="SESSION">
			<!---
			<CFIF structKeyExists(SESSION,'sessionID')>
				<cfcookie name="jsessionID" value="#SESSION.sessionID#" httponly="true" secure="#getPageContext().getRequest().isSecure()#" expires="300" />
			</CFIF>
			--->
			<!--- This checks if a cookie is created, for bots this will return false and use the low session timeout --->
			<!---<cfif StructKeyExists(cookie, "cfid") or StructKeyExists(cookie, "jsessionid")>
			 	<cfset this.sessiontimeout = CreateTimeSpan(0,1,0,0) />
			 	<cfset session.user = getBeanFactory().getBean('users') />
			</cfif>--->
			
			<!---<cfif !StructKeyExists(session, "user")>--->
			 	<!---<cfset this.sessiontimeout = CreateTimeSpan(0,1,0,0) />--->
			 	<cfset session.user = this.getBeanFactory().getBean('users') />
			<!---</cfif>--->

		</cflock>

	</cffunction>


	<cffunction name="setupRequest" access="public" returntype="any">

		<!--- Environment Mapping required! (somewhere under [project]/env/envname) --->
		<cfinclude template="#application.envPath#/envSettings_Request.cfm" >
		<cfset application.udf = getBeanFactory().getBean('globalUDFs') />
		<cfif !structKeyExists(application,"bf")>
			<cfset application.bf = this.setbeanfactory(application['framework.one'].factory) />
		</cfif>

		<cfif structKeyExists(url,"re")>
			<cfset setupSession() />
		
		</cfif>
		
		<cfif !structKeyExists(session,"user")>
			<cfset setupSession() />
			<cflocation url="/" addtoken="false" statuscode="301" >
			<cfabort />
		
		</cfif>

		<cfif structKeyExists(url,"init")>
			<cfset applicationstop() />
			<cfset setupApplication() />
			<!---<cfset ormReload() />
			<cfset setupSession() />--->
		</cfif>
		
		<cfinclude template="/xss.cfm" />
        <cfinclude template="/csrfCheck.cfm" />


	</cffunction>
	
	
	<!---<cffunction name="OnError" access="public" returntype="void" output="true"	hint="Fires when an exception occures that is not caught by a try/catch block">
		<!--- Define arguments. --->
		<cfargument	name="Exception" type="any"	required="true"	/>
		<cfargument	name="EventName" type="string" required="false" default=""	/>
		<!---
			Dump out the ARGUMENTS scope. Here, we want to see
			how the argument change depending on whether or not
			we have the OnRequest() method.
		--->
		<cfif request.isShowDebugging>
			<cfdump var="#request.exception#" label="dump in main.error" abort="true"  />
		<cfelse>
		
			<cflocation url="/index.cfm?action=home:main.error" />
			
			
		</cfif>
		<!---<cfdump var="#request#" label="cgi" abort="false" top="3" />--->
		
	<!---<cflog type="Error" 
        file="vcn_#application.config.getValue('environment')#"
		type = "Error"
        text="Exception error --  
            Exception type: #error.type# 
            Template: #error.template#, 
            Remote Address: #error.remoteAddress#,  
            HTTP Reference: #error.HTTPReferer# 
            Diagnostics: #error.diagnostics#"> --->
		<!--- Return out. --->
		<cfreturn />
	</cffunction>--->


</cfcomponent>
