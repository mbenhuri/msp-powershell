# This runs the mdm diagnostics tool and extracts the only csv
# the csv file contains the device hash and can be used to enroll to autopilot

mdmdiagnosticstool.exe -area "DeviceEnrollment;DeviceProvisioning;Autopilot" -zip "c:\temp\MDMDiagReport.zip"
tar -xvzf c:\temp\MDMDiagReport.zip *.csv
