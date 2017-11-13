# Heroku Dynatrace Buildpack

This Heroku buildpack installs the [Dynatrace OneAgent] for cloud-native monitoring of your Heroku applications.

## Usage

This buildpack deploys the [Dynatrace OneAgent] to automatically monitor the performance of your application and microservices in Heroku. This buildpack requires an existing Dynatrace environment and is to be used in addition to the normal [Heroku Language Buildpack] of your project. Please note this buildpack is language independent and can be used with any Dynatrace supported language for your Heroku environment.

### Installation

To install Dynatrace OneAgent to your project you need to add the Dynatrace buildpack to your project's buildpacks and set your Dynatrace environment ID and token.

```shell

# Define the language-specific buildpack of your project (if not done already)
heroku buildpacks:set heroku/java

# Add the Dynatrace buildpack
heroku buildpacks:add --index 1 https://github.com/Dynatrace/heroku-buildpack-dynatrace.git

# Set required credentials to your Dynatrace environment
heroku config:set DT_TENANT=<your-environment-id>
heroku config:set DT_API_TOKEN=<your-paas-token>

# Set hostname in Dynatrace
heroku config:set DT_HOST_ID=$(heroku apps:info|grep ===|cut -d' ' -f2)

# Deploy to Heroku
git push heroku master
```

After pushing the changes the buildpack installs Dynatrace OneAgent to automatically monitor the application.

### Configuration

The Dynatrace buildpack supports the following configurations:

| Environment variable | Description|
| --- | --- |
| DT_TENANT | Your Dynatrace environment ID is the unique identifier of your Dynatrace environment. You can find it in the deploy Dynatrace section within your environment. |
| DT_API_TOKEN | The token for integrating your Dynatrace environment with Heroku. You can find it in the deploy Dynatrace section within your environment. |
| DT_API_URL | *Optional* - Replace with your Dynatrace Managed URL, including the environment ID. An example URL might look like the following `https://{your-managed-cluster.com}/e/{environmentid}/api` |
| DT_DOWNLOAD_URL | *Optional* - A direct download URL for Dynatrace OneAgent. If this environment variable is set, the buildpack will download the OneAgent from this location. |
| SSL_MODE | *Optional* - Set to `all` if you want to accept all self-signed SSL certificates |
| DT_HOST_ID | *Optional* - The name to be used for the Dyno host entity in Dynatrace. The default name reported by Dynatrace is the Dyno hostname. |
| DT_TAGS | *Optional* - The tags you want to add to the monitored apps. |

## Disclaimer

This buildpack is supported by the Dynatrace Innovation Lab.
Please create an issue for this repository if you need help.

## License

Licensed under the MIT License. See the [LICENSE] file for details.

[Dynatrace OneAgent]: https://www.dynatrace.com
[Heroku Language Buildpack]: https://devcenter.heroku.com/articles/buildpacks#default-buildpacks
[LICENSE]: https://github.com/dynatrace/heroku-buildpack-dynatrace/blob/master/LICENSE
