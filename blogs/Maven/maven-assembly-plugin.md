# maven-assembly-plugin

## Package jar with dependencies
* With all dependencies:

```xml
<plugin>  
    <artifactId>maven-assembly-plugin</artifactId>  
    <configuration>  
    
        <descriptorRefs>  
            <descriptorRef>jar-with-dependencies</descriptorRef>  
        </descriptorRefs>  
    </configuration>  
</plugin>
```
* With all dependencies except some:

```xml
<dependencies>
    [...]
    <dependency>
        [...]
        <scope>provided</scope>  // exclude from final jar package.
    </dependency>
</dependencies>
```
* Customized package.

```xml
```