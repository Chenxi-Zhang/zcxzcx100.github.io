# HDFS (Hadoop Distributed Filesystem)
### The design of HDFS
* Goodness:
    - Very large files
    - Streaming data access
    - Commodity hardware
* Shortness:
    - Low-latency data access
    - Lots of small files
    - Multiple writers, arbitrary file modifications

---
### Terminology
> **Blocks**: chunks which are 128MB by default.  
> **Namenodes and Datanodes**: The namenode manages the filesystem namespace. The namenode also knows the datanodes on which all the blocks for a given file are located. Datanodes are the workhorses of the filesystem.  
> **Block Caching**: for increased read performance, frequently accessed files the blocks may be explicitly cached in the datanode’s memory, in an off-heap block cache.   
> **HDFS Federation**: a cluster can scale by adding namenodes, each of which manages a portion of the filesystem namespace.   
> **HDFS High Availability**: The namenode is a single point of failure (SPOF). To recover from a failed namenode, an administrator starts a new primary namenode(filesystem metadata replicas, correct configuration). QJM is designed for the sole purpose of providing a highly available edit log. Failover controller is used to monitor its namenode for failures (using a simple heartbeat mechanism). Fencing ensures that, in a failure triggered by slow network or network partition, the previously active namenode is prevented from doing any damage.   
> **The Command-Line Interface**: see also [pseudodistributed_mode](./configs/pseudodistributed_mode/setup.md)
> **Hadoop Filesystems**: Hadoop has an abstract notion of filesystems, of which HDFS is just one implementation. 
> **The Java Interface**: `FileSystem` class: the API for interacting with one of Hadoop’s filesystems. 

``` Java
//Reading Data from a Hadoop URL
InputStream in = null;
try {
    in = new URL("hdfs://host/path").openStream();
    // process in
} finally {
    IOUtils.closeStream(in);
}

//Reading Data Using the FileSystem API
public static FileSystem get(URI uri, Configuration conf) throws IOException


//Writing data
public FSDataOutputStream create(Path f) throws IOException
public FSDataOutputStream append(Path f) throws IOException

//Directories
public boolean mkdirs(Path f) throws IOException

// Querying the Filesystems
// FileStatus class encapsulates filesystem metadata for files and
// directories, including file length, block size, replication, modification
// time, ownership, and permission information.

// Listing files
public FileStatus[] listStatus(Path f) throws IOException

// File patterns
public FileStatus[] globStatus(Path pathPattern) throws IOException
public FileStatus[] globStatus(Path pathPattern, PathFilter filter) throws IOException

// PathFilter

// Deleting Data
public boolean delete(Path f, boolean recursive) throws IOException


```

> **Data Flow**: 
>> **File read**: (1) Client uses `DistributedFileSystem` class to call `open()` method. (2) `DistributedFileSystem` calls the namenode, using remote procedure calls (RPCs), to determine the locations of the first few blocks in the file. Namenode returns the address of datanodes which have a copy of that block. (3) At client side, `DistributedFileSystem` returns `FSDataInputStream` to read data by calling `read()` method. (4) Data is streamed from the datanode, and client calls `read()` repeatedly on the stream. (5) When the end of block is reached, `FSDataInputStream` close the connection to the datanode, then find the datanode for the next block. (6) When the client has finished reading, it calls `close()` on the `FSDataInputStream`.  
>> **File write**: (1) Client calls `create()` on `DistributedFileSystem`. (2) `DistributedFileSystem` makes a RPC to namenode to create a new file in FS's namespace, with no blocks associated with it. (3) The namenode performs various checks: file does not exists, client has permission. If checks pass, the namenode makes a record of new file, and `DistributedFileSystem` returns an `FSDataOutputStream` to client for writing data. (4) `FSDataOutputStream` splits data into packets, which it writes to an internal queue called the *data queue*. The data queue is consumed by the `DataStreamer`, which asks the namenode to allocate new blocks in suitable datanodes to store. The lists of datanodes forms a pipeline which forwards data from one to another progressively. (5) `FSDataOutputStream` also maintains internal queue of packets called *ack queue*, which are waiting for acknowledge of datanodes. (6) When the client has finished writing, it calls `close()` on stream. (7) Contact the namenode to signal that he file is completed.   

> **Coherency Model**: the data visibility of reads and writes for a file. `hflush()` forces all buffer to be flushed to the datanodes. 
> **Parallel Copying with distcp**: `hadoop distcp file1 file2`, `hadoop distcp dir1 dir2`. 