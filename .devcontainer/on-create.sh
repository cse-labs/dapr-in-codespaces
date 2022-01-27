#!/bin/bash

echo "on-create start" >> ~/status

# run dotnet restore
dotnet restore weather/weather.csproj 

# initialize dapr
dapr init

echo "on-create complete" >> ~/status
