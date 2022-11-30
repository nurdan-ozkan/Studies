@RestResource(urlMapping='/FieldAccount/*')
global class RestCaseController {
    @HTTPGet
    global static List<Case> numberOfRelatedCases(){
         
        String AccountName = RestContext.request.params.get('AccountName');
        String AccountRating = RestContext.request.params.get('AccountRating');
        
        Account ac= [SELECT Id, Name From Account WHERE name=: AccountName AND Rating =: AccountRating LIMIT 1];
        
        List<Case> relatedCases = [SELECT Id, Subject, Origin FROM Case WHERE AccountId =:ac.Id ];
        
       return relatedCases;
    }
    
    @HTTPPost
    global static String createNewAccount(String AccountName, String Rating){
        Account ac = new Account();
        ac.Name = AccountName;
        ac.Rating = Rating;
        insert ac;
        return 'New Account has been created.';
        
    }
    @HTTPPatch
    global static String updateanAccount(String acId, String acSite){
        Account ac =[SELECT Id, Name, Site FROM Account WHERE Id=: acId];
        ac.Site = acSite;
        update ac;
        return 'An Account has beeen update';
        
    }
   @HTTPDelete
    global static String deleteAccount(){
        String acId = RestContext.request.params.get('AccountId');
        Account ac = [SELECT Id From Account WHERE Id=:acId];
        delete ac;
        return 'An account has been deleted';
    }

}