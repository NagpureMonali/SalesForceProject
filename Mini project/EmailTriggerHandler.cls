/***************************************************************************************************
 *  This is the class for email handler trigger which calls Google service method and get response
 *  and store it to object
 **************************************************************************************************/ 
global with sharing class EmailTriggerHandler {
    /**
     *  This is the method which will be called for every email insertion
     */
    global static void queryResultRecords(List<Email__c> listEmail) {
        for (Email__c emailInstance : listEmail) {
            System.debug('====emailInsatnce====' + emailInstance);
            googleSearch(emailInstance.Query_String__c);
        } // End of for loop
    } // End of method
    
    /**
     *  This is the method which will be called to send callout to google to get response of search
     */
    @future (callout = true) // Annotation
    public static void googleSearch(String searchQuery) {
        Set<String> setLinks = new Set<String>();
        Set<String> setQueryString = new Set<String>();
        String responseReceived;
        Query_Response__c objQueryResponse;
        List<String> responseList;
        HttpRequest requestInstance = new HttpRequest();
        Http httpInstance = new Http();
        
        // Set the method
        requestInstance.setMethod('GET'); 
        
        // Generate the url for the request
        String url = 'https://www.google.com/search?q='
            + EncodingUtil.urlEncode(searchQuery,'UTF-8');
        
        // Add the endpoint url to the request
        requestInstance.setEndpoint(url);
        requestInstance.setHeader('Accept', 'application/xml');
        
        // Create the response object 
        HTTPResponse resp = httpInstance.send(requestInstance);
        responseReceived = resp.getBody(); 
        System.debug('===============Before parsing==========>' + responseReceived);   
        
        // Remove tag <!doctype html>
        responseReceived = responseReceived.remove('<!doctype html>'); 
        System.debug('=======responseReceived after removing html tag========' + responseReceived);
        
        //replacement for Link
        responseReceived = responseReceived.replace('<cite>',' LinkStart( '); 
        responseReceived = responseReceived.replace('</cite>',' )LinkEnd    Description( ');
        
        // Replacement for description 
        responseReceived = responseReceived.replace('</div></li>',' )DescriptionEnd '); 
        responseReceived = responseReceived.replace('Cached',' '); // Replacement for cached
        System.debug('responseReceived after getting links description ======' + responseReceived);
        
        String stripResponseReceived = responseReceived.stripHtmlTags(); // Strip all html tags 
        System.debug('======responseReceived after strip=====' + stripResponseReceived);
        responseList = new List<String>();
        
        // Spliting over description end
        responseList = stripResponseReceived.split('DescriptionEnd');  
        responseList.remove(0);
        responseList.remove(responseList.size()-1);
        System.debug('======responseReceived after SPLIT=====' + responseList);
        
        for (Query_Response__c queryResponseInstance : [SELECT Link__c 
                                                        FROM Query_Response__c
                                                        WHERE Query__c = :searchQuery
                                                       ]
        ) {
            setLinks.add(queryResponseInstance.Link__c); // add all links to set 
        } // End of for loop
        System.debug('======setLinks in furture method=====' + setLinks);
        
        for ( Query__c queryInsatnce :  [SELECT Search_String__c
                                         FROM Query__c 
                                         WHERE Search_String__c LIKE :searchQuery
                                        ]
        ) {
            setQueryString.add(queryInsatnce.Search_String__c); // Add all query strings to set
        } // End of for loop
        System.debug('======setQueryString in furture method=====' + setQueryString);
        
        for (String stringInstance : responseList) {
            String title = stringInstance.substringBefore(' LinkStart(');
            String link = stringInstance.substringBetween(' LinkStart(', ')LinkEnd');
            String description = stringInstance.substringBetween('Description(', ' )');
            System.debug('===title====' + title);
            System.debug('===link====' + link);
            System.debug('===description in else====' + description);
            objQueryResponse = new Query_Response__c();
            System.debug('===setquery contains body in set check for link======');
            
            // If set contains different response then add else dont add it 
            if (!setLinks.contains(link)) {
                List<Query__c> queryInsatnce = [SELECT Search_String__c
                                                FROM Query__c 
                                                WHERE Search_String__c = :searchQuery
                                               ];
                System.debug('===Link is not exist in setLink so add responses======');
                objQueryResponse = new Query_Response__c(Description__c = description,
                                                         Link__c = link,
                                                         Title__c = title,
                                                         Query__c = queryInsatnce[0].id
                                                         );
                insert objQueryResponse;
                System.debug('=in else block query response is createdt======');
            } // End of If 
        } // End of for loop
    } // End of method 
} // End of class