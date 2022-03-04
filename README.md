# Job Sequencer

## About

This is a design pattern for daisy chaining Salesforce batch jobs together. Often it's required to have one job fire only after another job finishes. This solution avoids the anti-pattern of a batch job needing to know about the next job to run. The Job Sequencer acts as the governing object that knows of all the jobs that need to run and in which order. It puts the point of control in one place and simplifies the individual jobs.

## How To Use

### Batch jobs extend the `AbstractSequencedBatchable` class

```
public without sharing class MyBatchable extends AbstractSequencedBatchable 
{    
    public List<Contact> start(Database.BatchableContext bc) {
        return [select FirstName from Contact limit 100];
    }

    public void execute(Database.BatchableContext bc, List<Contact> scope) {
        for (Contact c : scope) {
            System.debug('Hello ' + c.FirstName);
        }
    }
}
```

### Call the JobSequencer

```
new JobSequencer()
    .addJob(new MyBatchable())
    .addJob(new MyOtherBatchable(),100)
    .executeNextJob();
```

The above code will run `MyBatchable`, and then run `MyOtherBatchable` once `MyBatchable` is finished. The call to `executeNextJob` is what starts the whole thing off. Note that we are setting the batch size of `MyOtherBatchable` to 100. If this is excluded, then the default batch size is used.

