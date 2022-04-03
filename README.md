# Opioner-backend-docker-app

# Goal - MAKE YOUR OPINION COUNT AND SHARE WITH WORLD

# This project is meant to maintain the backend code for the [Opioner - MAKE YOUR OPINION COUNT AND SHARE WITH WORLD](https://souravs17031999.github.io/opioner-home).

Currently, the project is deployed using Heroku servers and all requests are served through Heroku API gateway.
Frontend of [Opioner app](https://github.com/souravs17031999/opioner-home) is served through Github pages but is planned to deploy through AWS in future.

## Running application locally:
  
- Clone this repo    
  `git clone git@github.com:souravs17031999/opioner-backend.git`      
- Start docker service if not started already on your system (Install docker from [here](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04) and docker-compose from [here](https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-18-04))           
- Run all services with docker-compose from cloned project root directory         
  `docker-compose up --build`      
- Your services should be up and running.  

or 

- Run `make local`

## Test the project locally:

- Run `make build`
- Run `make test`

## Test the deployed project:

- Run `make test_postdeploy` 
(useful in CI/CD pipelines)

### ENV VARIABLES FOR RUNNING (before starting the service):

- PGHOST
- PGUSER
- PGPASSWORD
- PGDATABASE
- REQUIRE_DB_INSERT
- POSTGRES_PASSWORD
- POSTGRES_DB
- POSTGRES_USER
- ALLOWED_ORIGIN_HOST_PROD
- REQUIRE_DB_MIGRATIONS
- REQUIRE_DB_INSERT
- SENDGRID_API_KEY_PROD
- FIREBASE_PROFILE_PIC_PATH
- REDIS_URL
- NOTIFICATION_INTERNAL_URL
- HEROKU_API_KEY
- SECRET_KEY

### Microservices:

- [Auth-service](https://github.com/souravs17031999/opioner-backend/tree/master/auth-service)
- [Product-service](https://github.com/souravs17031999/opioner-backend/tree/master/product-service)
- [User-service](https://github.com/souravs17031999/opioner-backend/tree/master/user-service)
- [Notification-service](https://github.com/souravs17031999/opioner-backend/tree/master/notification-service)
- [Cron-service](https://github.com/souravs17031999/opioner-backend/tree/master/cron-service)
- Postgres
- Redis

### Deployment via CI/CD:

- Deployment pipeline follows the deployment via Heroku CI/CD docker container registries to deliver the end product.
- Tests are integrated in the pipeline (preferably Jenkins pipeline) before and after the delivery of end product to make sure we deliver the value of the product without
breaking existing functionality.
- Run `make heroku_deploy` to deploy to Heroku cluster.

### Github CI pipeline:
- Every push to master branch triggers github Makefile CI actions workflow which builds, test and deploy container images.

### New Relic Monitoring
- We already have integrated new relic monitoring dashboards but configuration file `newrelic.ini` will have to be provided (inserted at each service root dir) 
  and set `APM_MONITORING_NEWRELIC` to "True" to start application service with monitoring enabled.
  (for security reasons, configuration file will not be commited to this repo)
  
### Token based authentication
- All authorized routes are protected with JWT based token authentication which is expected by client to send in `Authorization` headers containing claims such as `user-id` and `roles` which can be fetched by first authorized login response token.
 It requires `SECRET_KEY` (random hard password string) for authentication to work properly. 
 
### Pagination in API's
- Some API's such as for fetching public feeds which contains long lists of feeds data generated by various users is paginated for better client side experience
  so as to making rendering smooth, limit the time on API response (database query) and overall avoiding network timeouts/delays.  
  
### Databases (volume persistence)
- Currently, I have explored and made available instances of [Heroku postgresDB](https://devcenter.heroku.com/articles/heroku-postgresql) and [Amazon RDS postgresDB](https://aws.amazon.com/rds/postgresql/) in production. 
- For developmental debugging, volumes persistence (bind mounts/named volumes) is included in docker-compose.yml (using docker-compose)  

### Firebase storage 
- Firebase is used for storage of profile pictures.

## Useful: 
- Each service is built independently using it's own Dockerfile and pushed to Heroku container registeries.
- Then, the container is released into production.
- Final built image (for every service) contains the ENTRYPOINT which starts the flask api service and runs any scripts supplied before actually starting the service.
- Every service waits for the postgres service to start first (controlled by script), as every service depends on this one.
- Repo contains db migration scripts for local setup.

## Docker container optimization
- We have developed base-python-image which contains all the dependencies pre-installed specific to opioner application requirements that are common for consistency among all microservices and improves build time execution.
[python-base-image](https://github.com/souravs17031999/base-os-docker)
  
### Notes:      
- The actual database for app will be mounted automatically at `dbdata` directory owned by docker.     
- You can use Jenkins build locally for testing your changes as it already contains `test` stage which needs to pass all the tests added.     
- For testing purpose, it will automatically create the test database in Jenkins build and will be removed after the container stops.   
- Jenkins CI/CD is already configured in Jenkinsfile and Makefile.    
- We will use dockers to deploy the app in production.   
- `dbinit` contains test data to be migrated while starting postgres container and can be used for testing.
- Currently, db migration step has been added in `auth-service`, in future it maybe be segragated.
- Currently, we have total 5 services: `auth-service`, `user-service`, `product-service`, `notification-service`, `cron-service`.  
- All environment variables in Dockerfile are just default values, actual values are injected on the fly while deployment (not commited due to security reasons).

_Rest API's have been designed using best practices which conveys the exact purpose of what each API does_

_`Build-scripts` contains the useful scripts to be run on Jenkins CI/CD pipeline_

_`Hot reloading`: enabled for all services, server is reloaded as soon as code change is detected in development_

### GDPR compliance:
- All the data processed for user is transparent and is explained on terms and privacy policy page of (Opioner-home website)[https://souravs17031999.github.io/opioner-home]

**Whats coming up ?**
_Delpoyment strategy via Terraform and Kubernetes soon coming up._
