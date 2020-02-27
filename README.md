[![Build status](https://ci.appveyor.com/api/projects/status/8jquwox9xpatqb03?svg=true)](https://ci.appveyor.com/project/iainbrighton/xendesktop7)

# XenDesktop7

The XenDesktop7 PowerShell DSC resources can be used to deploy, configure and maintain a  Citrix
XenDesktop 7.x deployment.

__NOTE: Use of the XD7StoreFront* resources with PowerShell v5.0's `PsDscRunAsCredential` parameter
is not supported. This typically only affects the
[XenDesktop7Lab](https://github.com/virtualengine/XenDesktop7Lab) composite resources as the
XD7StoreFront* resources don't have a `Credential` parameter.__

__NOTE: The majority of the XD7StoreFront* resources use the newer StoreFront 3.6+ PowerShell module and not the legacy StoreFront 3.0 SDK.__

## Included Resources

* [XD7AccessPolicy](#xd7accesspolicy)
* [XD7Administrator](#xd7administrator)
* [XD7Catalog](#xd7catalog)
* [XD7CatalogMachine](#xd7catalogmachine)
* [XD7Controller](#xd7controller)
* [XD7Database](#xd7database)
* [XD7DesktopGroup](#xd7desktopgroup)
* [XD7DesktopGroupApplication](#xd7desktopgroupapplication)
* [XD7DesktopGroupMember](#xd7desktopgroupmember)
* [XD7EntitlementPolicy](#xd7entitlementpolicy)
* [XD7Feature](#xd7feature)
* [XD7Features](#xd7features)
* [XD7Role](#xd7role)
* [XD7Site](#xd7site)
* [XD7SiteConfig](#xd7siteconfig)
* [XD7SiteLicense](#xd7sitelicense)
* [XD7StoreFront](#xd7storefront)
* [XD7StoreFrontAccountSelfService](#xd7storefrontaccountselfservice)
* [XD7StoreFrontAuthenticationMethod](#xd7storefrontauthenticationmethod)
* [XD7StoreFrontAuthenticationService](#xd7storefrontauthenticationservice)
* [XD7StoreFrontAuthenticationServiceProtocol](#xd7storefrontauthenticationserviceprotocol)
* [XD7StoreFrontBaseUrl](#xd7storefrontbaseurl)
* [XD7StoreFrontExplicitCommonOptions](#xd7storefrontexplicitcommonoptions)
* [XD7StoreFrontFarmConfiguration](#xd7storefrontfarmconfiguration)
* [XD7StoreFrontFilterKeyword](#xd7storefrontfilterkeyword)
* [XD7StoreFrontOptimalGateway](#xd7storefrontoptimalgateway)
* [XD7StoreFrontPNA](#xd7storefrontpna)
* [XD7StoreFrontReceiverAuthenticationMethod](#xd7storefrontreceiverauthenticationmethod)
* [XD7StoreFrontRegisterStoreGateway](#xd7storefrontregisterstoregateway)
* [XD7StoreFrontRoamingBeacon](#xd7storefrontroamingbeacon)
* [XD7StoreFrontRoamingGateway](#xd7storefrontroaminggateway)
* [XD7StoreFrontSessionStateTimeout](#xd7storefrontsessionstatetimeout)
* [XD7StoreFrontStore](#xd7storefrontstore)
* [XD7StoreFrontStoreFarm](#xd7storefrontstorefarm)
* [XD7StoreFrontUnifiedExperience](#xd7storefrontunifiedexperience)
* [XD7StoreFrontWebReceiverCommunication](#xd7storefrontwebreceivercommunication)
* [XD7StoreFrontWebReceiverPluginAssistant](#xd7storefrontwebreceiverpluginassistant)
* [XD7StoreFrontWebReceiverResourcesService](#xd7storefrontwebreceiverresourcesservice)
* [XD7StoreFrontWebReceiverService](#xd7storefrontwebreceiverservice)
* [XD7StoreFrontWebReceiverSiteStyle](#xd7storefrontwebreceiversitestyle)
* [XD7StoreFrontWebReceiverUserInterface](#xd7storefrontwebreceiveruserinterface)
* [XD7VDAController](#xd7vdacontroller)
* [XD7VDAFeature](#xd7vdafeature)
* [XD7WaitForSite](#xd7waitforsite)

## XD7AccessPolicy

An access policy rule defines a set of connection filters and access control rights relating to a
desktop group.

### Syntax

```
XD7AccessPolicy [string]
{
    DeliveryGroup = [string]
    AccessType = [string] { AccessGateway | Direct }
    [ Enabled = [bool] ]
    [ AllowRestart = [bool] ]
    [ Name = [string] ]
    [ Description = [string] ]
    [ Protocol = [string[] ] { HDX | RDP }
    [ IncludeUsers = [string[]] ]
    [ ExcludeUsers = [string[]] ]
    [ Ensure = [string] { Present | Absent }]
    [ Credential = [PSCredential] ]
}
```

### Properties

* **DeliveryGroup**: The Citrix XenDesktop 7.x delivery group name to assign the access policy.
* **AccessType**: The access policy filter type.
* **Enabled**: Whether the access policy is enabled. If not specified, it defaults to True.
* **AllowRestart**: Whether users are permitted to restart desktop group machines. If not specified, it defaults to True.
* **Name**: Name of the access policy. If not specified, it defaults to `DesktopGroup_Direct` or `DesktopGroup_AG`.
* **Description**: Custom description assigned to the access policy rule.
* **Protocol**: Permitted protocols. If not specified, it defaults to both HDX and RDP.
* **IncludeUsers**: List of associated Active Directory user and groups assigned to the access policy.
* **ExcludeUsers**: List of associated Active Directory user and groups excluded from the access policy.
* **Ensure**: Whether the role is to be installed or not. Supported values are Present or Absent. If not specified, it defaults to Present.
* **Credential**: Specifies optional credential of a user which has permissions to access the source media and/or install/uninstall the specified role. __This property is required for Powershell 4.0.__

### Configuration

```
Configuration XD7AccessPolicyExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7AccessPolicy XD7AccessPolicyExample {
        DeliveryGroup = 'My Desktop Group'
        AccessType = 'AccessGateway'
        Enabled = $true
        AllowRestart = $true
        Protocol = 'HDX'
        IncludeUsers = @('DOMAIN\GroupA','DOMAIN\GroupB')
        Ensure = 'Present'
    }
}
```

## XD7Administrator

Registers an administrator in Citrix XenDesktop site. Administrators needs to be registered
before they can be assigned to a role.

### Syntax

```
XD7Administrator [string]
{
    Name = [string]
    Enabled = [bool]
    [ Ensure = [string] { Present | Absent } ]
    [ Credential = [PSCredential] ]
}
```

### Properties

* **Name**: Active Direcrtory user/group name to register in the site database.
* **Enabled**: Defines whether the user/group is enabled. If not specified, it defaults to True.
* **Ensure**: Whether the administrator is present or not. Supported values are Present or Absent. If not specified, it defaults to Present.
* **Credential**: Specifies optional credential of a user which has permissions to access the Citrix XenDesktop 7 site. __This property is required for Powershell 4.0.__

### Configuration

```
Configuration XD7AdministratorExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7Administrator XD7AdministratorExample {
        Name = 'Domain Admins'
        Enabled = $true
        Ensure = 'Present'
    }
}
```

## XD7Catalog

Creates a Citrix XenDesktop machine catalog.

### Syntax

```
XD7Catalog [string]
{
    Name = [string]
    Allocation = [string] { Permanent | Random | Static }
    Provisioning = [string] { Manual | PVS | MCS }
    Persistence = [string] { Discard | Local | PVD }
    [ Description = [string] ]
    [ IsMultiSession = [bool] ]
    [ PvsAddress = [string] ]
    [ PvsDomain = [string] ]
    [ Ensure = [string] { Present | Absent } ]
    [ Credential = [PSCredential] ]
}
```

### Properties

* **Name**: Name of the Citrix XenDesktop 7 machine catalog to create.
* **Description**: Description of the Citrix XenDesktop 7 machine catalog.
* **Allocation**: Machine catalog allocation type. Supported values are Permanent, Randam or Static.
* **Provisioning**: Machine catalog provisioning type. Supported values are Manual, PVS or MCS.
* **Persistence**: User settings persistence type. Supported values are Discard, Local or PVD.
* **IsMultiSession**: Flags the machine catalog supports multiple concurrent sessions on each machine.
* **PvsAddress**: Address of the PVS server. This option is only required if the provisioning type is set to PVS.
* **PvsDomain**: Domain of the PVS server. This option is only required if the provisioning type is set to PVS.
* **Ensure**: Whether the catalog is to be available or not. Supported values are Present or Absent. If not specified, it defaults to Present.
* **Credential**: Specifies optional credential of a user which has permissions to create the catalog. __This property is required for Powershell 4.0.__

### Configuration

```
Configuration XD7CatalogExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7Catalog XD7CatalogExample {
        Name = 'My Machine Catalog'
        Description = 'Random manual Citrix XenApp 7.6 machine catalog'
        Allocation = 'Random'
        Provisioning = 'Manual'
        Persistence = 'Local'
        IsMultisession = $true
    }
}
```

## XD7CatalogMachine

Adds/assigns an Active Directory machine to a Citrix XenDesktop 7 machine catalog.

### Syntax

```
XD7CatalogMachine [string]
{
    Name = [string]
    Members = [string[]] ]
    [ Ensure = [string] { Present | Absent } ]
    [ Credential = [PSCredential] ]
}
```

### Properties

* **Name**: Name of the Citrix XenDesktop 7 machine catalog to add the members to.
* **Members**: One or more Active Directory computers accounts to add to the machine catalog.
* **Ensure**: Whether the computer accounts should be present or not. Supported values are Present or Absent. If not specified, it defaults to Present.
* **Credential**: Specifies optional credential of a user which has permissions to machines to the catalog. __This property is required for Powershell 4.0.__

### Configuration

```
Configuration XD7CatalogMachineExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7CatalogMachine XD7CatalogMachineExample {
        Name = 'My Machine Catalog'
        Members = 'Domain\ComputerA','ComputerB'
        Ensure = 'Present'
    }
}
```

## XD7Controller

Adds or removes a Citrix XenDesktop 7 controller to or from a Citrix XenDesktop site.

### Syntax

```
XD7Controller [string]
{
    SiteName = [string]
    ExistingControllerName = [string]
    [ Ensure = [string] { Present | Absent } ]
    [ Credential = [PSCredential] ]
}
```

### Properties

* **SiteName**: Citrix XenDesktop 7 site name to join.
* **ExistingControllerName**: Existing Citrix XenDesktop 7 site controller used to join the site.
* **Ensure**: Whether the site controller should be present or not. Supported values are Present or Absent. If not specified, it defaults to Present.
* **Credential**: Specifies optional credential of a user which has permissions to add or remove the controller from the site. __This property is required for Powershell 4.0.__

### Configuration

```
Configuration XD7Controller {
    Import-DscResource -ModuleName XenDesktop7
    XD7Controller MyXD7Controller {
        SiteName = 'My Site'
        ExistingControllerName = 'controller-a.lab.local'
        Ensure = 'Present'
    }
}
```

## XD7Database

Creates a Citrix XenDesktop 7 site, logging or monitor database. This resource does not support
removing or relocation of site databases.

### Syntax

```
XD7Database [string]
{
    SiteName = [string]
    DatabaseName = [string]
    DatabaseServer = [string]
    DataStore = [string] { Site | Logging | Monitor }
    [ Credential = [PSCredential] ]
}
```

### Properties

* **SiteName**: Citrix XenDesktop 7 site name assigned to the database.
* **DatabaseName**: Name of the Microsoft SQL database to create.
* **DatabaseServer**: FQDN of the Microsoft SQL server to host the database.
* **DataStore**: Citrix XenDesktop site database type to create.
* **Credential**: Specifies optional credential of a user which has permissions to create the database. __This property is required for Powershell 4.0.__

### Configuration

```
Configuration XD7Database {
    Import-DscResource -ModuleName XenDesktop7
    XD7Database MyXD7LoggingDatabase {
        SiteName = 'My Site'
        DatabaseName = 'MySiteLoggingDatabase'
        DatabaseServer = 'mysqlserver.lab.local'
        DataStore = 'Logging'
    }
}
```

## XD7DesktopGroup

Creates a Citrix XenDesktop 7 desktop group.

### Syntax

```
XD7DesktopGroup [string]
{
    Name = [string]
    IsMultiSession = [bool]
    DeliveryType = [string] { AppsOnly | DesktopsOnly | DesktopsAndApps }
    DesktopType = [string] { Shared | Private }
    [ Description = [string]
    [ DisplayName = [string] ]
    [ Enabled = [bool] ]
    [ ColorDepth = [string] { FourBit | EightBit | SixteenBit | TwentyFourBit } ]
    [ IsMaintenanceMode = [bool] ]
    [ IsRemotePC = [bool] ]
    [ IsSecureIca = [bool] ]
    [ ShutdownDesktopsAfterUse = [bool] ]
    [ TurnOnAddedMachine = [bool] ]
    [ Ensure = [string] { Present | Absent } ]
    [ Credential = [PSCredential] ]
}
```

### Properties

* **Name**: Name of the Citrix XenDesktop 7 desktop group.
* **IsMultiSession**: Flags whether the desktop group supports multisession hosts.
* **DeliveryType**: Delivery type of the desktop group. Supported values are AppsOnlys, DesktopsOnly or DesktopsAndApps.
* **DesktopType**: Desktop allocation type. Supported values are Shared and Private.
* **Description**: Description of the desktop group.
* **DisplayName**: Display name of the desktop group.
* **Enabled**: Whether the desktop group is enabled. If not specified, this value defaults to True.
* **ColorDepth**: Color depth of the desktop group. Supported values are FourBit, EightBit, SixteenBit and TwentyFourBit. If not specified, a default value of TwentyFour bit is used.
* **IsMaintenanceMode**: Flags whether the desktop group is in maintenance mode. If not specified, this value defaults to False.
* **IsRemotePC**: Flags whether the desktop group is a RemotePC desktop group. If not specified, this value defaults to False.
* **IsSecureIca**: Flags whether Secure ICA is enabled/enforced.  If not specified, this value defaults to True.
* **ShutdownDesktopsAfterUse**: Flags whether virtual desktops are powered off after use.  If not specified, this value defaults to False.
* **TurnOnAddedMachine**: Flags whether machines added to the desktop group are automatically powered on.  If not specified, this value defaults to False.
* **Ensure**: Specifies whether the desktop group is present or not. If not specified, this value defaults to Present.
* **Credential**: Specifies optional credential of a user which has permissions to create the desktop group. __This property is required for Powershell 4.0.__

### Configuration

```
Configuration XD7DesktopGroupExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7DesktopGroup MyXD7DesktopGroup {
        SiteName = 'My Desktop Group'
        IsMultiSession = $true
        DeliveryType = 'DesktopsAndApps'
        DesktopType = 'Shared'
    }
}
```

## XD7DesktopGroupMember

Adds or removes Active Directory computer accounts to or from a Citrix XenDesktop 7 desktop group.

### Syntax

```
XD7DesktopGroupMember [string]
{
    Name = [string]
    Members = [string[]] ]
    [ Ensure = [string] { Present | Absent } ]
    [ Credential = [PSCredential] ]
}
```

### Properties

* **Name**: Name of the desktop group to allocate members to.
* **Members**: Active Directory computer account names to assign to the desktop group.
* **Ensure**: Specifies whether the specified Active Directory computer accounts are present in the desktop group or not. If not specified, this value defaults to Present.
* **Credential**: Specifies optional credential of a user which has permissions to modify the desktop group. __This property is required for Powershell 4.0.__

### Configuration

```
Configuration XD7DesktopGroupMemberExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7DesktopGroupMember MyXD7DesktopGroupMembers {
        Name = 'My Desktop Group'
        Members = 'computer1.lab.local','computer2.lab.local'
        Ensure = 'Present'
    }
}
```

## XD7DesktopGroupApplication

Adds or removes published applications to or from a Citrix XenDesktop 7 desktop/delivery group.

### Syntax

```
XD7DesktopGroupApplication [string]
{
    Name = [string]
    DesktopGroupName = [string]
    Path = [string]
    [ ApplicationType = [string] { HostedOnDesktop, InstalledOnClient } ]
    [ WorkingDirectory = [string] ]
    [ Arguments = [string] ]
    [ Description = [string] ]
    [ DisplayName = [string] ]
    [ Enabled = [bool] ]
    [ Visible = [bool] ]
    [ Ensure = [string] ] { Present | Absent } ]
    [ Credential = [PSCredential] ]
}
```

### Properties

* **Name**: Name of the desktop application to publish.
* **DesktopGroupName**: Name of the desktop/delivery group to publish the application.
* **Path**: Path to the application executable.
* **ApplicationType**: Specifies the type of application.
  * If not specified, this value defaults to HostedOnDesktop (published).
  * __NOTE: It is not possible to change the application type after it's created.__
* **WorkingDirectory**: Working directory of the application.
* **Arguments**: Command line arguments of the application.
* **Description**: Application description.
* **DisplayName**: Name of the application displayed to the user.
* **Enabled**: Specifies whether the application is enabled.
  * If not specifed, this value defaults to $true.
* **Visible**: Specifies whether the application is visible to the user.
  * If not specifed, this value defaults to $true.
* **Ensure**: Specifies whether the specified application is published in the desktop delivery group or not.
  * If not specified, this value defaults to Present.
* **Credential**: Specifies optional credential of a user which has permissions to modify the desktop group. __This property is required for Powershell 4.0.__

### Configuration

```
Configuration XD7DesktopGroupApplicationExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7DesktopGroupApplication XD7DesktopGroupApplicationExample {
        Name = 'Adobe Reader DC'
        DesktopGroupName = 'My Desktop Group'
        Path = 'C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe'
        WorkingDirectory = 'C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader'
        Ensure = 'Present'
    }
}
```

## XD7EntitlementPolicy

Grants Active Directory users/groups access to a Citrix XenDesktop 7 desktop group.

### Syntax

```
XD7EntitlementPolicy [string]
{
    DeliveryGroup = [string]
    EntitlementType = [string] EntitlementType { Desktop | Application }
    [ Enabled = [bool] ]
    [ Name = [string] ]
    [ Description = [string] ]
    [ IncludeUsers = [string[]] ]
    [ ExcludeUsers = [string[]] ]
    [ Ensure = [string] { Present | Absent } ]
    [ Credential = [PSCredential] ]
}
```

### Properties

* **DeliveryGroup**: The name of the delivery group to include and/or exclude users to.
* **EntitlementType**: Whether the entitlement is applies to a desktop or an application.
* **Enabled**: Flags whether the entitlement is enabled. If not specified, this value defaults to True.
* **Name**: Name of entitlement. If not specified, it defaults to `DeliveryGroup_EntitlementType`.
* **Description**: Optional description of the entitlement.
* **IncludeUser**: Users(s) explicitly included in the entitlement.
* **ExcludeUser**: User(s) explicitly excluded from the entitlement.
* **Ensure**: Whether the entitlement policy is present or not. If not specified, this value defaults to True.
* **Credential**: Specifies optional credential of a user which has permissions to create the entitlement. __This property is required for Powershell 4.0.__

### Configuration

```
Configuration XD7EntitlementPolicyExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7EntitlementPolicy XD7DesktopEntitlementPolicy {
        Name = 'My Desktop Group'
        EntitlementType = 'Desktop'
        IncludeUsers = 'MyDesktopGroupUsers','UserA'
    }
}
```

## XD7Feature

Installs Citrix XenDesktop 7 server role/feature.

### Syntax

```
XD7Feature [string]
{
    Role = [string] { Controller | Licensing | Storefront | Studio | Director }
    SourcePath = [string]
    [Ensure = [string] { Present | Absent } ]
    [ Credential = [PSCredential] ]
}
```

### Properties

* **Role**: The Citrix XenDesktop 7.x role/feature to install.
* **SourcePath**: Location of the extracted Citrix XenDesktop 7.x setup media.
* **Ensure**: Whether the role is to be installed or not. Supported values are Present or Absent. If not specified, it defaults to Present.
* **Credential**: Specifies optional credential of a user which has permissions to access the source media and/or install/uninstall the specified role.

### Configuration

```
Configuration XD7FeatureExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7Feature XD7ControllerFeature {
        Role = 'Controller'
        SourcePath = 'C:\Sources\XenDesktop76'
        Ensure = 'Present'
    }
}
```

## XD7Features

Installs multiple Citrix XenDesktop 7 server roles/features in a single pass, reducing the number of reboots.

### Syntax

```
XD7Features [string]
{
    IsSingleInstance = [string] { Yes }
    Role = [string[] { Controller | Licensing | Storefront | Studio | Director }
    SourcePath = [string]
    [ Ensure = [string] { Present | Absent } ]
    [ Credential = [PSCredential] ]
}
```

### Properties

* **Role**: The Citrix XenDesktop 7.x roles/features to install.
* **SourcePath**: Location of the extracted Citrix XenDesktop 7.x setup media.
* **Ensure**: Whether the role is to be installed or not. Supported values are Present or Absent. If not specified, it defaults to Present.
* **Credential**: Specifies optional credential of a user which has permissions to access the source media and/or install/uninstall the specified role.

### Configuration

```
Configuration XD7FeaturesExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7Features XD7MultiFeatures {
        IsSingleInstance = 'Yes'
        Role = 'Controller','Studio'
        SourcePath = 'C:\Sources\XenDesktop76'
        Ensure = 'Present'
    }
}
```

## XD7Role

Assigns a Citrix XenDesktop 7 delegated security role to an administrator. This resource
does not currently support creating new Citrix XenDesktop 7 roles.

### Syntax

```
XD7Role [string]
{
    Name = [string]
    Members = string[]
    RoleScope = [string]
    [ Ensure = [string] { Present | Absent } ]
    [ Credential = [PSCredential] ]
}
```

### Properties

* **Name**: Name of an existing Citrix XenDesktop 7 role to assign or unassign an administrator to/from.
* **Members**: Name(s) of the Citrix XenDesktop 7 administrator(s) to assign or unassign.
* **RoleScope**: Name of an existing Citrix XenDesktop 7 scope to apply to the assignment. If not specified, the value defaults to All.
* **Ensure**: Whether the role member(s) should be assigned to the role or note. If not specified, this value defaults to Present.
* **Credential**: Specifies optional credential of a user which has permissions to update the role membership. __This property is required for Powershell 4.0.__

### Configuration

```
Configuration XD7RoleExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7Role XD7RoleAssignment {
        Name = 'Full Administrator'
        Members = 'Citrix Admins'
        EntitlementType = 'Desktop'
        IncludeUsers = 'MyDesktopGroupUsers','UserA'
    }
}
```

## XD7Site

Creates a new Citrix XenDesktop 7 site.

### Syntax

```
XD7Site [string]
{
    SiteName = [string]
    DatabaseServer = [string]
    SiteDatabaseName = [string]
    LoggingDatabaseName = [string]
    MonitorDatabaseName = [string]
    [ Credential = [PSCredential] ]
}
```

### Properties

* **SiteName**: Name of the new Citrix XenDesktop 7 site.
* **DatabaseServer**: Name of the MS SQL server hosting the Citrix XenDesktop 7 site databases.
* **SiteDatabaseName**: Name of the existing Citrix XenDesktop 7 site database.
* **LoggingDatabaseName**: Name of the existing Citrix XenDesktop 7 logging database.
* **MonitorDatabaseName**: Name of the existing Citrix XenDesktop 7 monitor database.
* **Credential**: Specifies optional credential of a user which has permissions to create the site and access the MS SQL databases. __This property is required for Powershell 4.0.__

### Configuration

```
Configuration XD7SiteExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7Site XD7SiteCreation {
        SiteName = 'My Site'
        DatabaseServer = 'mysqlserver.lab.local'
        SiteDatabaseName = 'MySiteDatabase'
        LoggingDatabaseName = 'MyLoggingDatabase'
        MonitorDatabaseName = 'MyMonitorDatabase'
    }
}
```

## XD7SiteConfig

Configures a Citrix XenDesktop 7 global site settings.

### Syntax

```
XD7SiteConfig [string]
{
    IsSingleInstance = [string] { Yes }
    [ TrustRequestsSentToTheXmlServicePort = [bool] ]
    [ SecureIcaRequired = [bool] ]
    [ DnsResolutionEnabled = [bool] ]
    [ ConnectionLeasingEnabled = [bool] ]
    [ BaseOU = [string] ]
    [ Credential = [PSCredential] ]
}
```

### Properties

* **TrustRequestsSentToTheXmlServicePort**: The XML Service trust settings.
* **SecureIcaRequired**: The default SecureICA usage requirements for new desktop groups.
* **DnsResolutionEnabled**: The setting to configure whether numeric IP address or the DNS name to be present in the ICA file.
* **ConnectionLeasingEnabled**: The objectGUID property identifying the base OU in Active Directory used for desktop registrations.
* **BaseOU**: The indicator for connection leasing active.
* **Credential**: Specifies optional credential of a user which has permissions to create the site and access the MS SQL databases. __This property is required for Powershell 4.0.__

### Configuration

```
Configuration XD7SiteConfigExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7SiteConfig XD7GlobalSiteSetting {
        IsSingleInstance = 'Yes'
        TrustRequestsSentToTheXmlServicePort = $true
        ConnectionLeasingEnabled = $true
    }
}
```

## XD7SiteLicense

Configures a Citrix XenDesktop 7 licensing scheme.

### Syntax

```
XD7SiteLicense [string]
{
    LicenseServer = [string] ]
    [ LicenseServerPort = [uint16] ]
    [ LicenseProduct [string] { XDT | MPS } ]
    [ LicenseEdition [string] { PLT | ENT | VDI } ]
    [ LicenseModel = [string] { UserDevice | Concurrent } ]
    [ TrustLicenseServerCertificate = [bool] ]
    [ Credential = [PSCredential] ]
}
```

### Properties

* **LicenseServer**: Name of the exisiting Citrix license server.
* **LicenseServerPort**: Port number of the existing Citrix license server. If not specified, the value defaults to 27000.
* **LicenseProduct**: Citrix XenDesktop 7 site licensed product to apply, e.g XenDesktop or XenApp. Valid values are XDT or MPS. If not specified, a default value of XDT is used.
* **LicenseEdition**: Citrix XenDesktop 7 site licensed edition to apply. Valid values are PLT, ENT or VDI. If not specified, a default value of PLT is used.
* **LicenseModel**: Citrix XenDesktop 7 site license model to apply. Valid values are UserDevice or Concurrent. If not specified, a default value of UserDevice is used.
* **TrustLicenseServerCertificate**: Flags whether the Citrix license server certificate should be trusted. If not specified, this value defaults to True.
* **Credential**: Specifies optional credential of a user which has permissions to update the site licensing. __This property is required for Powershell 4.0.__

### Configuration

```
Configuration XD7SiteLicenseExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7SiteLicense XD7SiteLicensing {
        LicenseServer = 'citrixls.lab.local'
    }
}
```

## XD7StoreFront

Creates or updates a StoreFront deployment with the required features installed and configured

### Syntax

```
XD7StoreFront [string]
{
    SiteId = [UInt64]
    [ HostBaseUrl = [String] ]
    [ Ensure = [String] { Present | Absent } ]
}
```

### Properties

* **SiteId**: Citrix Storefront IIS site id.
* **HostBaseUrl**: Citrix StoreFront host base url.
  * If not specified, this value defaults to http://localhost.
* **Ensure**: Whether the Storefront deployment should be added or removed.

### Configuration

```
Configuration XD7StoreFrontExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFront XD7StoreFrontExample {
        SiteId = 1
        HostBaseUrl = 'http://localhost/'
        Ensure = 'Present'
    }
}
```
## XD7StoreFrontAccountSelfService

Sets StoreFront account self-service options.

### Syntax

```
XD7StoreFrontAccountSelfService [string]
{
    StoreName = [String]
    [ AllowResetPassword = [Boolean] ]
    [ AllowUnlockAccount = [Boolean] ]
    [ PasswordManagerServiceUrl = [String] ]
}
```

### Properties

* **StoreName**: StoreFront store name.
* **AllowResetPassword**: Allow self-service reset password.
* **AllowUnlockAccount**: Allow self-service account unlock.
* **PasswordManagerServiceUrl**: The Url of the password manager account self-service service. This must end with a /. Set to $null to remove.


### Configuration

```
Configuration XD7Example {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontAccountSelfService XD7StoreFrontAccountSelfServiceExample {
        StoreName = 'mock'
        AllowResetPassword = $true
        AllowUnlockAccount = $true
        PasswordManagerServiceUrl = 'http://WebServer/url/'
    }
```

## XD7StoreFrontAuthenticationMethod

Configures the available authentication providers of a Citrix StoreFront 2.x or 3.x server.

### Syntax

```
XD7StoreFrontAuthenticationMethod [string]
{
    VirtualPath = [string]
    AuthenticationMethod = [string[] ] { Certificate | CitrixAGBasic | CitrixFederation | ExplicitForms | HttpBasic | IntegratedWindows }
    [ SiteId = [uint16] ]
    [ Ensure = [string] { Absent | Present } ]
}
```

### Properties

* **VirtualPath**: The Citrix Storefront IIS authentication service virtual path.
* **AuthenticationMethod**: Authentication methods to be installed. Existing authentication methods will not be removed.
* **SiteId**: The Citrix Storefront IIS authentication service site id.
  * If not specified, the value defaults to 1.
* **Ensure**: Whether the Storefront authentication service method should be added or removed.

### Configuration

```
Configuration XD7StoreFrontAuthenticationMethodExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontAuthenticationMethod XD7StoreFrontAuthenticationMethods {
        VirtualPath = '/Citrix/Authentication'
        SiteId = 1
        AuthenticationMethod = 'WindowsIntegrated'
        Ensure = 'Present'
    }
}
```

## XD7StoreFrontAuthenticationService

Add or Remove a new Authentication service for Store and Receiver for Web authentication

### Syntax

```
XD7StoreFrontAuthenticationService [string]
{
    VirtualPath = [String]
    [ FriendlyName = [String] ]
    [ SiteId = [UInt64] ]
    [ Ensure = [String] { Present | Absent } ]
}
```

### Properties

* **VirtualPath**: The IIS virtual path to use for the service.
* **FriendlyName**: The friendly name the service should be known as.
* **SiteId**: Citrix Storefront IIS site id to configure the Authentication service for.
* **Ensure**: Ensure.  If not specified, this value defaults to Present.

### Configuration

```
Configuration XD7Example {
    Import-DSCResource -ModuleName XenDesktop7 {
    XD7StoreFrontAuthenticationService XD7StoreFrontAuthenticationServiceExample {
        VirtualPath = '/Citrix/mockweb'
        FriendlyName = 'mockauth'
        SiteId = 1
    }
}
```

## XD7StoreFrontAuthenticationServiceProtocol

Enables or disables StoreFront authentication service protocol(s).

**NOTE: this is a replacement for the `XD7StoreFrontAuthenticationMethod` resource implemented using the new StoreFront 3.x PowerShell cmdlets.**

### Syntax

```
XD7StoreFrontAuthenticationServiceProtocol [string]
{
    VirtualPath = [String]
    AuthenticationProtocol = [String[]]
    [ SiteId = [Uint64] ]
    [ Ensure = [String] { Present | Absent } ]
}
```

### Properties

* **VirtualPath**: Citrix Storefront Authentication Service IIS virtual path.
* **AuthenticationProtocol**: Citrix Storefront Authentication protocols to enable or disable.
* **SiteId**: Citrix Storefront Authentication Service IIS Site Id.
  * If not specified, this value defaults to 1.
* **Ensure**: Specifies whether to enable or disable the authentication protocol(s).
  * If not specified, this value defaults to 'Present'.

### Configuration

```
Configuration XD7Example {
    Import-DSCResource -ModuleName XenDesktop7 {
    XD7StoreFrontAuthenticationServiceProtocol AuthenticationServiceProtocolExample {
       VirtualPath = '/Citrix/Authentication'
       AuthenticationProtocol= 'ExplicitForms','IntegratedWindows','CitrixAGBasic'
       Ensure = 'Present'
    }
}
```

## XD7StoreFrontBaseUrl

Configures the base URL of a Citrix StoreFront 2.x or 3.x server.

### Syntax

```
XD7StoreFrontBaseUrl [string]
{
    BaseUrl = [string]
}
```

### Properties

* **BaseUrl**: Base URL to assign to the StoreFront server/group, e.g. https://storefront.lab.local/

### Configuration

```
Configuration XD7StoreFrontBaseUrlExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontBaseUrl 'storefront_lab_local' {
        BaseUrl = 'https://storefront.lab.local/'
    }
}
```

## XD7StoreFrontExplicitCommonOptions

Set the ExplicitCommon Authentication service protocol options.

### Syntax

```
XD7StoreFrontExplicitCommonOptions [string]
{
    StoreName = [String]
    [ Domains = [String[]] ]
    [ DefaultDomain = [String] ]
    [ HideDomainField = [Boolean] ]
    [ AllowUserPasswordChange = [String] { Always | ExpiredOnly | Never } ]
    [ ShowPasswordExpiryWarning = [String] { Custom | Never | Windows } ]
    [ PasswordExpiryWarningPeriod = [Uint32] ]
    [ AllowZeroLengthPassword = [Boolean] ]
}
```

### Properties

* **StoreName**: StoreFront store name.
* **Domains**: List of trusted domains.
* **DefaultDomain**: The default domain to use when omitted during login.
* **HideDomainField**: Hide the domain field on the login form.
* **AllowUserPasswordChange**: Configure when a user can change a password.
* **ShowPasswordExpiryWarning**: Show the password expiry warning to the user.
* **PasswordExpiryWarningPeriod**: The period of time in days before the expiry warning should be shown.
* **AllowZeroLengthPassword**: Allow a zero length password.

### Configuration

```
Configuration XD7StoreFrontExplicitCommonOptionsExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontExplicitCommonOptions XD7StoreFrontExplicitCommonOptionsExample {
        StoreName = 'mock'
        Domains = 'ipdev'
        DefaultDomain = 'ipdev'
        AllowUserPasswordChange = 'Always'
    }
}
```

## XD7StoreFrontFarmConfiguration

Sets the StoreFront farm configuration settings.

### Syntax

```
XD7StoreFrontFarmConfiguration [string]
{
    StoreName = [String]
    [ EnableFileTypeAssociation = [Boolean] ]
    [ CommunicationTimeout = [String] ]
    [ ConnectionTimeout = [String] ]
    [ LeasingStatusExpiryFailed = [String] ]
    [ LeasingStatusExpiryLeasing = [String] ]
    [ LeasingStatusExpiryPending = [String] ]
    [ PooledSockets = [Boolean] ]
    [ ServerCommunicationAttempts = [UInt32] ]
    [ BackgroundHealthCheckPollingPeriod = [String] ]
    [ AdvancedHealthCheck = [Boolean] ]
}
```

### Properties

* **StoreName**: StoreFront store name.
* **EnableFileTypeAssociation**: Enable file type association.
* **CommunicationTimeout**: Communication timeout when using to the Xml service in seconds.
* **ConnectionTimeout**: Connection timeout when connecting to the Xml service in seconds.
* **LeasingStatusExpiryFailed**: Period of time before retrying a XenDesktop 7 and greater farm in failed leasing mode in seconds.
* **LeasingStatusExpiryLeasing**: Period of time before retrying a XenDesktop 7 and greater farm in leasing mode in seconds.
* **LeasingStatusExpiryPending**: Period of time before retrying a XenDesktop 7 and greater farm pending leasing mode in seconds.
* **PooledSockets**: Use pooled sockets.
* **ServerCommunicationAttempts**: Number of server connection attempts before failing.
* **BackgroundHealthCheckPollingPeriod**: Period of time between polling XenApp or XenDesktop server health in seconds.
* **AdvancedHealthCheck**: Indicates whether an advanced health-check should be performed.

### Configuration

```
Configuration XD7Example {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontFarmConfiguration XD7StoreFrontFarmConfigurationExample {
        StoreName = 'mock'
        PooledSockets = $true
    }
}

```

## XD7StoreFrontFilterKeyword

Sets up enumeration filtering basing on resource keywords.

### Syntax

```
XD7StoreFrontFilterKeyword [string]
{
    StoreName = [String]
    [ IncludeKeywords = [String[]] ]
    [ ExcludeKeywords = [String[]] ]
}
```

### Properties

* **StoreName**: StoreFront store name.
* **IncludeKeywords**: Whitelist filtering. Only resources having one of the keywords specified are enumerated.
* **ExcludeKeywords**: Blacklist filtering. Only resources not having any of the keywords specified are enumerated.

    **Note: the filtering can be either by white- or blacklist, not both at the same time.**

### Configuration

```
Configuration XD7Example {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontFilterKeyword XD7StoreFrontFilterKeywordExample {
        StoreName = 'mock'
        IncludeKeywords = @('mock','support')
    }
}
```

## XD7StoreFrontOptimalGateway

Set the farms and the optimal gateway to use for launch.

### Syntax

```
XD7StoreFrontOptimalGateway [string]
{
    GatewayName = [String]
    ResourcesVirtualPath = [String]
    Hostnames = [String[]]
    StaUrls = [String[]]
    [ Farms = [String[]] ]
    [ SiteId = [UInt64] ]
    [ StasUseLoadBalancing = [Boolean] ]
    [ StasBypassDuration = [String] ]
    [ EnableSessionReliability = [Boolean] ]
    [ UseTwoTickets = [Boolean] ]
    [ Zones = [String[]] ]
    [ EnabledOnDirectAccess = [Boolean] ]
    [ Ensure = [String] { Present | Absent } ]
}
```

### Properties

* **GatewayName**: StoreFront gateway name.
* **SiteId**: Site Id.
  * If not specified, this value defaults to 1.
* **ResourcesVirtualPath**: Resources Virtual Path.
* **Hostnames[]**: Hostnames.
* **StaUrls[]**: Secure Ticket Authority server Urls.
* **StasUseLoadBalancing**: Load balance between the configured STA servers.
* **StasBypassDuration**: Time before retrying a failed STA server.
* **EnableSessionReliability**: Enable session reliability.
* **UseTwoTickets**: Request STA tickets from two STA servers.
* **Farms[]**: Farms.
* **Zones[]**: Zones.
  * If not specified, it will be set to all farms.
* **EnabledOnDirectAccess**: Enabled On Direct Access.
* **Ensure**: Ensure.

### Configuration

```
Configuration XD7Example {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontOptimalGateway XD7StoreFrontOptimalGatewayExample {
        ResourcesVirtualPath = '/Citrix/mock'
        GatewayName = 'ag.netscaler.com'
        Hostnames = @('ag.netscaler.com:443','ag2.netscaler.com:443')
        StaUrls = @('http://test/Scripts/CtxSTA.dll','http://test2/Scripts/CtxSTA.dll')
        StasBypassDuration = '02:00:00'
        Ensure = 'Present'
    }
}
```
## XD7StoreFrontPNA

Enables or disables PNA (XenApp Services) for a Store.

### Syntax

```
XD7StoreFrontPNA [string]
{
    StoreName = [String]
    [ DefaultPnaService = [Boolean] ]
    [ Ensure = [String] { Absent | Present } ]
}
```

### Properties

* **StoreName**: StoreFront store name.
* **DefaultPnaService**: Configure the Store to be the default PNA site hosted at http://example.storefront.com/Citrix/Store/PNAgent/config.xml.
* **Ensure**: Ensure. If not specified, the value defaults to Present


### Configuration

```
Configuration XD7StoreFrontUnifiedExperienceExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontPNA XD7StoreFrontPNAExample {
       StoreName = 'mock'
       DefaultPnaService = $true
    }
}
```

## XD7StoreFrontReceiverAuthenticationMethod

Configures the available authentication providers of a Citrix StoreFront 2.x or 3.x server.

### Syntax

```
XD7StoreFrontReceiverAuthenticationMethod [string]
{
    VirtualPath = [string]
    AuthenticationMethod = [string[]] { Certificate | CitrixAGBasic | CitrixFederation | ExplicitForms | HttpBasic | IntegratedWindows }
    [ SiteId = [uint16] ]
}
```

### Properties

* **VirtualPath**: The Citrix Storefront IIS authentication service virtual path.
* **AuthenticationMethod**: Authentication methods to be installed.
  * __Note: Existing authentication methods will be removed.__
* **SiteId**: The Citrix Storefront IIS authentication service site id.
  * If not specified, the value defaults to 1.

### Configuration

```
Configuration XD7StoreFrontReceiverAuthenticationMethodExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontReceiverAuthenticationMethod XD7StoreFrontReceiverAuthenticationMethods {
        VirtualPath = '/Citrix/StoreWeb'
        SiteId = 1
        AuthenticationMethod = 'ExplicitForms','WindowsIntegrated'
    }
}
```

## XD7StoreFrontRegisterStoreGateway

Register an authentication Gateway with a Store.

### Syntax

```
XD7StoreFrontRegisterStoreGateway [string]
{
    StoreName = [String]
    GatewayName = [String[]]
    AuthenticationProtocol[] = [String] { CitrixAGBasic | CitrixAGBasicNoPassword | HttpBasic | Certificate | CitrixFederation | IntegratedWindows | Forms-Saml | ExplicitForms}
    EnableRemoteAccess = [Boolean]
    [ Ensure = [String] { Present | Absent } ]
}
```

### Properties

* **StoreName**: Citrix StoreFront name.
* **GatewayName[]**: Gateway name.
* **AuthenticationProtocol[]**: Authentication Protocol.
* **EnableRemoteAccess**: Enable Remote Access.
* **Ensure**: Ensure.

### Configuration

```
Configuration XD7Example {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontRegisterStoreGateway XD7StoreFrontRegisterStoreGatewayExample {
        GatewayName = 'Netscaler'
        StoreName = 'mock'
        AuthenticationProtocol = @('ExplicitForms','CitrixFederation','CitrixAGBasicNoPassword')
        EnableRemoteAccess = $True
        Ensure = 'Present'
    }
}
```

## XD7StoreFrontRoamingBeacon

Set the internal and external beacons

### Syntax

```
XD7StoreFrontRoamingBeacon [string]
{
    SiteId = [UInt64]
    [ InternalUri = [String] ]
    [ ExternalUri = [String[]] ]
}
```

### Properties

* **SiteId**: Citrix Storefront IIS Site Id.
* **InternalUri**: Beacon internal address uri. You can set this one by itself.
* **ExternalUri**: Beacon external address uri. If you specify Externaluri, you must also include Internaluri.


### Configuration

```
Configuration XD7Example {
    Import-DSCResource -ModuleName XenDesktop7 {
    XD7StoreFrontRoamingBeacon XD7StoreFrontRoamingBeaconExample {
       SiteId = 1
       InternalURI = 'http://localhost/'
       ExternalURI = 'http://web.client1.com','http://web.client2.com'
    }
}
```

## XD7StoreFrontRoamingGateway

Add or update a Gateway that can be used for remote access and authentication.

### Syntax

```
XD7StoreFrontRoamingGateway [string]
{
    Name = [String]
    LogonType = [String] { UsedForHDXOnly | Domain | RSA | DomainAndRSA | SMS | GatewayKnows | SmartCard | None }
    GatewayUrl = [String]
    [ SmartCardFallbackLogonType = [String] ]
    [ Version = [String] ]
    [ CallbackUrl = [String] ]
    [ SessionReliability = [Boolean] ]
    [ RequestTicketTwoSTAs = [Boolean] ]
    [ SubnetIPAddress = [String] ]
    [ SecureTicketAuthorityUrls = [String[]] ]
    [ StasUseLoadBalancing = [Boolean] ]
    [ StasBypassDuration = [String] ]
    [ GslbUrl = [String] ]
    [ Ensure = [String] { Present | Absent } ]
}
```

### Properties

* **Name**: Gateway friendly name.
* **LogonType**: The login type required and supported by the Gateway.
* **SmartCardFallbackLogonType**: The login type to use when SmartCard fails.
* **Version**: The Citrix NetScaler Gateway version.
* **GatewayUrl**: The Gateway Url.
* **CallbackUrl**: The Gateway authentication call-back Url.
* **SessionReliability**: Enable session reliability.
* **RequestTicketTwoSTAs**: Request STA tickets from two STA servers.
* **SubnetIPAddress**: IP address.
* **SecureTicketAuthorityUrls[]**: Secure Ticket Authority server Urls.
* **StasUseLoadBalancing**: Load balance between the configured STA servers.
* **StasBypassDuration**: Time before retrying a failed STA server.
* **GslbUrl**: GSLB domain used by multiple gateways.
* **Ensure**: Ensure.

### Configuration

```
Configuration XD7StoreFrontRoamingGatewayExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontRoamingGateway XD7StoreFrontRoamingGatewayExample {
        Name = 'Netscaler'
        LogonType = 'Domain'
        GatewayUrl = 'https://accessgateway/netscaler'
        Version = 'Version10_0_69_4'
        SecureTicketAuthorityUrls = 'https://staurl/scripts/ctxsta.dll'
        SessionReliability = $true
        Ensure = 'Present'
    }
}
```

## XD7StoreFrontSessionStateTimeout

Sets the sessionState time interval for a Web Receiver site

### Syntax

```
XD7StoreFrontSessionStateTimeout [string]
{
    StoreName = [String]
    [ IntervalInMinutes = [UInt32] ]
    [ CommunicationAttempts = [UInt32] ]
    [ CommunicationTimeout = [UInt32] ]
    [ LoginFormTimeout = [UInt32] ]
}
```

### Properties

* **StoreName**: StoreFront store name.
* **IntervalInMinutes**: Time interval in minutes.
* **CommunicationAttempts**: Communication attempts.
* **CommunicationTimeout**: Communication timeout.
* **LoginFormTimeout**: Login form timeout.

### Configuration

```
Configuration XD7Example {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontSessionStateTimeout XD7StoreFrontSessionStateTimeoutExample {
        StoreName = 'mock'
        IntervalInMinutes = 20
    }
}
```

## XD7StoreFrontStore

Creates or sets a StoreFront store and all it's properties.

### Syntax

```
VE_XD7StoreFrontStore [string]
{
    StoreName = [String]
    AuthType = [String] { Explicit | Anonymous }
    [ AuthVirtualPath = [String] ]
    [ StoreVirtualPath = [String] ]
    [ SiteId = [UInt64] ]
    [ LockedDown = [Boolean] ]
    [ Ensure = [String] { Present | Absent } ]
}
```

### Properties

* **StoreName**: Citrix StoreFront name.
* **AuthType**: Citrix StoreFront Authentication type.
* **AuthVirtualPath**: Citrix StoreFront authenication service virtual path.
  * If not specified, this value defaults to /Citrix/Authentication.
* **StoreVirtualPath**: Citrix StoreFront store virtual path.
  * If not specified, this value defaults to /Citrix/<StoreName>.
* **SiteId**: Citrix StoreFront IIS site id.
  * If not specified, this value defaults to 1.
* **LockedDown**: All the resources delivered by locked-down Store are auto subscribed and do not allow for un-subscription.
* **Ensure**: Specifies whether the Store should be present or absent.
  * If not specified, this value defaults to 'Present'.

### Configuration

```
Configuration XD7Example {
    Import-DscResource -ModuleName XenDesktop7
    VE_XD7StoreFrontStore VE_XD7StoreFrontStoreExample {
        StoreName = 'Store'
        AuthType = 'Explicit'
        StoreVirtualPath = '/Citrix/Store'
        AuthVirtualPath = '/Citrix/Authentication'
        Ensure = 'Present'
    }
}
```

## XD7StoreFrontStoreFarm

Set the details of a StoreFront farm or create a StoreFront farm

### Syntax

```
XD7StoreFrontStoreFarm [string]
{
    StoreName = [String]
    FarmName = [String]
    [ FarmType = [String] { XenApp | XenDesktop | AppController | VDIinaBox | Store } ]
    [ Servers = [String[]] ]
    [ ServiceUrls = [String[]] ]
    [ Port = [UInt32] ]
    [ TransportType = [String] { HTTP | HTTPS | SSL } ]
    [ SSLRelayPort = [UInt32] ]
    [ LoadBalance = [Boolean] ]
    [ AllFailedBypassDuration = [UInt32] ]
    [ BypassDuration = [UInt32] ]
    [ TicketTimeToLive = [UInt32] ]
    [ RadeTicketTimeToLive = [UInt32] ]
    [ MaxFailedServersPerRequest = [UInt32] ]
    [ Zones = [String[]] ]
    [ Product = [String] ]
    [ RestrictPoPs = [String] ]
    [ FarmGuid = [String] ]
    [ Ensure = [string] { Present | Absent }]
}
```

### Properties

* **StoreName**: StoreFront store name.
* **FarmName**: The name of the Farm.
* **FarmType**: The type of farm.
* **Servers**: The hostnames or IP addresses of the xml services.
* **ServiceUrls**: The url to the service location used to provide web and SaaS apps via this farm.
* **Port**: Service communication port.
* **TransportType**: Type of transport to use. Http, Https, SSL for example.
* **SSLRelayPort**: The SSL Relay port.
* **LoadBalance**: Round robin load balance the xml service servers.
* **AllFailedBypassDuration**: Period of time to skip all xml service requests should all servers fail to respond.
* **BypassDuration**: Period of time to skip a server when is fails to respond.
* **TicketTimeToLive**: Period of time an ICA launch ticket is valid once requested on pre 7.0 XenApp and XenDesktop farms.
* **RadeTicketTimeToLive**: Period of time a RADE launch ticket is valid once requested on pre 7.0 XenApp and XenDesktop farms.
* **MaxFailedServersPerRequest**: Maximum number of servers within a single farm that can fail before aborting a request.
* **Zones**: The list of Zone names associated with the Store Farm.
* **Product**: Cloud deployments only otherwise ignored. The product name of the farm configured.
* **RestrictPoPs**: Cloud deployments only otherwise ignored. Restricts GWaaS traffic to the specified POP.
* **FarmGuid**: Cloud deployments only otherwise ignored. A tag indicating the scope of the farm.
* **Ensure**: Specifies whether the store farm should be present or not. If not specified, the value defaults to Present.

### Configuration

```
Configuration XD7Example {
    Import-DSCResource -ModuleName XenDesktop7 {
    XD7StoreFrontStoreFarm XD7StoreFrontStoreFarmExample {
       StoreName = 'mock'
       FarmName = 'farm2'
       Servers = 'Server10','Server11'
       FarmType = 'XenApp'
       TransportType = 'HTTPS'
    }
}
```

## XD7StoreFrontUnifiedExperience

Configures the Citrix Storefront Unified Experience of a Citrix Storefront 3.x server.

### Syntax

```
XD7StoreFrontUnifiedExperience [string]
{
    VirtualPath = [string]
    WebReceiverVirtualPath = [string]
    [ SiteId = [uint16] ]
    [ Ensure = [string] { Absent | Present } ]
}
```

### Properties

* **VirtualPath**: The Citrix Storefront IIS Store service virtual path.
* **WebReceiverVirtualPath**: The Citrix Storefront IIS Receiver for Web service virtual path.
  * __Note: Existing authentication methods will be removed.__
* **SiteId**: The Citrix Storefront IIS authentication service site id.
  * If not specified, the value defaults to 1.
* **Ensure**: Whether the Storefront unified experience should be enabled or disabled.

### Configuration

```
Configuration XD7StoreFrontUnifiedExperienceExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontUnifiedExperience EnableStoreFrontUnifiedExperience {
        VirtualPath = '/Citrix/Store'
        WebReceiverVirtualPath = '/Citrix/StoreWeb'
        SiteId = 1
        Ensure = 'Present'
    }
}
```

## XD7StoreFrontWebReceiverCommunication

Set the WebReceiver communication settings

### Syntax

```
XD7StoreFrontWebReceiverCommunication [string]
{
    StoreName = [String]
    [ Attempts = [UInt32] ]
    [ Timeout = [String] ]
    [ Loopback = [String] { On | Off | OnUsingHttp } ]
    [ LoopbackPortUsingHttp = [UInt32] ]
    [ ProxyEnabled = [Boolean] ]
    [ ProxyPort = [UInt32] ]
    [ ProxyProcessName = [String] ]
}
```

### Properties

* **StoreName**: StoreFront store name.
* **Attempts**: How many attempts WebReceiver should make to contact StoreFront before it gives up.
* **Timeout**: Timeout value for communicating with StoreFront.
* **Loopback**: Whether to use the loopback address for communications with the store service, rather than the actual StoreFront server URL.
* **LoopbackPortUsingHttp**: When loopback is set to OnUsingHttp, the port number to use for loopback communications.
* **ProxyEnabled**: Is the communications proxy enabled.
* **ProxyPort**: The port to use for the communications proxy.
* **ProxyProcessName**: The name of the process acting as proxy.

### Configuration

```
Configuration XD7Example {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontWebReceiverCommunication XD7StoreFrontWebReceiverCommunicationExample {
        StoreName = 'mock'
        Loopback = 'OnUsingHttp'
    }
}
```

## XD7StoreFrontWebReceiverPluginAssistant

Set the WebReceiver Plug-in Assistant options.

### Syntax

```
XD7StoreFrontWebReceiverPluginAssistant [string]
{
    StoreName = [String]
    [ Enabled = [Boolean] ]
    [ UpgradeAtLogin = [Boolean] ]
    [ ShowAfterLogin = [Boolean] ]
    [ Win32Path = [String] ]
    [ MacOSPath = [String] ]
    [ MacOSMinimumSupportedVersion = [String] ]
    [ Html5Enabled = [String] { Always | Fallback | Off } ]
    [ Html5Platforms = [String] ]
    [ Html5Preferences = [String] ]
    [ Html5SingleTabLaunch = [Boolean] ]
    [ Html5ChromeAppOrigins = [String] ]
    [ Html5ChromeAppPreferences = [String] ]
    [ ProtocolHandlerEnabled = [Boolean] ]
    [ ProtocolHandlerPlatforms = [String] ]
    [ ProtocolHandlerSkipDoubleHopCheckWhenDisabled = [Boolean] ]
}
```

### Properties

* **StoreName**: StoreFront store name.
* **Enabled**: Enable Receiver client detection.
* **UpgradeAtLogin**: Prompt to upgrade older clients.
* **ShowAfterLogin**: Show Receiver client detection after the user logs in.
* **Win32Path**: Path to the Windows Receiver.
* **MacOSPath**: Path to the MacOS Receiver.
* **MacOSMinimumSupportedVersion**: Minimum version of the MacOS supported.
* **Html5Enabled**: Method of deploying and using the Html5 Receiver.
* **Html5Platforms**: The supported Html5 platforms.
* **Html5Preferences**: Html5 Receiver preferences.
* **Html5SingleTabLaunch**: Launch Html5 Receiver in the same browser tab.
* **Html5ChromeAppOrigins**: The Html5 Chrome Application Origins settings.
* **Html5ChromeAppPreferences**: The Html5 Chrome Application preferences.
* **ProtocolHandlerEnabled**: Enable the Receiver Protocol Handler.
* **ProtocolHandlerPlatforms**: The supported Protocol Handler platforms.
* **ProtocolHandlerSkipDoubleHopCheckWhenDisabled**: Skip the Protocol Handle double hop check.

### Configuration

```
Configuration XD7Example {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontWebReceiverPluginAssistant XD7StoreFrontWebReceiverPluginAssistantExample {
        StoreName = 'mock'
        Enabled = $false
    }
}
```

## XD7StoreFrontWebReceiverResourcesService

Set the WebReceiver Resources Service settings

### Syntax

```
XD7StoreFrontWebReceiverResourcesService [string]
{
    StoreName = [String]
    [ PersistentIconCacheEnabled = [Boolean] ]
    [ IcaFileCacheExpiry = [UInt32] ]
    [ IconSize = [UInt32] ]
    [ ShowDesktopViewer = [Boolean] ]
}
```

### Properties

* **StoreName**: StoreFront store name.
* **PersistentIconCacheEnabled**: Whether to cache icon data in the local file system.
* **IcaFileCacheExpiry**: How long the ICA file data is cached in the memory of the Web Proxy.
* **IconSize**: The desired icon size sent to the Store Service in icon requests.
* **ShowDesktopViewer**: Shows the Citrix Desktop Viewer window and toolbar when users access their desktops from legacy clients. This setting may fix problems where the Desktop Viewer is not displayed. Default: Off..

### Configuration

```
Configuration XD7Example {
    Import-DSCResource -ModuleName XenDesktop7 {
    XD7StoreFrontWebReceiverResourcesService XD7StoreFrontWebReceiverResourcesServiceExample {
        StoreName = 'mock'
        ShowDesktopViewer = $false
    }
}
```

## XD7StoreFrontWebReceiverService

Configure Receiver for Web service options

### Syntax

```
XD7StoreFrontWebReceiverService [string]
{
    StoreName = [String]
    VirtualPath = [String]
    SiteId = [UInt64]
    [ ClassicReceiverExperience = [Boolean] ]
    [ SessionStateTimeout = [UInt32] ]
    [ DefaultIISSite = [Boolean] ]
    [ FriendlyName = [String] ]
    [ Ensure = [String] { Present | Absent } ]
}
```

### Properties

* **StoreName**: StoreFront store name.
* **VirtualPath**: Site virtual path.
* **SiteId**: Citrix Storefront IIS Site Id.
  * If not specified, this value defaults to 1.
* **ClassicReceiverExperience**: Enable the classic Receiver experience.
* **SessionStateTimeout**: Set the session state timeout, in minutes.
* **DefaultIISSite**:Set the Receiver for Web site as the default page in IIS.
* **FriendlyName**: Friendly name to identify the Receiver for Web service.
  * **Note: this name cannot be changed after initial configuration**
* **Ensure**: Whether the Storefront Web Receiver Service should be added or removed.

### Configuration

```
Configuration XD7Example {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontWebReceiverService XD7StoreFrontWebReceiverServiceExample {
        StoreName = 'mock'
        VirtualPath = '/Citrix/mockweb'
        ClassicReceiverExperience = $false
        Ensure = 'Present'
    }
}
```

## XD7StoreFrontWebReceiverSiteStyle

Sets the Style info in the custom style sheet

### Syntax

```
XD7StoreFrontWebReceiverSiteStyle [string]
{
    StoreName = [String]
    [ HeaderLogoPath = [String] ]
    [ LogonLogoPath = [String] ]
    [ HeaderBackgroundColor = [String] ]
    [ HeaderForegroundColor = [String] ]
    [ LinkColor = [String] ]
}
```

### Properties

* **StoreName**: StoreFront store name.
* **HeaderLogoPath**: Header logo path. This file must exist and it cannot be in the ..\receiver\images folder or subfolders. Preferably the custom folder.
* **LogonLogoPath**: Logon logo path. This file must exist and it cannot be in the ..\receiver\images folder or subfolders. Preferably the custom folder.
* **HeaderBackgroundColor**: Background color of the Header.
* **HeaderForegroundColor**: Foreground color of the Header.
* **LinkColor**: Link color of the page.

### Configuration

```
Configuration XD7Example {
    Import-DSCResource -ModuleName XenDesktop7 {
    XD7StoreFrontWebReceiverSiteStyle XD7StoreFrontWebReceiverSiteStyleExample {
       StoreName = 'mock'
       LinkColor = '#02a1c1'
       HeaderBackgroundColor = '#0574f5b'
       HeaderForegroundColor = '#fff'
       HeaderLogoPath = 'C:\inetpub\wwwroot\Citrix\mockweb\custom\CustomHeader.png'
       LogonLogoPath = 'C:\inetpub\wwwroot\Citrix\mockweb\custom\CustomLogon.png'
    }
}
```

## XD7StoreFrontWebReceiverUserInterface

Set the WebReceiver User Interface options.

### Syntax

```
XD7StoreFrontWebReceiverUserInterface [string]
{
    StoreName = [String]
    [ AutoLaunchDesktop = [Boolean] ]
    [ MultiClickTimeout = [UInt32] ]
    [ EnableAppsFolderView = [Boolean] ]
    [ ShowAppsView = [Boolean] ]
    [ ShowDesktopsView = [Boolean] ]
    [ DefaultView = [String] { Apps | Auto | Desktops } ]
    [ WorkspaceControlEnabled = [Boolean] ]
    [ WorkspaceControlAutoReconnectAtLogon = [Boolean] ]
    [ WorkspaceControlLogoffAction = [String] { Disconnect | None | Terminate } ]
    [ WorkspaceControlShowReconnectButton = [Boolean] ]
    [ WorkspaceControlShowDisconnectButton = [Boolean] ]
    [ ReceiverConfigurationEnabled = [Boolean] ]
    [ AppShortcutsEnabled = [Boolean] ]
    [ AppShortcutsAllowSessionReconnect = [Boolean] ]
}
```

### Properties

* **StoreName**: StoreFront store name.
* **AutoLaunchDesktop**: Whether to auto-launch desktop at login if there is only one desktop available for the user.
* **MultiClickTimeout**: The time period for which the spinner control is displayed, after the user clicks on the App or Desktop icon within Receiver for Web.
* **EnableAppsFolderView**: Allows the user to turn off folder view when in a locked-down store or unauthenticated store.
* **ShowAppsView**: Whether to show the apps view tab.
* **ShowDesktopsView**: Whether to show the desktops tab.
* **DefaultView**: The view to show after logon.
* **WorkspaceControlEnabled**: Whether to enable workspace control.
* **WorkspaceControlAutoReconnectAtLogon**: Whether to perform auto-reconnect at login.
* **WorkspaceControlLogoffAction**: Whether to disconnect or terminate HDX sessions when actively logging off Receiver for Web.
* **WorkspaceControlShowReconnectButton**: Whether to show the reconnect button or link.
* **WorkspaceControlShowDisconnectButton**: Whether to show the disconnect button or link.
* **ReceiverConfigurationEnabled**: Enable the Receiver Configuration .CR download file.
* **AppShortcutsEnabled**: Enable App Shortcuts.
* **AppShortcutsAllowSessionReconnect**: Enable App Shortcuts to support session reconnect.

### Configuration

```
Configuration XD7Example {
    Import-DscResource -ModuleName XenDesktop7
    XD7StoreFrontWebReceiverUserInterface XD7StoreFrontWebReceiverUserInterfaceExample {
        StoreName = 'mock'
        WorkspaceControlLogoffAction = 'Disconnect'
        WorkspaceControlEnabled = $True
        WorkspaceControlAutoReconnectAtLogon = $True
        AutoLaunchDesktop = $True
        ShowDesktopsView = $False
        ReceiverConfigurationEnabled = $False
        MultiClickTimeout = 3
        DefaultView = 'Apps'
    }
}
```

## XD7VDAController

Assigns a Citrix XenDesktop Controller to a Citrix Virtual Delivery Agent (VDA).

### Syntax

```
XD7VDAController [string]
{
    Name = [string]
    [ Ensure = [string] { Present | Absent } ]
}
```

### Properties

* **Name**: Name of the Citrix XenDesktop 7 Delivery Controller to assign to the VDA.
* **Ensure**: Specifies whether the Citrix XenDesktop 7 controller entry should be present or not. If not specified, the value defaults to Present.

### Configuration

```
Configuration XD7VDAControllerExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7VDAController XD7VDAController1 {
        Name = 'controller1.lab.local'
    }
    XD7VDAController XD7VDAController2 {
        Name = 'controller2.lab.local'
    }
}
```

## XD7VDAFeature

Installs Citrix XenDesktop 7 Virtual Delivery Agent (VDA) feature.

### Syntax

```
XD7VDAFeature [string]
{
    Role = [string] { DesktopVDA | SessionVDA }
    SourcePath = [string]
    [ InstallReceiver = [bool] ]
    [ EnableRemoteAssistance = [bool] ]
    [ Optimize = [bool] ]
    [ InstallDesktopExperience = [bool] ]
    [ EnableRealTimeTransport = [bool] ]
    [ ExcludeTelemetryService = [bool] ]
    [ Ensure = [string] { Present | Absent } ]
}
```

### Properties

* **Role**: The Citrix XenDesktop 7 VDA feature to install.
* **SourcePath**: Location of the extracted Citrix XenDesktop 7 setup media.
* **InstallReceiver**: Flags whether to install the Citrix Receiver. If not specified, the value defaults to False.
* **EnableRemoteAssistance**: Flags whether to enable Remote Assistance during installation. If not specified, the value defaults to True.
* **Optimize**: Flags whether to optimize a VDA. This is only applicable to virtual machines. If not specified, the value defaults to False.
* **InstallDesktopExperience**: Flags whether to install the Windows Desktop Experience feature. This is only applicable to server operating systems. If not specified, the value defaults to True.
* **EnableRealTimeTransport**: Flags whether to enable UDP Real-time transport feature during install. If not specified, this value defaults to False.
* **ExcludeTelemetryService**: Excludes the Citrix Telemetry Service from the install.
  * __NOTE:__ _Only applicable/included from Citrix XenDesktop 7.8 and later._
* **Ensure**: Whether the role is to be installed or not. Supported values are Present or Absent. If not specified, it defaults to Present.

### Configuration

```
Configuration XD7VDAFeatureExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7VDAFeature XD7DeskopVDAFeature {
        Role = 'DesktopVDA'
        SourcePath = 'C:\Sources\XenDesktop76'
        InstallReceiver = $true
        Optimize = $true
    }
}
```

## XD7WaitForSite

Waits for a Citrix XenDesktop 7 site to become available.

### Syntax

```
XD7WaitForSite [string]
{
    SiteName = [string]
    ExistingControllerName = [string]
    [ RetryIntervalSec = [uint64] ]
    [ RetryCount = [uint32] ]
    [ Credential = [PSCredential] ]
}
```

### Properties

* **SiteName**: Citrix XenDesktop 7 site to wait for.
* **ExistingControllerName**: Name of an existing Citrix XenDesktop 7 site controller to check for site availavility.
* **RetryIntervalSec**: Number of seconds between retries. If not specified, the value defaults to 30 seconds.
* **RetryCount**: Number of attempts to try before giving up. If not specified, the value default to 10.
* **Credential**: Specifies optional credential of a user which has permissions to communicate with the existing site controller. __This property is required for Powershell 4.0.__

### Configuration

```
Configuration XD7WaitForSiteExample {
    Import-DscResource -ModuleName XenDesktop7
    XD7WaitForSite XD7WaitForMySite {
        SiteName = 'My Site'
        ExistingControllerName = 'controller1.lab.local'
    }
}
```
