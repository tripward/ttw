<cfset rc.title = "Users" />
<cfoutput>
<!---<cfset local.bos = application.dm.getBranchOfServiceServices().getByPK('6576F65B-C129-3847-90E23C20DE349C30') />
<!---<cfdump var="#application.dm.getBranchOfServiceServices().getByPK('6576F65C-AD8C-C6F6-50DDCB5BB3FF4FD2')#" label="cgi" abort="true" top="3" />--->
<cfdump var="#application.UM.hasBranchofServicePermission(session.user,'ManageCriteriaSet',local.bos)#" label="cgi" abort="false" top="3" />--->



<!---<cfdump var="#rc.user.getBrachesOfServiceAsString()#" label="cgi" abort="false" top="3" />
<cfdump var="#rc.user.getBrachesOfServiceAsObjects()#" label="cgi" abort="false" top="3" />--->

<!---<cfdump var="#arguments.submitted.user.getRoles()#" label="cgi" abort="true" top="5" />--->
<!---		<cfloop array="#session.user.getRoles()#" index="local.myIdx" >

<div>#local.myIdx.GETnAME()#</div>
			<cfloop array="#local.myIdx.getBranchesOfService()#" index="local.mysecondIdx" >
				<div>#local.mysecondIdx.GETbranchofservice()#</div>



			</cfloop>


		</cfloop>
--->
<!---<cfdump var="#rc#" label="cgi" abort="true"  />--->
<cfinclude template="/common/views/main/inc_validation.cfm" />
<form action="#buildurl('accountManagement:main.persistUser')#" method="post">
	#application.securityutils.getCSRFTokenFormField(session,application)#
#rc.user.internalform()#

<input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary"/>
<input type="submit"  class="btn btn-primary" name="submit" value="Submit">
</form>


<!---<cfdump var="#rc.user#" label="cgi" abort="false" top="5" />
<cfdump var="#arguments#" label="cgi" abort="true"  />
<cfloop array="#rc.user.getRoles()#" index="local.rolDisplayIdx" >
	#local.rolDisplayIdx.getName()#
</cfloop>--->

<!---<cfdump var="#session.user.getRoles()#" label="cgi" abort="false" top="5" />--->

</cfoutput>
