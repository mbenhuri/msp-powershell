# Creates 3 directories, exenta, exenta\pdf-driver, exenta\barcode-fonts
# -> You can create three directories manually if you want


New-Item -ItemType "directory" -Path "c:\exenta"
New-Item -ItemType "directory" -Path "c:\exenta\pdf-driver"
New-Item -ItemType "directory" -Path "c:\exenta\barcide-fonts"


# Downloads the zip files with CURL
# -> Manually download from below URLs with a web browser


Invoke-WebRequest -Uri "http://exenta-app1.exampledomain.local/exampledomainProdWs/data/PDF.zip" -OutFile "c:\exenta\pdf.zip"
Invoke-WebRequest -Uri "http://exenta-app1.exampledomain.local/exampledomainProdWs/data/Barcode.zip" -OutFile "c:\exenta\barcode.zip"
Invoke-WebRequest -Uri "http://exenta-app1.exampledomain.local/exampledomainProdWs/data/exampledomainProdLoader.zip" -OutFile "c:\exenta\exenta.zip"


# Unzips the downloaded zip files to respective folders

Expand-Archive -Force "c:\exenta\exenta.zip" c:\exenta
Expand-Archive -Force "c:\exenta\pdf.zip" c:\exenta\pdf-driver
Expand-Archive -Force "c:\exenta\barcode.zip" c:\exenta\barcode-fonts


# Sets Working Directory


Set-Location C:\exenta


# Below commands will run the installers


# Start-process -FilePath "c:\exenta\barcode-fonts\Install.exe"
# Start-Process -FilePath "c:\exenta\pdf-driver\InstallPDF.bat"
# Start-Process -FilePath "c:\exenta\loader.exe"
