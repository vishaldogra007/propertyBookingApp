public with sharing class SearchClass {
    //Search by  propertyName
    @AuraEnabled(cacheable=true)
    public static List<List<SObject>> searchUsingPropertyName(String propertyName){
        List<List<SObject>> l1 = new List<List<SObject>>();
        String PropName = propertyName;
        List<Property__c> property = [Select Id , Property__c , Name , Area__c , State__c , District__c , Type__c , Storey__c , Built_On__c , Property_Age_Years__c, Needs_Renovation__c from Property__c where Name=:PropName];
        
        List<Quotation__c> quotations = [Select Id , Booking_Ref__c ,Booking_Ref__r.Name,  Name , Property_Type__c , Customer_Name__c , Acquire_Property_By__c , Price__c , Quoted_to_Customer__c , Customer_Email__c , Quote_No__c from Quotation__c where Name=:PropName];
         
       List<Property_Booking__c> proBook = [select Id,Property__r.Name ,Customer__r.Name,Status__c,Actual_Price__c,Quoted_Price__c,Quotation_Generated__c,Name,Acquire_Property_By__c from Property_Booking__c where Property__r.Name=:PropName];

       List<Customer_Obj__c> customers = new List<Customer_Obj__c>();
       for(Property_Booking__c rec : proBook){
         String custName = rec.Customer__r.Name;
         Customer_Obj__c cust = [select Id,Name ,Aadhar__c,Pan__c,District__c,State__c,Email__c,Phone__c from Customer_Obj__c where Name =:custName];
         customers.add(cust);
       }
       l1.add(property);
       l1.add(quotations);
       l1.add(proBook);
       l1.add(customers);
       return l1;

       
    }

//Search  by Property id

@AuraEnabled(cacheable=true)
public static  List<List<SObject>> searchUsingPropertyId(String propertyId){
 
    List<List<SObject>> l1 = new List<List<SObject>>();
    String PropId = propertyId;
    List<Property__c> property = [Select Id , Property__c , Name , Area__c , State__c , District__c , Type__c , Storey__c , Built_On__c , Property_Age_Years__c, Needs_Renovation__c from Property__c where Property__c=:PropId];
    String PropName = property[0].Name;
    List<Property_Booking__c> proBook = [Select Id,Property__r.Name ,Customer__r.Name,Status__c,Actual_Price__c,Quoted_Price__c,Quotation_Generated__c,Name,Acquire_Property_By__c from Property_Booking__c where Property__r.Name=:PropName];
    List< Quotation__c>  quotations = [Select Id , Booking_Ref__c , Booking_Ref__r.Name, Name , Property_Type__c , Customer_Name__c , Acquire_Property_By__c , Price__c , Quoted_to_Customer__c , Customer_Email__c , Quote_No__c from Quotation__c where Name=:PropName];

     
  List<Customer_Obj__c> customers = new List<Customer_Obj__c>();
  for(Property_Booking__c rec : proBook){
    String custName = rec.Customer__r.Name;
    Customer_Obj__c cust = [select Id,Name ,Aadhar__c,Pan__c,District__c,State__c,Email__c,Phone__c from Customer_Obj__c where Name =:custName];
    customers.add(cust);

    }
    l1.add(property);
    l1.add(quotations);
    l1.add(proBook);
    l1.add(customers);
   return l1;
 

   
}

//Search  by Booking Ref

@AuraEnabled(cacheable=true)
public static  List<List<SObject>> searchUsingBookingRef(String BookingRef){

    List<List<SObject>> l1 = new List<List<SObject>>();
    String bRef = BookingRef;
    
   List<Property_Booking__c> proBook = [Select Id,Property__r.Name ,Customer__r.Name,Status__c,Actual_Price__c,Quoted_Price__c,Quotation_Generated__c,Name,Acquire_Property_By__c from Property_Booking__c where Name=:bRef];
    Id proBookingId = proBook[0].Id;
    String propName = proBook[0].Property__r.Name;
    String custName = proBook[0].Customer__r.Name;
    List< Quotation__c> quotation = [Select Id , Booking_Ref__c , Booking_Ref__r.Name, Name , Property_Type__c , Customer_Name__c , Acquire_Property_By__c , Price__c , Quoted_to_Customer__c , Customer_Email__c , Quote_No__c from Quotation__c where Booking_Ref__c=:proBookingId];
    List<Property__c> property = [Select Id , Property__c , Name , Area__c , State__c , District__c , Type__c , Storey__c , Built_On__c , Property_Age_Years__c, Needs_Renovation__c from Property__c where Name=:propName];
    List<Customer_Obj__c> customer = [select Id,Name ,Aadhar__c,Pan__c,District__c,State__c,Email__c,Phone__c from Customer_Obj__c where Name =:custName];
     

     l1.add(property);
     l1.add(quotation);
     l1.add(proBook);
     l1.add(customer);
   return l1;
 

   
}

//Search by Customer Name

@AuraEnabled(cacheable=true)
public static  List<List<SObject>> searchUsingCustomerName(String customerName){
    List<List<SObject>> l1 = new List<List<SObject>>();
    String CustName = customerName;
    List<Customer_Obj__c> customers = [select Id,Name ,Aadhar__c,Pan__c,District__c,State__c,Email__c,Phone__c from Customer_Obj__c where Name =:custName];
    List< Quotation__c>  quotations = [Select Id , Booking_Ref__c ,Booking_Ref__r.Name,  Name , Property_Type__c , Customer_Name__c , Acquire_Property_By__c , Price__c , Quoted_to_Customer__c , Customer_Email__c , Quote_No__c from Quotation__c where Customer_Name__c=:custName];
    List<Property_Booking__c> proBook = [Select Id,Property__r.Name ,Customer__r.Name,Status__c,Actual_Price__c,Quoted_Price__c,Quotation_Generated__c,Name,Acquire_Property_By__c from Property_Booking__c where Customer__r.Name=:custName];
    
    List<Property__c> properties = new List<Property__c>();
    for(Property_Booking__c rec : proBook){
        String propertyName = rec.Property__r.Name;
        Property__c property = [Select Id , Property__c , Name , Area__c , State__c , District__c , Type__c , Storey__c , Built_On__c , Property_Age_Years__c, Needs_Renovation__c from Property__c where Name=:propertyName];
        properties.add(property);
    }

    l1.add(properties);
    l1.add(quotations);
    l1.add(proBook);
    l1.add(customers);
   return l1;
 

   
}

//Search by Quote No

@AuraEnabled(cacheable=true)
public static  List<List<SObject>> searchUsingQuoteNo(String QuoteNo){
    List<List<SObject>> l1 = new List<List<SObject>>();
    String qNo = QuoteNo;
    List<Quotation__c>  quotation = [Select Id , Booking_Ref__c ,Booking_Ref__r.Name ,  Name , Property_Type__c , Customer_Name__c , Acquire_Property_By__c , Price__c , Quoted_to_Customer__c , Customer_Email__c , Quote_No__c from Quotation__c where Quote_No__c=:qNo];

    String customerName = quotation[0].Customer_Name__c;
    String bRef = quotation[0].Booking_Ref__c;
    List<Property_Booking__c> proBook = [Select Id,Property__r.Name ,Customer__r.Name,Status__c,Actual_Price__c,Quoted_Price__c,Quotation_Generated__c,Name,Acquire_Property_By__c from Property_Booking__c where Id=:bRef];
    List<Customer_Obj__c> customer = [select Id,Name ,Aadhar__c,Pan__c,District__c,State__c,Email__c,Phone__c from Customer_Obj__c where Name =:customerName];

    String propertyName = proBook[0].Property__r.Name;
    List<Property__c> property = [Select Id , Property__c , Name , Area__c , State__c , District__c , Type__c , Storey__c , Built_On__c , Property_Age_Years__c, Needs_Renovation__c from Property__c where Name=:propertyName];
    

    l1.add(property);
    l1.add(quotation);
    l1.add(proBook);
    l1.add(customer);
   return l1;
 

   
}





}

