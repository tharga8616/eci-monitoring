# eci-monitoring
ECI metrics with graphite and grafana docker-compose

Configure the environment variables in the docker-compose.yaml:

| Variable | Example | Description |
| --- | --- | --- |
| ECI_URL |https://eci.ec.europa.eu/012/public | URL of the signatures site |
|ECI_NAME |unconditionalbasicincome  | Arbitrary name for identifying whisper metrics | 


Run the docker-compose.yaml
```bash
$ docker-compose up -d
```
Add the graphite datasource

![Screenshot 2020-08-19 at 04 37 11](https://user-images.githubusercontent.com/9881318/90585717-c48bc780-e1d5-11ea-8e5f-133ee54392d7.png)


Manually import the dashboard at [grafana/signatures.yml](https://github.com/tharga8616/eci-monitoring/blob/master/grafana/signatures.yml) and substitute all "finning" words by your $ECI_NAME

Configure graphite to show metrics older than 12h
/var/lib/docker/volumes/ecimonitoring_graphite-conf/_data/storage-schemas.conf
```
[carbon]
pattern = ^carbon\.
retentions = 10s:6h,1m:90d

[eci]
pattern = ^eci.*
retentions = 5m:3y
```
/var/lib/docker/volumes/ecimonitoring_graphite-conf/_data/storage-aggregation.conf
```
[min]
pattern = \.lower$
xFilesFactor = 0.1
aggregationMethod = min

[max]
pattern = \.upper(_\d+)?$
xFilesFactor = 0.1
aggregationMethod = max

[sum]
pattern = \.sum$
xFilesFactor = 0
aggregationMethod = sum

[count]
pattern = \.count$
xFilesFactor = 0
aggregationMethod = sum

[count_legacy]
pattern = ^stats_counts.*
xFilesFactor = 0
aggregationMethod = sum

[default_average]
pattern = .*
xFilesFactor = 0.3
aggregationMethod = average
```

Configure grafana to allow anonymous users to see graph
Place this [config file](https://github.com/tharga8616/eci-monitoring/blob/master/grafana/defaults.ini) into /var/lib/docker/volumes/ecimonitoring_grafana-conf/_data/defaults.ini

## Enjoy!

![Screenshot 2020-06-26 at 00 19 10](https://user-images.githubusercontent.com/9881318/85801212-aad48380-b742-11ea-829a-bdd2ba9f83c7.png)

https://grafana.unconditionalbasicincome.eu/
