public with sharing class PropertyClass {
    @AuraEnabled(cacheable=true)
    public static List<Property__c> allProperties(){
       List<Property__c> properties = [Select Id , Property__c , Name , Area__c , State__c , District__c , Type__c , Storey__c , Built_On__c , Property_Age_Years__c, Needs_Renovation__c from Property__c];
       return properties;
    }
}
