<cfcomponent displayname="baseObject.cfc" hint="I am an org" output="false" persistent="false" accessors="true">
	
	<cfproperty name="beanfactory" />
	
	<cfset variables.simpleValues = "string,numeric,boolean,date" />

<!---Attention: these populate methods are needed in both beans and service objects in order to poplate them from queries, structs(like form) but there isn't a
 common object that both share. I could have put it in utils but the nuber of calls is just too great and the since so many things use this the test footprint is too great.--->

	<cffunction name="init" access="public" output="false" returntype="any">
		
		<!---<cfset this.setbeanfactory(application['framework.one'].factory) />--->
		<!---<cfset this.configure()>--->

		<cfreturn THIS />
	</cffunction>
	
	
	<cffunction name="configure" access="public" output="false" returntype="any" hint="I loop over all local and and extended objects' properties, set defaults where possible and return a fully configured default object">


		<!---<cfdump var="#collectAllProperties(getMetadata(THIS))#" label="collectAllProperties(getMetadata(THIS)" abort="true" />--->

		<cftry>

			<cfloop array="#collectAllProperties(getMetadata(THIS))#" index="local.theProp">


			<cfif StructKeyExists(local.theProp,"type")>

				<!---create the set method name--->
				<cfset var theMethod = this["set" & local.theProp.name] />

				<!---if it is a simple variable and there is a default value including empty string set it--->
				<cfif listFind("string",local.theProp.type) AND structKeyExists(local.theProp,"default")><!---numeric--->

					 <cftry>

						 <cfset theMethod(rTrim(trim(local.theProp.default))) />

						 <cfcatch type="any">
							 <cfdump var="#local.theProp.name#" label="k" abort="false" />
							 <cfdump var="#cfcatch#'" label="k" abort="true" />
							 <cfabort />
						 </cfcatch>

					</cftry>

				</cfif>

				<cfif local.theProp.type IS "numeric" AND structKeyExists(local.theProp,"default") AND len(trim(local.theProp.default))><!---numeric--->

					 <cftry>

						 <cfset theMethod(rTrim(trim(local.theProp.default))) />

						 <cfcatch type="any">
							 <cfdump var="#local.theProp.name#" label="k" abort="false" />
							 <cfdump var="#cfcatch#'" label="k" abort="true" />
							 <cfabort />
						 </cfcatch>

					</cftry>

				</cfif>

				<cfif listFind("boolean",local.theProp.type) AND structKeyExists(local.theProp,"default")><!---numeric--->

					 <cftry>

						<!---I'm not really sure I want to set a boolean if it doesn;t have a value in the database, howevr
						a boolean without a value isn't a boolean - it's an error--->
						<cfif len(local.theProp.default)>
							<cfset theMethod(rTrim(trim(local.theProp.default))) />
						<cfelse>
							<cfset theMethod(0) />
						</cfif>

						 <cfcatch type="any">
							 <cfif request.isShowFullErrorDebugging>
							 	<cfdump var="#local.theProp.name#" label="k" abort="false" />
							 	<cfdump var="#cfcatch#'" label="cfcatch" abort="true" />
							</cfif>
						 </cfcatch>

					</cftry>

				</cfif>

				<!---CF9 won't set a default value of an array--->
				<cfif StructKeyExists(local.theProp,"type") AND listFind("array",local.theProp.type)>

					 <cftry>

						 <cfset theMethod(arrayNew(1)) />

						 <cfcatch type="any">
							 <cfif request.isShowFullErrorDebugging>
								 <cfdump var="#local.theProp#" label="k" abort="false" />
								 <cfdump var="#cfcatch#'" label="cfcatch" abort="true" />
							 </cfif>
						 </cfcatch>

					</cftry>

				</cfif>

				<!---CF9 won't set a default value of an array--->
				<cfif StructKeyExists(local.theProp,"type") AND listFind("struct",local.theProp.type)>

					 <cftry>

						 <cfset theMethod(structNew()) />

						 <cfcatch type="any">
							 <cfif request.isShowFullErrorDebugging>
								 <cfdump var="#local.theProp#" label="k" abort="false" />
								 <cfdump var="#cfcatch#'" label="cfcatch" abort="true" />
							 </cfif>
						 </cfcatch>

					</cftry>

				</cfif>
				</cfif>
			</cfloop>

			<!---<cfdump var="#this.getFormats()#" label="cgi" abort="true" />--->

			<cfcatch type="any">
				 <!---<cfdump var="#cgi#'" label="getMetaData(this)" abort="false" />--->
				 <!---<cfif request.isShowFullErrorDebugging>--->
				 	<cfdump var="#cfcatch#'" label="cfcatch in configure in basebean" abort="true" />
				 <!---</cfif>--->
			 </cfcatch>

			</cftry>
<!---<cfdump var="#arguments#" label="cgi" abort="false" />
<cfdump var="#this#" label="cgi" abort="true" />--->
		</cffunction>

	<cfscript>
		private array function collectAllProperties(required struct md,array props=ArrayNew(1)) {
	    local.prop = 1;
	    if (structKeyExists(arguments.md,"properties")) {
	        for (local.prop=1; local.prop <= ArrayLen(arguments.md.properties); local.prop++) {
	            if (not ArrayContains(arguments.props,arguments.md.properties[local.prop].name)) {
	                arrayAppend(arguments.props,arguments.md.properties[local.prop]);
	            }
	        }
	    }
	    if (arguments.md.extends.fullname neq "WEB-INF.cftags.component") {
	        arguments.props = collectAllProperties(arguments.md.extends,arguments.props);
	    }
	    return arguments.props;
	}
	</cfscript>



	<!---ok, i hated writing this, although it is pretty slick. fw1 come with injectproperties, but because most of the db columns don't have defaults,
       when trying to inject properties, anything that isn't a varchar but is empty it throws an error. This method allows to pass what ever values we have an populatethe obj--->
	<cffunction name="populateFromStructWithValidation" displayname="populateFromStructWithValidation" description="I populate what fields are settible and treturn a validation object" hint="getSearchResultEntry" access="public" output="false" returntype="any">
              <cfargument name="info" >
              <!---<cfdump var="#arguments#" label="cgi" abort="false" />
              <cfdump var="#getMetaData(this).properties#" label="cgi" abort="true" />--->

			<!---this is property on all beans so it can report if it is valid--->
			<cfset THIS.setvalidationResults(application.framework.one.factory.getBean("ValidationResults"))>


			<!---get all props from extends--->
              <cfset local.props = collectAllProperties(getMetaData(this)) />



                     <!---loop over all this beans properties - array of structs--->
                     <cfloop array="#local.props#" index="local.theProp">



<!---Strings are different then other type checks. they take anything, so the only question is required. If the a structkey is passed in
                                         and it it doesn't have a len AND it isn't required you still just do the set to capture the empty string--->

  <cfif structKeyExists(arguments.info, local.theProp.name) AND structKeyExists( local.theProp, "type") AND local.theProp.type IS "string" > 
        
        
        <!--- this prevents ID fields from being set causing ORM errors for new entities i.e. ORM sees the new entity having a set ID field and tries to do an update instead of and insert.--->
        <cfif NOT structKeyExists( local.theProp, "fieldType") OR (structKeyExists( local.theProp, "fieldType") AND local.theProp.fieldType IS NOT "id")   >


			<cfset var theMethod = this["set" & local.theProp.name] />
			<cfset theMethod(trim(arguments.info[local.theProp.name])) />
								

							<!---check length of suplied field, if it is required and we don't have len add it - ALERT but if we already n\know it is required and no length, we're going to check type - DUMB finad another order--->
							<cfif listFindNoCase(this.getrequiredFields(),local.theProp.name) AND !len(arguments.info[local.theProp.name])>
								
								<cfset arrayAppend(THIS.getvalidationResults().getnonLength(),local.theProp) />
								<cfset var theMethod = this["set" & local.theProp.name] />
								<cfset theMethod(trim(arguments.info[local.theProp.name])) />

							<!---<cfelse>--->

								
								<!---<cfdump var="#theMethod#" label="cgi" abort="false" top="3" />
								<cfdump var="#local.theProp.name#" label="cgi" abort="false" top="3" />
								<cfdump var="#arguments.info[local.theProp.name]#" label="cgi" abort="true" top="3" />--->


							</cfif>


					</cfif>
					
				</cfif>

						<!---ATTENTION:we just checked if it is required and if len - why would we then check type. if it is required and no len - skip this but not in a giant if then elfif etc--->

						<!---ATTENTION: you need to find a cleaner way to do this, each case is nearly identical, the only difference the type.
						seems like you can can create a list of types that are good isValid(), loop over the list and do the same thing on suc/failure
						however we get a little wiggle room per type.--->

							<!---check type--->
							<!---The property name exists in the struct that was passed, and we know we have the type attribute from the property and there is a len--->
   							<cfif structKeyExists(arguments.info, local.theProp.name) AND structKeyExists(local.theProp, "type") AND len(trim(arguments.info[local.theProp.name]))>

							  <cftry>
							   	<cfswitch expression="#local.theProp.type#" >

							   		<!---condition covers it is a string/varchar(you can add length attribute to prop), it is required, and we have a len--->
							   		<cfcase value="numeric">

										<!---there is a value and it is numeric--->
										<cfif len(arguments.info[local.theProp.name])
										AND isValid("numeric",arguments.info[local.theProp.name])>

											<!---set it--->
											<cfset var theMethod = this["set" & local.theProp.name] />
											<cfset theMethod(rTrim(trim(arguments.info[local.theProp.name]))) />

										<cfelseif len(arguments.info[local.theProp.name])
										AND !isValid("numeric",arguments.info[local.theProp.name])>
											<!---Add it to type field results--->
											<cfset arrayAppend(THIS.getvalidationResults().gettypeCheck(),local.theProp) />

										  </cfif>
							   		</cfcase>

							   		<!---condition covers it is a string/varchar(you can add length attribute to prop), it is required, and we have a len--->
							   		<cfcase value="boolean">

										<!---there is a value and it is boolean--->
										<cfif len(arguments.info[local.theProp.name])
										AND isValid("boolean",arguments.info[local.theProp.name])>

											<!---set it--->
											<cfset var theMethod = this["set" & local.theProp.name] />
											<cfset theMethod(rTrim(trim(arguments.info[local.theProp.name]))) />

										<cfelseif len(arguments.info[local.theProp.name])
										AND !isValid("boolean",arguments.info[local.theProp.name])>
											<!---Add it to type field results--->
											<cfset arrayAppend(THIS.getvalidationResults().gettypeCheck(),local.theProp) />

										  </cfif>
							   		</cfcase>

							   		<!---condition covers it is a string/varchar(you can add length attribute to prop), it is required, and we have a len--->
							   		<cfcase value="date">

										<!---there is a value and it is numeric--->
										<cfif len(arguments.info[local.theProp.name])
										AND isValid("date",arguments.info[local.theProp.name])>

											<!---set it--->
											<cfset var theMethod = this["set" & local.theProp.name] />
											<cfset theMethod(rTrim(trim(arguments.info[local.theProp.name]))) />

										<cfelseif len(arguments.info[local.theProp.name])
										AND !isValid("date",arguments.info[local.theProp.name])>
											<!---Add it to type field results--->
											<cfset arrayAppend(THIS.getvalidationResults().gettypeCheck(),local.theProp) />

										  </cfif>
							   		</cfcase>

							   		<!---condition covers it is a string/varchar(you can add length attribute to prop), it is required, and we have a len--->
							   		<cfcase value="email">

										<!---there is a value and it is numeric--->
										<cfif len(arguments.info[local.theProp.name])
										AND isValid("email",arguments.info[local.theProp.name])>

											<!---set it--->
											<cfset var theMethod = this["set" & local.theProp.name] />
											<cfset theMethod(rTrim(trim(arguments.info[local.theProp.name]))) />

										<cfelseif len(arguments.info[local.theProp.name])
										AND !isValid("email",arguments.info[local.theProp.name])>
											<!---Add it to type field results--->
											<cfset arrayAppend(THIS.getvalidationResults().gettypeCheck(),local.theProp) />

										  </cfif>
							   		</cfcase>

							   		<cfdefaultcase>
										<!---if it isn't a type from above and has no length do nothing--->
							   			<!---<cfset var theMethod = this["set" & local.theProp.name] />
										<cfset theMethod(rTrim(trim(arguments.info[local.theProp.name]))) />--->
							   		</cfdefaultcase>


							   	</cfswitch>

							   		<cfcatch type="any">
												<cfdump var="#arguments#" label="Struct that was passed into populateFromStructWithValidation" abort="false" />
                                                <cfdump var="#local.theProp#" label="local.theProp" abort="false" />
                                                <cfdump var="#arguments.info[local.theProp.name]#" label="arguments.info[local.theProp.name]" abort="false" />
                                               <cfdump var="#theMethod#" label="theMethod" abort="false" />
                                               <cfdump var="#cfcatch#" label="cfcatch" abort="true" />

                                         </cfcatch>
							   	 </cftry>

</cfif>

                                    </cfloop>



             <!--- <cfdump var="#THIS#" label="cg2i" abort="true" />--->
              <cfreturn THIS />
       </cffunction>





	<!---ok, i hated writing this, although it is pretty slick. fw1 come with injectproperties, but because most of the db columns don't have defaults,
       when trying to inject properties, anything that isn't a varchar but is empty it throws an error. This method allows to pass what ever values we have an populatethe obj--->
	<cffunction name="populateFromStruct" displayname="getSearchResultEntry" description="I get the display code to display myself in search results" hint="getSearchResultEntry" access="public" output="false" returntype="any">
              <cfargument name="info" >
              <!---<cfdump var="#arguments#" label="cgi" abort="false" />
              <cfdump var="#getMetaData(this).properties#" label="cgi" abort="true" />--->

              <cfset local.props = collectAllProperties(getMetaData(this)) />

              <cftry>
                     <cfloop array="#local.props#" index="local.theProp">

                           <cfif structKeyExists(arguments.info, local.theProp.name) AND structKeyExists(local.theProp, "type")>

                                  <cftry>
                                         <cfif local.theProp.type IS "string">

                                                <cfset var theMethod = this["set" & local.theProp.name] />

                                                <cfset theMethod(rTrim(trim(arguments.info[local.theProp.name]))) />


                                         <cfelseif listFind("numeric,boolean,date",local.theProp.type) AND len(trim(arguments.info[local.theProp.name]))>

                                                <cfset var theMethod = this["set" & local.theProp.name] />

                                                <cfset theMethod(rTrim(trim(arguments.info[local.theProp.name]))) />

                                         </cfif>

                                         <cfcatch type="any">
												<cfdump var="#arguments#" label="Struct that was passed in" abort="false" />
                                                <cfdump var="#local.theProp#" label="local.theProp" abort="false" />
                                                <cfdump var="#arguments.info[local.theProp.name]#" label="arguments.info[local.theProp.name]" abort="false" />
                                               <cfdump var="#theMethod#" label="theMethod" abort="false" />
                                               <cfdump var="#cfcatch#" label="cfcatch" abort="true" />

                                         </cfcatch>
                                  </cftry>

                           </cfif>
                     </cfloop>

                     <cfcatch type="any">
                           <cfdump var="#arguments#" label="arguments" abort="false" />
                           <cfdump var="#cfcatch#" label="cfcatch" abort="true" />
                           <cfabort />
                     </cfcatch>

              </cftry>
              <!---<cfdump var="#THIS#" label="cgi" abort="true" />--->
              <cfreturn THIS />
       </cffunction>


	<cffunction name="formatBoolean" returntype="string" hint="" output="false">
		<cfargument name="response" required="false" default="0" />
		<!---<cfdump var="#application#" label="cgi" abort="true" />--->
		<cfset local.theContent = application.Utils.formatBoolean(arguments.response) />

		<cfreturn local.theContent />
	</cffunction>

	<!---Helper Methods that all controllers can use--->
	<cffunction name="queryRowToStruct" displayname="queryRowToStruct" hint="queryRowToStruct" access="public" output="false" returntype="Any">
            <cfargument name="q" required="Yes" type="query">
            <cfargument name="rowindex" required="Yes" type="numeric">
            <cfset local.ret = structNew()>

            <!--- Loop over the columnlist and get the rowindex needed. --->
            <cfloop list="#q.columnlist#" index="column">
            <cfset local.ret[column] = q[column][rowindex]>
            </cfloop>
            <cfreturn local.ret>
     </cffunction>

     <!---todo: decide: is this worth it? used in compenduim to check that answer--->
<cffunction name="doTrimStructValues" displayname="doTrimStructValues" hint="I trim all values in a struct, used primarily for form scopes" access="public" output="false" returntype="struct">
	<cfargument name="structToTrim" />

	<cfset local.newStruct = structNew() />

	<cfloop collection="#arguments.structToTrim#" item="local.key">
		<cfif isSimpleValue(arguments.structToTrim[local.key])>
			<cfset arguments.structToTrim[local.key] = trim(arguments.structToTrim[local.key]) />
		</cfif>
	</cfloop>

	<cfreturn arguments.structToTrim />
</cffunction>

<cffunction name="sucessTest" access="public" returntype="any">
		<cfargument name="response" >
		
		<cfif arguments.response.ack IS NOT "Success">
			<!---Display human version of Set up express check out call response--->
			<h3>API CALL FAILURE</h3>
			<cfdump var="#arguments.response#" label="API Response" abort="false" top="3" />
			
			<cfif application.isErrorEmailsEnabled>
				
<cfmail from="error@fedttw.com" subject="FED TTW #application.environment# Error" to="error@fedttw.com,king@WeRWards.com" >
Error in PP api call
<cfloop collection="#arguments.response#" item="local.key" >
	#local.key# = #arguments.response[local.key]#, 
</cfloop>
</cfmail>
			</cfif>
			<cfabort />
		</cfif>
	
	</cffunction>
	
	<cffunction name="getFileContentDisplay" access="public" returntype="string">
		<cfargument name="theFileContent" >
	
		<cfset var fileContentStruct = transformFileContentToStruct(arguments.theFileContent.fileContent) />
		
		<cfsavecontent variable="local.content">
		<cfoutput>
			<cfloop collection="#fileContentStruct#" item="local.structKey">
				#local.structKey# = #urlDecode(local.fileContentStruct[local.structKey])#<br />
			</cfloop>
		</cfoutput>
		</cfsavecontent>
	
		<cfreturn local.content />
	</cffunction>
	
	<cffunction name="transformFileContentToStruct" access="public" returntype="struct">
		<cfargument name="theFileContent" >
		
		<cfset local.fileContentStruct = structNew() />
		<cfloop list="#arguments.theFileContent#" index="local.key" delimiters="&">
			<cfset structInsert(local.fileContentStruct,listFirst(local.key,"="),listLast(local.key,"=")) />
		</cfloop>
		
		<cfreturn local.fileContentStruct />
	</cffunction>



     <!---=============== utility methods --->


</cfcomponent>