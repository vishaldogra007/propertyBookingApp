public with sharing class QuotationTriggerHandler {

    //function to check if a property record is already made for same customer and property

   public static void checkPropBookRecords(List<Property_Booking__c> propRecs){
    Property_Booking__c propRec = propRecs[0];
    List<Property_Booking__c> allRec = [select Id,Property__c ,Customer__c,Status__c,Actual_Price__c,Quoted_Price__c,Quotation_Generated__c,Name,Acquire_Property_By__c from Property_Booking__c];
    for(Property_Booking__c rec : allRec){
        if(rec.Customer__c == propRec.Customer__c && rec.Property__c == propRec.Property__c){
            propRec.addError('Property booking record is already created for same property and customer ');
          
        }
    }
   }

   //function to genreate quotation

    public static void generateQuotation(List<Property_Booking__c> newList) {   
               boolean present  = false;
               Property_Booking__c property = newList[0];

               List<Quotation__c> quotationRecs = [Select Id,Booking_Ref__c from  Quotation__c];
               for(Quotation__c quotation : quotationRecs){
                   if(property.Id == quotation.Booking_Ref__c){
                    present = true;

                   }
               }

                //current property booking record 
                Property_Booking__c propBook = [select Id,Property__c ,Customer__c,Status__c,Actual_Price__c,Quoted_Price__c,Quotation_Generated__c,Name,Acquire_Property_By__c from Property_Booking__c where Id =:property.Id ] ;
               
                //Id of property and customer record 
                Id propertyId = propBook.Property__c;
                Id customerId = propBook.Customer__c;
                 
                //Property and customer used in property booking record
                Property__c prop = [select Id,Property__c ,Area__c,State__c,District__c,Type__c,Storey__c,Name,Built_On__c ,Property_Age_Years__c, Needs_Renovation__c from Property__c where Id=:propertyId];
                Customer_Obj__c customer = [select Id,Name ,Aadhar__c,Pan__c,District__c,State__c,Email__c,Phone__c from Customer_Obj__c where Id=:customerId];
                
                if(present==true){
                    property.addError('Only one quotation is allowed per Property Booking');

                }else{
                    if(property.Status__c == 'Approved'){
                        //generatig new Quotation record
                       Quotation__c quotation = new Quotation__c();
                       quotation.Booking_Ref__c= propBook.Id;
                       quotation.Name = prop.Name;
                       quotation.Property_Type__c= prop.Type__c;
                       quotation.Customer_Name__c= customer.Name;
                       quotation.Acquire_Property_By__c=propBook.Acquire_Property_By__c;
                       quotation.Price__c = propBook.Quoted_Price__c;
                       quotation.Customer_Email__c=customer.Email__c;
                        insert quotation; 
                       }

                }
                
                
                
                
        }

     public static void checkChangeInQuotedToCustomer(List<Quotation__c> oldList , List<Quotation__c> newList){
       Quotation__c newQuote = newList[0];
        Quotation__c Oldquote = oldList[0];
        if(oldquote.Quoted_to_Customer__c == true ){
            newQuote.addError('Quotation could not be modified once sent to Customer');
        }
     }


    }

