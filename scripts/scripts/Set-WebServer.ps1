Get-Website | Foreach-Object {
    $errorMode = (Get-WebConfiguration -Filter '/system.webServer/httpErrors' -PSPath "IIS:\sites\$($_.Name)").errorMode
  
    [PSCustomObject]@{
      "Site"  = $_.Name
      "ErrorMode" = $errorMode
      "Errors" = $(If(($errorMode -NE 'Custom') -And ($errorMode -NE 'DetailedLocalOnly') ){ $False } Else { $True })
    }
  }


  foreach ($site in $manager.Sites) {    
    # Set the site to automatically start when Windows is started    
    # Maps to applicationHost.config node: <sites> <site serverAutoStart="true">
    $site.ServerAutoStart = $true

    # Get a reference to the root site application using its path “/”. Maps to applicationHost.config node: <sites> <site name="My Site Name"> <application path="/">
    $siteRootApplication = $site.Applications["/"]

    # Sets <application path="/" preloadEnabled="true"> to make IIS simulate a request to your site when it's application pool starts up
    $siteRootApplication.SetAttributeValue("preloadEnabled", $true)

    # Sets <application path="/" serviceAutoStartEnabled="true"> to make IIS use the default Application Initialization warmup module.
    $siteRootApplication.SetAttributeValue("serviceAutoStartEnabled", $true)    

    # Get a reference to the associated application pool. Maps to applicationHost.config node: <applicationPools> <add name="My App Pool Name">
    $appPool = $manager.ApplicationPools[$siteRootApplication.ApplicationPoolName]

    # Sets <add name="My App Pool Name" autoStart="true"> to make the app pool start automatically when the server starts
    $appPool.AutoStart = $true

    # Sets <add name="My App Pool Name" startMode="AlwaysRunning"> to make the w3wp.exe worker process always running
    $appPool.StartMode = "AlwaysRunning"
}

# Need to commit changes for the applicationHost.config file to be updated
$manager.CommitChanges()