@IsTest
public class JobSequencerTest {
    @IsTest
    static void CanSequenceJobs() {
        Test.startTest();
        new JobSequencer()
            .addJob(new TestSequencedBatchable('job 1'))
            .addJob(new TestSequencedBatchable('job 2'))
            .addJob(new TestSequencedBatchable('job 3'))
            .executeNextJob();
        Test.stopTest();
    }
}
