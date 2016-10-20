<cfcomponent displayname="BaseBean" extends="common.baseObject"  hint="I am an org" output="false" persistent="false" accessors="true">

	<cfproperty name="validationResults" type="any" default="" />
	<!---<cfproperty name="beanfactory" />--->
	<!---<cfproperty name="myServicesName" type="string" default="" persistent="false" />--->

	<cfset variables.simpleValues = "string,numeric,boolean,date" />


	<!--- es end properties--->
	<cffunction name="init" access="public" output="false" returntype="any">

		<!---<cfset SUPER.init() />--->
		<cfset this.setbeanfactory(application['framework.one'].factory) />
		
		<cfset this.configure()>
		
		<!---<cfdump var="#this#" label="foooo" abort="true" top="3" />--->
		<!---<cfif len(this.getMyServicesName())>
			<cfdump var="#this.getbeanfactory()#" label="cgi" abort="true" top="3" />
			<cfset this.setMyServices(this.getbeanfactory(this.getmyServicesName())) />
		</cfif>--->

		<cfreturn THIS />
	</cffunction>

	<!--- es end properties--->
	<cffunction name="isValid" displayname="isValid" access="public" output="false" returntype="any">
		<cfreturn THIS.getValidationResults().isValid() />
	</cffunction>


	<cffunction name="validate" access="public" returntype="any" output="false">
		<cfargument name="valuesTobeValidated" type="struct" required="true" >

		<!---ATTENTION - you are setting directly on the bean you are in so there is no return, it just is--->
		<cfset THIS.populateFromStructWithValidation(arguments.valuesTobeValidated) />

	</cffunction>
	
	<!---<cffunction name="getBF" access="public" returntype="any" output="false">

		<cfreturn application['framework.one'].factory />
	</cffunction>--->
	
	<cffunction name="getMyServices" access="public" returntype="any" output="false">
		<!---<cfdump var="#application['framework.one'].factory#" label="rrttyy" abort="true" top="3" />--->
		<!---<cfreturn this.getBeanFactory().getBean(this.getmyServicesName()) />--->
		<cfreturn application['framework.one'].factory.getBean(this.getmyServicesName()) />
	</cffunction>
	
	<cffunction name="getBF" access="public" returntype="any" output="false">

		<cfreturn application['framework.one'].factory />
	</cffunction>
	
	<cffunction name="getService" access="public" returntype="any" output="false">
		<cfargument name="serviceName" required="true" default="" />
		<cfreturn getBF().getBean(arguments.serviceName) />
	</cffunction>
					
	<cffunction name="getActiveSelect" access="public" returntype="string" output="false">
		


		<cfsavecontent variable="local.content">
			<cfoutput>

				<select name="active" id="active">
					<option value="0" <cfif this.getActive() EQ 0>selected='selected'</cfif>>No</option>
					<option value="1" <cfif this.getActive() EQ 1>selected='selected'</cfif>>Yes</option>
				</select>
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getGovernmentTypeSelect" access="public" returntype="string" output="false">
		<cfargument name="selected" required="false" default="" type="any" />
		<cfset local.id = "" />
		<cfif !isSimpleValue(arguments.selected)>
			<cfloop array="#arguments.selected#" index="local.objIdx" >
				<cfset local.id = listAppend(local.id,local.objIdx.getID()) />
			</cfloop>
		<cfelse>
			<cfset local.id = arguments.selected />
		</cfif>
		<!---<cfdump var="#local.id#" label="cgi" abort="true" top="3" />--->

<!---<cfdump var="#this.getService('governmentTypeServices').get()#" label="cfgbfdgbgi" abort="true" top="3" />--->
		<cfsavecontent variable="local.content">
			<cfoutput>

				<select name="governmentTypeid" class="form-control" id="governmentTypeid" size="2" multiple="multiple">
					<cfloop array="#this.getService('governmentTypeServices').get()#" index="local.Idx" >
						<option value="#local.Idx.getGovernmentTypeid()#" <cfif listFindNoCase(local.id,local.Idx.getid())>selected='selected'</cfif>>#local.Idx.getName()#</option>
					</cfloop>
				</select>
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="appendValidationResults" access="public" returntype="string" output="false">
		<cfargument name="results" required="true" default="#structNew()#" type="struct" />
		
		<cfset local.combinedResults = validationServices.get() />
		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getDepartmentsSelect" access="public" returntype="string" output="false">
		<cfargument name="selected" required="false" default="" type="any" />
		
		<cfset local.id = "" />
		<cfif !isSimpleValue(arguments.selected)>
			<cfloop array="#arguments.selected#" index="local.objIdx" >
				<cfset local.id = listAppend(local.id,local.objIdx.getID()) />
			</cfloop>
		<cfelse>
			<cfset local.id = arguments.selected />
		</cfif>

<!---<cfdump var="#this.getService('governmentTypeServices').get()#" label="cfgbfdgbgi" abort="true" top="3" />--->
		<cfsavecontent variable="local.content">
			<cfoutput>

				<select name="Departmentid" class="form-control" id="Departmentid" size="5" multiple="multiple">
					<cfloop array="#this.getService('departmentsServices').get()#" index="local.Idx" >
						<option value="#local.Idx.getDepartmentid()#" <cfif listFindNoCase(local.id,local.Idx.getid())>selected='selected'</cfif>>#local.Idx.getName()#</option>
					</cfloop>
				</select>
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getDepartmentOrganizationsSelect" access="public" returntype="string" output="false">
		<cfargument name="selected" required="false" default="" type="any" />
		
		<cfset local.id = "" />
		<cfif !isSimpleValue(arguments.selected)>
			<cfloop array="#arguments.selected#" index="local.objIdx" >
				<cfset local.id = listAppend(local.id,local.objIdx.getID()) />
			</cfloop>
		<cfelse>
			<cfset local.id = arguments.selected />
		</cfif>
		
		<cfsavecontent variable="local.content">
			<cfoutput>

				<select name="DepartmentOrganizationid" class="form-control" id="DepartmentOrganizationid" size="14" multiple="multiple">
					<cfloop array="#this.getService('departmentOrganizationServices').get()#" index="local.Idx" >
						<option value="#local.Idx.getDepartmentOrganizationid()#" <cfif listFindNoCase(local.id,local.Idx.getid())>selected='selected'</cfif>>#local.Idx.getName()#</option>
					</cfloop>
				</select>
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getPeriodofPerformanceSelect" access="public" returntype="string" output="false">
		<cfargument name="selected" required="false" default="" type="any" />
		
		
		<cfsavecontent variable="local.content">
			<cfoutput>
				<input type="checkbox" name="PeriodofPerformance" value="FY16"<cfif listFind(arguments.selected,'FY16')> checked="checked"</cfif>/> FY16
				<input type="checkbox" name="PeriodofPerformance" value="FY15"<cfif listFind(arguments.selected,'FY15')> checked="checked"</cfif>/> FY15
				<input type="checkbox" name="PeriodofPerformance" value="FY14"<cfif listFind(arguments.selected,'FY14')> checked="checked"</cfif>/> FY14
				<input type="checkbox" name="PeriodofPerformance" value="FY13"<cfif listFind(arguments.selected,'FY13')> checked="checked"</cfif>/> FY13
				<input type="checkbox" name="PeriodofPerformance" value="FY12"<cfif listFind(arguments.selected,'FY12')> checked="checked"</cfif>/> FY12
				
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getPrimeContractorsSelect" access="public" returntype="string" output="false">
		<cfargument name="selected" required="false" default="" type="any" />
		
		<!---<cfif !isSimpleValue(arguments.selected)>
			<cfset local.id = arguments.selected.getDepartmentOrganizationid() />
		<cfelse>
			<cfset local.id = arguments.selected />
		</cfif>--->
		
		
		<cfsavecontent variable="local.content">
			<cfoutput>

				
					<cfloop array="#this.getService('ContractTypeServices').get()#" index="local.Idx" >
						<!---<cfdump var="#local.Idx#" label="cgi" abort="true" top="3" />--->
						<input type="radio" name="PrimeContractor" value="#local.Idx.ContractTypeid#" > #local.Idx.name#
						<!---<option value="#local.Idx.getDepartmentOrganizationid()#" <cfif local.id EQ local.Idx.getDepartmentOrganizationid()>selected='selected'</cfif>>#local.Idx.getName()#</option>--->
					</cfloop>
			
			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	
	<cffunction name="getSDBSelect" access="public" returntype="string" output="false">
		<cfargument name="selected" required="false" default="" type="any" />
		<!---<cfdump var="#arguments#" label="cgi" abort="true" top="3" />--->
		
		<cfset local.IDlist = "" />
		
		<cfif !isSimpleValue(arguments.selected) AND arrayLen(arguments.selected)>
			
			<cfloop array="#arguments.selected#" index="local.gotIdx">
				<cfset local.IDlist = listAppend(local.IDlist,local.gotIdx.getSDBTypeid()) />
			</cfloop> 
		
		<cfelse>
		
			<cfset local.types = arguments.selected />

		</cfif>
		
		
		<cfsavecontent variable="local.content">
			<cfoutput>

			<select name="SDBTypeid" class="form-control" id="SDBTypeid" multiple="multiple"  size="#(arraylen(this.getService('sdbTypeServices').get()))#">
				<cfloop array="#this.getService('sdbTypeServices').get()#" index="local.Idx" >
					<option value="#local.Idx.getSDBTypeid()#" <cfif listFindNoCase(local.IDlist,local.Idx.getSDBTypeid())>selected='selected'</cfif>>#local.Idx.getName()#</option>
				</cfloop>
			</select>

			</cfoutput>
		</cfsavecontent>

		<cfreturn Trim(local.content) />
	</cffunction>
	<cfscript>
		/**
 * Sorts an array of structures based on a key in the structures.
 * 
 * @param aofS 	 Array of structures. (Required)
 * @param key 	 Key to sort by. (Required)
 * @param sortOrder 	 Order to sort by, asc or desc. (Optional)
 * @param sortType 	 Text, textnocase, or numeric. (Optional)
 * @param delim 	 Delimiter used for temporary data storage. Must not exist in data. Defaults to a period. (Optional)
 * @return Returns a sorted array. 
 * @author Nathan Dintenfass (nathan@changemedia.com) 
 * @version 1, April 4, 2013 
 */
function arrayOfStructsSort(aOfS,key){
		//by default we'll use an ascending sort
		var sortOrder = "asc";		
		//by default, we'll use a textnocase sort
		var sortType = "textnocase";
		//by default, use ascii character 30 as the delim
		var delim = ".";
		//make an array to hold the sort stuff
		var sortArray = arraynew(1);
		//make an array to return
		var returnArray = arraynew(1);
		//grab the number of elements in the array (used in the loops)
		var count = arrayLen(aOfS);
		//make a variable to use in the loop
		var ii = 1;
		//if there is a 3rd argument, set the sortOrder
		if(arraylen(arguments) GT 2)
			sortOrder = arguments[3];
		//if there is a 4th argument, set the sortType
		if(arraylen(arguments) GT 3)
			sortType = arguments[4];
		//if there is a 5th argument, set the delim
		if(arraylen(arguments) GT 4)
			delim = arguments[5];
		//loop over the array of structs, building the sortArray
		for(ii = 1; ii lte count; ii = ii + 1)
			sortArray[ii] = aOfS[ii][key] & delim & ii;
		//now sort the array
		arraySort(sortArray,sortType,sortOrder);
		//now build the return array
		for(ii = 1; ii lte count; ii = ii + 1)
			returnArray[ii] = aOfS[listLast(sortArray[ii],delim)];
		//return the array
		return returnArray;
}

	</cfscript>

</cfcomponent>