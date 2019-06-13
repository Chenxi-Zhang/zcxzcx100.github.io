# MapReduce Features

### Counters: gathering statistics about the job
* **Built-in Counters**: 
> **Task counters**: gather information about tasks over the course of their execution, and the results are aggregated over all the tasks in a job. 
> **Job counters**: measure job-level statistics, and are maintained by the app master. 

* **User-Defined Java Counters**: Counters are defined by a Java enum. Counters are global. 

```Java
enum Temperature {
    MISSING,
    MALFORMED
}
context.getCounter(Temperature.MISSING).increment(1);
```
> **Dynamic counters**: `public Counter getCounter(String groupName, String counterName)` in context. 
> **Retrieving counters**: `Job` from `cluster.getJob(JobID.forName(jobID))`. `Counters` returns from `job.getCounter()`. It has a method `findCounter(enum name).getValue()`. 
* **User-Defined Streaming Counters**: increment counters by sending a specially for‐ matted line to the standard error stream: `reporter:counter:group,counter,amount`

### Sorting
* **Preparation**: keys need to be ready to sort (`IntWritable` type).
* **Partial Sort**: MapReduce sorts the input at 'Shuffle and Sort' stage. Each of the output from reducers is sorted, but there is no easy way to combine the files to produce a globally sorted file. 
* **Total Sort**: use a partitioner that respects the total order of the outputs instead of its hash code. `InputSampler` to approximate the key distribution from a small subset of the keys. The key distribution is used to split the input evenly. 
* **Secondary Sort**: `Mapper` sorts the key, but the values of a particular key are not sorted. Change the keys to be composite: key-value. Set partitioner to send the same year values go to the same reducer. Group values in the reducer by the original key part of the key-value composite. 
> 需要自己写`IntPair class implements WritableComparable<IntPair>`实现key-value的组合。除了必须实现的方法外，还需要`hashcode()`，默认构造函数（在读取数据时需要），`toString()`在写入文件时需要。
* **Streaming**: use library classes that Hadoop provides in command line. 
### Joins: Pig, Hive, Cascading, Cruc, or Spark
* **Map-Side Joins**: Each input dataset must be divided into the same number of partitions, and it must be sorted by the same key (the join key) in each source. All the records for a particular key must reside in the same partition. 
* **Reduce-Side Joins**:  mapper tags each record with its source and uses the join key as the map output key. `job.setGroupingComparatorClass()` sets the grouping comparator which puts all records with the same join key in the same group. Reducer combines the two-source records with all different ways. 

### Side Data Distribution: Side data can be defined as extra read-only data needed by a job to process the main dataset.
* **Using the Job Configuration**: set arbitrary key-value pairs in the job configuration using the various setter methods on `Configuration`. Retrieve it from `Context`'s `getConfiguration()`. Better be less than a few kilobytes. 
* **Distributed Cache**: copies files and archives to the task nodes in time for the tasks to use them when they run. 
> **Usage**: if implementing `GenericOptionsParser`, uses `-files` with comma-separated list of URIs to specify the files. Default file scheme is local filesystem. `-archives` to copy archive files. `-libjars` to add JAR files to the classpath of the mapper and reducer tasks. Reducer's `setup()` method to retrieve the cache file.
> **How it works**: When launch a job, files are copied to distributed filesystem. Then, before a task is run, the *node manager* copies the files from distributed filesystem to a local disk--the cache (localized). *Node manager* maintains a reference count for the number of tasks using each file in the cache. Before the task has run, file reference count is incremented by 1; then, after the task has run, the count is decresed by 1. When the count of a file reaches zero, it is eligible for deletion. 
> **The distributed cache API**: 

```Java
public void addCacheFile(URI uri)
public void addCacheArchive(URI uri)
public void setCacheFiles(URI[] files)
public void setCacheArchives(URI[] archives)
public void addFileToClassPath(Path file)
public void addArchiveToClassPath(Path archive)
```

### MapReduce Library Classes
```Java
ChainMapper, ChainReducer
FieldSelectionMapper and FieldSelectionReducer
IntSumReducer, LongSumReducer
InverseMapper
MultithreadedMapper
TokenCounterMapper
RegexMapper
```