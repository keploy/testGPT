# Test-ReportQL

```yaml
name: Run test-cases
on:
  push:
    branches:
      - main
  pull_request:
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
```

Enviormental Varibales needed : -
`working-directory` :- Path where the pkg, keploy folder is present.
`delay` :- is optional, it is the time taken by the application to get started.
`command` :- Command to run the application.

Right Now languages such as :- `Go`,`Java`,`NodeJS` & `Python` are supported.