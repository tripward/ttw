<cfcomponent displayname="ValidationResults" extends="common.model.beans.BaseBean"  hint="I am an ValidationResultsType.cfc" output="false" persistent="false" accessors="true">

	<cfproperty name="nonLength" type="array" default="" />
	<cfproperty name="typeCheck" type="array" />
	<cfproperty name="custom" type="array" />
	<cfproperty name="isValid" type="boolean" default="TRUE" />

	<cfset variables.simpleValues = "string,numeric,boolean,date" />

	<!--- es end properties--->
	<cffunction name="init" access="public" output="false" returntype="any">

		<cfset SUPER.init() />
		<cfset this.configure()>

		<cfreturn THIS />
	</cffunction>

	<cffunction name="basicValidation" displayname="basicValidation" access="public" output="false" returntype="any">
		<cfargument name="object" type="any" required="true" >




		<cfreturn local.newValidationTypeBean />
	</cffunction>



	<cffunction name="requiredLen" displayname="getResponse" access="public" output="false" returntype="struct">

		<cfloop list="#this.getrequiredfields()#" index="local.fieldIdx">
			<cfset var theMethod = this["get" & local.fieldIdx] />

			<cfif !len(theMethod())>
				<cfset arrayAppend(getnonLength(),getPropertyStruct(local.fieldIdx)) />
			</cfif>

		</cfloop>

	</cffunction>


	<cffunction name="requiredType" displayname="getResponse" access="public" output="false" returntype="struct">
		<cfloop list="#this.getrequiredfields()#" index="local.fieldIdx">
			<cfset var theMethod = this["get" & local.fieldIdx] />

			<cfif !len(theMethod())>

			</cfif>

		</cfloop>
	</cffunction>


	<cffunction name="getPropertyStruct" displayname="getPropertyStruct" access="public" output="false" returntype="struct">
		<cfargument name="propToGet" type="string">

		<cfloop array="#collectAllProperties(getMetadata(THIS))#" index="local.theProp">
			<cfif local.theProp.name IS arguments.propToGet>
				<cfset local.theProperty = local.theProp />
				<cfbreak />
			</cfif>

		</cfloop>
		<cfreturn local.theProperty />
	</cffunction>


	<cffunction name="IsValid" displayname="getIsValid" access="public" output="false" returntype="boolean">

		<cfif ArrayLen(this.getnonLength())>
			<cfset this.setisValid(FALSE) />
		</cfif>

		<cfif ArrayLen(this.gettypeCheck())>
			<cfset this.setisValid(FALSE) />
		</cfif>

		<cfif ArrayLen(this.getCustom())>
			<cfset this.setisValid(FALSE) />
		</cfif>

		<cfreturn getIsValid() />
	</cffunction>
	
	<cffunction name="getHeaderDisplay" displayname="getResponse" access="public" output="false" returntype="string">

        <cfsavecontent variable="local.content" >
        	<cfoutput>
				<p><i class="fa fa-times-circle"></i> The information entered could not be processed. Please correct the following issues to continue:</p>
        	</cfoutput>
        </cfsavecontent>

		<cfreturn local.content />
	</cffunction>


	<cffunction name="getDisplay" displayname="getResponse" access="public" output="false" returntype="string">

        <cfsavecontent variable="local.content" >
        	<cfoutput>
				<div id="formMsg" class="error msg">
					
					<ul class="bulleted">

						<cfif arrayLen(this.getnonLength())>
			        		<cfloop array="#this.getnonLength()#" index="local.thenon">
			        			<cfif structKeyExists(local.thenon,"displayName") AND len(local.thenon.displayName)>
									<li>#local.thenon.displayName# is required.</li>
			        			<cfelse>
									<li>#local.thenon.name# is required.</li>
			        			</cfif>
			        		</cfloop>
						</cfif>

						<cfif arrayLen(this.gettypeCheck())>
			        		<cfloop array="#this.gettypeCheck()#" index="local.thetype">
			        			<cfif structKeyExists(local.thetype,"displayName") AND len(local.thetype.displayName)>
									<li>#local.thetype.displayName# is not #local.thetype.type#</li>
			        			<cfelse>
									<li>#local.thetype.name# is not #local.thetype.type#</li>
			        			</cfif>
			        		</cfloop>
		        		</cfif>

		        		<cfif arrayLen(this.getCustom())>
			        		<cfloop array="#this.getCustom()#" index="local.thecustom">
								<li>#local.thecustom#</li>
			        		</cfloop>
		        		</cfif>

					</ul>
				</div>



<!---
        		<h2>Validation Issue</h2>
				<cfif arrayLen(this.getnonLength())>
				<div style="color: red;">
					<h3>Required fields:</h3>
	        		<ul>
	        		<cfloop array="#this.getnonLength()#" index="local.thenon">
	        			<cfif structKeyExists(local.thenon,"displayName") AND len(local.thenon.displayName)>
							<li>#local.thenon.displayName#</li>
	        			<cfelse>
							<li>#local.thenon.name#</li>
	        			</cfif>
	        		</cfloop>
	        		</ul>
        		</div>
				</cfif>

				<cfif arrayLen(this.gettypeCheck())>
				<div style="color: red;">
	        		<h3>Type Check: </h3>
	        		<ul>
	        		<cfloop array="#this.gettypeCheck()#" index="local.thetype">

	        			<cfif structKeyExists(local.thetype,"displayName") AND len(local.thetype.displayName)>
							<li>#local.thetype.displayName# is not #local.thetype.type#</li>
	        			<cfelse>
							<li>#local.thetype.name# is not #local.thetype.type#</li>
	        			</cfif>

	        		</cfloop>
	        		</ul>
        		</div>
        		</cfif>

        		<cfif arrayLen(this.getCustom())>
				<div style="color: red;">
	        		<h3>Custom: </h3>
	        		<ul>
	        		<cfloop array="#this.getCustom()#" index="local.thecustom">
						<li>#local.thecustom#</li>
	        		</cfloop>
	        		</ul>
        		</div>
        		</cfif>

--->

        	</cfoutput>
        </cfsavecontent>

		<cfreturn local.content />
	</cffunction>
	
	<cffunction name="getRequiredLenElements" displayname="getRequiredLenElements" access="public" output="false" returntype="string">
        <cfsavecontent variable="local.content" >
        	<cfoutput>
				<cfif arrayLen(this.getnonLength())>
	        		<cfloop array="#this.getnonLength()#" index="local.thenon">
	        			<cfif structKeyExists(local.thenon,"displayName") AND len(local.thenon.displayName)>
							<li>#local.thenon.displayName# is required.</li>
	        			<cfelse>
							<li>#local.thenon.name# is required.</li>
	        			</cfif>
	        		</cfloop>
				</cfif>
        	</cfoutput>
        </cfsavecontent>

		<cfreturn local.content />
	</cffunction>
	
	<cffunction name="getRequiredTypeElements" displayname="getRequiredLenElements" access="public" output="false" returntype="string">
        <cfsavecontent variable="local.content" >
        	<cfoutput>
				<cfif arrayLen(this.gettypeCheck())>
	        		<cfloop array="#this.gettypeCheck()#" index="local.thetype">
	        			<cfif structKeyExists(local.thetype,"displayName") AND len(local.thetype.displayName)>
							<li>#local.thetype.displayName# is not #local.thetype.type#</li>
	        			<cfelse>
							<li>#local.thetype.name# is not #local.thetype.type#</li>
	        			</cfif>
	        		</cfloop>
        		</cfif>
        	</cfoutput>
        </cfsavecontent>

		<cfreturn local.content />
	</cffunction>
	
	<cffunction name="getCustomElements" displayname="getRequiredLenElements" access="public" output="false" returntype="string">
        <cfsavecontent variable="local.content" >
        	<cfoutput>
				<cfif arrayLen(this.getCustom())>
	        		<cfloop array="#this.getCustom()#" index="local.thecustom">
						<li>#local.thecustom#</li>
	        		</cfloop>
        		</cfif>
        	</cfoutput>
        </cfsavecontent>

		<cfreturn local.content />
	</cffunction>





</cfcomponent>