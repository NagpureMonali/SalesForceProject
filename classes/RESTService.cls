/**************************************************************************************************
 *  Here is class to call webserive from another org using REST Callouts.
 **************************************************************************************************/
public class RESTService {
    /**
     *  Here is login method which provides access to call webservice from other org
     */
    public static wrapperForOauthResponse loginMethod() {
        String username = 'monali.nagpure@eternussolutions.com';
        String password = 'test123@';
        String clientId = '3MVG9ZL0ppGP5UrDt_ROjAvPsCrP56Xd5Ma0wm.N9ebStuN1.T8OouI3avnhPDcQ4s09aPbicnXfzZhM6tosc';
        String clientSecret = '6817841756348214463';
        HttpRequest request = new HttpRequest();    
        request.setMethod('POST');
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token'); 
        request.setBody('grant_type=password' +'&client_id=' + clientId +'&client_secret=' 
            + clientSecret + '&username=' + EncodingUtil.urlEncode(username, 'UTF-8') + 
            '&password=' + EncodingUtil.urlEncode(password, 'UTF-8')
        );
        Http http = new Http();
        HTTPResponse res = http.send(request);  
        System.debug('Request sent');
        System.debug('BODY: ' + res.getBody());
        System.debug('STATUS:' + res.getStatus());
        System.debug('STATUS_CODE:' + res.getStatusCode());
        
        wrapperForOauthResponse wrapperInstane = 
            (wrapperForOauthResponse)JSON.deserialize(res.getBody(),wrapperForOauthResponse.class);
        System.debug('=========Access Token :========' + wrapperInstane.access_token);
        return wrapperInstane;
    } // End of method
    
    /**
     *  Here is method which calls create lead method from other org
     */
    public HttpResponse leadCreate() { 
        wrapperForOauthResponse Instance = RESTService.loginMethod();
        Http httpInstance = new Http();
        HttpRequest HttpRequestInstance = new HttpRequest();
        HttpRequestInstance.setHeader('Authorization','Bearer ' + Instance.access_token);
        HttpRequestInstance.setHeader('Content-Type','application/json');
        HttpRequestInstance.setHeader('accept','application/json');
        HttpRequestInstance.setMethod('POST');
        String parameterForCreate = 
            '{"firstName":"TestREST", "lastName":"TestREST", "phone":"1234567890", "email":"Test@rest.com", "company":"Test", "status":"Closed Won"}';
        HttpRequestInstance.setBody(parameterForCreate);
        HttpRequestInstance.setEndpoint(Instance.instance_url + '/services/apexrest/Lead');
        HttpRequestInstance.setHeader('Authorization', 'OAuth ' + Instance.access_token);
        HttpResponse responseInstance = httpInstance.send(HttpRequestInstance);
        System.debug('====== Response ======' + responseInstance.getBody());
        return responseInstance;
    } // End of method 
    
    /**
     *  Here is method which calls update lead method from other org
     */
    public HttpResponse leadUpdate() {
        wrapperForOauthResponse Instance = RESTService.loginMethod();
        Http httpInstance = new Http();
        HttpRequest HttpRequestInstance = new HttpRequest();
        HttpRequestInstance.setHeader('Authorization','Bearer ' + Instance.access_token);
        HttpRequestInstance.setHeader('Content-Type','application/json');
        HttpRequestInstance.setHeader('accept','application/json');
        HttpRequestInstance.setEndpoint(Instance.instance_url + '/services/apexrest/Lead?_HttpMethod=PATCH');
        HttpRequestInstance.setHeader('X-HTTP-Method-Override','PATCH');
        HttpRequestInstance.setMethod('POST');
        String parameterForUpdate = 
            '{"firstName":"TestREST", "lastName":"TestREST", "phone":"1234567890", "email":"Test@rest.com", "company":"ESPL", "status":"Closed Won"}';
        HttpRequestInstance.setBody(parameterForUpdate);
        HttpRequestInstance.setHeader('Authorization', 'OAuth ' + Instance.access_token);
        HttpResponse responseInstance = httpInstance.send(HttpRequestInstance);
        System.debug('====== Response ======'+responseInstance.getBody());
        return responseInstance;
    } // End of method
    
    /**
     *  Here is method which calls delete  method from other org
     */
    public HttpResponse leadDelete() {
        wrapperForOauthResponse Instance = RESTService.loginMethod();
        Http httpInstance = new Http();
        HttpRequest HttpRequestInstance = new HttpRequest();
        HttpRequestInstance.setHeader('Authorization','Bearer ' + Instance.access_token);
        HttpRequestInstance.setHeader('Content-Type','application/json');
        HttpRequestInstance.setHeader('accept','application/json');
        HttpRequestInstance.setEndpoint(Instance.instance_url + '/services/apexrest/Lead?firstName=TestREST&lastName=TestREST&email=Test@rest.com&phone=1234567890');
        HttpRequestInstance.setMethod('DELETE');      
        HttpRequestInstance.setHeader('Authorization', 'OAuth ' + Instance.access_token);       
        HttpResponse responseInstance = httpInstance.send(HttpRequestInstance);
        System.debug('====== Response ======' + responseInstance.getBody());
        return responseInstance;
    } // End of method
    
    /**
     *  Here is wrapper class which will hold responce for different methods
     */
    public class wrapperForOauthResponse {
        public String id;
        public String issued_at;
        public String instance_url;
        public String signature;
        public String access_token;
    } // End of wrapper class
} // End of class