# Developing a MapReduce Application

### The Configuration API
* **Combining Resources**: later override the earlier definations, but the properties with `<final>` mark cannot be overridden. 
* **Variable Expansion**:  `${var}` represents a defined variable `var`. System properties are not accessible through the configuration API, unless they are redefine in custom configuration. 

### Setting Up the Development Environment
* **Managing Configuration**: use any configuration file with `-conf` command line. Default configuration in `$HADOOP_CONF_DIR/etc/hadoop`. As a matter of best practice, it’s recommended to keep these files outside Hadoop’s installation directory tree, as this makes it easy to switch between Hadoop versions without duplicating or losing settings.  
* **GenericOptionsParser, Tool, and ToolRunner**: `GenericOptionsParser` is a class that interprets common Hadoop command-line options and sets them on a `Configuration` object for your application to use as desired. `-D` option is used to set the customized configuration with `key=value` pair. 

### Writing a Unit Test with MRUnit
* **Map and Reducer**: use `org.apache.hadoop.mrunit.mapreduce.MapDriver` or `org.apache.hadoop.mrunit.mapreduce.ReduceDriver`. 

### Running Locally on Test Data
* **Running a Job in a Local Job Runner**: The local job runner is used if mapreduce.framework.name is set to local, which is the default.  
* **Testing the Driver**: hard-code the configuration and path in java test code and use junit to test the result. Or use `MiniDFSCluster`, `MiniMRCluster` and `MiniYARNCluster`. 

### Running on a Cluster
* **Packaging a Job**: a job’s classes must be packaged into a job JAR file to send to the cluster. Hadoop will find the job JAR automatically by searching for the JAR on the driver’s classpath that contains the class set in the `setJarByClass()` method (on JobConf or Job). 
> **The client classpath**: (1) The job JAR file set by `hadoop jar <jar>`. (2) Any JAR files in the lib directory of the job JAR file, and the classes directory (if present). (3) The classpath defined by HADOOP_CLASSPATH, if set.   
> **The task classpath**: (1) The job JAR file. (2) Any JAR files contained in the lib directory of the job JAR file, and the classes directory (if present). (3) Any files added to the distributed cache using the `-libjars` option, or the `addFileToClassPath()` method on `DistributedCache` (old API), or `Job` (new API).  
> **Packaging dependencies**: (1) Unpack the libraries and repackage them in the job JAR. (2) Package the libraries in the lib directory of the job JAR. (3) Keep the libraries separate from the job JAR, and add them to the client classpath via HADOOP_CLASSPATH and to the task classpath via -libjars.  
> **Task classpath precedence**: to solve dependency conflict between user's JAR files and Hadoop built-in library, the order of picking up the classes must be controlled. On the client side, put user classpath first by setting `HADOOP_USER_CLASSPATH_FIRST` to `true`. For the task classpath, set `mapreduce.job.user.classpath.first` to `true`.   
* **Launching a job**: `waitForCompletion()` method on `Job` launches the job and polls for progress.
* **The MapReduce Web UI**: `http://resource-manager-host:8088/`.
* **Retrieving the Results**: The `-getmerge` option to the `hadoop fs` command is useful here, as it gets all the files in the directory specified in the source pattern and merges them into a single file on the local filesystem. 
* **Debugging a Job**: create a custom counter to count the total number of records with implausible temperatures in the whole dataset. This gives us valuable information about how to deal with the condition. 
* **Hadoop Logs**: (1) System daemon logs. (2) HDFS audit logs. (3) MapReduce job history logs. (4) MapReduce task logs. 
* **Remote Debugging**: (1) Reproduce the failure locally. (2) Use JVM debugging options. (3) Use task profiling. 

### Tuning a Job
* **Profiling Tasks**: profile a fraction of the tasks in a job and, as each task completes, pulls down the profile information to your machine for later analysis with standard profiling tools.
> **The HPROF profiler**: setting the property `mapreduce.task.profile` to `true`. 

### MapReduce Workflows
* **Decomposing a Problem into MapReduce Jobs**: make map and reduce functions composable. Split a mapper into distinct mappers and chain them into a single mapper using the `ChainMapper` library class.
* **JobControl**: a linear chain of jobs or a more complex directed acyclic graph (DAG) of jobs to make sure jobs are excuted in order. `Boolean` return value of the `waitForCompletion()` method on `Job`: `true` means the job succeeded, `and` false means it failed. `org.apache.hadoop.mapreduce.jobcontrol` package has `JobControl` class which help orchestrate the complex workflow. 
* **Apache Oozie**: a system for running workflows of dependent jobs. 
> **Defining an Oozie workflow**: Workflow definitions are written in XML. 