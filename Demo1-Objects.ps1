# In this example we are building a person object. Think of the properties of a physical person.
# Name, Height, HairColor...
# You set these by either using the Add-Members function or by adding the members during instantiation.
    $Jason = [pscustomobject]@{
        Name           = "Jason";
        Height         = 72;
        HairColor      = "Brown";
        CurrentSession = "PowerShell";
        IsPresenter    = $true;
        Company        = "NetApp";
        JobTitle       = "Professional Services Consultant"
    }

# With the object now created lets display the object and list the properties.
    $Jason
    $Jason.GetType()
    $Jason | Get-Member

# Even Properties have types. Notice that we didn't specify the types of these properties!
# Remember types can cause you problems if you let PowerShell decide for you. PowerShell = Adaptive Type System
# PowerShell is not strongly typed!
    $Jason.Name.GetType()
    $Jason.Name | Get-Member

    $Jason.Height.GetType()
    $Jason.Height
    $Jason.Height * 2
    $Jason.Height = '72'
    $Jason.Height.GetType()
    $Jason.Height * 2
    $Jason.Height = [int]'72'
    $Jason.Height = [int]'72a'
    $Jason.Height.GetType()

    $Jason.IsPresenter.GetType()

# Let's instantiate another person

    $Joseph = [pscustomobject]@{
        Name           = "Joseph"
        Height         = 69
        HairColor      = "Brown"
        CurrentSession = "PowerShell"
        IsPresenter    = $true
        Company        = "NetApp"
        JobTitle       = "Professional Services Engineer"
    }

    $Joseph

#
# These objects are nice by themselves but now these people are attending a great insight session. Lets put them together in an array.

# This command can be used to instantiate an array.
    $sessionAttendees = @()
    $sessionAttendees.gettype()

# Again everything is an object in PowerShell, so lets show the methods and properties of an array
    Get-Member -InputObject $sessionAttendees

# Now that we have an array let's add an object to it.
    $sessionAttendees += $Jason
    $sessionAttendees += $Joseph

# We can now see the two attendees of this session
    $sessionAttendees

# We now have an array of objects.
    $sessionAttendees.GetType()

# I can view the members of the objects by sending each object over the pipline and retrieving the members
    $sessionAttendees | Get-Member

# Notice that when I view the members of the sessionAttendees object that this is an array type and not a pscustomobject.
    Get-Member -InputObject $sessionAttendees

# I can now use the pipeline to filter the objects that I see on screen or that I send to the next command over the pipeline.
# This is done using the Where-Object function.
    $sessionAttendees | Where-Object { $_.Name -eq "Jason" }

# I can now put Jason into a difference variable and show the content.
    $JasonObj = $sessionAttendees | Where-Object { $_.Name -eq "Jason" }
    $JasonObj

# I can update a property of Jason and it will reflect back to the object in the array, as they are one in the same.
    $JasonObj.Company = "The Best Company... NETAPP"
    $JasonObj

    $sessionAttendees  | Where-Object { $_.Name -eq "Jason" }

    $JasonObj.Company = "NetApp"
    $JasonObj

#

#region Volume and properties

    Import-Module DataONTAP

    Connect-NcController -Name den-cdot

    ## Gather all volumes into the $vols variable
    $vols = Get-NcVol

    $vols

    ## Let's just look at one of them
    $vol = $vols | Select-Object -First 1

    $vol

    $vol | Get-Member

    $vol.VolumeStateAttributes

#endregion
