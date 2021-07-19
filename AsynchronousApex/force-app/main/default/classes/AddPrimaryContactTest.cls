@isTest
public class AddPrimaryContactTest {
	@testSetup
    public static void setup() {
        List<Account> accountList = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            Account acc = new Account(
            	Name = 'accountNY' + i,
                BillingState = 'NY'
            );
            accountList.add(acc);
        }
        
        for (Integer i = 0; i < 50; i++) {
            Account acc = new Account(
            	Name = 'accountCA' + i,
                BillingState = 'CA'
            );
            accountList.add(acc);
        }
        
        insert accountList;
    }
    
    @isTest
    public static void testAddPrimaryContact() {
        Contact contact = new Contact(
        	LastName = 'rocha'
        );
        
        Contact contact2 = new Contact(
        	LastName = 'vieira'
        );
        AddPrimaryContact adcNY = new AddPrimaryContact(contact, 'NY');
        AddPrimaryContact adcCA = new AddPrimaryContact(contact2, 'CA');
        // startTest/stopTest block to force async processes to run
        Test.startTest();
        System.enqueueJob(adcNY);
        System.enqueueJob(adcCA);
        Test.stopTest();
        // Validate the job ran. Check if record have correct parentId now
        System.assertEquals(50, [SELECT count() FROM Contact WHERE LastName = 'rocha']);
        System.assertEquals(50, [SELECT count() FROM Contact WHERE LastName = 'vieira']);
    }
}