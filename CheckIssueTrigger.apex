trigger CheckIssue on Issue__c (before insert) { 
    for(Issue__c issue : Trigger.new) { 
        List<Issue__c> existing = [SELECT Id FROM Issue__c 
                                   WHERE Book__c = :issue.Book__c 
                                   AND Return_Date__c = NULL]; 
        if(!existing.isEmpty()) { 
            issue.addError('Book already issued!');
        }
    }
}
