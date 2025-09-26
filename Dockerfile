# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy project files and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy all source code and publish
COPY . ./
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Runtime image
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app

# Copy published files into /app root
COPY --from=build /app/publish/. ./

# Make the app listen on port 80
ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80

# Start the app
ENTRYPOINT ["dotnet", "MyWebApp.dll"]
