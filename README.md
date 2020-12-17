`docker-compose up`

Alternatively: 
`docker build --rm -t jupyter/my-spark-nb .`
`docker run -it --rm -p 8558:8558 jupyter/pyspark-notebook start.sh jupyter lab`

https://medium.com/@ntruong/jupyterlab-setup-for-my-data-team-84e5724d1bea

https://stackoverflow.com/questions/57138221/error-trying-to-access-aws-s3-using-pyspark

https://www.jitsejan.com/integrating-pyspark-notebook-with-s3.html

Must go install jupyterlab/toc
and go to advanced settings and override default to be true:
`{"collapsibleNotebooks": true}`

spark_version: The Spark version to install (3.0.0).
hadoop_version: The Hadoop version (3.2).
spark_checksum: The package checksum (BFE4540...).
