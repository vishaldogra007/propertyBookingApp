trigger lockQuotation on Quotation__c (before update) {
    if(Trigger.isUpdate && Trigger.isBefore){
       QuotationTriggerHandler.checkChangeInQuotedToCustomer(Trigger.old , Trigger.new);
    }

}