# MapReduce Types and Formats

### MapReduce Types  
* **The Default MapReduce Job**: key methods: `setInputFormatClass()`, `setMapperClass()`, `setMapOutputKeyClass()`, `setMapOutputValueClass()`, `setPartitionerClass()`, `setNumReduceTasks()`, `setReducerClass()`, `setOutputKeyClass()`, `setOutputValueClass()`, `setOutputFormatClass()`. 
> **The default Streaming job**: When we specify a non-Java mapper and the default text mode is in effect, it just passes the value to the mapper process.   
> **Keys and values in Streaming**: control the separator, `\t` by default. The key could have more than 1 field.   

### Input Formats
* **Input Splits and Records**: split is a chunk of the input. Each split is divided into records. Notice that a split doesn’t contain the input data; it is just a reference to the data. The client calculates the splits for the job by calling `getSplits()`, then sends them to the app master. The map task passes the split to the `createRecordReader()` method on `InputFormat` to obtain a `RecordReader` for that split. 
> **FileInputFormat**: `FileInputFormat` is the base class for all implementations of `InputFormat` that use files as their data source. 
> **FileInputFormat input paths**:

```Java
public static void addInputPath(Job job, Path path)
public static void addInputPaths(Job job, String commaSeparatedPaths)
public static void setInputPaths(Job job, Path... inputPaths)
public static void setInputPaths(Job job, String commaSeparatedPaths)
```
> **FileInputFormat input splits**: size of a split: `max(minimumSize, min(maximumSize, blockSize))`
> **Small files and CombineFileInputFormat**: `CombineFileInputFormat` packs many files into each split so that each mapper has more to process. 
> **Preventing splitting**: Some applications don’t want files to be split, as this allows a single mapper to process each input file in its entirety. First way: set minimum split size to its maximum value. Second way: subclass the concrete subclass of `FileInputFormat` and override the isSplitable() method to return `false`. 
> **File information in the mapper**:  `getInputSplit()` method on the `Mapper`’s `Context` object. 
> **Processing a whole file as a record**: a `RecordReader` that delivers the file contents as the value of the record. It has (1) `nextKeyValue()` which reads the file content, (2) `getCurrentKey()` which returns `NullWritable`, (3) `getCurrentValue()` which returns the content it read. 

* **Text Input**: 
> **TextInputFormat**: `TextInputFormat` is the default `InputFormat`. The key, a `LongWritable`, is the byte offset within the file of the beginning of the line. The value is the contents of the line, excluding any line terminators. Splits honor logical record boundaries instead of block.   
> **Controlling the maximum line length**: `mapreduce.input.linerecordread er.line.maxlength` safeguard against corrupted files. Corruption in a file can manifest itself as a very long line, which can cause out-of- memory errors.   
> **KeyValueTextInputFormat**: It is common for each line in a file to be a key-value pair, separated by a delimiter such as `\t`. Set `mapreduce.input.keyvaluelinere cordreader.key.value.separator` property.  
> **NLineInputFormat**: the mappers receive a fixed number of lines of input. The keys are the byte offsets within the file and the values are the lines themselves.   
> **XML**: `StreamXmlRecordReader`.  

* **Binary Input**: 
> **SequenceFileInputFormat**: stores sequences of binary key-value pairs.   
> **SequenceFileAsTextInputFormat**: converts the sequence file's keys and values to `Text` objest. 
> **SequenceFileAsBinaryInputFormat**: retrieves the sequence file’s keys and values as opaque binary objects (`BytesWritable`). 
> **FixedLengthInputFormat**: reads fixed-width binary records from a file, when the records are not separated by delimiters. The record size must be set via `fixedlengthinputformat.record.length`.   

* **Multiple Inputs**: to cope with all of your legacy formats. use `MultipleInputs`'s `addInputPath()` method to specify which `InputFormat` and `Mapper` to use on a per-path basis. It replaces the usual calls to `FileInputFormat.addInputPath()` and `job.setMapperClass()`. The important thing is that the map outputs have the same types.
* **Database Input (and output)**: `DBInputFormat` (and `DBOutputFormat`). Sqoop. HBase's `TableInputFormat` (and `TableOutputFormat`) for an HBase table. 

### Output Formats
* **Text Output**: `TextOutputFormat` by default. It writes records as lines of text. Each key-value pair is separated by a tab character (`mapreduce.output.textoutputformat.separator`). Using `NullWritable` as key or value causes no separator to be written, which makes the output suitable for reading in using `TextInputFormat`. 
* **Binary Output**: 
> **SequenceFileOutputFormat**: writes sequence files for its output. This is a good choice of output if it forms the input to a further MapReduce job. 
> **SequenceFileAsBinaryOutputFormat**: writes keys and values in raw binary format into a sequence file container.
> **MapFileOutputFormat**:  writes map files as output. The keys in map file must be added in order. 
* **Multiple Outputs**: 
> **Partitioning data**:   
> **MultipleOutputs**: allows you to write data to files in any arbitrary name. Use file path separator characters (/) to create subdirectories of arbitrary depth. 

```Java
private MultipleOutputs<KEY, VALUE> multipleOutputs;
multipleOutputs = new MultipleOutputs<>(context);
multipleOutputs.write(KEYOUT, VALUEOUT, filename);
```

* **Lazy Output**: `LazyOutputFormat` prevent empty files from being created. 