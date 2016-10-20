<cfinclude template="../envSettings_Request.cfm" >

<!---usedin a number of places but mainly the publication.cfc to find files automagically--->
<cfset request.pubpdfAbsoluteRepoPath ="F:\workspace\cwig\cwigPubs\pubPDFs\" />
<cfset request.pubpdfRelativeRepoPath ="/pubPDFs/" />

<cfset request.isShowFullErrorDebugging = false />
<cfset request.isShowPubDebugging = false />
<cfset request.isShowRCDebugging = false />
<cfset request.isShowSecurityDebugging = TRUE />

<cfset request.isPubOrderingDown = FALSE />



<cfscript>
	/*Strong argument these should be in the app scope, These values will always be the same for a given
	 environemnt for the life of the application scope. for right this second going to stay in request for speed of dev*/
	/* ATTENTION/WARNING - if you change anything in request.google you have to add ?reloadapp */

	/* Google Variables - placed in this file to provide the most robost way to set up environement based */
	/* for full parameter reference -
	http://code.google.com/apis/searchappliance/documentation/610/xml_reference.html##request_parameters

	Most settings and description are common no matter the environment, so most settings are in commonSettings.cfm */

	/*Misc vars*/
	request.google.showDebugging = 1;

	/*URL Swapping - because we have lots of environments and we only have stage and prod collection we want to be able to run the search against any collection any time*/
	request.google.doURL_Swap = 1;
	/* needs to represnt the environment your in */
	request.google.url_Swap = "http://cwmura.loc/search/?";

	request.google.url_Returned = "https://googlesearch.icfwebservices.com/search?";
	/* used for pagination and sort */
	request.google.searchPage_url = "http://cwmura.loc/search/?";

	/* Google Variables - placed in this file to provide the most robost way to set up environement based */
	/* for full parameter reference -
	http://code.google.com/apis/searchappliance/documentation/610/xml_reference.html##request_parameters

	Most settings are common no matter the environment, so most settings are in commonSettings.cfm */

	request.Google.SearchServerBaseURI = "http://googlesearch.icfwebservices.com/search?";
	request.Google.access = "p";
	request.Google.site = "childwelfare_prod";
	request.Google.SearchCollection = "childwelfare_prod";
	request.Google.client = "childwelfare_prod";
	request.Google.SearchFrontEnd = "childwelfare_prod";
	request.google.output = "xml_no_dtd";
	request.google.ProxyStylesheet = "childwelfare_prod";/*childwelfare_stage*//* default_frontend */
	request.google.defaultSort = "date:D:L:d1";
	request.google.ud = 1;
	request.google.entqr = 3;
	request.google.start = 1;
	/* Maximum number of results to include in the search results per page. The maximum value of this parameter is 1000. */
	request.google.Num = 10;
	/* Number of KeyMatch results to return with the results. A value between 0 to 50 can be specified for this option. */
	request.google.numgm = 10;

	/* cbexpress Collection information */
	request.google.cbx_proxyStylesheet = "childwefare_CBExpress_AddOn";
	request.google.cbx_client = "childwefare_CBExpress_AddOn";
	request.google.cbx_site = "childwefare_CBExpress_AddOn";
	request.google.cbx_Num = 5;
	/* http://code.google.com/apis/searchappliance/documentation/612/xml_reference.html#request_filter_auto */
	request.google.cbx_filter = "p";
	request.google.ulang = "";
	request.google.oe = "UTF-8";
	request.google.ie = "UTF-8";
	request.google.sort = "date:D:L:d1";
	request.google.entqrm = 0;
	request.google.filter = 0;
	request.google.ip = "";
	/*These are fields that changed per request like te persons IP address or start record number. we use this to chack for hpp*/
	request.google.requestSpecificSettings = "start,num,ip,csrfToken";

	/*
	URL Swapping

	Documenting here so i can get my thoughts out, should be moved to a design doc

	Here's the deal, in various environments you'll be hitting a gsa collection. If
	it's the stage collection all the urls are for stage, and if your's hitting the
	production collection all the urls are for prod.

	If you're working locally or dev or you want stage site to use the prod collection
	you'll need to swap the base url' I wanted this configurable vs dynamic. Easier to
	read and much easier to set up different scenarios.

	The variable key:
	doURL_Swap - if your in stage and you want to use the urls as they come, don't do
	the swap. However in local/dev you'll want to swap for your local/dev path

	url_Returned - this is url the gsa collection will return. Example, if you
	 hitting the stage collection, all links will point to stage - because
	 this is common to all environments, the setting is actually in commonSettings.cfm


	google.url_Swap - the value to swap the rturned value for Example: if you
	local url is cw.loc you and your hitting the stage collection you want to swap
	stage.childwelfare.gov for cw.loc

	request.google.searchPage_url - for pagination, we need to swap all all the
	references to gsa

	*/


</cfscript>


