<cfset rc.title = "User Management Examples" />
<!---Example of login call--->
<!---<cfdump var="#rc#" label="cgi" abort="true" top="3" />--->
<h3>Example of checking Role</h3>
<div>The call - <strong>application.um.hasRole(rc.user,'marineBranchAdmin')</strong></div>
<!---Example of has role call--->
<cfdump var="user hase role - #application.um.hasRole(rc.user,'marineBranchAdmin')#" label="cgi" abort="false" /><br />

<h3>Example of checking Permission</h3>
<div>The call - <strong>application.um.hasPerm(request.user,'editUsers')</strong></div>
<!---Example of has perm call--->
<cfdump var="user has permission - #application.um.hasPerm(rc.user,'editUsers')#" label="cgi" abort="false" /><br />

<h3>User Bean</h3>
<cfdump var="#rc.user#" label="user after login" abort="false" />

