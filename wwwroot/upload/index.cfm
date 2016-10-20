<cfset rc.title = "Department Upload" />




<cfif !structIsEmpty(form)>
	<!---<cfdump var="#form#" label="cgi" abort="true"  />--->
	
	<cffile  
				action = "upload"
				destination = "#GetTempDirectory()#"
				fileField = "file1"
				accept = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
				nameConflict = "overwrite" 
				result = "local.upload"
				ContinueOnError = "false"
				Errors = "local.uploadErrors"
				strict="false">
			<!---<cfdump var="#local.upload#" label="cgi" abort="true"  />--->
			
			<cfset local.fullFilePath = local.upload.SERVERDIRECTORY & "\" & local.upload.SERVERFILE />
			<!---<cfdump var="#local.fullFilePath#" label="cgi" abort="false"  />--->
			<cfdump var="#local.fullFilePath#" label="cgi" abort="true"  />
	</cfif>
<cfoutput>
	
	<h2>Expectations</h2>
	
<!---<form id="formupload" action="#buildURL('datamanager:main.UploadDepartmentFile')#" method="post" enctype="multipart/form-data">

	<label for="file">File</label>
	<input type="file" name="file" accept="application/csv,text/csv,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
	
	<input type="submit" name="submit" value="Submit">
</form>--->
<cfinclude template="/common/views/main/inc_validation.cfm" />
<form action="" method="post"  enctype="multipart/form-data">
#application.securityutils.getCSRFTokenFormField(session,application)#
	<label for="file">File</label>
	<input type="file" name="file1" accept="application/csv,text/csv,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
	
	<input type="button" name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary"/>
<input type="submit"  class="btn btn-primary" name="submit" value="Submit">
</form>

</cfoutput>
