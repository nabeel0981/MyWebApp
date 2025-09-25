FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
COPY out/ ./
ENTRYPOINT ["dotnet", "MyWebApp.dll"]
