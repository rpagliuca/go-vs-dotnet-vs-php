FROM microsoft/dotnet:2.2-sdk AS build-env
WORKDIR /app

# Copiar csproj e restaurar dependencias
COPY *.csproj ./
RUN dotnet restore

# Build da aplicacao
COPY . ./
RUN dotnet publish -c Debug -o out

# Build da imagem
FROM microsoft/dotnet:2.2-aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/out .
EXPOSE 5000/tcp
ENTRYPOINT ["dotnet", "TesteApsNetCoreDocker.dll"]