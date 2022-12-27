# escape=`

# ================================================================================================
# Runtime Stage
# ================================================================================================

FROM mcr.microsoft.com/windows/servercore/iis:windowsservercore-ltsc2022
COPY . c:/app
RUN powershell -Command c:/app/run.ps1

ENTRYPOINT ["powershell", "C:\\ServiceMonitor.exe w3svc"]
