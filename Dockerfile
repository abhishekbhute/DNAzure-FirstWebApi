#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS build-env
WORKDIR /app

COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY ../engine/examples ./
RUN dotnet publish -c Release -o out


FROM mcr.microsoft.com/dotnet/aspnet:3.1
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "MyFirstWebApi.dll"]