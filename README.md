# Heroku Dynatrace Buildpack

The Heroku buildpack for Dynatrace OneAgent enables cloud-native monitoring of your Heroku application by integrating Dynatrace OneAgent into your application’s slug and dyno.

## Usage

This buildpack deploys the [Dynatrace OneAgent] to automatically monitor the performance of your application and microservices in Heroku. This buildpack requires an existing Dynatrace environment and is to be used in addition to the normal [Heroku Language Buildpack] of your project. Please note this buildpack is language-independent and can be used with any [Dynatrace supported language](https://www.dynatrace.com/support/help/technology-support/supported-versions-and-environments/which-environments-and-versions-does-dynatrace-support/#applications-services%E2%80%94databases) for your Heroku environment.

### Installation

To integrate Dynatrace OneAgent into your existing project you need to add the Dynatrace buildpack to your project's buildpacks and set your Dynatrace environment ID and token. For complete details, please see the [Dynatrace Heroku installation guidelines](https://www.dynatrace.com/support/help/cloud-platforms/).

```shell
# Add the Dynatrace buildpack
heroku buildpacks:add https://github.com/Dynatrace/heroku-buildpack-dynatrace.git

# Set required credentials and link your Heroku application with your Dynatrace environment
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
| DT_HOST_ID | The name to be used for the Dyno host entity in Dynatrace. The default name reported by Dynatrace is the Dyno hostname. |
| DT_API_URL | *Optional* - Replace with your Dynatrace Managed URL, including the environment ID. An example URL might look like the following `https://{your-managed-cluster.com}/e/{environmentid}/api` |
| DT_DOWNLOAD_URL | *Optional* - A direct download URL for Dynatrace OneAgent. If this environment variable is set, the buildpack will download the OneAgent from this location. |
| SSL_MODE | *Optional* - Set to `all` if you want to accept all self-signed SSL certificates |
| DT_TAGS | *Optional* - The tags you want to add to the monitored apps. |


## License

Licensed under the MIT License. See the [LICENSE] file for details.

[Dynatrace OneAgent]: https://www.dynatrace.com
[Heroku Language Buildpack]: https://devcenter.heroku.com/articles/buildpacks#default-buildpacks
[LICENSE]: https://github.com/dynatrace/heroku-buildpack-dynatrace/blob/master/LICENSE
