@isTest
public class LeadProcessorTest {
	@testSetup
    static void setup() {
        List<Lead> leadList = new List<Lead>();
        for (Integer i = 0; i < 200; i++) {
            Lead lead = new Lead(
            	LastName = 'lead' + i,
                Company = 'lead' + 1
            );
            leadList.add(lead);
        }
        
        insert leadList;
    }
    
    @isTest
    static void testLeadProcessor() {
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
		Id batchId = Database.executeBatch(lp);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        List<Lead> leadList = [
            SELECT Id, Name, LeadSource FROM Lead
        ];
        System.debug('leadList => ' + leadList);
        System.assertEquals(200, [SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce']);
    }
}