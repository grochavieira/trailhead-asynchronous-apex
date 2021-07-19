public class AddPrimaryContact implements Queueable {
    private Contact contact;
    private String state;
    public AddPrimaryContact(Contact record, String st) {
        this.contact = record;
        this.state = st;
    }
    public void execute(QueueableContext context) {
        List<Account> accountList = [
            SELECT Id, Name
            FROM Account
            WHERE BillingState =: state
            LIMIT 200
        ];
  
        List<Contact> contactList = new List<Contact>();
        for (Account acc : accountList) {
            Contact ctc = contact.clone(false, false, false, false);
            ctc.AccountId = acc.Id;
            contactList.add(ctc);
        }
        
        if (contactList.size() > 0) {
            insert contactList;
        }
    }
}