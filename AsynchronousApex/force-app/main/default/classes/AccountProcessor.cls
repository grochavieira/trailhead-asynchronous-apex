public class AccountProcessor {
    @future
    public static void countContacts(List<id> accountIds){
        List<Account> accountList = [
            SELECT Id, Name, 
            	(
                    SELECT Id
                    FROM Contacts
                )
            FROM Account
            WHERE Id IN: accountIds
        ];
        
        for (Account acc : accountList) {
            acc.Number_Of_Contacts__c = 0;
            if (acc.Contacts != null) {
                acc.Number_Of_Contacts__c = acc.Contacts.size();
            }
        }
        System.debug('accountList before update => ' + accountList);
        update accountList;
    }
}