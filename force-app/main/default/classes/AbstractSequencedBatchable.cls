public abstract class AbstractSequencedBatchable implements Database.Batchable<SObject> {
    
    public AbstractJobSequencer jobSequencer = null;

    public void finish( Database.BatchableContext context ) {
        if (jobSequencer != null) {
            jobSequencer.executeNextJob();
        }
    }
}
