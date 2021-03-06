##########
# Tweaked Win10 Initial Setup Script
# Primary Author: Disassembler <disassembler@dasm.cz>
# Primary Author Source: https://github.com/Disassembler0/Win10-Initial-Setup-Script
# Tweaked Source: https://gist.github.com/alirobe/7f3b34ad89a159e6daa1/
#
#    Note from author: Never run scripts without reading them & understanding what they do.
#
#    Addition: One command to rule them all, One command to find it, and One command to Run it!
#
#     > powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://git.io/JJ8R4')"
#
#    Chris Titus Tech Additions:
#
#    - Dark Mode
#    - One Command to launch and run
#    - Chocolatey Install
#    - O&O Shutup10 CFG and Run
#    - Added Install Programs
#    - Added Debloat Microsoft Store Apps
#    - Added Confirm Menu for Adobe and Brave Browser
#    - Changed Default Apps to Notepad++, Brave, Irfanview, and more using XML Import feature
#
##########
# Default preset

[CmdletBinding()]
param (
    $tweaks = @(
        'RequireAdmin',
        # 'CreateRestorePoint',
        'RemoveCameraRoll',
        'RemovePowerShellISE',

        'SetVendor',
        'SetSpotifyCache',
        'RemoveVSContext',

        ### Windows Apps
        'DebloatAll',

        ### Privacy Tweaks ###
        # "DisableTelemetry",           # "EnableTelemetry",
        # "DisableWiFiSense",           # "EnableWiFiSense",
        # "DisableSmartScreen",         # "EnableSmartScreen",
        # "DisableWebSearch",           # "EnableWebSearch",
        # "DisableAppSuggestions",      # "EnableAppSuggestions",
        # "DisableActivityHistory",     # "EnableActivityHistory",
        # "DisableBackgroundApps",      # "EnableBackgroundApps",
        # "DisableLocationTracking",    # "EnableLocationTracking",
        'DisableMapUpdates', # "EnableMapUpdates",
        "DisableFeedback", # "EnableFeedback",
        "DisableTailoredExperiences", # "EnableTailoredExperiences",
        "DisableAdvertisingID", # "EnableAdvertisingID",
        'DisableCortana', # "EnableCortana",
        # "DisableErrorReporting",      # "EnableErrorReporting",
        # "SetP2PUpdateLocal",          # "SetP2PUpdateInternet",
        # "DisableDiagTrack",           # "EnableDiagTrack",
        # "DisableWAPPush",             # "EnableWAPPush",

        ### Security Tweaks ###
        "SetUACLow", # "SetUACHigh",
        # "EnableSharingMappedDrives",  # "DisableSharingMappedDrives",
        # "DisableAdminShares",         # "EnableAdminShares",
        # "DisableSMB1",                # "EnableSMB1",
        # "DisableSMBServer",           # "EnableSMBServer",
        # "DisableLLMNR",               # "EnableLLMNR",
        'SetCurrentNetworkPrivate', # "SetCurrentNetworkPublic",
        #"SetUnknownNetworksPrivate",
        'SetUnknownNetworksPublic',
        # "DisableNetDevicesAutoInst",  # "EnableNetDevicesAutoInst",
        # "DisableCtrldFolderAccess",   # "EnableCtrldFolderAccess",
        'EnableFirewall',
        # 'EnableDefender', # BROKEN!
        # "EnableDefenderCloud",
        # "EnableF8BootMenu",           # "DisableF8BootMenu",
        # "SetDEPOptOut",               # "SetDEPOptIn",
        # "EnableCIMemoryIntegrity",    # "DisableCIMemoryIntegrity",
        # "DisableScriptHost",          # "EnableScriptHost",
        # "EnableDotNetStrongCrypto",   # "DisableDotNetStrongCrypto",
        # "DisableMeltdownCompatFlag",  # "EnableMeltdownCompatFlag"

        ### Service Tweaks ###
        # "DisableUpdateMSRT",          # "EnableUpdateMSRT",
        # "DisableUpdateDriver",        # "EnableUpdateDriver",
        # "DisableUpdateRestart",       # "EnableUpdateRestart",
        # "DisableHomeGroups",          # "EnableHomeGroups",
        # "DisableSharedExperiences",   # "EnableSharedExperiences",
        # "DisableRemoteAssistance",    # "EnableRemoteAssistance",
        # "EnableRemoteDesktop",        # "DisableRemoteDesktop",
        # "DisableAutoplay",            # "EnableAutoplay",
        # "DisableAutorun",             # "EnableAutorun",
        'DisableStorageSense', # "EnableStorageSense",
        # "DisableDefragmentation",     # "EnableDefragmentation",
        # "DisableSuperfetch",          # "EnableSuperfetch",
        "EnableIndexing",
        # "SetBIOSTimeUTC",             # "SetBIOSTimeLocal",
        'DisableHibernation', # "EnableHibernation",
        # "EnableSleepButton",          # "DisableSleepButton",
        # "DisableSleepTimeout",        # "EnableSleepTimeout",
        # "DisableFastStartup",         # "EnableFastStartup",

        ### UI Tweaks ###
        # "DisableActionCenter",        # "EnableActionCenter",
        # "EnableLockScreen",           # "DisableLockScreen",
        # "EnableLockScreenRS1",        # "DisableLockScreenRS1",
        # "HideNetworkFromLockScreen",  # "ShowNetworkOnLockScreen",
        # "HideShutdownFromLockScreen", # "ShowShutdownOnLockScreen",
        'DisableStickyKeys', # "EnableStickyKeys",
        'ShowTaskManagerDetails'        # "HideTaskManagerDetails",
        'ShowFileOperationsDetails', # "HideFileOperationsDetails",
        # 'DisableFileDeleteConfirm', # "EnableFileDeleteConfirm",
        'HideTaskbarSearch', #"ShowTaskbarSearchIcon",       # "ShowTaskbarSearchBox",
        'HideTaskView', # "ShowTaskView",
        # "ShowSmallTaskbarIcons",      # "ShowLargeTaskbarIcons",
        # "SetTaskbarCombineWhenFull",  # "SetTaskbarCombineNever",     # "SetTaskbarCombineAlways",
        'HideTaskbarPeopleIcon', # "ShowTaskbarPeopleIcon",
        'ShowTrayIcons', # "HideTrayIcons",
        'DisableSearchAppInStore', # "EnableSearchAppInStore",
        # "DisableNewAppPrompt",        # "EnableNewAppPrompt",
        # "SetControlPanelSmallIcons",  # "SetControlPanelLargeIcons",  # "SetControlPanelCategories",
        # "SetVisualFXPerformance",     # "SetVisualFXAppearance",
        # "AddENKeyboard",              # "RemoveENKeyboard",
        'EnableNumlock', # "DisableNumlock",
        # 'EnableDarkMode', # "DisableDarkMode",
        'Stop-EdgePDF',

        ### Explorer UI Tweaks ###
        'ShowKnownExtensions', # "HideKnownExtensions",
        'ShowHiddenFiles', # "HideHiddenFiles",
        # "HideSyncNotifications"       # "ShowSyncNotifications",
        # "HideRecentShortcuts",        # "ShowRecentShortcuts",
        'SetExplorerThisPC', # "SetExplorerQuickAccess",
        # "HideThisPCFromDesktop",      # "ShowThisPCOnDesktop",
        # "ShowUserFolderOnDesktop",    # "HideUserFolderFromDesktop",
        # "HideDesktopFromThisPC",      # "ShowDesktopInThisPC",
        # "HideDesktopFromExplorer",    # "ShowDesktopInExplorer",
        # "HideDocumentsFromThisPC",    # "ShowDocumentsInThisPC",
        # "HideDocumentsFromExplorer",  # "ShowDocumentsInExplorer",
        # "HideDownloadsFromThisPC",    # "ShowDownloadsInThisPC",
        # "HideDownloadsFromExplorer",  # "ShowDownloadsInExplorer",
        # "HideMusicFromThisPC",        # "ShowMusicInThisPC",
        # "HideMusicFromExplorer",      # "ShowMusicInExplorer",
        # "HidePicturesFromThisPC",     # "ShowPicturesInThisPC",
        # "HidePicturesFromExplorer",   # "ShowPicturesInExplorer",
        # "HideVideosFromThisPC",       # "ShowVideosInThisPC",
        # "HideVideosFromExplorer",     # "ShowVideosInExplorer",
        'Hide3DObjectsFromThisPC', # "Show3DObjectsInThisPC",
        'Hide3DObjectsFromExplorer', # "Show3DObjectsInExplorer",
        # "DisableThumbnails",          # "EnableThumbnails",
        # "DisableThumbsDB",            # "EnableThumbsDB",

        ### Application Tweaks ###
        # "EnableOneDrive",
        'UninstallMsftBloat', # "InstallMsftBloat",
        'UninstallThirdPartyBloat', # "InstallThirdPartyBloat",
        # "UninstallWindowsStore",      # "InstallWindowsStore",
        # "DisableXboxFeatures",        # "EnableXboxFeatures",
        'DisableAdobeFlash', # "EnableAdobeFlash",
        # "InstallMediaPlayer",
        'UninstallMediaPlayer',
        'UninstallInternetExplorer', # "InstallInternetExplorer",
        'UninstallWorkFolders', # "InstallWorkFolders",
        # 'InstallLinuxSubsystem', # "UninstallLinuxSubsystem",
        # "InstallHyperV",              # "UninstallHyperV",
        'SetPhotoViewerAssociation', # "UnsetPhotoViewerAssociation",
        'AddPhotoViewerOpenWith', # "RemovePhotoViewerOpenWith",
        # "InstallPDFPrinter"           # "UninstallPDFPrinter",
        'UninstallXPSPrinter', # "InstallXPSPrinter",
        'RemoveFaxPrinter'           # "AddFaxPrinter",

        ### Server Specific Tweaks ###
        # "HideServerManagerOnLogin",   # "ShowServerManagerOnLogin",
        # "DisableShutdownTracker",     # "EnableShutdownTracker",
        # "DisablePasswordPolicy",      # "EnablePasswordPolicy",
        # "DisableCtrlAltDelLogin",     # "EnableCtrlAltDelLogin",
        # "DisableIEEnhancedSecurity",  # "EnableIEEnhancedSecurity",
        # "EnableAudio",                # "DisableAudio",

        ### Unpinning ###
        #"UnpinStartMenuTiles",
        #"UnpinTaskbarIcons",

        ### Auxiliary functions ###
    ),
    $preset
)

##########
# Privacy Tweaks
##########

# Disable Telemetry
# Note: This tweak may cause Enterprise edition to stop receiving Windows updates.
# Windows Update control panel will then show message "Your device is at risk because it's out of date and missing important security and quality updates. Let's get you back on track so Windows can run more securely. Select this button to get going".
# In such case, enable telemetry, run Windows update and then disable telemetry again. See also https://github.com/Disassembler0/Win10-Initial-Setup-Script/issues/57
function DisableTelemetry {
    Write-Output 'Disabling Telemetry...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 0
    Disable-ScheduledTask -TaskName 'Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser' | Out-Null
    Disable-ScheduledTask -TaskName 'Microsoft\Windows\Application Experience\ProgramDataUpdater' | Out-Null
    Disable-ScheduledTask -TaskName 'Microsoft\Windows\Autochk\Proxy' | Out-Null
    Disable-ScheduledTask -TaskName 'Microsoft\Windows\Customer Experience Improvement Program\Consolidator' | Out-Null
    Disable-ScheduledTask -TaskName 'Microsoft\Windows\Customer Experience Improvement Program\UsbCeip' | Out-Null
    Disable-ScheduledTask -TaskName 'Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector' | Out-Null
}

# Enable Telemetry
function EnableTelemetry {
    Write-Output 'Enabling Telemetry...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 3
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 3
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name 'AllowTelemetry' -ErrorAction SilentlyContinue
    Enable-ScheduledTask -TaskName 'Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser' | Out-Null
    Enable-ScheduledTask -TaskName 'Microsoft\Windows\Application Experience\ProgramDataUpdater' | Out-Null
    Enable-ScheduledTask -TaskName 'Microsoft\Windows\Autochk\Proxy' | Out-Null
    Enable-ScheduledTask -TaskName 'Microsoft\Windows\Customer Experience Improvement Program\Consolidator' | Out-Null
    Enable-ScheduledTask -TaskName 'Microsoft\Windows\Customer Experience Improvement Program\UsbCeip' | Out-Null
    Enable-ScheduledTask -TaskName 'Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector' | Out-Null
}

# Disable Wi-Fi Sense
function DisableWiFiSense {
    Write-Output 'Disabling Wi-Fi Sense...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting' -Name 'Value' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots' -Name 'Value' -Type DWord -Value 0
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config' -Name 'AutoConnectAllowedOEM' -Type Dword -Value 0
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config' -Name 'WiFISenseAllowed' -Type Dword -Value 0
}

# Enable Wi-Fi Sense
function EnableWiFiSense {
    Write-Output 'Enabling Wi-Fi Sense...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting' -Name 'Value' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots' -Name 'Value' -Type DWord -Value 1
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config' -Name 'AutoConnectAllowedOEM' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config' -Name 'WiFISenseAllowed' -ErrorAction SilentlyContinue
}

# Disable SmartScreen Filter
function DisableSmartScreen {
    Write-Output 'Disabling SmartScreen Filter...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'EnableSmartScreen' -Type DWord -Value 0
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter' -Name 'EnabledV9' -Type DWord -Value 0
}

# Enable SmartScreen Filter
function EnableSmartScreen {
    Write-Output 'Enabling SmartScreen Filter...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'EnableSmartScreen' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter' -Name 'EnabledV9' -ErrorAction SilentlyContinue
}

# Disable Web Search in Start Menu
function DisableWebSearch {
    Write-Output 'Disabling Bing Search in Start Menu...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'BingSearchEnabled' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'CortanaConsent' -Type DWord -Value 0
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'DisableWebSearch' -Type DWord -Value 1
}

# Enable Web Search in Start Menu
function EnableWebSearch {
    Write-Output 'Enabling Bing Search in Start Menu...'
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'BingSearchEnabled' -ErrorAction SilentlyContinue
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'CortanaConsent' -Type DWord -Value 1
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'DisableWebSearch' -ErrorAction SilentlyContinue
}

# Disable Application suggestions and automatic installation
function DisableAppSuggestions {
    Write-Output 'Disabling Application suggestions...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'ContentDeliveryAllowed' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'OemPreInstalledAppsEnabled' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'PreInstalledAppsEnabled' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'PreInstalledAppsEverEnabled' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SilentInstalledAppsEnabled' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-338387Enabled' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-338388Enabled' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-338389Enabled' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-353698Enabled' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SystemPaneSuggestionsEnabled' -Type DWord -Value 0
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent' -Name 'DisableWindowsConsumerFeatures' -Type DWord -Value 1
}

# Enable Application suggestions and automatic installation
function EnableAppSuggestions {
    Write-Output 'Enabling Application suggestions...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'ContentDeliveryAllowed' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'OemPreInstalledAppsEnabled' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'PreInstalledAppsEnabled' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'PreInstalledAppsEverEnabled' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SilentInstalledAppsEnabled' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-338388Enabled' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-338389Enabled' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SystemPaneSuggestionsEnabled' -Type DWord -Value 1
    Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-338387Enabled' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager' -Name 'SubscribedContent-353698Enabled' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent' -Name 'DisableWindowsConsumerFeatures' -ErrorAction SilentlyContinue
}

# Disable Activity History feed in Task View - Note: The checkbox "Let Windows collect my activities from this PC" remains checked even when the function is disabled
function DisableActivityHistory {
    Write-Output 'Disabling Activity History...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'EnableActivityFeed' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'PublishUserActivities' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'UploadUserActivities' -Type DWord -Value 0
}

# Enable Activity History feed in Task View
function EnableActivityHistory {
    Write-Output 'Enabling Activity History...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'EnableActivityFeed' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'PublishUserActivities' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'UploadUserActivities' -ErrorAction SilentlyContinue
}

# Disable Background application access - ie. if apps can download or update when they aren't used - Cortana is excluded as its inclusion breaks start menu search
function DisableBackgroundApps {
    Write-Output 'Disabling Background application access...'
    Get-ChildItem -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications' -Exclude 'Microsoft.Windows.Cortana*' | ForEach-Object {
        Set-ItemProperty -Path $_.PsPath -Name 'Disabled' -Type DWord -Value 1
        Set-ItemProperty -Path $_.PsPath -Name 'DisabledByUser' -Type DWord -Value 1
    }
}

# Enable Background application access
function EnableBackgroundApps {
    Write-Output 'Enabling Background application access...'
    Get-ChildItem -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications' | ForEach-Object {
        Remove-ItemProperty -Path $_.PsPath -Name 'Disabled' -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path $_.PsPath -Name 'DisabledByUser' -ErrorAction SilentlyContinue
    }
}

# Disable Location Tracking
function DisableLocationTracking {
    Write-Output 'Disabling Location Tracking...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location' -Name 'Value' -Type String -Value 'Deny'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}' -Name 'SensorPermissionState' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration' -Name 'Status' -Type DWord -Value 0
}

# Enable Location Tracking
function EnableLocationTracking {
    Write-Output 'Enabling Location Tracking...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location' -Name 'Value' -Type String -Value 'Allow'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}' -Name 'SensorPermissionState' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration' -Name 'Status' -Type DWord -Value 1
}

# Disable automatic Maps updates
function DisableMapUpdates {
    Write-Output 'Disabling automatic Maps updates...'
    Set-ItemProperty -Path 'HKLM:\SYSTEM\Maps' -Name 'AutoUpdateEnabled' -Type DWord -Value 0
}

# Enable automatic Maps updates
function EnableMapUpdates {
    Write-Output 'Enable automatic Maps updates...'
    Remove-ItemProperty -Path 'HKLM:\SYSTEM\Maps' -Name 'AutoUpdateEnabled' -ErrorAction SilentlyContinue
}

# Disable Feedback
function DisableFeedback {
    Write-Output 'Disabling Feedback...'
    if (!(Test-Path 'HKCU:\SOFTWARE\Microsoft\Siuf\Rules')) {
        New-Item -Path 'HKCU:\SOFTWARE\Microsoft\Siuf\Rules' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Siuf\Rules' -Name 'NumberOfSIUFInPeriod' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name 'DoNotShowFeedbackNotifications' -Type DWord -Value 1
    Disable-ScheduledTask -TaskName 'Microsoft\Windows\Feedback\Siuf\DmClient' -ErrorAction SilentlyContinue | Out-Null
    Disable-ScheduledTask -TaskName 'Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload' -ErrorAction SilentlyContinue | Out-Null
}

# Enable Feedback
function EnableFeedback {
    Write-Output 'Enabling Feedback...'
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Siuf\Rules' -Name 'NumberOfSIUFInPeriod' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection' -Name 'DoNotShowFeedbackNotifications' -ErrorAction SilentlyContinue
    Enable-ScheduledTask -TaskName 'Microsoft\Windows\Feedback\Siuf\DmClient' -ErrorAction SilentlyContinue | Out-Null
    Enable-ScheduledTask -TaskName 'Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload' -ErrorAction SilentlyContinue | Out-Null
}

# Disable Tailored Experiences
function DisableTailoredExperiences {
    Write-Output 'Disabling Tailored Experiences...'
    if (!(Test-Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent')) {
        New-Item -Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent' -Name 'DisableTailoredExperiencesWithDiagnosticData' -Type DWord -Value 1
}

# Enable Tailored Experiences
function EnableTailoredExperiences {
    Write-Output 'Enabling Tailored Experiences...'
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent' -Name 'DisableTailoredExperiencesWithDiagnosticData' -ErrorAction SilentlyContinue
}

# Disable Advertising ID
function DisableAdvertisingID {
    Write-Output 'Disabling Advertising ID...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo' | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo' -Name 'DisabledByGroupPolicy' -Type DWord -Value 1
}

# Enable Advertising ID
function EnableAdvertisingID {
    Write-Output 'Enabling Advertising ID...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo' -Name 'DisabledByGroupPolicy' -ErrorAction SilentlyContinue
}

# Disable Cortana
function DisableCortana {
    Write-Output 'Disabling Cortana...'
    if (!(Test-Path 'HKCU:\SOFTWARE\Microsoft\Personalization\Settings')) {
        New-Item -Path 'HKCU:\SOFTWARE\Microsoft\Personalization\Settings' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Personalization\Settings' -Name 'AcceptedPrivacyPolicy' -Type DWord -Value 0
    if (!(Test-Path 'HKCU:\SOFTWARE\Microsoft\InputPersonalization')) {
        New-Item -Path 'HKCU:\SOFTWARE\Microsoft\InputPersonalization' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\InputPersonalization' -Name 'RestrictImplicitTextCollection' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\InputPersonalization' -Name 'RestrictImplicitInkCollection' -Type DWord -Value 1
    if (!(Test-Path 'HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore')) {
        New-Item -Path 'HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore' -Name 'HarvestContacts' -Type DWord -Value 0
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowCortana' -Type DWord -Value 0
}

# Enable Cortana
function EnableCortana {
    Write-Output 'Enabling Cortana...'
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Personalization\Settings' -Name 'AcceptedPrivacyPolicy' -ErrorAction SilentlyContinue
    if (!(Test-Path 'HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore')) {
        New-Item -Path 'HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\InputPersonalization' -Name 'RestrictImplicitTextCollection' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\InputPersonalization' -Name 'RestrictImplicitInkCollection' -Type DWord -Value 0
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore' -Name 'HarvestContacts' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name 'AllowCortana' -ErrorAction SilentlyContinue
}

# Disable Error reporting
function DisableErrorReporting {
    Write-Output 'Disabling Error reporting...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting' -Name 'Disabled' -Type DWord -Value 1
    Disable-ScheduledTask -TaskName 'Microsoft\Windows\Windows Error Reporting\QueueReporting' | Out-Null
}

# Enable Error reporting
function EnableErrorReporting {
    Write-Output 'Enabling Error reporting...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting' -Name 'Disabled' -ErrorAction SilentlyContinue
    Enable-ScheduledTask -TaskName 'Microsoft\Windows\Windows Error Reporting\QueueReporting' | Out-Null
}

# Restrict Windows Update P2P only to local network - Needed only for 1507 as local P2P is the default since 1511
function SetP2PUpdateLocal {
    Write-Output 'Restricting Windows Update P2P only to local network...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config' | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config' -Name 'DODownloadMode' -Type DWord -Value 1
}

# Unrestrict Windows Update P2P
function SetP2PUpdateInternet {
    Write-Output 'Unrestricting Windows Update P2P to internet...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config' -Name 'DODownloadMode' -ErrorAction SilentlyContinue
}

# Stop and disable Diagnostics Tracking Service
function DisableDiagTrack {
    Write-Output 'Stopping and disabling Diagnostics Tracking Service...'
    Stop-Service 'DiagTrack' -WarningAction SilentlyContinue
    Set-Service 'DiagTrack' -StartupType Disabled
}

# Enable and start Diagnostics Tracking Service
function EnableDiagTrack {
    Write-Output 'Enabling and starting Diagnostics Tracking Service...'
    Set-Service 'DiagTrack' -StartupType Automatic
    Start-Service 'DiagTrack' -WarningAction SilentlyContinue
}

# Stop and disable WAP Push Service
function DisableWAPPush {
    Write-Output 'Stopping and disabling WAP Push Service...'
    Stop-Service 'dmwappushservice' -WarningAction SilentlyContinue
    Set-Service 'dmwappushservice' -StartupType Disabled
}

# Enable and start WAP Push Service
function EnableWAPPush {
    Write-Output 'Enabling and starting WAP Push Service...'
    Set-Service 'dmwappushservice' -StartupType Automatic
    Start-Service 'dmwappushservice' -WarningAction SilentlyContinue
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\dmwappushservice' -Name 'DelayedAutoStart' -Type DWord -Value 1
}



##########
# Security Tweaks
##########

# Lower UAC level (disabling it completely would break apps)
function SetUACLow {
    Write-Output 'Lowering UAC level...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ConsentPromptBehaviorAdmin' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'PromptOnSecureDesktop' -Type DWord -Value 0
}

# Raise UAC level
function SetUACHigh {
    Write-Output 'Raising UAC level...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ConsentPromptBehaviorAdmin' -Type DWord -Value 5
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'PromptOnSecureDesktop' -Type DWord -Value 1
}

# Enable sharing mapped drives between users
function EnableSharingMappedDrives {
    Write-Output 'Enabling sharing mapped drives between users...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLinkedConnections' -Type DWord -Value 1
}

# Disable sharing mapped drives between users
function DisableSharingMappedDrives {
    Write-Output 'Disabling sharing mapped drives between users...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'EnableLinkedConnections' -ErrorAction SilentlyContinue
}

# Disable implicit administrative shares
function DisableAdminShares {
    Write-Output 'Disabling implicit administrative shares...'
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters' -Name 'AutoShareWks' -Type DWord -Value 0
}

# Enable implicit administrative shares
function EnableAdminShares {
    Write-Output 'Enabling implicit administrative shares...'
    Remove-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters' -Name 'AutoShareWks' -ErrorAction SilentlyContinue
}

# Disable obsolete SMB 1.0 protocol - Disabled by default since 1709
function DisableSMB1 {
    Write-Output 'Disabling SMB 1.0 protocol...'
    Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
}

# Enable obsolete SMB 1.0 protocol - Disabled by default since 1709
function EnableSMB1 {
    Write-Output 'Enabling SMB 1.0 protocol...'
    Set-SmbServerConfiguration -EnableSMB1Protocol $true -Force
}

# Disable SMB Server - Completely disables file and printer sharing, but leaves the system able to connect to another SMB server as a client
function DisableSMBServer {
    Write-Output 'Disabling SMB Server...'
    Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force
    Set-SmbServerConfiguration -EnableSMB2Protocol $false -Force
}

# Enable SMB Server
function EnableSMBServer {
    Write-Output 'Enabling SMB Server...'
    Set-SmbServerConfiguration -EnableSMB2Protocol $true -Force
}

# Disable Link-Local Multicast Name Resolution (LLMNR) protocol
function DisableLLMNR {
    Write-Output 'Disabling LLMNR...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient' -Name 'EnableMulticast' -Type DWord -Value 0
}

# Enable Link-Local Multicast Name Resolution (LLMNR) protocol
function EnableLLMNR {
    Write-Output 'Enabling LLMNR...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\DNSClient' -Name 'EnableMulticast' -ErrorAction SilentlyContinue
}

# Set current network profile to private (allow file sharing, device discovery, etc.)
function SetCurrentNetworkPrivate {
    Write-Output 'Setting current network profile to private...'
    Set-NetConnectionProfile -NetworkCategory Private
}

# Set current network profile to public (deny file sharing, device discovery, etc.)
function SetCurrentNetworkPublic {
    Write-Output 'Setting current network profile to public...'
    Set-NetConnectionProfile -NetworkCategory Public
}

# Set unknown networks profile to private (allow file sharing, device discovery, etc.)
function SetUnknownNetworksPrivate {
    Write-Output 'Setting unknown networks profile to private...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0010000000F0000F0C967A3643C3AD745950DA7859209176EF5B87C875FA20DF21951640E807D7C24')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0010000000F0000F0C967A3643C3AD745950DA7859209176EF5B87C875FA20DF21951640E807D7C24' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0010000000F0000F0C967A3643C3AD745950DA7859209176EF5B87C875FA20DF21951640E807D7C24' -Name 'Category' -Type DWord -Value 1
}

# Set unknown networks profile to public (deny file sharing, device discovery, etc.)
function SetUnknownNetworksPublic {
    Write-Output 'Setting unknown networks profile to public...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\NetworkList\Signatures\010103000F0000F0010000000F0000F0C967A3643C3AD745950DA7859209176EF5B87C875FA20DF21951640E807D7C24' -Name 'Category' -ErrorAction SilentlyContinue
}

# Disable automatic installation of network devices
function DisableNetDevicesAutoInst {
    Write-Output 'Disabling automatic installation of network devices...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private' -Name 'AutoSetup' -Type DWord -Value 0
}

# Enable automatic installation of network devices
function EnableNetDevicesAutoInst {
    Write-Output 'Enabling automatic installation of network devices...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\NcdAutoSetup\Private' -Name 'AutoSetup' -ErrorAction SilentlyContinue
}

# Enable Controlled Folder Access (Defender Exploit Guard feature) - Applicable to 1709 or newer, requires Windows Defender to be enabled
function EnableCtrldFolderAccess {
    Write-Output 'Enabling Controlled Folder Access...'
    Set-MpPreference -EnableControlledFolderAccess Enabled
}

# Disable Controlled Folder Access (Defender Exploit Guard feature) - Applicable to 1709 or newer, requires Windows Defender to be enabled
function DisableCtrldFolderAccess {
    Write-Output 'Disabling Controlled Folder Access...'
    Set-MpPreference -EnableControlledFolderAccess Disabled
}

# Disable Firewall
function DisableFirewall {
    Write-Output 'Disabling Firewall...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile' -Name 'EnableFirewall' -Type DWord -Value 0
}

# Enable Firewall
function EnableFirewall {
    Write-Output 'Enabling Firewall...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile' -Name 'EnableFirewall' -ErrorAction SilentlyContinue
}

# Disable Windows Defender
function DisableDefender {
    Write-Output 'Disabling Windows Defender...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' -Name 'DisableAntiSpyware' -Type DWord -Value 1
    if ([System.Environment]::OSVersion.Version.Build -eq 14393) {
        Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'WindowsDefender' -ErrorAction SilentlyContinue
    } Elseif ([System.Environment]::OSVersion.Version.Build -ge 15063) {
        Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'SecurityHealth' -ErrorAction SilentlyContinue
    }
}

# Enable Windows Defender
function EnableDefender {
    # BROKEN
    Write-Output 'Enabling Windows Defender...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender' -Name 'DisableAntiSpyware' -ErrorAction SilentlyContinue
    if ([System.Environment]::OSVersion.Version.Build -eq 14393) {
        Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'WindowsDefender' -Type ExpandString -Value "`"%ProgramFiles%\Windows Defender\MSASCuiL.exe`""
    } Elseif ([System.Environment]::OSVersion.Version.Build -ge 15063) {
        Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'SecurityHealth' -Type ExpandString -Value "`"%ProgramFiles%\Windows Defender\MSASCuiL.exe`""
    }
}

# Disable Windows Defender Cloud
function DisableDefenderCloud {
    Write-Output 'Disabling Windows Defender Cloud...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet' -Name 'SpynetReporting' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet' -Name 'SubmitSamplesConsent' -Type DWord -Value 2
}

# Enable Windows Defender Cloud
function EnableDefenderCloud {
    Write-Output 'Enabling Windows Defender Cloud...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet' -Name 'SpynetReporting' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet' -Name 'SubmitSamplesConsent' -ErrorAction SilentlyContinue
}

# Enable F8 boot menu options
function EnableF8BootMenu {
    Write-Output 'Enabling F8 boot menu options...'
    bcdedit /set `{current`} bootmenupolicy Legacy | Out-Null
}

# Disable F8 boot menu options
function DisableF8BootMenu {
    Write-Output 'Disabling F8 boot menu options...'
    bcdedit /set `{current`} bootmenupolicy Standard | Out-Null
}

# Set Data Execution Prevention (DEP) policy to OptOut
function SetDEPOptOut {
    Write-Output 'Setting Data Execution Prevention (DEP) policy to OptOut...'
    bcdedit /set `{current`} nx OptOut | Out-Null
}

# Set Data Execution Prevention (DEP) policy to OptIn
function SetDEPOptIn {
    Write-Output 'Setting Data Execution Prevention (DEP) policy to OptIn...'
    bcdedit /set `{current`} nx OptIn | Out-Null
}

# Enable Core Isolation Memory Integrity - Part of Windows Defender System Guard virtualization-based security - Supported from 1803
function EnableCIMemoryIntegrity {
    Write-Output 'Enabling Core Isolation Memory Integrity...'
    if (!(Test-Path 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity')) {
        New-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity' -Name 'Enabled' -Type DWord -Value 1
}

# Disable Core Isolation Memory Integrity -
function DisableCIMemoryIntegrity {
    Write-Output 'Disabling Core Isolation Memory Integrity...'
    Remove-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity' -Name 'Enabled' -ErrorAction SilentlyContinue
}

# Disable Windows Script Host (execution of *.vbs scripts and alike)
function DisableScriptHost {
    Write-Output 'Disabling Windows Script Host...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows Script Host\Settings' -Name 'Enabled' -Type DWord -Value 0
}

# Enable Windows Script Host
function EnableScriptHost {
    Write-Output 'Enabling Windows Script Host...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows Script Host\Settings' -Name 'Enabled' -ErrorAction SilentlyContinue
}

# Enable strong cryptography for .NET Framework (version 4 and above)
# https://stackoverflow.com/questions/36265534/invoke-webrequest-ssl-fails
function EnableDotNetStrongCrypto {
    Write-Output 'Enabling .NET strong cryptography...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Type DWord -Value 1
}

# Disable strong cryptography for .NET Framework (version 4 and above)
function DisableDotNetStrongCrypto {
    Write-Output 'Disabling .NET strong cryptography...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -ErrorAction SilentlyContinue
}

# Enable Meltdown (CVE-2017-5754) compatibility flag - Required for January 2018 and all subsequent Windows updates
# This flag is normally automatically enabled by compatible antivirus software (such as Windows Defender).
# Use the tweak only if you have confirmed that your AV is compatible but unable to set the flag automatically or if you don't use any AV at all.
# See https://support.microsoft.com/en-us/help/4072699/january-3-2018-windows-security-updates-and-antivirus-software for details.
function EnableMeltdownCompatFlag {
    Write-Output 'Enabling Meltdown (CVE-2017-5754) compatibility flag...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\QualityCompat')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\QualityCompat' | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\QualityCompat' -Name 'cadca5fe-87d3-4b96-b7fb-a231484277cc' -Type DWord -Value 0
}

# Disable Meltdown (CVE-2017-5754) compatibility flag
function DisableMeltdownCompatFlag {
    Write-Output 'Disabling Meltdown (CVE-2017-5754) compatibility flag...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\QualityCompat' -Name 'cadca5fe-87d3-4b96-b7fb-a231484277cc' -ErrorAction SilentlyContinue
}



##########
# Service Tweaks
##########

# Disable offering of Malicious Software Removal Tool through Windows Update
function DisableUpdateMSRT {
    Write-Output 'Disabling Malicious Software Removal Tool offering...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\MRT')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\MRT' | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\MRT' -Name 'DontOfferThroughWUAU' -Type DWord -Value 1
}

# Enable offering of Malicious Software Removal Tool through Windows Update
function EnableUpdateMSRT {
    Write-Output 'Enabling Malicious Software Removal Tool offering...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\MRT' -Name 'DontOfferThroughWUAU' -ErrorAction SilentlyContinue
}

# Disable offering of drivers through Windows Update
# Note: This doesn't work properly if you use a driver intended for another hardware model. E.g. Intel I219-V on WinServer works only with I219-LM driver.
# Therefore Windows update will repeatedly try and fail to install I219-V driver indefinitely even if you use the tweak.
function DisableUpdateDriver {
    Write-Output 'Disabling driver offering through Windows Update...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata' -Name 'PreventDeviceMetadataFromNetwork' -Type DWord -Value 1
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' -Name 'DontPromptForWindowsUpdate' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' -Name 'DontSearchWindowsUpdate' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' -Name 'DriverUpdateWizardWuSearchEnabled' -Type DWord -Value 0
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -Name 'ExcludeWUDriversInQualityUpdate' -Type DWord -Value 1
}

# Enable offering of drivers through Windows Update
function EnableUpdateDriver {
    Write-Output 'Enabling driver offering through Windows Update...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Device Metadata' -Name 'PreventDeviceMetadataFromNetwork' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' -Name 'DontPromptForWindowsUpdate' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' -Name 'DontSearchWindowsUpdate' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\DriverSearching' -Name 'DriverUpdateWizardWuSearchEnabled' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' -Name 'ExcludeWUDriversInQualityUpdate' -ErrorAction SilentlyContinue
}

# Disable Windows Update automatic restart
# Note: This doesn't disable the need for the restart but rather tries to ensure that the restart doesn't happen in the least expected moment. Allow the machine to restart as soon as possible anyway.
function DisableUpdateRestart {
    Write-Output 'Disabling Windows Update automatic restart...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name 'NoAutoRebootWithLoggedOnUsers' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name 'AUPowerManagement' -Type DWord -Value 0
}

# Enable Windows Update automatic restart
function EnableUpdateRestart {
    Write-Output 'Enabling Windows Update automatic restart...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name 'NoAutoRebootWithLoggedOnUsers' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' -Name 'AUPowerManagement' -ErrorAction SilentlyContinue
}

# Stop and disable Home Groups services - Not applicable to 1803 and newer or Server
function DisableHomeGroups {
    Write-Output 'Stopping and disabling Home Groups services...'
    Stop-Service 'HomeGroupListener' -WarningAction SilentlyContinue
    Set-Service 'HomeGroupListener' -StartupType Disabled
    Stop-Service 'HomeGroupProvider' -WarningAction SilentlyContinue
    Set-Service 'HomeGroupProvider' -StartupType Disabled
}

# Enable and start Home Groups services - Not applicable to 1803 and newer or Server
function EnableHomeGroups {
    Write-Output 'Starting and enabling Home Groups services...'
    Set-Service 'HomeGroupListener' -StartupType Manual
    Set-Service 'HomeGroupProvider' -StartupType Manual
    Start-Service 'HomeGroupProvider' -WarningAction SilentlyContinue
}

# Disable Shared Experiences - Not applicable to Server
function DisableSharedExperiences {
    Write-Output 'Disabling Shared Experiences...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'EnableCdp' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'EnableMmx' -Type DWord -Value 0
}

# Enable Shared Experiences - Not applicable to Server
function EnableSharedExperiences {
    Write-Output 'Enabling Shared Experiences...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'EnableCdp' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'EnableMmx' -ErrorAction SilentlyContinue
}

# Disable Remote Assistance - Not applicable to Server (unless Remote Assistance is explicitly installed)
function DisableRemoteAssistance {
    Write-Output 'Disabling Remote Assistance...'
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance' -Name 'fAllowToGetHelp' -Type DWord -Value 0
}

# Enable Remote Assistance - Not applicable to Server (unless Remote Assistance is explicitly installed)
function EnableRemoteAssistance {
    Write-Output 'Enabling Remote Assistance...'
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Remote Assistance' -Name 'fAllowToGetHelp' -Type DWord -Value 1
}

# Enable Remote Desktop w/o Network Level Authentication
function EnableRemoteDesktop {
    Write-Output 'Enabling Remote Desktop w/o Network Level Authentication...'
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name 'UserAuthentication' -Type DWord -Value 0
    Enable-NetFirewallRule -Name 'RemoteDesktop*'
}

# Disable Remote Desktop
function DisableRemoteDesktop {
    Write-Output 'Disabling Remote Desktop...'
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name 'UserAuthentication' -Type DWord -Value 1
    Disable-NetFirewallRule -Name 'RemoteDesktop*'
}

# Disable Autoplay
function DisableAutoplay {
    Write-Output 'Disabling Autoplay...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers' -Name 'DisableAutoplay' -Type DWord -Value 1
}

# Enable Autoplay
function EnableAutoplay {
    Write-Output 'Enabling Autoplay...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers' -Name 'DisableAutoplay' -Type DWord -Value 0
}

# Disable Autorun for all drives
function DisableAutorun {
    Write-Output 'Disabling Autorun for all drives...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'NoDriveTypeAutoRun' -Type DWord -Value 255
}

# Enable Autorun for removable drives
function EnableAutorun {
    Write-Output 'Enabling Autorun for all drives...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'NoDriveTypeAutoRun' -ErrorAction SilentlyContinue
}

# Enable Storage Sense - automatic disk cleanup - Not applicable to Server
function EnableStorageSense {
    Write-Output 'Enabling Storage Sense...'
    if (!(Test-Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy')) {
        New-Item -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -Name '01' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -Name '04' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -Name '08' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -Name '32' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -Name 'StoragePoliciesNotified' -Type DWord -Value 1
}

# Disable Storage Sense - Not applicable to Server
function DisableStorageSense {
    Write-Output 'Disabling Storage Sense...'
    Remove-Item -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -Recurse -ErrorAction SilentlyContinue
}

# Disable scheduled defragmentation task
function DisableDefragmentation {
    Write-Output 'Disabling scheduled defragmentation...'
    Disable-ScheduledTask -TaskName 'Microsoft\Windows\Defrag\ScheduledDefrag' | Out-Null
}

# Enable scheduled defragmentation task
function EnableDefragmentation {
    Write-Output 'Enabling scheduled defragmentation...'
    Enable-ScheduledTask -TaskName 'Microsoft\Windows\Defrag\ScheduledDefrag' | Out-Null
}

# Stop and disable Superfetch service - Not applicable to Server
function DisableSuperfetch {
    Write-Output 'Stopping and disabling Superfetch service...'
    Stop-Service 'SysMain' -WarningAction SilentlyContinue
    Set-Service 'SysMain' -StartupType Disabled
}

# Start and enable Superfetch service - Not applicable to Server
function EnableSuperfetch {
    Write-Output 'Starting and enabling Superfetch service...'
    Set-Service 'SysMain' -StartupType Automatic
    Start-Service 'SysMain' -WarningAction SilentlyContinue
}

# Stop and disable Windows Search indexing service
function DisableIndexing {
    Write-Output 'Stopping and disabling Windows Search indexing service...'
    Stop-Service 'WSearch' -WarningAction SilentlyContinue
    Set-Service 'WSearch' -StartupType Disabled
}

# Start and enable Windows Search indexing service
function EnableIndexing {
    Write-Output 'Starting and enabling Windows Search indexing service...'
    Set-Service 'WSearch' -StartupType Automatic
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\WSearch' -Name 'DelayedAutoStart' -Type DWord -Value 1
    Start-Service 'WSearch' -WarningAction SilentlyContinue
}

# Set BIOS time to UTC
function SetBIOSTimeUTC {
    Write-Output 'Setting BIOS time to UTC...'
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation' -Name 'RealTimeIsUniversal' -Type DWord -Value 1
}

# Set BIOS time to local time
function SetBIOSTimeLocal {
    Write-Output 'Setting BIOS time to Local time...'
    Remove-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\TimeZoneInformation' -Name 'RealTimeIsUniversal' -ErrorAction SilentlyContinue
}

# Enable Hibernation - Do not use on Server with automatically started Hyper-V hvboot service as it may lead to BSODs (Win10 with Hyper-V is fine)
function EnableHibernation {
    Write-Output 'Enabling Hibernation...'
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Session Manager\Power' -Name 'HibernteEnabled' -Type Dword -Value 1
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings' | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings' -Name 'ShowHibernateOption' -Type Dword -Value 1
}

# Disable Hibernation
function DisableHibernation {
    Write-Output 'Disabling Hibernation...'
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Session Manager\Power' -Name 'HibernteEnabled' -Type Dword -Value 0
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings' | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings' -Name 'ShowHibernateOption' -Type Dword -Value 0
}

# Disable Sleep start menu and keyboard button
function DisableSleepButton {
    Write-Output 'Disabling Sleep start menu and keyboard button...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings' | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings' -Name 'ShowSleepOption' -Type Dword -Value 0
    powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_BUTTONS SBUTTONACTION 0
    powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_BUTTONS SBUTTONACTION 0
}

# Enable Sleep start menu and keyboard button
function EnableSleepButton {
    Write-Output 'Enabling Sleep start menu and keyboard button...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings' | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings' -Name 'ShowSleepOption' -Type Dword -Value 1
    powercfg /SETACVALUEINDEX SCHEME_CURRENT SUB_BUTTONS SBUTTONACTION 1
    powercfg /SETDCVALUEINDEX SCHEME_CURRENT SUB_BUTTONS SBUTTONACTION 1
}

# Disable display and sleep mode timeouts
function DisableSleepTimeout {
    Write-Output 'Disabling display and sleep mode timeouts...'
    powercfg /X monitor-timeout-ac 0
    powercfg /X monitor-timeout-dc 0
    powercfg /X standby-timeout-ac 0
    powercfg /X standby-timeout-dc 0
}

# Enable display and sleep mode timeouts
function EnableSleepTimeout {
    Write-Output 'Enabling display and sleep mode timeouts...'
    powercfg /X monitor-timeout-ac 10
    powercfg /X monitor-timeout-dc 5
    powercfg /X standby-timeout-ac 30
    powercfg /X standby-timeout-dc 15
}

# Disable Fast Startup
function DisableFastStartup {
    Write-Output 'Disabling Fast Startup...'
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name 'HiberbootEnabled' -Type DWord -Value 0
}

# Enable Fast Startup
function EnableFastStartup {
    Write-Output 'Enabling Fast Startup...'
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name 'HiberbootEnabled' -Type DWord -Value 1
}



##########
# UI Tweaks
##########

# Disable Action Center
function DisableActionCenter {
    Write-Output 'Disabling Action Center...'
    if (!(Test-Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer')) {
        New-Item -Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer' | Out-Null
    }
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'DisableNotificationCenter' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications' -Name 'ToastEnabled' -Type DWord -Value 0
}

# Enable Action Center
function EnableActionCenter {
    Write-Output 'Enabling Action Center...'
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'DisableNotificationCenter' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications' -Name 'ToastEnabled' -ErrorAction SilentlyContinue
}

# Disable Lock screen
function DisableLockScreen {
    Write-Output 'Disabling Lock screen...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization' | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization' -Name 'NoLockScreen' -Type DWord -Value 1
}

# Enable Lock screen
function EnableLockScreen {
    Write-Output 'Enabling Lock screen...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization' -Name 'NoLockScreen' -ErrorAction SilentlyContinue
}

# Disable Lock screen (Anniversary Update workaround) - Applicable to 1607 - 1803 (The GPO used in DisableLockScreen has been fixed again in 1803)
function DisableLockScreenRS1 {
    Write-Output 'Disabling Lock screen using scheduler workaround...'
    $service = New-Object -com Schedule.Service
    $service.Connect()
    $task = $service.NewTask(0)
    $task.Settings.DisallowStartIfOnBatteries = $false
    $trigger = $task.Triggers.Create(9)
    $trigger = $task.Triggers.Create(11)
    $trigger.StateChange = 8
    $action = $task.Actions.Create(0)
    $action.Path = 'reg.exe'
    $action.Arguments = 'add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\SessionData /t REG_DWORD /v AllowLockScreen /d 0 /f'
    $service.GetFolder('\').RegisterTaskDefinition('Disable LockScreen', $task, 6, 'NT AUTHORITY\SYSTEM', $null, 4) | Out-Null
}

# Enable Lock screen (Anniversary Update workaround) - Applicable to 1607 - 1803
function EnableLockScreenRS1 {
    Write-Output 'Enabling Lock screen (removing scheduler workaround)...'
    Unregister-ScheduledTask -TaskName 'Disable LockScreen' -Confirm:$false -ErrorAction SilentlyContinue
}

# Hide network options from Lock Screen
function HideNetworkFromLockScreen {
    Write-Output 'Hiding network options from Lock Screen...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'DontDisplayNetworkSelectionUI' -Type DWord -Value 1
}

# Show network options on lock screen
function ShowNetworkOnLockScreen {
    Write-Output 'Showing network options on Lock Screen...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\System' -Name 'DontDisplayNetworkSelectionUI' -ErrorAction SilentlyContinue
}

# Hide shutdown options from Lock Screen
function HideShutdownFromLockScreen {
    Write-Output 'Hiding shutdown options from Lock Screen...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ShutdownWithoutLogon' -Type DWord -Value 0
}

# Show shutdown options on lock screen
function ShowShutdownOnLockScreen {
    Write-Output 'Showing shutdown options on Lock Screen...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'ShutdownWithoutLogon' -Type DWord -Value 1
}

# Disable Sticky keys prompt
function DisableStickyKeys {
    Write-Output 'Disabling Sticky keys prompt...'
    Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\StickyKeys' -Name 'Flags' -Type String -Value '506'
}

# Enable Sticky keys prompt
function EnableStickyKeys {
    Write-Output 'Enabling Sticky keys prompt...'
    Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\StickyKeys' -Name 'Flags' -Type String -Value '510'
}

# Show Task Manager details - Applicable to 1607 and later - Although this functionality exist even in earlier versions, the Task Manager's behavior is different there and is not compatible with this tweak
function ShowTaskManagerDetails {
    Write-Output 'Showing task manager details...'
    $taskmgr = Start-Process -WindowStyle Hidden -FilePath taskmgr.exe -PassThru
    Do {
        Start-Sleep -Milliseconds 100
        $preferences = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager' -Name 'Preferences' -ErrorAction SilentlyContinue
    } Until ($preferences)
    Stop-Process $taskmgr
    $preferences.Preferences[28] = 0
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager' -Name 'Preferences' -Type Binary -Value $preferences.Preferences
}

# Hide Task Manager details
function HideTaskManagerDetails {
    Write-Output 'Hiding task manager details...'
    $preferences = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager' -Name 'Preferences' -ErrorAction SilentlyContinue
    if ($preferences) {
        $preferences.Preferences[28] = 1
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\TaskManager' -Name 'Preferences' -Type Binary -Value $preferences.Preferences
    }
}

# Show file operations details
function ShowFileOperationsDetails {
    Write-Output 'Showing file operations details...'
    if (!(Test-Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager')) {
        New-Item -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager' | Out-Null
    }
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager' -Name 'EnthusiastMode' -Type DWord -Value 1
}

# Hide file operations details
function HideFileOperationsDetails {
    Write-Output 'Hiding file operations details...'
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager' -Name 'EnthusiastMode' -ErrorAction SilentlyContinue
}

# Enable file delete confirmation dialog
function EnableFileDeleteConfirm {
    Write-Output 'Enabling file delete confirmation dialog...'
    if (!(Test-Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer')) {
        New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' | Out-Null
    }
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'ConfirmFileDelete' -Type DWord -Value 1
}

# Disable file delete confirmation dialog
function DisableFileDeleteConfirm {
    Write-Output 'Disabling file delete confirmation dialog...'
    Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'ConfirmFileDelete' -ErrorAction SilentlyContinue
}

# Hide Taskbar Search icon / box
function HideTaskbarSearch {
    Write-Output 'Hiding Taskbar Search icon / box...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Type DWord -Value 0
}

# Show Taskbar Search icon
function ShowTaskbarSearchIcon {
    Write-Output 'Showing Taskbar Search icon...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Type DWord -Value 1
}

# Show Taskbar Search box
function ShowTaskbarSearchBox {
    Write-Output 'Showing Taskbar Search box...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search' -Name 'SearchboxTaskbarMode' -Type DWord -Value 2
}

# Hide Task View button
function HideTaskView {
    Write-Output 'Hiding Task View button...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowTaskViewButton' -Type DWord -Value 0
}

# Show Task View button
function ShowTaskView {
    Write-Output 'Showing Task View button...'
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowTaskViewButton' -ErrorAction SilentlyContinue
}

# Show small icons in taskbar
function ShowSmallTaskbarIcons {
    Write-Output 'Showing small icons in taskbar...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarSmallIcons' -Type DWord -Value 1
}

# Show large icons in taskbar
function ShowLargeTaskbarIcons {
    Write-Output 'Showing large icons in taskbar...'
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarSmallIcons' -ErrorAction SilentlyContinue
}

# Set taskbar buttons to show labels and combine when taskbar is full
function SetTaskbarCombineWhenFull {
    Write-Output 'Setting taskbar buttons to combine when taskbar is full...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarGlomLevel' -Type DWord -Value 1
}

# Set taskbar buttons to show labels and never combine
function SetTaskbarCombineNever {
    Write-Output 'Setting taskbar buttons to never combine...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarGlomLevel' -Type DWord -Value 2
}

# Set taskbar buttons to always combine and hide labels
function SetTaskbarCombineAlways {
    Write-Output 'Setting taskbar buttons to always combine, hide labels...'
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarGlomLevel' -ErrorAction SilentlyContinue
}

# Hide Taskbar People icon
function HideTaskbarPeopleIcon {
    Write-Output 'Hiding People icon...'
    if (!(Test-Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People')) {
        New-Item -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People' | Out-Null
    }
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People' -Name 'PeopleBand' -Type DWord -Value 0
}

# Show Taskbar People icon
function ShowTaskbarPeopleIcon {
    Write-Output 'Showing People icon...'
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People' -Name 'PeopleBand' -ErrorAction SilentlyContinue
}

# Show all tray icons
function ShowTrayIcons {
    Write-Output 'Showing all tray icons...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'EnableAutoTray' -Type DWord -Value 0
}

# Hide tray icons as needed
function HideTrayIcons {
    Write-Output 'Hiding tray icons...'
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'EnableAutoTray' -ErrorAction SilentlyContinue
}

# Disable search for app in store for unknown extensions
function DisableSearchAppInStore {
    Write-Output 'Disabling search for app in store for unknown extensions...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'NoUseStoreOpenWith' -Type DWord -Value 1
}

# Enable search for app in store for unknown extensions
function EnableSearchAppInStore {
    Write-Output 'Enabling search for app in store for unknown extensions...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'NoUseStoreOpenWith' -ErrorAction SilentlyContinue
}

# Disable 'How do you want to open this file?' prompt
function DisableNewAppPrompt {
    Write-Output "Disabling 'How do you want to open this file?' prompt..."
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'NoNewAppAlert' -Type DWord -Value 1
}

# Enable 'How do you want to open this file?' prompt
function EnableNewAppPrompt {
    Write-Output "Enabling 'How do you want to open this file?' prompt..."
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer' -Name 'NoNewAppAlert' -ErrorAction SilentlyContinue
}

# Set Control Panel view to Small icons (Classic)
function SetControlPanelSmallIcons {
    Write-Output 'Setting Control Panel view to small icons...'
    if (!(Test-Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel')) {
        New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel' | Out-Null
    }
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel' -Name 'StartupPage' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel' -Name 'AllItemsIconView' -Type DWord -Value 1
}

# Set Control Panel view to Large icons (Classic)
function SetControlPanelLargeIcons {
    Write-Output 'Setting Control Panel view to large icons...'
    if (!(Test-Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel')) {
        New-Item -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel' | Out-Null
    }
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel' -Name 'StartupPage' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel' -Name 'AllItemsIconView' -Type DWord -Value 0
}

# Set Control Panel view to categories
function SetControlPanelCategories {
    Write-Output 'Setting Control Panel view to categories...'
    Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel' -Name 'StartupPage' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel' -Name 'AllItemsIconView' -ErrorAction SilentlyContinue
}

# Adjusts visual effects for performance - Disables animations, transparency etc. but leaves font smoothing and miniatures enabled
function SetVisualFXPerformance {
    Write-Output 'Adjusting visual effects for performance...'
    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'DragFullWindows' -Type String -Value 0
    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'MenuShowDelay' -Type String -Value 0
    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'UserPreferencesMask' -Type Binary -Value ([byte[]](144, 18, 3, 128, 16, 0, 0, 0))
    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\WindowMetrics' -Name 'MinAnimate' -Type String -Value 0
    Set-ItemProperty -Path 'HKCU:\Control Panel\Keyboard' -Name 'KeyboardDelay' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ListviewAlphaSelect' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ListviewShadow' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarAnimations' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects' -Name 'VisualFXSetting' -Type DWord -Value 3
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\DWM' -Name 'EnableAeroPeek' -Type DWord -Value 0
}

# Adjusts visual effects for appearance
function SetVisualFXAppearance {
    Write-Output 'Adjusting visual effects for appearance...'
    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'DragFullWindows' -Type String -Value 1
    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'MenuShowDelay' -Type String -Value 400
    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name 'UserPreferencesMask' -Type Binary -Value ([byte[]](158, 30, 7, 128, 18, 0, 0, 0))
    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\WindowMetrics' -Name 'MinAnimate' -Type String -Value 1
    Set-ItemProperty -Path 'HKCU:\Control Panel\Keyboard' -Name 'KeyboardDelay' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ListviewAlphaSelect' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ListviewShadow' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarAnimations' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects' -Name 'VisualFXSetting' -Type DWord -Value 3
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\DWM' -Name 'EnableAeroPeek' -Type DWord -Value 1
}

# Add secondary en-US keyboard
function AddENKeyboard {
    Write-Output 'Adding secondary en-US keyboard...'
    $langs = Get-WinUserLanguageList
    $langs.Add('en-US')
    Set-WinUserLanguageList $langs -Force
}

# Remove secondary en-US keyboard
function RemoveENKeyboard {
    Write-Output 'Removing secondary en-US keyboard...'
    $langs = Get-WinUserLanguageList
    Set-WinUserLanguageList ($langs | Where-Object { $_.LanguageTag -ne 'en-US' }) -Force
}

# Enable NumLock after startup
function EnableNumlock {
    Write-Output 'Enabling NumLock after startup...'
    if (!(Test-Path 'HKU:')) {
        New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS | Out-Null
    }
    Set-ItemProperty -Path 'HKU:\.DEFAULT\Control Panel\Keyboard' -Name 'InitialKeyboardIndicators' -Type DWord -Value 2147483650
    Add-Type -AssemblyName System.Windows.Forms
    if (!([System.Windows.Forms.Control]::IsKeyLocked('NumLock'))) {
        $wsh = New-Object -ComObject WScript.Shell
        $wsh.SendKeys('{NUMLOCK}')
    }
}

# Disable NumLock after startup
function DisableNumlock {
    Write-Output 'Disabling NumLock after startup...'
    if (!(Test-Path 'HKU:')) {
        New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS | Out-Null
    }
    Set-ItemProperty -Path 'HKU:\.DEFAULT\Control Panel\Keyboard' -Name 'InitialKeyboardIndicators' -Type DWord -Value 2147483648
    Add-Type -AssemblyName System.Windows.Forms
    if ([System.Windows.Forms.Control]::IsKeyLocked('NumLock')) {
        $wsh = New-Object -ComObject WScript.Shell
        $wsh.SendKeys('{NUMLOCK}')
    }
}



##########
# Explorer UI Tweaks
##########

# Show known file extensions
function ShowKnownExtensions {
    Write-Output 'Showing known file extensions...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Type DWord -Value 0
}

# Hide known file extensions
function HideKnownExtensions {
    Write-Output 'Hiding known file extensions...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'HideFileExt' -Type DWord -Value 1
}

# Show hidden files
function ShowHiddenFiles {
    Write-Output 'Showing hidden files...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Type DWord -Value 0
}

# Hide hidden files
function HideHiddenFiles {
    Write-Output 'Hiding hidden files...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'Hidden' -Type DWord -Value 1
}

# Hide sync provider notifications
function HideSyncNotifications {
    Write-Output 'Hiding sync provider notifications...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSyncProviderNotifications' -Type DWord -Value 0
}

# Show sync provider notifications
function ShowSyncNotifications {
    Write-Output 'Showing sync provider notifications...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowSyncProviderNotifications' -Type DWord -Value 1
}

# Hide recently and frequently used item shortcuts in Explorer
function HideRecentShortcuts {
    Write-Output 'Hiding recent shortcuts...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowRecent' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowFrequent' -Type DWord -Value 0
}

# Show recently and frequently used item shortcuts in Explorer
function ShowRecentShortcuts {
    Write-Output 'Showing recent shortcuts...'
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowRecent' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' -Name 'ShowFrequent' -ErrorAction SilentlyContinue
}

# Change default Explorer view to This PC
function SetExplorerThisPC {
    Write-Output 'Changing default Explorer view to This PC...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LaunchTo' -Type DWord -Value 1
}

# Change default Explorer view to Quick Access
function SetExplorerQuickAccess {
    Write-Output 'Changing default Explorer view to Quick Access...'
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'LaunchTo' -ErrorAction SilentlyContinue
}

# Show This PC shortcut on desktop
function ShowThisPCOnDesktop {
    Write-Output 'Showing This PC shortcut on desktop...'
    if (!(Test-Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu')) {
        New-Item -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -Type DWord -Value 0
    if (!(Test-Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel')) {
        New-Item -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -Type DWord -Value 0
}

# Hide This PC shortcut from desktop
function HideThisPCFromDesktop {
    Write-Output 'Hiding This PC shortcut from desktop...'
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Name '{20D04FE0-3AEA-1069-A2D8-08002B30309D}' -ErrorAction SilentlyContinue
}

# Show User Folder shortcut on desktop
function ShowUserFolderOnDesktop {
    Write-Output 'Showing User Folder shortcut on desktop...'
    if (!(Test-Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu')) {
        New-Item -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Name '{59031a47-3f72-44a7-89c5-5595fe6b30ee}' -Type DWord -Value 0
    if (!(Test-Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel')) {
        New-Item -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Name '{59031a47-3f72-44a7-89c5-5595fe6b30ee}' -Type DWord -Value 0
}

# Hide User Folder shortcut from desktop
function HideUserFolderFromDesktop {
    Write-Output 'Hiding User Folder shortcut from desktop...'
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu' -Name '{59031a47-3f72-44a7-89c5-5595fe6b30ee}' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel' -Name '{59031a47-3f72-44a7-89c5-5595fe6b30ee}' -ErrorAction SilentlyContinue
}

# Hide Desktop icon from This PC - The icon remains in personal folders and open/save dialogs
function HideDesktopFromThisPC {
    Write-Output 'Hiding Desktop icon from This PC...'
    Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}' -Recurse -ErrorAction SilentlyContinue
}

# Show Desktop icon in This PC
function ShowDesktopInThisPC {
    Write-Output 'Showing Desktop icon in This PC...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}' | Out-Null
    }
}

# Hide Desktop icon from Explorer namespace - Hides the icon also from personal folders and open/save dialogs
function HideDesktopFromExplorer {
    Write-Output 'Hiding Desktop icon from Explorer namespace...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Hide'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Hide'
}

# Show Desktop icon in Explorer namespace
function ShowDesktopInExplorer {
    Write-Output 'Showing Desktop icon in Explorer namespace...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Show'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Show'
}

# Hide Documents icon from This PC - The icon remains in personal folders and open/save dialogs
function HideDocumentsFromThisPC {
    Write-Output 'Hiding Documents icon from This PC...'
    Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}' -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}' -Recurse -ErrorAction SilentlyContinue
}

# Show Documents icon in This PC
function ShowDocumentsInThisPC {
    Write-Output 'Showing Documents icon in This PC...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}' | Out-Null
    }
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}' | Out-Null
    }
}

# Hide Documents icon from Explorer namespace - Hides the icon also from personal folders and open/save dialogs
function HideDocumentsFromExplorer {
    Write-Output 'Hiding Documents icon from Explorer namespace...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Hide'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Hide'
}

# Show Documents icon in Explorer namespace
function ShowDocumentsInExplorer {
    Write-Output 'Showing Documents icon in Explorer namespace...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Show'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Show'
}

# Hide Downloads icon from This PC - The icon remains in personal folders and open/save dialogs
function HideDownloadsFromThisPC {
    Write-Output 'Hiding Downloads icon from This PC...'
    Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}' -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}' -Recurse -ErrorAction SilentlyContinue
}

# Show Downloads icon in This PC
function ShowDownloadsInThisPC {
    Write-Output 'Showing Downloads icon in This PC...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}' | Out-Null
    }
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}' | Out-Null
    }
}

# Hide Downloads icon from Explorer namespace - Hides the icon also from personal folders and open/save dialogs
function HideDownloadsFromExplorer {
    Write-Output 'Hiding Downloads icon from Explorer namespace...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Hide'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Hide'
}

# Show Downloads icon in Explorer namespace
function ShowDownloadsInExplorer {
    Write-Output 'Showing Downloads icon in Explorer namespace...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Show'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Show'
}

# Hide Music icon from This PC - The icon remains in personal folders and open/save dialogs
function HideMusicFromThisPC {
    Write-Output 'Hiding Music icon from This PC...'
    Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}' -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}' -Recurse -ErrorAction SilentlyContinue
}

# Show Music icon in This PC
function ShowMusicInThisPC {
    Write-Output 'Showing Music icon in This PC...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}' | Out-Null
    }
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}' | Out-Null
    }
}

# Hide Music icon from Explorer namespace - Hides the icon also from personal folders and open/save dialogs
function HideMusicFromExplorer {
    Write-Output 'Hiding Music icon from Explorer namespace...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Hide'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Hide'
}

# Show Music icon in Explorer namespace
function ShowMusicInExplorer {
    Write-Output 'Showing Music icon in Explorer namespace...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Show'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Show'
}

# Hide Pictures icon from This PC - The icon remains in personal folders and open/save dialogs
function HidePicturesFromThisPC {
    Write-Output 'Hiding Pictures icon from This PC...'
    Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}' -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}' -Recurse -ErrorAction SilentlyContinue
}

# Show Pictures icon in This PC
function ShowPicturesInThisPC {
    Write-Output 'Showing Pictures icon in This PC...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}' | Out-Null
    }
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}' | Out-Null
    }
}

# Hide Pictures icon from Explorer namespace - Hides the icon also from personal folders and open/save dialogs
function HidePicturesFromExplorer {
    Write-Output 'Hiding Pictures icon from Explorer namespace...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Hide'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Hide'
}

# Show Pictures icon in Explorer namespace
function ShowPicturesInExplorer {
    Write-Output 'Showing Pictures icon in Explorer namespace...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Show'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Show'
}

# Hide Videos icon from This PC - The icon remains in personal folders and open/save dialogs
function HideVideosFromThisPC {
    Write-Output 'Hiding Videos icon from This PC...'
    Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}' -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}' -Recurse -ErrorAction SilentlyContinue
}

# Show Videos icon in This PC
function ShowVideosInThisPC {
    Write-Output 'Showing Videos icon in This PC...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}' | Out-Null
    }
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}' | Out-Null
    }
}

# Hide Videos icon from Explorer namespace - Hides the icon also from personal folders and open/save dialogs
function HideVideosFromExplorer {
    Write-Output 'Hiding Videos icon from Explorer namespace...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Hide'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Hide'
}

# Show Videos icon in Explorer namespace
function ShowVideosInExplorer {
    Write-Output 'Showing Videos icon in Explorer namespace...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Show'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Show'
}

# Hide 3D Objects icon from This PC - The icon remains in personal folders and open/save dialogs
function Hide3DObjectsFromThisPC {
    Write-Output 'Hiding 3D Objects icon from This PC...'
    Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}' -Recurse -ErrorAction SilentlyContinue
}

# Show 3D Objects icon in This PC
function Show3DObjectsInThisPC {
    Write-Output 'Showing 3D Objects icon in This PC...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}' | Out-Null
    }
}

# Hide 3D Objects icon from Explorer namespace - Hides the icon also from personal folders and open/save dialogs
function Hide3DObjectsFromExplorer {
    Write-Output 'Hiding 3D Objects icon from Explorer namespace...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag')) {
        New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Hide'
    if (!(Test-Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag')) {
        New-Item -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag' -Name 'ThisPCPolicy' -Type String -Value 'Hide'
}

# Show 3D Objects icon in Explorer namespace
function Show3DObjectsInExplorer {
    Write-Output 'Showing 3D Objects icon in Explorer namespace...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag' -Name 'ThisPCPolicy' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{31C0DD25-9439-4F12-BF41-7FF4EDA38722}\PropertyBag' -Name 'ThisPCPolicy' -ErrorAction SilentlyContinue
}

# Disable thumbnails, show only file extension icons
function DisableThumbnails {
    Write-Output 'Disabling thumbnails...'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'IconsOnly' -Type DWord -Value 1
}

# Enable thumbnails
function EnableThumbnails {
    Write-Output 'Enabling thumbnails...'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'IconsOnly' -Type DWord -Value 0
}

# Disable creation of Thumbs.db thumbnail cache files
function DisableThumbsDB {
    Write-Output 'Disabling creation of Thumbs.db...'
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'DisableThumbnailCache' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'DisableThumbsDBOnNetworkFolders' -Type DWord -Value 1
}

# Enable creation of Thumbs.db thumbnail cache files
function EnableThumbsDB {
    Write-Output 'Enable creation of Thumbs.db...'
    Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'DisableThumbnailCache' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'DisableThumbsDBOnNetworkFolders' -ErrorAction SilentlyContinue
}



##########
# Application Tweaks
##########

# Disable OneDrive
function DisableOneDrive {
    Write-Output 'Disabling OneDrive...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive' | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive' -Name 'DisableFileSyncNGSC' -Type DWord -Value 1
}

# Enable OneDrive
function EnableOneDrive {
    Write-Output 'Enabling OneDrive...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive' -Name 'DisableFileSyncNGSC' -ErrorAction SilentlyContinue
}

# Uninstall OneDrive - Not applicable to Server
function UninstallOneDrive {
    Write-Output 'Uninstalling OneDrive...'
    Stop-Process -Name 'OneDrive' -ErrorAction SilentlyContinue
    Start-Sleep -s 2
    $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
    if (!(Test-Path $onedrive)) {
        $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
    }
    Start-Process $onedrive '/uninstall' -NoNewWindow -Wait
    Start-Sleep -s 2
    Stop-Process -Name 'explorer' -ErrorAction SilentlyContinue
    Start-Sleep -s 2
    Remove-Item -Path "$env:USERPROFILE\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:PROGRAMDATA\Microsoft OneDrive" -Force -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path "$env:SYSTEMDRIVE\OneDriveTemp" -Force -Recurse -ErrorAction SilentlyContinue
    if (!(Test-Path 'HKCR:')) {
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    }
    Remove-Item -Path 'HKCR:\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path 'HKCR:\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}' -Recurse -ErrorAction SilentlyContinue
}

# Install OneDrive - Not applicable to Server
function InstallOneDrive {
    Write-Output 'Installing OneDrive...'
    $onedrive = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"
    if (!(Test-Path $onedrive)) {
        $onedrive = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
    }
    Start-Process $onedrive -NoNewWindow
}

# Uninstall default Microsoft applications
function UninstallMsftBloat {
    Write-Output 'Uninstalling default Microsoft applications...'
    Get-AppxPackage 'Microsoft.3DBuilder' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.AppConnector' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.BingFinance' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.BingNews' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.BingSports' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.BingTranslator' | Remove-AppxPackage
    # Get-AppxPackage "Microsoft.BingWeather" | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.CommsPhone' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.ConnectivityStore' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.GetHelp' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.Getstarted' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.Messaging' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.Microsoft3DViewer' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.MicrosoftPowerBIForWindows' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.MicrosoftSolitaireCollection' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.MicrosoftStickyNotes' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.NetworkSpeedTest' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.Office.OneNote' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.Office.Sway' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.OneConnect' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.People' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.Print3D' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.RemoteDesktop' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.Wallet' | Remove-AppxPackage
    # Get-AppxPackage "Microsoft.WindowsAlarms" | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.WindowsCamera' | Remove-AppxPackage
    Get-AppxPackage 'microsoft.windowscommunicationsapps' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.WindowsFeedbackHub' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.WindowsMaps' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.WindowsPhone' | Remove-AppxPackage
    # Get-AppxPackage "Microsoft.Windows.Photos" | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.WindowsSoundRecorder' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.ZuneMusic' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.ZuneVideo' | Remove-AppxPackage
}

# Install default Microsoft applications
function InstallMsftBloat {
    Write-Output 'Installing default Microsoft applications...'
    Get-AppxPackage -AllUsers 'Microsoft.3DBuilder' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.AppConnector' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.BingFinance' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.BingNews' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.BingSports' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.BingTranslator' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.BingWeather' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.CommsPhone' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.ConnectivityStore' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.GetHelp' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.Getstarted' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.Messaging' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.Microsoft3DViewer' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.MicrosoftPowerBIForWindows' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.MicrosoftSolitaireCollection' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.MicrosoftStickyNotes' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.MinecraftUWP' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.MSPaint' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.NetworkSpeedTest' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.Office.Sway' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.OneConnect' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.People' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.Print3D' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.RemoteDesktop' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.SkypeApp' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.Wallet' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.WindowsAlarms' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.WindowsCamera' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.windowscommunicationsapps' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.WindowsFeedbackHub' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.WindowsMaps' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.WindowsPhone' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.Windows.Photos' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.WindowsSoundRecorder' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.ZuneMusic' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.ZuneVideo' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
}
# In case you have removed them for good, you can try to restore the files using installation medium as follows
# New-Item C:\Mnt -Type Directory | Out-Null
# dism /Mount-Image /ImageFile:D:\sources\install.wim /index:1 /ReadOnly /MountDir:C:\Mnt
# robocopy /S /SEC /R:0 "C:\Mnt\Program Files\WindowsApps" "C:\Program Files\WindowsApps"
# dism /Unmount-Image /Discard /MountDir:C:\Mnt
# Remove-Item -Path C:\Mnt -Recurse

# Uninstall default third party applications
function UninstallThirdPartyBloat {
    Write-Output 'Uninstalling default third party applications...'
    Get-AppxPackage '2414FC7A.Viber' | Remove-AppxPackage
    Get-AppxPackage '41038Axilesoft.ACGMediaPlayer' | Remove-AppxPackage
    Get-AppxPackage '46928bounde.EclipseManager' | Remove-AppxPackage
    # Get-AppxPackage "4DF9E0F8.Netflix" | Remove-AppxPackage
    Get-AppxPackage '64885BlueEdge.OneCalendar' | Remove-AppxPackage
    Get-AppxPackage '7EE7776C.LinkedInforWindows' | Remove-AppxPackage
    Get-AppxPackage '828B5831.HiddenCityMysteryofShadows' | Remove-AppxPackage
    Get-AppxPackage '89006A2E.AutodeskSketchBook' | Remove-AppxPackage
    Get-AppxPackage '9E2F88E3.Twitter' | Remove-AppxPackage
    Get-AppxPackage 'A278AB0D.DisneyMagicKingdoms' | Remove-AppxPackage
    Get-AppxPackage 'A278AB0D.MarchofEmpires' | Remove-AppxPackage
    Get-AppxPackage 'ActiproSoftwareLLC.562882FEEB491' | Remove-AppxPackage
    Get-AppxPackage 'AdobeSystemsIncorporated.AdobePhotoshopExpress' | Remove-AppxPackage
    Get-AppxPackage 'CAF9E577.Plex' | Remove-AppxPackage
    Get-AppxPackage 'D52A8D61.FarmVille2CountryEscape' | Remove-AppxPackage
    Get-AppxPackage 'D5EA27B7.Duolingo-LearnLanguagesforFree' | Remove-AppxPackage
    Get-AppxPackage 'DB6EA5DB.CyberLinkMediaSuiteEssentials' | Remove-AppxPackage
    Get-AppxPackage 'DolbyLaboratories.DolbyAccess' | Remove-AppxPackage
    Get-AppxPackage 'Drawboard.DrawboardPDF' | Remove-AppxPackage
    Get-AppxPackage 'Facebook.Facebook' | Remove-AppxPackage
    Get-AppxPackage 'flaregamesGmbH.RoyalRevolt2' | Remove-AppxPackage
    Get-AppxPackage 'GAMELOFTSA.Asphalt8Airborne' | Remove-AppxPackage
    Get-AppxPackage 'KeeperSecurityInc.Keeper' | Remove-AppxPackage
    Get-AppxPackage 'king.com.BubbleWitch3Saga' | Remove-AppxPackage
    Get-AppxPackage 'king.com.CandyCrushSodaSaga' | Remove-AppxPackage
    Get-AppxPackage 'PandoraMediaInc.29680B314EFC2' | Remove-AppxPackage
    # Get-AppxPackage "SpotifyAB.SpotifyMusic" | Remove-AppxPackage
    Get-AppxPackage 'WinZipComputing.WinZipUniversal' | Remove-AppxPackage
    Get-AppxPackage 'XINGAG.XING' | Remove-AppxPackage
}

# Install default third party applications
function InstallThirdPartyBloat {
    Write-Output 'Installing default third party applications...'
    Get-AppxPackage -AllUsers '2414FC7A.Viber' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers '41038Axilesoft.ACGMediaPlayer' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers '46928bounde.EclipseManager' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers '4DF9E0F8.Netflix' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers '64885BlueEdge.OneCalendar' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers '7EE7776C.LinkedInforWindows' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers '828B5831.HiddenCityMysteryofShadows' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers '89006A2E.AutodeskSketchBook' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers '9E2F88E3.Twitter' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'A278AB0D.DisneyMagicKingdoms' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'A278AB0D.MarchofEmpires' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'ActiproSoftwareLLC.562882FEEB491' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'AdobeSystemsIncorporated.AdobePhotoshopExpress' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'CAF9E577.Plex' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'D52A8D61.FarmVille2CountryEscape' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'D5EA27B7.Duolingo-LearnLanguagesforFree' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'DB6EA5DB.CyberLinkMediaSuiteEssentials' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'DolbyLaboratories.DolbyAccess' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Drawboard.DrawboardPDF' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Facebook.Facebook' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'flaregamesGmbH.RoyalRevolt2' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'GAMELOFTSA.Asphalt8Airborne' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'KeeperSecurityInc.Keeper' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'king.com.BubbleWitch3Saga' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'king.com.CandyCrushSodaSaga' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'PandoraMediaInc.29680B314EFC2' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'SpotifyAB.SpotifyMusic' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'WinZipComputing.WinZipUniversal' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'XINGAG.XING' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
}

# Uninstall Windows Store
function UninstallWindowsStore {
    Write-Output 'Uninstalling Windows Store...'
    Get-AppxPackage 'Microsoft.DesktopAppInstaller' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.WindowsStore' | Remove-AppxPackage
}

# Install Windows Store
function InstallWindowsStore {
    Write-Output 'Installing Windows Store...'
    Get-AppxPackage -AllUsers 'Microsoft.DesktopAppInstaller' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.WindowsStore' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
}

# Disable Xbox features
function DisableXboxFeatures {
    Write-Output 'Disabling Xbox features...'
    Get-AppxPackage 'Microsoft.XboxApp' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.XboxIdentityProvider' | Remove-AppxPackage -ErrorAction SilentlyContinue
    Get-AppxPackage 'Microsoft.XboxSpeechToTextOverlay' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.XboxGameOverlay' | Remove-AppxPackage
    Get-AppxPackage 'Microsoft.Xbox.TCUI' | Remove-AppxPackage
    Set-ItemProperty -Path 'HKCU:\System\GameConfigStore' -Name 'GameDVR_Enabled' -Type DWord -Value 0
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR' | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR' -Name 'AllowGameDVR' -Type DWord -Value 0
}

# Enable Xbox features
function EnableXboxFeatures {
    Write-Output 'Enabling Xbox features...'
    Get-AppxPackage -AllUsers 'Microsoft.XboxApp' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.XboxIdentityProvider' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.XboxSpeechToTextOverlay' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.XboxGameOverlay' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Get-AppxPackage -AllUsers 'Microsoft.Xbox.TCUI' | ForEach-Object { Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" }
    Set-ItemProperty -Path 'HKCU:\System\GameConfigStore' -Name 'GameDVR_Enabled' -Type DWord -Value 1
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR' -Name 'AllowGameDVR' -ErrorAction SilentlyContinue
}

# Disable built-in Adobe Flash in IE and Edge
function DisableAdobeFlash {
    Write-Output 'Disabling built-in Adobe Flash in IE and Edge...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer' -Name 'DisableFlashInIE' -Type DWord -Value 1
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons' -Name 'FlashPlayerEnabled' -Type DWord -Value 0
}

# Enable built-in Adobe Flash in IE and Edge
function EnableAdobeFlash {
    Write-Output 'Enabling built-in Adobe Flash in IE and Edge...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer' -Name 'DisableFlashInIE' -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Addons' -Name 'FlashPlayerEnabled' -ErrorAction SilentlyContinue
}

# Uninstall Windows Media Player
function UninstallMediaPlayer {
    Write-Output 'Uninstalling Windows Media Player...'
    Disable-WindowsOptionalFeature -Online -FeatureName 'WindowsMediaPlayer' -NoRestart -WarningAction SilentlyContinue | Out-Null
}

# Install Windows Media Player
function InstallMediaPlayer {
    Write-Output 'Installing Windows Media Player...'
    Enable-WindowsOptionalFeature -Online -FeatureName 'WindowsMediaPlayer' -NoRestart -WarningAction SilentlyContinue | Out-Null
}

# Uninstall Internet Explorer
function UninstallInternetExplorer {
    Write-Output 'Uninstalling Internet Explorer...'
    Disable-WindowsOptionalFeature -Online -FeatureName "Internet-Explorer-Optional-$env:PROCESSOR_ARCHITECTURE" -NoRestart -WarningAction SilentlyContinue | Out-Null
}

# Install Internet Explorer
function InstallInternetExplorer {
    Write-Output 'Installing Internet Explorer...'
    Enable-WindowsOptionalFeature -Online -FeatureName "Internet-Explorer-Optional-$env:PROCESSOR_ARCHITECTURE" -NoRestart -WarningAction SilentlyContinue | Out-Null
}

# Uninstall Work Folders Client - Not applicable to Server
function UninstallWorkFolders {
    Write-Output 'Uninstalling Work Folders Client...'
    Disable-WindowsOptionalFeature -Online -FeatureName 'WorkFolders-Client' -NoRestart -WarningAction SilentlyContinue | Out-Null
}

# Install Work Folders Client - Not applicable to Server
function InstallWorkFolders {
    Write-Output 'Installing Work Folders Client...'
    Enable-WindowsOptionalFeature -Online -FeatureName 'WorkFolders-Client' -NoRestart -WarningAction SilentlyContinue | Out-Null
}

# Install Linux Subsystem - Applicable to 1607 or newer
function InstallLinuxSubsystem {
    Write-Output 'Installing Linux Subsystem...'
    if ([System.Environment]::OSVersion.Version.Build -eq 14393) {
        # 1607 needs developer mode to be enabled
        Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock' -Name 'AllowDevelopmentWithoutDevLicense' -Type DWord -Value 1
        Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock' -Name 'AllowAllTrustedApps' -Type DWord -Value 1
    }
    Enable-WindowsOptionalFeature -Online -FeatureName 'Microsoft-Windows-Subsystem-Linux' -NoRestart -WarningAction SilentlyContinue | Out-Null
}

# Uninstall Linux Subsystem - Applicable to 1607 or newer
function UninstallLinuxSubsystem {
    Write-Output 'Uninstalling Linux Subsystem...'
    if ([System.Environment]::OSVersion.Version.Build -eq 14393) {
        Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock' -Name 'AllowDevelopmentWithoutDevLicense' -Type DWord -Value 0
        Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock' -Name 'AllowAllTrustedApps' -Type DWord -Value 0
    }
    Disable-WindowsOptionalFeature -Online -FeatureName 'Microsoft-Windows-Subsystem-Linux' -NoRestart -WarningAction SilentlyContinue | Out-Null
}

# Install Hyper-V - Not applicable to Home
function InstallHyperV {
    Write-Output 'Installing Hyper-V...'
    if ((Get-WmiObject -Class 'Win32_OperatingSystem').Caption -like '*Server*') {
        Install-WindowsFeature -Name 'Hyper-V' -IncludeManagementTools -WarningAction SilentlyContinue | Out-Null
    } Else {
        Enable-WindowsOptionalFeature -Online -FeatureName 'Microsoft-Hyper-V-All' -NoRestart -WarningAction SilentlyContinue | Out-Null
    }
}

# Uninstall Hyper-V - Not applicable to Home
function UninstallHyperV {
    Write-Output 'Uninstalling Hyper-V...'
    if ((Get-WmiObject -Class 'Win32_OperatingSystem').Caption -like '*Server*') {
        Uninstall-WindowsFeature -Name 'Hyper-V' -IncludeManagementTools -WarningAction SilentlyContinue | Out-Null
    } Else {
        Disable-WindowsOptionalFeature -Online -FeatureName 'Microsoft-Hyper-V-All' -NoRestart -WarningAction SilentlyContinue | Out-Null
    }
}

# Set Photo Viewer association for bmp, gif, jpg, png and tif
function SetPhotoViewerAssociation {
    Write-Output 'Setting Photo Viewer association for bmp, gif, jpg, png and tif...'
    if (!(Test-Path 'HKCR:')) {
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    }
    ForEach ($type in @('Paint.Picture', 'giffile', 'jpegfile', 'pngfile')) {
        New-Item -Path $("HKCR:\$type\shell\open") -Force | Out-Null
        New-Item -Path $("HKCR:\$type\shell\open\command") | Out-Null
        Set-ItemProperty -Path $("HKCR:\$type\shell\open") -Name 'MuiVerb' -Type ExpandString -Value '@%ProgramFiles%\Windows Photo Viewer\photoviewer.dll,-3043'
        Set-ItemProperty -Path $("HKCR:\$type\shell\open\command") -Name '(Default)' -Type ExpandString -Value "%SystemRoot%\System32\rundll32.exe `"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll`", ImageView_Fullscreen %1"
    }
}

# Unset Photo Viewer association for bmp, gif, jpg, png and tif
function UnsetPhotoViewerAssociation {
    Write-Output 'Unsetting Photo Viewer association for bmp, gif, jpg, png and tif...'
    if (!(Test-Path 'HKCR:')) {
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    }
    Remove-Item -Path 'HKCR:\Paint.Picture\shell\open' -Recurse -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path 'HKCR:\giffile\shell\open' -Name 'MuiVerb' -ErrorAction SilentlyContinue
    Set-ItemProperty -Path 'HKCR:\giffile\shell\open' -Name 'CommandId' -Type String -Value 'IE.File'
    Set-ItemProperty -Path 'HKCR:\giffile\shell\open\command' -Name '(Default)' -Type String -Value "`"$env:SystemDrive\Program Files\Internet Explorer\iexplore.exe`" %1"
    Set-ItemProperty -Path 'HKCR:\giffile\shell\open\command' -Name 'DelegateExecute' -Type String -Value '{17FE9752-0B5A-4665-84CD-569794602F5C}'
    Remove-Item -Path 'HKCR:\jpegfile\shell\open' -Recurse -ErrorAction SilentlyContinue
    Remove-Item -Path 'HKCR:\pngfile\shell\open' -Recurse -ErrorAction SilentlyContinue
}

# Add Photo Viewer to "Open with..."
function AddPhotoViewerOpenWith {
    Write-Output "Adding Photo Viewer to `"Open with...`""
    if (!(Test-Path 'HKCR:')) {
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    }
    New-Item -Path 'HKCR:\Applications\photoviewer.dll\shell\open\command' -Force | Out-Null
    New-Item -Path 'HKCR:\Applications\photoviewer.dll\shell\open\DropTarget' -Force | Out-Null
    Set-ItemProperty -Path 'HKCR:\Applications\photoviewer.dll\shell\open' -Name 'MuiVerb' -Type String -Value '@photoviewer.dll,-3043'
    Set-ItemProperty -Path 'HKCR:\Applications\photoviewer.dll\shell\open\command' -Name '(Default)' -Type ExpandString -Value "%SystemRoot%\System32\rundll32.exe `"%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll`", ImageView_Fullscreen %1"
    Set-ItemProperty -Path 'HKCR:\Applications\photoviewer.dll\shell\open\DropTarget' -Name 'Clsid' -Type String -Value '{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}'
}

# Remove Photo Viewer from "Open with..."
function RemovePhotoViewerOpenWith {
    Write-Output "Removing Photo Viewer from `"Open with...`""
    if (!(Test-Path 'HKCR:')) {
        New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT | Out-Null
    }
    Remove-Item -Path 'HKCR:\Applications\photoviewer.dll\shell\open' -Recurse -ErrorAction SilentlyContinue
}

# Uninstall Microsoft Print to PDF
function UninstallPDFPrinter {
    Write-Output 'Uninstalling Microsoft Print to PDF...'
    Disable-WindowsOptionalFeature -Online -FeatureName 'Printing-PrintToPDFServices-Features' -NoRestart -WarningAction SilentlyContinue | Out-Null
}

# Install Microsoft Print to PDF
function InstallPDFPrinter {
    Write-Output 'Installing Microsoft Print to PDF...'
    Enable-WindowsOptionalFeature -Online -FeatureName 'Printing-PrintToPDFServices-Features' -NoRestart -WarningAction SilentlyContinue | Out-Null
}

# Uninstall Microsoft XPS Document Writer
function UninstallXPSPrinter {
    Write-Output 'Uninstalling Microsoft XPS Document Writer...'
    Disable-WindowsOptionalFeature -Online -FeatureName 'Printing-XPSServices-Features' -NoRestart -WarningAction SilentlyContinue | Out-Null
}

# Install Microsoft XPS Document Writer
function InstallXPSPrinter {
    Write-Output 'Installing Microsoft XPS Document Writer...'
    Enable-WindowsOptionalFeature -Online -FeatureName 'Printing-XPSServices-Features' -NoRestart -WarningAction SilentlyContinue | Out-Null
}

# Remove Default Fax Printer
function RemoveFaxPrinter {
    Write-Output 'Removing Default Fax Printer...'
    Remove-Printer -Name 'Fax' -ErrorAction SilentlyContinue
}

# Add Default Fax Printer
function AddFaxPrinter {
    Write-Output 'Adding Default Fax Printer...'
    Add-Printer -Name 'Fax' -DriverName 'Microsoft Shared Fax Driver' -PortName 'SHRFAX:' -ErrorAction SilentlyContinue
}



##########
# Server specific Tweaks
##########

# Hide Server Manager after login
function HideServerManagerOnLogin {
    Write-Output 'Hiding Server Manager after login...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Server\ServerManager')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Server\ServerManager' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Server\ServerManager' -Name 'DoNotOpenAtLogon' -Type DWord -Value 1
}

# Hide Server Manager after login
function ShowServerManagerOnLogin {
    Write-Output 'Showing Server Manager after login...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Server\ServerManager' -Name 'DoNotOpenAtLogon' -ErrorAction SilentlyContinue
}

# Disable Shutdown Event Tracker
function DisableShutdownTracker {
    Write-Output 'Disabling Shutdown Event Tracker...'
    if (!(Test-Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Reliability')) {
        New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Reliability' -Force | Out-Null
    }
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Reliability' -Name 'ShutdownReasonOn' -Type DWord -Value 0
}

# Enable Shutdown Event Tracker
function EnableShutdownTracker {
    Write-Output 'Enabling Shutdown Event Tracker...'
    Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Reliability' -Name 'ShutdownReasonOn' -ErrorAction SilentlyContinue
}

# Disable password complexity and maximum age requirements
function DisablePasswordPolicy {
    Write-Output 'Disabling password complexity and maximum age requirements...'
    $tmpfile = New-TemporaryFile
    secedit /export /cfg $tmpfile /quiet
    (Get-Content $tmpfile).Replace('PasswordComplexity = 1', 'PasswordComplexity = 0').Replace('MaximumPasswordAge = 42', 'MaximumPasswordAge = -1') | Out-File $tmpfile
    secedit /configure /db "$env:SYSTEMROOT\security\database\local.sdb" /cfg $tmpfile /areas SECURITYPOLICY | Out-Null
    Remove-Item -Path $tmpfile
}

# Enable password complexity and maximum age requirements
function EnablePasswordPolicy {
    Write-Output 'Enabling password complexity and maximum age requirements...'
    $tmpfile = New-TemporaryFile
    secedit /export /cfg $tmpfile /quiet
    (Get-Content $tmpfile).Replace('PasswordComplexity = 0', 'PasswordComplexity = 1').Replace('MaximumPasswordAge = -1', 'MaximumPasswordAge = 42') | Out-File $tmpfile
    secedit /configure /db "$env:SYSTEMROOT\security\database\local.sdb" /cfg $tmpfile /areas SECURITYPOLICY | Out-Null
    Remove-Item -Path $tmpfile
}

# Disable Ctrl+Alt+Del requirement before login
function DisableCtrlAltDelLogin {
    Write-Output 'Disabling Ctrl+Alt+Del requirement before login...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'DisableCAD' -Type DWord -Value 1
}

# Enable Ctrl+Alt+Del requirement before login
function EnableCtrlAltDelLogin {
    Write-Output 'Enabling Ctrl+Alt+Del requirement before login...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name 'DisableCAD' -Type DWord -Value 0
}

# Disable Internet Explorer Enhanced Security Configuration (IE ESC)
function DisableIEEnhancedSecurity {
    Write-Output 'Disabling Internet Explorer Enhanced Security Configuration (IE ESC)...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}' -Name 'IsInstalled' -Type DWord -Value 0
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}' -Name 'IsInstalled' -Type DWord -Value 0
}

# Enable Internet Explorer Enhanced Security Configuration (IE ESC)
function EnableIEEnhancedSecurity {
    Write-Output 'Enabling Internet Explorer Enhanced Security Configuration (IE ESC)...'
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}' -Name 'IsInstalled' -Type DWord -Value 1
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}' -Name 'IsInstalled' -Type DWord -Value 1
}

# Enable Audio
function EnableAudio {
    Write-Output 'Enabling Audio...'
    Set-Service 'Audiosrv' -StartupType Automatic
    Start-Service 'Audiosrv' -WarningAction SilentlyContinue
}

# Disable Audio
function DisableAudio {
    Write-Output 'Disabling Audio...'
    Stop-Service 'Audiosrv' -WarningAction SilentlyContinue
    Set-Service 'Audiosrv' -StartupType Manual
}



##########
# Unpinning
##########

# Unpin all Start Menu tiles - Note: This function has no counterpart. You have to pin the tiles back manually.
function UnpinStartMenuTiles {
    Write-Output 'Unpinning all Start Menu tiles...'
    if ([System.Environment]::OSVersion.Version.Build -ge 15063 -And [System.Environment]::OSVersion.Version.Build -le 16299) {
        Get-ChildItem -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount' -Include '*.group' -Recurse | ForEach-Object {
            $data = (Get-ItemProperty -Path "$($_.PsPath)\Current" -Name 'Data').Data -Join ','
            $data = $data.Substring(0, $data.IndexOf(',0,202,30') + 9) + ',0,202,80,0,0'
            Set-ItemProperty -Path "$($_.PsPath)\Current" -Name 'Data' -Type Binary -Value $data.Split(',')
        }
    } Elseif ([System.Environment]::OSVersion.Version.Build -eq 17133) {
        $key = Get-ChildItem -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount' -Recurse | Where-Object { $_ -like "*start.tilegrid`$windows.data.curatedtilecollection.tilecollection\Current" }
        $data = (Get-ItemProperty -Path $key.PSPath -Name 'Data').Data[0..25] + ([byte[]](202, 50, 0, 226, 44, 1, 1, 0, 0))
        Set-ItemProperty -Path $key.PSPath -Name 'Data' -Type Binary -Value $data
    }
}

# Unpin all Taskbar icons - Note: This function has no counterpart. You have to pin the icons back manually.
function UnpinTaskbarIcons {
    Write-Output 'Unpinning all Taskbar icons...'
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband' -Name 'Favorites' -Type Binary -Value ([byte[]](255))
    Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Taskband' -Name 'FavoritesResolve' -ErrorAction SilentlyContinue
}



##########
# Auxiliary functions
##########

# Relaunch the script with administrator privileges
function RequireAdmin {
    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
        Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -WorkingDirectory $pwd -Verb RunAs
        Exit
    }
}

# Wait for key press
function WaitForKey {
    Write-Output 'Press any key to continue...'
    [Console]::ReadKey($true) | Out-Null
}

# Restart computer
function Restart {
    Write-Output 'Restarting...'
    Restart-Computer
}

function EnableDarkMode {
    Write-Output 'Enabling Dark Mode'
    Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
}

function DisableDarkMode {
    Write-Output 'Disabling Dark Mode'
    Remove-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme
}

##########
# Debloat Script Additions
##########

function Stop-EdgePDF {

    #Stops edge from taking over as the default .PDF viewer
    Write-Output 'Stopping Edge from taking over as the default .PDF viewer'
    $NoPDF = 'HKCR:\.pdf'
    $NoProgids = 'HKCR:\.pdf\OpenWithProgids'
    $NoWithList = 'HKCR:\.pdf\OpenWithList'
    if (!(Get-ItemProperty $NoPDF  NoOpenWith)) {
        New-ItemProperty $NoPDF NoOpenWith
    }
    if (!(Get-ItemProperty $NoPDF  NoStaticDefaultVerb)) {
        New-ItemProperty $NoPDF  NoStaticDefaultVerb
    }
    if (!(Get-ItemProperty $NoProgids  NoOpenWith)) {
        New-ItemProperty $NoProgids  NoOpenWith
    }
    if (!(Get-ItemProperty $NoProgids  NoStaticDefaultVerb)) {
        New-ItemProperty $NoProgids  NoStaticDefaultVerb
    }
    if (!(Get-ItemProperty $NoWithList  NoOpenWith)) {
        New-ItemProperty $NoWithList  NoOpenWith
    }
    if (!(Get-ItemProperty $NoWithList  NoStaticDefaultVerb)) {
        New-ItemProperty $NoWithList  NoStaticDefaultVerb
    }

    #Appends an underscore '_' to the Registry key for Edge
    $Edge = 'HKCR:\AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_'
    if (Test-Path $Edge) {
        Set-Item $Edge AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723_
    }
}

function CreateRestorePoint {
    Write-Output 'Creating Restore Point incase something bad happens'
    Enable-ComputerRestore -Drive 'C:\'
    Checkpoint-Computer -Description 'RestorePoint1' -RestorePointType 'MODIFY_SETTINGS'
}

function DebloatAll {

    $Bloatware = @(

        #Unnecessary Windows 10 AppX Apps
        'Microsoft.BingNews'
        'Microsoft.GetHelp'
        'Microsoft.Getstarted'
        'Microsoft.Messaging'
        'Microsoft.Microsoft3DViewer'
        'Microsoft.MicrosoftSolitaireCollection'
        'Microsoft.NetworkSpeedTest'
        'Microsoft.News'
        'Microsoft.Office.Lens'
        'Microsoft.Office.Sway'
        'Microsoft.OneConnect'
        'Microsoft.People'
        'Microsoft.Print3D'
        'Microsoft.SkypeApp*'
        'Microsoft.StorePurchaseApp'
        'Microsoft.Whiteboard'
        'Microsoft.WindowsAlarms'
        'microsoft.windowscommunicationsapps'
        'Microsoft.WindowsFeedbackHub'
        'Microsoft.WindowsMaps*'
        'Microsoft.WindowsSoundRecorder'
        'Microsoft.ZuneMusic'
        'Microsoft.ZuneVideo'
        'Microsoft.YourPhone*'

        #Sponsored Windows 10 AppX Apps
        #Add sponsored/featured apps to remove in the "*AppName*" format
        '*EclipseManager*'
        '*ActiproSoftwareLLC*'
        '*AdobeSystemsIncorporated.AdobePhotoshopExpress*'
        '*Duolingo-LearnLanguagesforFree*'
        '*PandoraMediaInc*'
        '*CandyCrush*'
        '*BubbleWitch3Saga*'
        '*Wunderlist*'
        '*Flipboard*'
        '*Twitter*'
        '*Facebook*'
        '*Spotify*'
        '*Royal Revolt*'
        '*Sway*'
        '*Speed Test*'
        '*Dolby*'

        #Optional: Typically not removed but you can if you need to for some reason
        #"*Microsoft.Advertising.Xaml_10.1712.5.0_x64__8wekyb3d8bbwe*"
        #"*Microsoft.Advertising.Xaml_10.1712.5.0_x86__8wekyb3d8bbwe*"
        #"*Microsoft.BingWeather*"
        #"*Microsoft.MSPaint*"
        #"*Microsoft.MicrosoftStickyNotes*"
        #"*Microsoft.Windows.Photos*"
        #"*Microsoft.WindowsCalculator*"
        #"*Microsoft.WindowsStore*"
    )
    foreach ($Bloat in $Bloatware) {
        Get-AppxPackage -Name $Bloat | Remove-AppxPackage
        Get-AppxProvisionedPackage -Online | Where-Object DisplayName -Like $Bloat | Remove-AppxProvisionedPackage -Online
        Write-Output "Trying to remove $Bloat."
    }
}

function SetVendor {
    #Requires -RunAsAdministrator
    [CmdletBinding()]
    param (
        $Model = 'Xenon',
        $Manufacturer = 'Raiden'
    )
    $item = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation'
    if (Get-ItemProperty $item) {
        Set-ItemProperty -Path $item -Name 'Model' -Value $Model
        Set-ItemProperty -Path $item -Name 'Manufacturer' -Value $Manufacturer
    } else {
        New-ItemProperty -Path $item -Name 'Model' -Value $Model
        New-ItemProperty -Path $item -Name 'Manufacturer' -Value $Manufacturer
    }
    Rename-Computer -NewName $Model
}
function RemoveCameraRoll {
    #Requires -RunAsAdministrator
    [CmdletBinding()]
    param ()
    $item = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{2B20DF75-1EDA-4039-8097-38798227D5B7}\PropertyBag'
    if (Get-ItemProperty $item) {
        Set-ItemProperty -Path $item -Name 'ThisPCPolicy' -Value "Hide"
    } else {
        New-ItemProperty -Path $item -Name 'ThisPCPolicy' -Value "Hide"
    }
}
function SetSpotifyCache {
    [CmdletBinding()]
    param (
        $storage = 'storage.size=2048'
    )
    $path = (Resolve-Path "$env:USERPROFILE\AppData\Local\Packages\SpotifyAB.SpotifyMusic*\LocalState\Spotify").path | Join-Path -ChildPath 'prefs'
    $storage | Out-File -FilePath $path -Append -Force -Verbose
}


function RemovePowerShellISE {
    [CmdletBinding()]
    param ()
    DISM /Online /Remove-Capability /CapabilityName:Microsoft.Windows.PowerShell.ISE~~~~0.0.1.0
}

function RemoveVSContext {
    [CmdletBinding()]
    param ()
    if (!(Test-Path "HKCR:\Directory\Background\shell\AnyCode\Extended")) {
        New-ItemProperty -Path "HKCR:\Directory\Background\shell\AnyCode\Extended" -Name Extended -PropertyType String -Force -ErrorAction SilentlyContinue
    }
    if (!(Test-Path "HKCR:\Directory\shell\AnyCode\Extended")) {
        New-ItemProperty -Path "HKCR:\Directory\shell\AnyCode\Extended" -Name Extended -PropertyType String -Force -ErrorAction SilentlyContinue
    }
}
##########
# Parse parameters and apply tweaks
##########


if (!(Test-Path 'HKCR:\')) { New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT }

if ($preset) {
    if ($preset -isnot [IO.FileSystemInfo]) {
        $preset = Get-Item $preset
    }
    $tweaks = . $preset
}

# Call the desired tweak functions
$tweaks | ForEach-Object { Invoke-Expression $_ }
