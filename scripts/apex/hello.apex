// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:

        //Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
        List<Opportunity> listOfOpps = [SELECT Name, Account.Name, Owner.Name, StageName, CloseDate FROM Opportunity WHERE StageName = 'Closed Won'];
        // Create a set of Account Ids from the Opportunities
        Set<Id> accountIds = new Set<Id>();
        //List<Contact> contactsFromAcct = new List<Contact>();
        Contact primaryConToSet;
        Map<Id, Id> contactsByAccountId = new Map<Id, Id>();
        For (Opportunity opp : listOfOpps){
            accountIds.add(opp.AccountId);
            }      
        System.debug('List of opportunities ' + listOfOpps);
        System.debug('Acct Ids' + accountIds);   
        // Query the Contacts
        List<Contact> newContactsList = [SELECT Name, Id, AccountId FROM Contact WHERE AccountId IN :accountIds ORDER BY ID LIMIT 1];
        System.debug('Contacts are ' + newContactsList);
        //For (Contact cont : newContactsList){
            //contactsFromAcct.add(cont.Contacts[0]);
        //}
        // Loop through each Contact and add the Account Id and Contact to the map
        For (Contact indivContact : newContactsList){
            contactsByAccountId.put(indivContact.AccountId, indivContact.Id);
        }
        // Loop through each Opportunity
        For (Opportunity indivOpp : listOfOpps){
            For (Id indivAcctId : contactsByAccountId.KeySet()){
                // Update the Opportunity primary contact from accountToContactMap
                If (indivAcctId == indivOpp.AccountId){
                    System.debug('acct id is ' + indivAcctId);
                    //indivOpp.Primary_Contact__c = contactsByAccountId.get(indivAcctId);    
                }
            }
        }
        Update listOfOpps;
        