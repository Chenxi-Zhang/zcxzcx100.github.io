# YARN (Yet Another Resource Negotiator) 

> YARN is a Hadoop's cluster resource management system. YARN provides APIs for requesting and working with cluster resources. Some higher-level framework, such as MapReduce, Spark and Tez, uses YARN APIs. A layer of applications build on these frameworks, such as Pig, Hive and Crunch.  

### Anatomy of a YARN application run
> (1) The client contacts the resource manager and asks it to run an application master process. (2) The resource manager finds a node manager that can launch the application master in a container. (3) It could simply run a computation in the container and return the result to the client. Or it could request more containers from the resource managers. (4) All containers run a distributed computation. 

> **Resource request**: A request for a set of containers can express the amount of computer resources required for each container (memory and CPU), as well as locality constraints for the containers in that request.  
> **Application Lifespan**: (1) MapReduce: map application to the jobs. (2) Spark: run one application per workflow or user session of jobs. (3) Apache Slider: long-running application that is shared by different users. 
> **Scheduling in YARN**: (1) FIFO, (2) Capacity and (3) Fair Scheduler. 
> 