# Stage 1: Build the application
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /src

# Copy project files and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the source code and publish
COPY . ./
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Create the runtime image
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app

# Copy the published app from the build stage
COPY --from=build /app/publish ./

# Make the app listen on port 8080
ENV ASPNETCORE_URLS=http://+:8080

# Expose port
EXPOSE 8080

# Start the app
ENTRYPOINT ["dotnet", "MyWebApp.dll"]
