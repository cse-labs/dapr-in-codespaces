# Dapr in Codespaces

> Dapr 101 Hands-on Lab

![License](https://img.shields.io/badge/license-MIT-green.svg)

## Overview

This is a template that will setup a Dapr development environment in `GitHub Codespaces`

For ideas, feature requests, and discussions, please use GitHub issues so we can collaborate and follow up.

This Codespace is tested with `zsh` and `oh-my-zsh` - it "should" work with bash but hasn't been fully tested. For the HoL, please use zsh to avoid any issues.

You can run the `dev container` locally and you can also connect to the Codespace with a local version of VS Code.

Please experiment and add any issues to the GitHub Discussion. We LOVE PRs!

The motivation for creating and using Codespaces is highlighted by this [GitHub Blog Post](https://github.blog/2021-08-11-githubs-engineering-team-moved-codespaces/). "It eliminated the fragility and single-track model of local development environments, but it also gave us a powerful new point of leverage for improving GitHub’s developer experience."

Cory Wilkerson, Senior Director of Engineering at GitHub, recorded a podcast where he shared the GitHub journey to [Codespaces](https://changelog.com/podcast/459)

## Open with Codespaces

> You must be a member of the Microsoft OSS and CSE-Labs GitHub organizations

- Instructions for joining the GitHub orgs are [here](https://github.com/cse-labs/moss)
  - If you don't see an `Open in Codespaces` option, you are not part of the organization(s)

- Click the `Code` button on this repo
- Click the `Codespaces` tab
- Click `New Codespace`
- Choose the `4 core` option

![Create Codespace](./images/OpenWithCodespaces.jpg)

## Dapr Lab

> make sure you are in the root of the repo

### Create and run a Web API app with Dapr

Create a new dotnet webapi project

```bash

mkdir -p dapr-app
cd dapr-app
dotnet new webapi --no-https

```

Run the app with Dapr

```bash

dapr run -a myapp -p 5000 -H 3500 -- dotnet run

```

Check the endpoints

- open `dapr.http`
  - click on the `dotnet app` `send request` link
  - click on the `dapr endpoint` `send request` link

Open Zipkin

- Click on the `Ports` tab
  - Open the `Zipkin` link
  - Click on `Run Query`
    - Explore the traces generated automatically with Dapr

Stop the app by pressing `ctl-c`

Clean up

```bash

cd ..
rm -rf dapr-app

```

### Add Dapr SDK to the weather app

> Changes to the app have already been made and are detailed below

- Open `.vscode/launch.json`
  - Added `.NET Core Launch (web) with Dapr` configuration
- Open `.vscode/task.json`
  - Added `daprd-debug` and `daprd-down` tasks
- Open `weather/weather.csproj`
  - Added `dapr.aspnetcore` package reference
- Open `weather/Startup.cs`
  - Injected Dapr into the services
    - Line 29 `services.AddControllers().AddDapr()`
  - Added `Cloud Events`
    - Line 40 `app.UseCloudEvents()`
- Open `weather/Controllers/WeatherForecastController.cs`
  - `PostWeatherForecast` is a new function for `sending` pub-sub events
    - Added the `Dapr.Topic` attribute
    - Got the `daprClient` via Dependency Injection
    - Published the model to the `State Store`
  - `Get`
    - Added the `daprClient` via Dependency Injection
    - Retrieved the model from the `State Store`
  - Set a breakpoint on lines 30 and 38

### Run the Dapr weather app

- Click on one of the VS Code panels to make sure it has the focus, then Press `F5` to run
- Alternatively, you can use the `hamburger` menu, then `Run` and `Start Debugging`
- Open `dapr.http`
  - Send a message via Dapr
    - Click on `Send Request` under `post to Dapr`
    - Click `continue` when you hit the breakpoint
    - 200 OK
  - Get the model from the `State Store`
    - Click on `Send Request` under `Dapr endpoint`
    - Click `continue` when you hit the breakpoint
    - Verify the value from the POST request appears
  - Change the `temperatureC` value in POST request and repeat

### Engineering Docs

- Team Working [Agreement](.github/WorkingAgreement.md)
- Team [Engineering Practices](.github/EngineeringPractices.md)
- CSE Engineering Fundamentals [Playbook](https://github.com/Microsoft/code-with-engineering-playbook)

## How to file issues and get help

This project uses GitHub Issues to track bugs and feature requests. Please search the existing issues before filing new issues to avoid duplicates. For new issues, file your bug or feature request as a new issue.

For help and questions about using this project, please open a GitHub issue.

## Contributing

This project welcomes contributions and suggestions.  Most contributions require you to agree to a Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us the rights to use your contribution. For details, visit <https://cla.opensource.microsoft.com>

When you submit a pull request, a CLA bot will automatically determine whether you need to provide a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions provided by the bot. You will only need to do this once across all repos using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

## Trademarks

This project may contain trademarks or logos for projects, products, or services.

Authorized use of Microsoft trademarks or logos is subject to and must follow [Microsoft's Trademark & Brand Guidelines](https://www.microsoft.com/en-us/legal/intellectualproperty/trademarks/usage/general).

Use of Microsoft trademarks or logos in modified versions of this project must not cause confusion or imply Microsoft sponsorship.

Any use of third-party trademarks or logos are subject to those third-party's policies.
