public with sharing class ApprovalClass {
    @AuraEnabled
    public static void approvalInit(String id, String comment){
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments(comment);
        req.setObjectId(id);
        Approval.ProcessResult result;
        try{
            // submit the approval request for processing
            result = Approval.process(req);
        }catch(Exception e){
            System.debug('No approval process has been setup yet.');
        }
    }
}
