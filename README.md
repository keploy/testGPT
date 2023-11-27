
<p align="center">
  <img align="center" src="https://docs.keploy.io/img/keploy-logo-dark.svg?s=200&v=4" height="40%" width="500%"  alt="keploy logo"/>
</p>
<br/>

# Overview
It allow users to utilize Keploy's features in test-mode. 

## Usage

Enviormental Varibales needed : -
`working-directory` :- Path where the main code and pkg is present.
`delay` :- is optional, it is the time taken by the application to get started.
`command` :- Command to run the application.
`keploy-path` :- Path where Keploy folder is present.

Right Now languages such as :- `Go`,`Java`,`NodeJS` & `Python` are supported.

```yaml
name: Run test-cases
on:
  push:
    branches:
      - main

jobs:
  my_job:
    runs-on: ubuntu-latest

    steps:
    - name: Keploy Report
      uses: keploy/testgpt@main
      with:
        working-directory: /
        delay: 10
        command: node src/app.js
        keploy-path: ./
```

### Test summary on PR

Before merging PR, `keploy/testgpt@main` would let you in advance whether the test-cases are passing or not. We just need to add the below code on the `job_on:` .

```yml
  pull_request:
    branches:
      - main
```

The test-cases will be visible on both the github_action logs as well as on the PR as the comment, which allows maintainer and contributor to know beforehand if there are fix associated with the PR

![Keploy PR Comment](image.png?raw=true)