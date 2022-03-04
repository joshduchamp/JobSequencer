public without sharing class TestSequencedBatchable extends AbstractSequencedBatchable 
{    
    private string name = null;

    public TestSequencedBatchable(string name) {
        this.name = name;
    }
    
    public List<Contact> start(Database.BatchableContext bc) {
        return new List<Contact>{new Contact()};
    }

    public void execute(Database.BatchableContext bc, List<Contact> scope) {
        System.debug('execute ' + this.name);
    }
}
