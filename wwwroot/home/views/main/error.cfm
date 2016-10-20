<cfset rc.title = "An Error has Occurred" />

<cfif request.isShowDebugging>
	<cfdump var="#request.exception#" label="dump in main.error" abort="true"  />
<cfelse>
	<p class="lead">If this challenge continues, please let us know. <a href="mailto:help@fedttw.com">help@fedttw.com</a></p>
</cfif>