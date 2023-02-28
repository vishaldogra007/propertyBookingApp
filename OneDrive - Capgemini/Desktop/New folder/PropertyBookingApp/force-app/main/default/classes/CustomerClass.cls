public with sharing class CustomerClass {
    @AuraEnabled(cacheable=true)
    public static List<Customer_Obj__c> allCustomers(){
        List<Customer_Obj__c> customers = [select Id,Name ,Aadhar__c,Pan__c,District__c,State__c,Email__c,Phone__c from Customer_Obj__c];
        return customers;
    }
}
