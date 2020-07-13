Add the following to ~/.aws/config

```
[profile its]
output = json
region = eu-west-1
aws_access_key_id = AKIAUZBL73ARI2262TRU
aws_secret_access_key = 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
```



```
$ eb init --profile its
$ eb create live
$ eb eb status

$ rake secret
generatesalongkey
$ eb setenv SECRET_KEY_BASE=generatesalongkey


$ eb setenv MYSQL_HOST=its-database-server.c5fcghkkunxe.eu-west-1.rds.amazonaws.com MYSQL_PORT=3306 MYSQL_DATABASE=its_prod_jul12_2019 MYSQL_USERNAME=admin MYSQL_PASSWORD=ITSLabel2020



```




