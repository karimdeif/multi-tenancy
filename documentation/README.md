# Multi tenancy

**------------------**
**UNDER CONSTRUCTION**
**------------------**

### Multi-tenancy projects

* [Serverless](https://github.com/karimdeif/multi-tenancy)
* [OpenShift](https://github.com/kleniu/openshift-multi-tenancy)
* [Satellite]()

### Target architecture `serverless`:

* One frontend per tenant, one business logic per tenant.

![](images/Mulit-Tenancy-architecture-codeengine-serverless.png)

* Just a single tenant.

![](images/Multi-tenancy-serverless.png)

### Objectives for sprint in week 41 `serverless`

These are the main objectives for this sprint.

#### 1 **Running simple ecommerce application on Code Engine**

  * App ID is configured **(DONE)**
  * Frontend is integrated with AppID **(DONE)**
  * Backend is integrated with AppID **(PENDING)**
  * Backend is integrated postgres **(DONE)**
  * Postgres is setup **(DONE)**

#### 2  **Automation of the deployment**
      
  * Installation and setup is more about **creation** **(IN PROGRESS)** ([link to the bash script for initial creation](https://github.com/karimdeif/multi-tenancy/blob/main/installapp/ce-create-two-tenantcies.sh))
  * CI/CD is more about **update** **(IN PROGRESS)** ([link to the Toolchain with the tekton pipeline](https://cloud.ibm.com/devops/toolchains/92bb1c04-7f8a-4984-ab8a-2da143a96476?env_id=ibm:yp:us-south))

#### **Differences between creation and update**

  * Creation ([link to the bash script for initial creation](https://github.com/karimdeif/multi-tenancy/blob/main/installapp/ce-create-two-tenantcies.sh))
 
  ![](images/Mulit-Tenancy-installation-cicd-02.png)

  * Update ([link to the Toolchain with the tekton pipeline](https://cloud.ibm.com/devops/toolchains/92bb1c04-7f8a-4984-ab8a-2da143a96476?env_id=ibm:yp:us-south))

  ![](images/Mulit-Tenancy-installation-cicd-01.png)

##### **Used CLIs and APIs for the automation**

  * [AppID REST API](https://us-south.appid.cloud.ibm.com/swagger-ui)
  * [IBM Cloud CLI](https://cloud.ibm.com/docs/cli?topic=cli-getting-started)
  * [Code Engine CLI](https://cloud.ibm.com/docs/codeengine?topic=codeengine-cli)
  * [Cloud databases CLI](https://cloud.ibm.com/docs/databases-cli-plugin?topic=databases-cli-plugin-cdb-reference)

#### 3  **Documenation of the setup**

  * Manual setup **(pending)**
  * Automation setup **(in progress)**
  * Workshop **(pending)**

### Table of tasks

* Project tasks/activities in [ZenHub link](https://github.com/karimdeif/multi-tenancy#workspaces/serverless-6152c725095153001243b1aa/board?repos=388999110)

|   | Objectives |  Status | Priority |  Notes | 
|---|---|---|---|---|
| 1 | **Running simple ecommerce application including Quarkus on Code Engine** |  in progress | high |Running example: [tenant b](https://frontend-oidc-b.ceqctuyxg6m.us-south.codeengine.appdomain.cloud/), [tenant a](https://frontend-oidc-a.ceqctuyxg6m.us-south.codeengine.appdomain.cloud/)  |
| 1.0 | - Create a folder for the source code of the applications called **code** |  **done** | high | Inside the folder the name on the subfolders should refect the appliation name. |
| 1.1 | - AppID setup |  **done** | high |  |
| 1.2 | - AppID integration to frontend |  **done** | high |  |
| 1.3 | - AppID integration to Backend |  open | high |  |
| 1.4 | - Backend database postgres integration |  done | high |  |
| 1.5 | - Deploy to Code Engine |  in progress | high | the intergrated appid frontend and postgress backend is deployed |
| 2 | **Automation of the deployment** | in progress | high |  |
| 2.0 | - Define a folder structure for the **installation/setup and CI/CD** | **done** | high | one folder call **installapp** (first time installation) **cicd** (continuous delivery realization with tekton) |
| 2.1 | - Create containers and save them in a public container registry | open | high |  |
| 2.2 | - Create a bash automation for the creation and configuration of AppID | inprogress | high | Thomas need to copy the work he did the the project. |
| 2.3 | - Create a bash automation for the creation and configuration of postgres | open | high |  |
| 2.4 | - Create a bash automation for deployment to Code Engine | in progress | high |  |
| 2.5 | - Setup tekton using the IBM Cloud toolchain | in progress | high |  |
| 2.6 | - Integrate exiting bash automations to tekton pipeline | open | high |  |
| 2.7 | - Add an admin UI for onboarding of new tenant roberts application |  open | low |  |
| 2.7 | - Problem to start the frontend container in code engine |  open | high |  |
| 3 | **Documenation of the setup** | open | high | We should use **mkdocs** |  
| 3.1 | - Manual setup | open | high |  |  
| 3.2 | - Automation setup | open | high |  |
| 3.3 | - Workshop  | open | low |  |

### Technology Used

The example ecommerce mircorservices application is build on following `technologies/services/tools/frameworks`.

  * [Microservices architecture](https://en.wikipedia.org/wiki/Microservices)
  * [OpenID Connect](https://openid.net/connect/)
  * [Jakarta EE](https://jakarta.ee/)
  * [MicroProfile](https://microprofile.io/)

---

  * [IBM Cloud Code Engine](https://cloud.ibm.com/docs/codeengine?topic=codeengine-about)
  * [Postgres](https://cloud.ibm.com/databases/databases-for-postgresql/create)
  * [AppID](https://www.ibm.com/de-de/cloud/app-id)
  * [Toolchain](https://cloud.ibm.com/docs/ContinuousDelivery?topic=ContinuousDelivery-toolchains_getting_started)

---

  * [Quarkus](https://quarkus.io/ingress)
  * [Vue.js](https://vuejs.org/)

---

  * [NGINX](https://www.nginx.com/)
  * [git 2.24.1 or higher](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  * [yarn 1.22.4 or higher](https://yarnpkg.com)
  * [Node.js v14.6.0 or higher](https://nodejs.org/en/)
  * [Apache Maven 3.6.3](https://maven.apache.org/ref/3.6.3/maven-embedder/cli.html)
  * [Quay](https://quay.io/)
  * [Tekton](https://tekton.dev/)

---

  * [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))
  * [jq](https://lzone.de/cheat-sheet/jq)
  * [sed](https://en.wikipedia.org/wiki/Sed)
  * [grep](https://en.wikipedia.org/wiki/Grep)
  