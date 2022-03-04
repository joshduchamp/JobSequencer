public without sharing class JobSequencer extends AbstractJobSequencer {
    private List<JobItem> jobList = new List<JobItem>();
    private integer index = 0;
    
    public override void executeNextJob() {
        if (jobList.size() > index) {
            JobItem job = jobList.get(index++);
            if (job.batchSize == 0) {
                Database.executeBatch(job.batchable);
            } else {
                Database.executeBatch(job.batchable, job.batchSize);
            }
        }
    }

    public JobSequencer addJob(AbstractSequencedBatchable batchable) {
        addJob(batchable, 0);
        return this;
    }

    public JobSequencer addJob(AbstractSequencedBatchable batchable, Integer batchSize) {
        batchable.jobSequencer = this;
        jobList.add(new JobItem(batchable, batchSize));
        return this;
    }

    private class JobItem {
        public AbstractSequencedBatchable batchable;
        public Integer batchSize;
        public JobItem(AbstractSequencedBatchable batchable, Integer batchSize) {
            this.batchable = batchable;
            this.batchSize = batchSize;
        }
    }
}
