trigger quotationRecord on Property_Booking__c (after update ,before insert ) {
    if(Trigger.isUpdate && Trigger.isAfter){
        QuotationTriggerHandler.generateQuotation(Trigger.new);

    }
    if(Trigger.isInsert && Trigger.isBefore){
        QuotationTriggerHandler.checkPropBookRecords(Trigger.new);
    }

}