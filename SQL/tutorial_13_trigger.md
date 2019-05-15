#Trigger

## Syntax
```MySQL
CREATE TRIGGER trigger_name trigger_time trigger_event
ON tbl_name 
FOR EACH ROW trigger_stmt

    trigger_time:
        BEFORE
        | AFTER
    trigger_event:
        INSERT
        | UPDATE
        | DELETE

DROP TRIGGER [schema_name.]trigger_name


```

##