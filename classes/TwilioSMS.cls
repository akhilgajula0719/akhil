public class TwilioSMS {
    public String phNumber{get;set;}
    public String smsBody;
    String accountSid;
    string token;
    String fromPhNumber;
    errorResponseWrapper erw;
    public TwilioSMS(){
        
    }
    public void processSms(){
        phNumber ='+447877839198';
        accountSid = 'AC83ee2670a69cf0XXXXXXXXXXXXXX';
        token = 'XXXXXXXXXXXX';
        fromPhNumber = '+447877839198';
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/account_sid/Messages.json');
		req.setMethod('POST'); 
        Blob headerValue = Blob.valueOf('AC83ee2670a69cf02d39730c25f466f79e:54d50d20c8c63bc442ad7e2948a96917');
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        req.setHeader('Authorization', authorizationHeader);
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        String body = EncodingUtil.urlEncode('From=%2B447877839198&To=%2B447877839198&Body=Sample text from twilio', 'UTF-8');
        req.setBody(body);
        Http ht = new Http();
        HttpResponse res = ht.send(req);
        /*HttpRequest req = new HttpRequest();
req.setEndpoint('https://api.twilio.com/2010-04-01/Accounts/'+accountSid+'/SMS/Messages.json');
req.setMethod('POST');
String VERSION  = '3.2.0';
req.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);
req.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);
req.setHeader('Accept', 'application/json');
req.setHeader('Accept-Charset', 'utf-8');
req.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(accountSid+':' +token)));
req.setBody('To='+EncodingUtil.urlEncode(phNumber,'UTF-8')+'&From='+EncodingUtil.urlEncode(fromPhNumber,'UTF-8')+'&Body='+'textmessage');
Http http = new Http();
HTTPResponse res = http.send(req);
System.debug(res.getBody());
if(res.getStatusCode()==201)
ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'SMS Sent Successfully'));
else{
erw =(errorResponseWrapper)json.deserialize(res.getBody(),errorResponseWrapper.class);
}*/
    }
    @AuraEnabled(cacheable=true)
    public static string sendSMS(String textmessage) {
        system.debug('hello testing:'+textmessage);
        TwilioSMS twilio = new TwilioSMS();
        twilio.smsBody = textmessage;
        twilio.processSms();
        return textmessage;
    }
    public class errorResponseWrapper{
        String code;
        String message;
        String moreInfo;
        String status;
    }
}