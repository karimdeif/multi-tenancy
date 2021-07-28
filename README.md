# QuickStarts for Getting Started Guides

This repository contains a set of Quickstarts for the Quarkus framework. Each of them have a Getting started guide.

## Requirements

To compile and run these demos you will need:

- JDK 8 or 11+
- GraalVM

See the [Building a Native Executable guide](https://quarkus.io/guides/building-native-image) for help setting up your environment.

## Use alternative platforms

These quickstart by default currently uses the Quarkus core BOM.

If you want to use an alternative BOM when building the quickstart you can override the `quarkus.platform.*` properties. The following example shows how to set `quarkus.platform.artifact-id` to use the universe-bom.

```
mvn -Dquarkus.platform.artifact-id=quarkus-universe-bom clean install
```

## Contributions

See [CONTRIBUTING](CONTRIBUTING.md) for how to build these examples.

## Quick Start list

* [Hibernate ORM Multitenancy](./hibernate-orm-multi-tenancy-quickstart): Multitenant CRUD service over REST using Hibernate ORM to connect to a PostgreSQL database (schema or database approach)
* [Supporting Multi-Tenancy in OpenID Connect Applications](./security-openid-connect-multi-tenancy-quickstart): How to use OpenId Connect and [Keycloak](https://www.keycloak.org)


There is documentation published at <https://quarkus.io> (docs' [sources are here](https://github.com/quarkusio/quarkus/tree/master/docs/src/main/asciidoc)).

## Architecture

![Architecture Diagram](https://github.com/karimdeif/quarkus-quickstarts/blob/main/diagrams/multi-tenant-app-architecture.png)


