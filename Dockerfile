FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS base
WORKDIR /app
COPY out/ ./
ENV ASPNETCORE_URLS=http://+:80
ENTRYPOINT ["dotnet", "MyWebApp.dll"]
