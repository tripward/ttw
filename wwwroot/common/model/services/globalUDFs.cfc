<cfcomponent displayname="globalUDFs" persistent="false" accessors="true" hint="" output="false">

	<cffunction name="init" access="public" output="false" returntype="any">
		<!---<cfset setVarScope() />--->
		<cfreturn THIS />
	</cffunction>

	<cffunction name="queryRowToStruct" displayname="queryRowToStruct" hint="queryRowToStruct" access="public" output="false" returntype="Any">
            <cfargument name="q" required="Yes" type="query">
            <cfargument name="rowindex" required="Yes" type="numeric">
            <cfset local.ret = structNew()>

			<cftry>
	            <!--- Loop over the columnlist and get the rowindex needed. --->
	            <cfloop list="#q.columnlist#" index="column">
	            	<cfset local.ret[column] = q[column][rowindex]>
	            </cfloop>

				<cfcatch type="any">
					<cfdump var="#arguments#" label="arguments" abort="false" />
					<cfdump var="#cfcatch#" label="cgi" abort="true" />

				</cfcatch>
			 </cftry>

            <cfreturn local.ret />
     </cffunction>

     <cffunction name="getBaseDir" hint="I return the first directory after the FQDN" returntype="string">
		<cfargument name="userCGI" required="true" type="struct" default="#structNew()#" >
		<!---<cfdump var="#arguments#" label="cgi" abort="true"  />--->
		<cfset local.dir = "/#listFirst(cgi.path_info,'/')#" />
		<cfdump var="#local.dir#" label="cgi" abort="true"  />

		<cfreturn local.dir />
	</cffunction>

     <cffunction name="getErrorDisplay">

			<cfargument name="errorArray" required="false" type="array" default="#arrayNew(1)#" >
			<!---<cfdump var="#arguments#" label="cgi" abort="true" />--->
			<cfsavecontent variable="local.content">
				<cfoutput>
					<cfif arrayLen(arguments.errorArray)>
					<cfloop array="#arguments.errorArray#" index="local.theValue">
						<div class="alert alert-info">
							<!---<a class="close" data-dismiss="alert" href="##">--->#local.theValue#<!---</a>--->
							<!---#rc.message#--->
						</div>
					</cfloop>
					</cfif>
				</cfoutput>
			</cfsavecontent>
		<cfreturn local.content />
	</cffunction>

	

<cffunction name="getCSRFTokenFormField" access="public" output="false" returntype="any">
	<cfargument name="sessionRef" type="struct" default="#structNew()#" >
	<cfargument name="applicationRef" type="struct" default="#structNew()#" >
	<!---<cfdump var="#arguments.sessionRef#" label="cgi" abort="true" />--->

		<cfset local.content = "" />
		<cfsavecontent variable="local.content">
			<cfoutput>
				<!---todo: functionality: we need to find an identifer to seperate out cralwers--->
				<cfif arguments.applicationRef.ApplicationName IS "foo">
					<input name="csrfToken" value="#arguments.sessionRef.sessionID#" type="hidden" />
				</cfif>
			</cfoutput>
		</cfsavecontent>

		<cfreturn local.content />
	</cffunction>

<cffunction name="formatBoolean" returntype="string" hint="" output="false">
		<cfargument name="response" required="false" default="0" />

		<cfset local.theContent = "the value passes to format boolean doesn't appear to be a boolean" />

		<cfif arguments.response IS "true" OR arguments.response EQ 1>
		<cfset local.theContent = "Yes" />
		<cfelseif arguments.response IS "false" OR arguments.response EQ 0>
		<cfset local.theContent = "No" />
		</cfif>

		<cfreturn local.theContent />
	</cffunction>

	<cffunction name="getCleanedError" returntype="string" hint="" output="false">
		<cfargument name="theCatch" required="true" default="" />
		<!---<cfdump var="#arguments.theCatch#" abort="true" />--->
		<cfsavecontent variable="local.theContent">
		<cfoutput>
			<div>Message: #arguments.theCatch.message#</div>
			<!---<cf_OutputCFCatch CFCatch="#arguments.theCatch#" />--->
			<cfif structKeyExists(arguments.theCatch,"type") AND arguments.theCatch.type IS "database">
				<div>#arguments.theCatch.detail#</div>
			</cfif>
			<div>Stack:</div>
			<cfloop array="#arguments.theCatch.tagContext#" index="local.theLine" >
				<div>#listLast(local.theLine.raw_trace,"\")#,</div>
			</cfloop>
			<!---<div>cgi.HTTP_USER_AGENT: #cgi.HTTP_USER_AGENT#, Referer: #cgi.HTTP_REFERER#, cgi.REMOTE_ADDR: #cgi.REMOTE_ADDR#</div>--->
			<!---<cfdump var="#cgi#" label="cgi in utils getCleanedError" abort="false" />--->
		</cfoutput>
		</cfsavecontent>
		<cfreturn local.theContent />
	</cffunction>

	<cffunction name="formatDate" output="false">
		<cfargument name="when" hint="Named argument passed implicitly via RC from controller or user." />
		<cfreturn dateFormat( arguments.when, "dd-mmmm-yyyy" ) />
	</cffunction>

	<cffunction name="isBot" returntype="string" hint="" output="false">
		<cfargument name="theAgent" required="true" default="" />
		<cfset local.botList = "icf-vnuchgoogle" />
		<cfset local.isBot = false />
		<cfif ListContainsNoCase(local.botList, arguments.theAgent)>
			<cfset local.isBot = true />
		</cfif>
		<cfreturn local.isBot />
	</cffunction>
	
	

	
	<cffunction name="getRelatedSelectBoxJquery">
              <cfargument name="childToParentDataset" required="true" type="any" default="" >
              <cfargument name="parentID" required="true" type="any" default="" >
              <cfargument name="childID" required="true" type="any" default="" >
              <cfargument name="displayName" required="true" type="any" default="" >

<!---
              child to parent data set arguments.childToParentDataset getSubjectsForBranchesByUserPerm exected based on parent id in query
              parent id/form fieldid /columnname #branchofserviceid
              child form field id '#childID
              child name getproperty() #rc.childName#
--->

       <cfsavecontent variable="local.content" >
              <cfoutput>

                           <script>

                           var subArrys = [];

                           <cfloop collection="#arguments.childToParentDataset#" item="local.item">
                                  subArrys['#local.item#'] = #StructFind(arguments.childToParentDataset, local.item)#;
                           </cfloop>

                           $( document ).ready(function() {
                                  $('#arguments.parentID#').ready(function() {
                                         setChildSelectOptions($(this).find('option:selected').val(), $('#arguments.childID#'), subArrys, <cfoutput>'#arguments.displayName#'</cfoutput>);
                                  })
                                  .change(function() {
                                         setChildSelectOptions($(this).find('option:selected').val(), $('#arguments.childID#'), subArrys, <cfoutput>'#arguments.displayName#'</cfoutput>);
                                  });

                                  function setChildSelectOptions(parentSelectedID, childSelect, childOptsArray, childSelectedID){
                                         var isSelected = false;

                                         // remove the current options
                                         childSelect.find('option').remove();
                                         // add the '- Select -' option
                                         childSelect.append(new Option('- Select -', ''));

                                         // add the options if a valid branchID was passed in
                                         if(parentSelectedID.length){
                                                $.each(childOptsArray[parentSelectedID]['DATA'], function(index, item) {
                                                       //2 corresponds to the column positon for the data you want to display
                                                       childSelect.append(new Option(item[1],  item[0], false, (item[0].localeCompare(childSelectedID) == 0) ? true : false) );
                                                });
                                         }
                                  }
                           });
                     </script>



                           </cfoutput>
                     </cfsavecontent>
              <cfreturn local.content />
       </cffunction>


    <cfscript>
		function getFullDomain() {
			var str = cgi.HTTP_HOST;
			var baseProt = "http://";
			if(SERVER_PORT_SECURE) baseProt = "https://";
			return baseProt & str;
		}
	</cfscript>


</cfcomponent>