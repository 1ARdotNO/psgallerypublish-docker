FROM mcr.microsoft.com/powershell:latest as base

SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN Set-PSRepository -Name PSGallery -InstallationPolicy Trusted; \
    Install-Module PowerShellGet -Scope AllUsers -Repository PSGallery -Force

FROM base as publisher
LABEL "com.github.actions.name"         = "Publish to PSGallery"
LABEL "com.github.actions.description"  = "Publish your module to the PowerShell Gallery"
LABEL "com.github.actions.icon"="upload"
LABEL "com.github.actions.color"="blue"

LABEL "name"       = "publish-powershell-module"
LABEL "version"    = "1.0.0"
LABEL "repository" = "https://github.com/OvrAp3x/psgallerypublish-docker"
LABEL "homepage"   = "https://github.com/OvrAp3x"
LABEL "maintainer" = "OvrAp3x"

ADD entrypoint.ps1  /entrypoint.ps1

COPY LICENSE README.md /

RUN chmod +x /entrypoint.ps1

ENTRYPOINT ["pwsh", "/entrypoint.ps1"]
