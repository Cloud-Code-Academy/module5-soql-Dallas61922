/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Dallas Bailey
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
    public static List<Lead> getTheLeads() {
    //  The body of the method
        List<Lead> leadsList = [SELECT Id, LastName, Company, Phone, Email FROM Lead];
        Return leadsList;
    }

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    public static List<Contact> contactsByFirstName () {
        String nameToFind = 'John';
        List<Contact> listOFContacts = [SELECT Name, Id FROM Contact WHERE FirstName = :nameToFind];
        Return listOfContacts;
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    public static List<Id> contactsByLastName () {
        String lastName1 = 'Smith';
        String lastName2 = 'Jones';
        List<Id> contactIds = new List<Id>();
        List<Contact> contactsLastName = [SELECT Name, Id FROM Contact WHERE LastName = :lastName1 OR LastName = :lastName2];
        For (Contact con : contactsLastName){
            contactIds.add(con.Id);
        }
        Return contactIds;
    }

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    public static List<Opportunity> returnOpps (Id accountId) {
        List<Opportunity> relatedOpps = [SELECT Name, Id, StageName, AccountId, Amount, CloseDate, Type, Probability FROM Opportunity WHERE AccountId = :accountId AND StageName = 'Closed Won'];
        Return relatedOpps;
    }

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    public static Integer numOfAccts () {
        Integer numberOfAccts = null;
        List<Account> allAccounts = [SELECT Name, Id FROM Account];
        numberOfAccts = allAccounts.size();
        Return numberOfAccts;
    }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    public static Map<Id, Task> tasksDueThisWeek () {
        Date sevenDaysAway = System.today().addDays(7);
        List<Task> listOfTasks = [SELECT Id, Subject FROM Task WHERE ActivityDate <= :sevenDaysAway];
        Map<Id, Task> tasksById = new Map<Id, Task>(listOfTasks);
        Return tasksById;
    }

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    public static List<Contact> contactsBasedOnEmail () {
        String emailEnding = '%example.com';
        List<Contact> contactsEmail = new List<Contact> ([SELECT Name, Email, Id FROM Contact WHERE Email LIKE :emailEnding]);
        Return contactsEmail;
    }

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        String wordToSearch = '%' + keyword + '%';
        List<Opportunity> oppsByKeyword = [SELECT Name, Id FROM Opportunity WHERE Name LIKE :wordToSearch];
        return oppsByKeyword;
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {
        String origin1 = 'Web';
        String origin2 = 'Email';
        String origin3 = '';
        List<Case> filteredCases = [SELECT CaseNumber, Id, Subject, Origin FROM Case WHERE Origin NOT IN (:origin1, :origin2, :origin3)];
        return filteredCases; 
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    public static List<Lead> filteredListOfLeads (String leadSource, String keyword) {
        String titleKeyword = '%' + keyword + '%';
        List<Lead> filteredList = [SELECT Name, FirstName, LastName, Id, LeadSource, Title, Phone, Company, Email FROM Lead WHERE LeadSource = :leadSource OR Title LIKE :titleKeyword];
        Return filteredList;
    }    

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(Id accountId) {
        // Create a list to hold the Contact LastNames
        List<String> contactLastName = new List<String>();
        List<Contact> contactObjectList = [SELECT FirstName, LastName, Id, AccountId FROM Contact WHERE AccountId = :accountId];
        For (Contact con : contactObjectList){
            contactLastName.add(con.LastName);
        }
        Return contactLastName;
    }

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        // Use AggregateQuery to get the total revenue
        String stageToCheck = stage;
        Decimal amountToCheck = 10000;
        Decimal total;
        List<AggregateResult> result = [SELECT Sum(Amount) totalAmount FROM Opportunity WHERE StageName = :stageToCheck OR Amount > :amountToCheck ];
        total = (Decimal) result[0].get('totalAmount');
        Return total; // Replace null with the variable you used to store the result
    }

    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        List<Account> firstTenAccts = [SELECT Name, Id FROM Account ORDER BY Name ASC LIMIT 10];
        Return firstTenAccts; 
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
        Integer amountToCheck = 100000;
        List<Opportunity> topFiveOpps = [SELECT CloseDate, Name, StageName, Amount FROM Opportunity WHERE Amount > :amountToCheck ORDER BY CloseDate LIMIT 5];
        return topFiveOpps;
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
        List<Contact> contactsByBirthdate = [SELECT Birthdate, Name, Id FROM Contact ORDER BY Birthdate DESC LIMIT 3];
        return contactsByBirthdate;
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        String statusToCheck = 'Open';
        List<Case> openCases = [SELECT Id, CaseNumber, CreatedDate FROM Case WHERE Status = :statusToCheck ORDER BY CreatedDate LIMIT 10 OFFSET 5];
        return openCases; 
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        Set<Id> casesForAccount = new Set<Id>();
        List<Case> listOfCases = [SELECT Id FROM Case WHERE AccountId = :accountId];
        For (Case indivCase : listOfCases){
            casesForAccount.add(indivCase.Id);
        }
        return casesForAccount;
    }

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        Map<Id, String> accountIdsToNames = new Map<Id, String>();
        List<Account> acctsNotInCountry = [SELECT Name, Id FROM Account WHERE BillingCountry != :country];
        For (Account acct : acctsNotInCountry){
            accountIdsToNames.put(acct.Id, acct.Name);
        }
        return accountIdsToNames; 
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
        Contact contactsAcct = [SELECT Contact.Name, Account.Name FROM Contact WHERE Id = :contactId];
        String acctName = contactsAcct.Account.Name;
        return acctName;
        }

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getOpportunityAndAccountNamesForLineItem('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getOpportunityAndAccountNamesForLineItem(Id accountId) {
        Account acctToReturn = [SELECT Name, Id, (SELECT Id, Name FROM Opportunities) FROM Account  WHERE Id = :accountId];
        return acctToReturn;
    }

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        Account acct = [SELECT Id, BillingState FROM Account WHERE Id = :accountId];
        String billingStateToCheck = acct.BillingState;
        List<Contact> listOfContacts = [SELECT Id, Name FROM Contact WHERE MailingState LIKE :billingStateToCheck];
        return listOfContacts;
    }

    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findContactsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findContactsByLeadEmailDomains(Set<Id> leadIds) {
        String domain; 
        List<Lead> allLeadEmails = [SELECT Id, Name, Email FROM Lead WHERE Id = :leadIds];
        Set<String> emailDomain = new Set<String>();
        For (Lead indivLead : allLeadEmails){
            if (indivLead.Email != null){
                domain = '%' + indivLead.Email.Substringafter('@') + '%';
                emailDomain.add(domain);
            }
        }
        List<Account> acctsWithMatchingWebsite = [SELECT Name, Id, Website FROM Account WHERE Website LIKE :emailDomain];
        Return acctsWithMatchingWebsite;
        }

    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        OpportunityLineItem newItem;
        Id oppIdentifier; 
        Opportunity oppPriceBook = [SELECT Pricebook2Id FROM Opportunity WHERE Id = :origOppId];
        List<OpportunityLineItem> originalLineItems = [SELECT Name, Id, PriceBookEntryId, UnitPrice, Opportunity.Pricebook2Id, OpportunityId, ServiceDate, ProductCode, Product2Id FROM OpportunityLineItem WHERE OpportunityId = :origOppId];
        List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();
        Integer randomNumber = Integer.valueof((Math.random() * 3));
        For (Id opp : cloneOppIds){
            For (OpportunityLineItem item : originalLineItems){
                newItem = item.clone();
                newItem.OpportunityId = opp;
                newItem.Quantity = randomNumber;
                newItem.Opportunity.Pricebook2Id = oppPriceBook.Pricebook2Id;
                newItem.PriceBookEntryId = item.PriceBookEntryId;
                newLineItems.add(newItem);
            }  
        }
        Insert newLineItems;
    }
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() { 
        String stageToCheck = 'Closed Won'; 
        List<Opportunity> closedWonOpps = [SELECT Name, Account.Name, Owner.Name, StageName, CloseDate, Primary_Contact__c FROM Opportunity WHERE StageName = :stageToCheck];      
        return closedWonOpps; 
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
    public static void setPrimaryContact() {
        List<Opportunity> listOfOpps = SOQL.getOpportunityDetailsForClosedWon();
        Set<Id> accountIds = new Set<Id>();
        Map<Id, Id> contactsByAccountId = new Map<Id, Id>();
        For (Opportunity opp : listOfOpps){
            accountIds.add(opp.AccountId);
            }         
        List<Contact> newContactsList = [SELECT Name, Id, AccountId FROM Contact WHERE AccountId IN :accountIds ORDER BY ID DESC LIMIT 1];
        For (Contact indivContact : newContactsList){
            contactsByAccountId.put(indivContact.AccountId, indivContact.Id);
        }
        For (Opportunity indivOpp : listOfOpps){
            indivOpp.Primary_Contact__c = contactsByAccountId.get(indivOpp.AccountId);
            }
        Update listOfOpps;
        }
}