trigger OpportunityTrigger on Opportunity (after insert, after update) {
    Set<Id> accIds = new Set<Id>();
    Map<Id,Double> mapOpp = new Map<Id,Double>();
    Double totalAmount = 0;
    Map<Id,List<Opportunity>> mapownOpp = new Map<Id,List<Opportunity>>();
    List<Account> Acclist = new List<Account>();
    for(opportunity opp: Trigger.New){
        if(opp.StageName  == 'Closed Won'){
            accIds.add(opp.AccountId);
        }
    }
    for(opportunity opp: [Select Id, Amount,AccountId,StageName from Opportunity where AccountId In: accIds]){
        if(opp.StageName  == 'Closed Won' && opp.Amount!=null){
            totalAmount = totalAmount+opp.Amount;
            mapOpp.put(opp.AccountId, totalAmount);
        }
    }
    for(Account Acc: [Select Id,Total_Customer_Spend__c from Account where Id in : accIds]){
        
        Acc.Total_Customer_Spend__c = mapOpp.get(Acc.Id);
        Acclist.add(Acc);
        
    }
    if(!Acclist.isEmpty()){
        update Acclist;
    }
}