public with sharing class QuotationClass {
    @AuraEnabled(Cacheable=true)
    public static Quotation__c getQuotation(Id propertyId){
        Property_Booking__c proprec = [Select Id ,Name from  Property_Booking__c where Id =:propertyId];
        Id propId = proprec.Id;
        Quotation__c quot = [Select Id , Booking_Ref__c ,  Name , Property_Type__c , Customer_Name__c , Acquire_Property_By__c , Price__c , Quoted_to_Customer__c , Customer_Email__c , Quote_No__c from Quotation__c where Booking_Ref__c=:propId];
        return quot;
       
    }
    @AuraEnabled(cacheable=true)
    public static List<Quotation__c> getAllQuotation(){
        List<Quotation__c> allQuotation = [Select Id , Booking_Ref__c ,  Name , Property_Type__c , Customer_Name__c , Acquire_Property_By__c , Price__c , Quoted_to_Customer__c , Customer_Email__c , Quote_No__c from Quotation__c];
        return allQuotation;
    }
    @AuraEnabled
    public static void quotedToCustomer(Id quoteId){
        Id quotationId = quoteId;
        Quotation__c quote = [Select Id,  Quoted_to_Customer__c from Quotation__c where Id=:quotationId ];
        quote.Quoted_to_Customer__c = true;
        update quote;
    
        
    }
    
}
