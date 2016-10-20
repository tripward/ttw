<cfset rc.title = "Maintain Account" />
<!---<cfdump var="#rc.user#" label="rc1" abort="true" top="2"  />
<cfdump var="#session.user#" label="cgi1" abort="true"  top="2" />--->
<cfoutput>
<div class="col-md-6">
	
<!--- Display validation messages --->

<cfinclude template="/common/views/main/inc_validation.cfm" />
	<form action="#buildurl('profile:contracts.contractFormSubmit')#" method="post">
		#application.securityutils.getCSRFTokenFormField(session,application)#
		#rc.user.getProfile().getDisplay()#
		<cfif arrayLen(rc.user.getOrganization().getContracts())>
			<input type="submit" name="intent" value="Edit" class="btn btn-primary pull-left" />
		
			<!---<button name="login" type="submit" value="Login">Login</button>--->
			<input type="submit" name="intent" class="btn btn-primary pull-right" id="delbtn" value="Delete" onclick="return confirm('Are you sure you want to delete this item?');" />
		</cfif>

 	
<!---<button class='btn btn-danger btn-xs' type="submit" name="remove_levels" value="delete"><span class="fa fa-times"></span> delete</button></td>

--->

	</form>
</div>
	
	<!---<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h3 class="modal-title" id="myModalLabel">Warning!</h3>

                </div>
                <div class="modal-body">
                    <h4>Are you sure you want to DELETE?</h4>

                </div>
                <!--/modal-body-collapse -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" id="btnDelteYes" href="">Yes</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">No</button>
                </div>
                <!--/modal-footer-collapse -->
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
      </div>--->
	
<!---<form action ="##" method="POST">
<button class='btn btn-danger btn-xs' type="submit" name="remove_levels" value="delete"><span class="fa fa-times"></span> delete</button>
</form>

<div id="confirm" class="modal hide fade">
  <div class="modal-body">
    Are you sure?
  </div>
  <div class="modal-footer">
    <button type="button" data-dismiss="modal" class="btn btn-primary" id="delete">Delete</button>
    <button type="button" data-dismiss="modal" class="btn">Cancel</button>
  </div>
</div>--->
	

	

</cfoutput>