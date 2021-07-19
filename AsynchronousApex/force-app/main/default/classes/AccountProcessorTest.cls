@isTest
public class AccountProcessorTest {
	@isTest
    private static void testAccountProcessor() {
        Account acc = new Account(
        	Name = 'gui'
        );
        
        insert acc;
        
        List<Id> accountIds = new List<Id>{
            acc.Id
        };
        
        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();
    }
}