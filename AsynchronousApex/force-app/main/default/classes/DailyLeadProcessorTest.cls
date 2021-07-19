@isTest
private class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    @testSetup
    static void setup() {
        List<Lead> leadList = new List<Lead>();
        
        for (Integer i = 0; i < 200; i++) {
            Lead lead = new Lead(
            	LastName = 'lead' + i,
                Company = 'company' + i
            );
            
            leadList.add(lead);
        }
        
        insert leadList;
    }
    
    @isTest
    static void testScheduledJob() {
        Test.startTest();
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();
        
        List<Lead> leadList = [
            SELECT Id, LeadSource
            FROM Lead
        ];
        
        System.debug('leadList => ' + leadList);
    }
}