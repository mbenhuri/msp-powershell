# Import-Module Microsoft.Graph.Identity.DirectoryManagement
Connect-MgGraph -Scopes "Directory.ReadWrite.All", "DeviceManagementConfiguration.ReadWrite.All","Device.ReadWrite.All"

# Read the CSV file, alternately this can run on a get-mgdevice query with one change listed below
$devices = Import-Csv -Path "c:\temp\devices.csv"


# Loop through devices 
foreach ($device in $devices) {

# Because the export from Azure AD GUI lists object ID, the CSV does so it is listed here
# If this script was based on a get-mgdevice it would have to be $device.id
$deviceId = $device.objectId

# Sets the parameters. ExtensionAttribute1 is a sub attribute to extensionAttributes, so there are 2 hashtables.
$params = @{
			"extensionAttributes" = @{
							ExtensionAttribute1 = "SAW"
						} 
    }

    try {
        # Update the device's ExtensionAttribute1
        Update-MgDevice -DeviceId $deviceId -BodyParameter $params
        Write-Host "Successfully updated device $deviceId" -ForegroundColor Green
    } catch {
        Write-Host "Error updating device $deviceId': $_" -ForegroundColor Red
    }
}
