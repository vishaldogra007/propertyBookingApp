public with sharing class Profile {
    @AuraEnabled(cacheable = true)
    public static string getProfile(){
        Id profileId = UserInfo.getProfileId();
    String profileName =[Select Id, Name from Profile where Id=:profileId].Name;
    system.debug('Profile Name'+profileName);
        return profileName;
    }
}
