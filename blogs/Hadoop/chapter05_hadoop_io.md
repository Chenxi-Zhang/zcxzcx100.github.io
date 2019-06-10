# Hadoop I/O

### Data integrity
* **Data Integrity in HDFS**: Checksum of data. 
* **LocalFileSystem**: The Hadoop `LocalFileSystem` performs client-side checksumming.
* **ChecksumFileSystem**: `LocalFileSystem` uses `ChecksumFileSystem` to do its work. 
* **Compression**: gzip, bzip2, ...
* **Codecs**: the implementation of a compression-decompression algorithm. 
* **Compression and Input Splits**: bzip2 supports splitting. 
* **Using Compression in MapReduce**: if your input files are compressed, they will be decompressed automatically as they are read by MapReduce. 

### Serialization
* **Writable**: a serialization format that is certainly compact and fast, but not so easy to extend or use from languages other than Java.  

```Java
// Writable Interface
public interface Writable {
    void write(DataOutput out) throws IOException;
    void readFields(DataInput in) throws IOException;
}

// WritableComparable and comparators
// RawComparator avoid the cost of deserialization when compare two byte arrays. 
public interface WritableComparable<T> extends Writable, Comparable<T> {
}
public interface RawComparator<T> extends Comparator<T> {
    public int compare(byte[] b1, int s1, int l1, byte[] b2, int s2, int l2); 
}

```

* **Writable classes**: 
> **Java primitives**: BooleanWritable, ByteWritable, ShortWritable, IntWritable, VIntWritable, FloatWritable, LongWritable, VLongWritable, DoubleWritable.  
> **Text**: like String, but several differences. (1) Indexing for the `Text` class is in terms of position in the encoded byte sequence. `charAt()` returns an `int` representing a Unicode code point instead of `char`. `Text`'s `find()` is analogous to `String`'s `indexOf()`. (2) The length of a `String` is the number of `char` code units it contains, whereas the length of a `Text` object is the number of bytes in its **UTF-8 encoding**. (3) Iteration of `Text`: wrap `Text` into `java.nio.ByteBuffer`, repeatly call `Text.bytesToCodePoint()`, end the loop when `bytesToCodePoint()` returns -1. (4) `Text` is mutable. 

```Java
// UTF-8 to bytes.
public static void main(String[] args) throws UnsupportedEncodingException {
    String str = "\u0041\u00DF\u6771\uD801\uDC00";
    System.out.println(str);
    System.out.println(str.charAt(3) == '\uD801');
    System.out.println(bytesToHex(str.getBytes()));
}
private static String bytesToHex(byte[] hashInBytes) {
    StringBuilder sb = new StringBuilder();
    for (byte b : hashInBytes) {
        sb.append(String.format("%02x", b));
    }
    return sb.toString();
}
```

> **BytesWritable**: Its serialized format is a 4-byte integer field that specifies the number of bytes to follow, followed by the bytes themselves. For example, `new BytesWritable( new byte[]{3,5} )` is serialized to `0x000000020305`. 
> **NullWritable**: a zero-length serialization. It is an immutable singleton. 
> **ObjectWritable** and **GenericWritable**: `ObjectWritable` is a general-purpose wrapper. `ObjectWritable` is useful when a field can be of more than one type. `ObjectWritable` writes the classname of the wrapped type every time it is serialized. `GenericWritable` has a static array of types and uses the index into the array as the serialized reference type (to save space). 
> **Writable collections**: Array Writable, ArrayPrimitiveWritable, TwoDArrayWritable, MapWritable, SortedMapWritable, and EnumSetWritable.
* **Serialization Frameworks**: a serialization framework is represented by an implementation of `Serialization`. A `Serialization` defines a mapping from types to Serializer instances (for turning an object into a byte stream) and Deserializer instances (for turning a byte stream into an object).

### File-Based Data Structures
* **SequenceFile**: a persistent data structure for binary key-value pairs. 
> **Writing a SequenceFile**: create a `SequenceFile` with its `createWriter()` static method. Write key-value pair using `append()` method. 
> **Reading a SequenceFile**: create an instance of `SequenceFile.Reader` and repeatly invoke its `next()` method. 
> **Displaying a SequenceFile with the command-line interface**: `fs` command has a `-text` option to display sequence files in textual form.
> **Sorting and merging SequenceFiles**: MapReduce or `SequenceFile.Sorter` class. 
> **The SequenceFile format**: (1) Header, Record, Record, Sync, Record, Record, Sync. Record: Record length(4-byte) + Key length(4-byte) + Key + Value. (2) Header, Sync, Block, Sync, Block. Block: num of records (1-5 bytes) + Compressed key lengths + Compressed keys + Compressed value lengths + Compressed values. 
* **MapFile**: a sorted `SequenceFile` with an index to permit lookups by key. 
> **MapFile variants**: `SetFile`, `ArrayFile`, `BloomMapFile`
* **Other File Formats and Column-Oriented Formats**: Avro datafiles. RCFile, Trevni. 
