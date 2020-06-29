# eci-monitoring
ECI metrics with graphite and grafana docker-compose

Configure the environment variables in the docker-compose.yaml:

| Variable | Example | Description |
| --- | --- | --- |
| ECI_URL |https://eci.ec.europa.eu/012/public | URL of the signatures site |
|ECI_NAME |finning  | Arbitrary name for identifying whisper metrics | 


Run the docker-compose.yaml
```bash
$ docker-compose up -d
```

Manually import the dashboard at grafana/signatures.yml.

## Enjoy!

![Screenshot 2020-06-26 at 00 19 10](https://user-images.githubusercontent.com/9881318/85801212-aad48380-b742-11ea-829a-bdd2ba9f83c7.png)
