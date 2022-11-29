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
   

}