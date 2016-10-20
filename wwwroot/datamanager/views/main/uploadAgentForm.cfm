<cfset rc.title = "Agent Upload" />

<cfoutput>
	
	<h2>Expectations</h2>
	<ul>
		<li>The columns names can't have spaces in them - leave the exact words in place but just remove the spaces.</li>
	</ul>
	
<!---<form id="formupload" action="#buildURL('datamanager:main.UploadDepartmentFile')#" method="post" enctype="multipart/form-data">

	<label for="file">File</label>
	<input type="file" name="file" accept="application/csv,text/csv,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
	
	<input type="submit" name="submit" value="Submit">
</form>--->

<form action="#buildURL('datamanager:main.UploadAgentFile')#" method="post"  enctype="multipart/form-data">
#application.securityutils.getCSRFTokenFormField(session,application)#
	<label for="file">File</label>
	<input type="file" name="file1" accept="application/csv,text/csv,application/vnd.ms-excel,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
	
	<input type="button"  name="cancel" value="Cancel" onclick="javascript: window.history.back();" class="btn btn-primary"/>
<input type="submit"  class="btn btn-primary" name="submit" value="Submit">
</form>

</cfoutput>
