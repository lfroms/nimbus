<h1 align="center">
  &#x26c8;
  <br>
  Nimbus 
  <br>
</h1>

<h4 align="center">A powerful weather data aggregation service, written in Ruby and built using Ruby on Rails. Open source.</h4>

<p align="center">
  <a href="https://github.com/lfroms/nimbus/issues"><img alt="GitHub issues" src="https://img.shields.io/github/issues/lfroms/nimbus"></a>
  <img alt="GitHub contributors" src="https://img.shields.io/github/contributors/lfroms/nimbus">
  <a href="https://github.com/lfroms/nimbus/stargazers"><img alt="GitHub stars" src="https://img.shields.io/github/stars/lfroms/nimbus"></a>
  <a href="https://github.com/lfroms/nimbus"><img alt="GitHub license" src="https://img.shields.io/github/license/lfroms/nimbus"></a>
  <img alt="Contributions welcome" src="https://img.shields.io/badge/contributions-welcome-orange">
</p>

<p align="center">
  <a href="#about">About</a> •
  <a href="#supported-regions">Supported Regions</a> •
  <a href="#getting-started">Getting Started</a> •
  <a href="#contributing">Contributing</a> •
  <a href="#license">License</a>
</p>

## About

Nimbus is a weather data aggregation service, much like Dark Sky's API, or OpenWeatherMap's API. It's written in Ruby using Ruby on Rails. Nimbus uses GraphQL to efficiently serve weather data to mobile and web applications alike. Nimbus was designed to work hand-in-hand with [Clouds](https://github.com/lfroms/clouds), a unique weather app written in [SwiftUI](https://developer.apple.com/xcode/swiftui/).

### Vision & Goals

* **Fast.** It should serve data as quickly as possible.
* **Efficient.** Using GraphQL, Nimbus only serves (and processes) the requested data, and should not waste compute time.
* **Trustworthy.** Weather data should be accurate, and from trusted sources.
* **Global.** Nimbus should (eventually) be able to serve data from any location on the planet.

## Supported Regions

Currently, the following regions are supported:

* Canada _via_ [Environment Canada](https://weather.gc.ca)

### Radar

Radar regions are independent from weather regions. Currently, the following data sources are supported:

* [MSC GeoMet](https://eccc-msc.github.io/open-data/) (Environment and Climate Change Canada)
* [RainViewer](https://www.rainviewer.com), which provides global radar imagery.

## Getting Started

To get started, you'll need to pull the source code. Find yourself a working directory, and clone this repo to it. I recommend using [GitHub Desktop](https://desktop.github.com).

Otherwise, pull it using the `git` CLI:
```sh
git clone https://github.com/lfroms/nimbus.git
```

Then, navigate into the cloned repository:
```sh
cd nimbus
```

If you are unfamiliar with [Rails](https://rubyonrails.org), you should follow the [Getting Started Guide](https://guides.rubyonrails.org/getting_started.html) to learn how to get Rails running on your system before starting.

Once everything is installed, set up the database:

```sh
rails db:setup
```

Then, load the weather regions:

```sh
rails c
```
```ruby
Stations::EnvironmentCanada::StationListSyncService.execute
```

Finally, you can start the server:
```sh
rails s
```

Once the server is booted, you can query the GraphQL endpoint at `localhost:3000/graphql`.

## Contributing

### Code
If you have any improvements that you'd like to make to Nimbus, please create a branch and open a pull request! This project is meant to be community-driven. It cannot evolve without your help! Please be mindful of the software architecture. It can't be maintained if you're the only person that is able to understand what it does.  When in doubt, try to mimic the existing architecture. If you think that the architecture can be improved, please [open an issue](https://github.com/lfroms/nimbus/issues/new/choose). Architecture and decisions should be documented in the [Wiki](https://github.com/lfroms/nimbus/wiki).

Oh, and please write tests. There aren't any tests right now, but I simply don't have the capacity to write them. All new contributions _should_ be tested.

Code should be linted using [RuboCop](https://rubocop.org). Please ensure that you've executed `rubocop -A` before pushing your changes.

### Documentation
Nimbus needs better documentation! The [Wiki](https://github.com/lfroms/nimbus/wiki) sure could use some help. Think the README needs some more information? Add it!

## Deployment

Nimbus is deployed to Heroku on a regular basis, provided that there are enough changes to justify a new deploy. Pressing bug fixes will be deployed promptly. Before deploying and merging code, all changes should be tested on the staging server. Tag [**@lfroms**](https://github.com/lfroms) to request that your pull request be deployed to the staging server.

## License

Nimbus is released under the [MIT License](LICENSE.md).
