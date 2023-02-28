public with sharing class Email {
    @AuraEnabled(cacheable=true)
    public static String sendQuote(Id quoteId){
        
        
        Id quotationId = quoteId;
        Quotation__c quote = [Select Id , Booking_Ref__c ,  Name , Property_Type__c , Customer_Name__c , Acquire_Property_By__c , Price__c , Quoted_to_Customer__c , Customer_Email__c , Quote_No__c from Quotation__c where Id =:quotationId];
         String mailaddress = quote.Customer_Email__c;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'vdogra4747@gmail.com'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Quotation Details');
        mail.setHtmlBody('<div>Booking Ref :' + quote.Booking_Ref__c + '<br>  Name :' +  quote.Name + ' <br> Property Type :'+ quote.Property_Type__c + '<br> CustomerName :' + quote.Customer_Name__c + '<br> Acquire Property By :' + quote.Acquire_Property_By__c + '<br> Price :' + quote.Price__c  + '<br> Customer Email :' +  quote.Customer_Email__c + '<br> Quote No :' + quote.Quote_No__c + ' </div>');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

        return 'Success';
        
    }
}