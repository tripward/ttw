SET basePath = "F:\workspace\cwig\cwig_mura_dev"




REM - just to make sure the plugings are always refreshed
REM del %basePath %\wwwroot\plugins\cfapplication.cfm
REM del %basePath %\wwwroot\plugins\mappings.cfm
REM - remove all compiled css stuff
del /Q /F %basePath %\wwwroot\CWIG\includes\themes\fresh\compiled\*.js
del /Q /F %basePath %\wwwroot\CWIG\includes\themes\fresh\compiled\*.css
del /s %basePath %\wwwroot\*.less.css
