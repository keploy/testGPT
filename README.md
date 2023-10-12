# Test-ReportQL

```yaml
 - name: Test-Report
      uses: alphasians/test-reportql@main
      with:
        working-directory: /
        delay: 10
        command: node src/app.js
```

Enviormental Varibales needed : -
`working-directory` :- Path where the pkg, keploy folder is present.
`delay` :- is optional, it is the time taken by the application to get started.
`command` :- Command to run the application.