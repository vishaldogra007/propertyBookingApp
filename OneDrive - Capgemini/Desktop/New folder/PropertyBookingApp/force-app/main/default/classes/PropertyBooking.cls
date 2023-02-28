public with sharing class PropertyBooking {
    @AuraEnabled(cacheable = true)
    public static List<Property_Booking__c> bookingRecs(){
        List<Property_Booking__c> records = [select Id,Property__r.Name ,Customer__r.Name,Status__c,Actual_Price__c,Quoted_Price__c,Quotation_Generated__c,Name,Acquire_Property_By__c from Property_Booking__c];
        return records;
    }
}
