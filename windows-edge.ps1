# For the times I end up on a 2012 server and IE will no longer operate

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -uri 'https://go.microsoft.com/fwlink/?linkid=2109047&Channel=Stable&language=en' -OutFile c:\temp\SetupEdge.exe
