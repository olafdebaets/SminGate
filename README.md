# Swisscom SminGate Coding Challenge CI/CD

## Background
The "Hello World" application is running in Kubernetes and requires additional parameters from an external data source, which can be retrieved via an API. The API requires an authentication request, providing a token, authorizing subsequent query requests. 
The objective of this task is to create an automation, which authenticates against the API of the external data source, retrieves the parameters, and deploys the "Hello World" application including the retrieved data to Kubernetes.

## Tasks
Part 1 involves creating the automation given specific presets. Part 2 involves critacally questioning the presets.

### 1.
* Create a Bash script which retrieves the token for the external data source API, then retrieves PARAMETER1 and PARAMETER2, passing the token via http GET parameter named 'TOKEN'.

-> Solution: getParamters.sh

* Create a docker image, ready to run this bash script.

-> Solution: dockerfile included getParamters.sh and CI workflow to create the dockerimage smingate:0.1

* Extend the Bash script to generate a plain kubernetes deployment yaml, deploying the "Hello World" app. The provided deployment must result in the container outputting "HELLO WORD , {parmater1} - {parmater1}" on startup, with the retrieved values of PARAMETER1 and PARAMETER2.

-> Solution: please see extendedGetParameters.sh

### 2.
* Please come up with an alternative way to deploy the "Hello World" application with the same end result as with part 1, then briefly debate the pros and cons of both solutions.
* Please note: it is not required to create a demonstration of the alternative solution.

-> Instead of having a script, which retrieves the token and consequently the two parameters, one could create a deployment with two pods. The first pod in the deployment could be an init container and could retrieve the token and paramters, the second pod could print the "hello world" text with the two values.

Advantages: Tightly coupled functionality belongs together in one deployment, the normal container would be dependent on the init container, only when the token and values are fetched, the print output container would be started.

Disavantages: increased need of resources: there is an additional container to be run and secondly, on an init container we cannot put liveness probes, the check if it is running.
