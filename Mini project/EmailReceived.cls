/**************************************************************************************************
 *  This is the class which manages incomming emails and stores them to the org 
 *************************************************************************************************/
global class EmailReceived implements Messaging.InboundEmailHandler {
    /**
     *  This is the method which will store incomming email into objects according
     */
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,
        Messaging.Inboundenvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        Contact contactInstance;
        Email__c emailInstance;
        Query__c queryInstance;
        ResponseToSend__c responseInstance; 
        String searchString;
        Set<String> setQueryString = new Set<String>();
        try {
            if ((!String.isBlank(email.plainTextBody)) || 
                (email.plainTextBody.contains('Query[') && email.plainTextBody.contains(']'))
            ) {
                System.debug('Proper Format query');
                searchString = email.plainTextBody.substringBetween('Query[',']');
                if (!String.isBlank(searchString)) {
                    System.debug('Query contains text');
                    result.success = true;
                } else {
                    System.debug('Query String Empty');
                    result.success = false;
                    result.message = 'Please Send Query in proper Format " Query[Your Query] "';
                }
            } else {
                System.debug('Not in Proper Format query');
                result.success = false;
                result.message = 'Please Send Query in proper Format " Query[Your Query] "';
            } // End of else block
            if (result.success == true ) {
                searchString = searchString.toLowerCase(); 
                searchString = searchString.trim();
                System.debug('======body email=====' + searchString);
                System.debug('======emailSubject==========' + email.subject);
                for ( Query__c instanceQuery : [SELECT Search_String__c
                                                FROM Query__c 
                                                WHERE Search_String__c like :searchString
                                               ]
                ) {
                    // Add query strings to set
                    setQueryString.add(instanceQuery.Search_String__c); 
                } // End of for loop
                System.debug('======setQueryString in email response=====' + setQueryString);  
                if ([SELECT COUNT() 
                     FROM Contact 
                     WHERE Email = :email.fromAddress 
                    ] == 0
                ) { // If that email not present in contact then it will create new contact 
                    System.debug('====Dont have contact so inserted======');
                    contactInstance = new Contact();
                    contactInstance.LastName = email.fromName;
                    contactInstance.Email = email.fromAddress;
                    insert contactInstance;
                         
                    emailInstance = new Email__c();
                    emailInstance.Email_Subject__c = email.subject; // Email subject
                    emailInstance.Email_Sender__c = email.fromAddress; // Email sender
                    emailInstance.Query_String__c = searchString; // Email body 
                    insert emailInstance;
                    
                    // If email body(Query String) is not present in set, add it to query object
                    if (!setQueryString.contains(searchString)) {
                        System.debug('======in if block if setQueryString is not in set=======');
                        queryInstance = new Query__c(Search_String__c = searchString);
                        insert queryInstance;
                        System.debug('===Query inserted======');
                        responseInstance = new ResponseToSend__c(Query__c = queryInstance.Id,
                                                                 Contact__c = contactInstance.Id);
                        insert responseInstance;
                        System.debug('=response inserted inserted======');
                    } else { 
                        // Fatch that query string and append reponse 
                        System.debug('======in else block if setQueryString is in set=======');
                        List<Query__c> queryList = [SELECT Id,
                                                           Search_String__c
                                                    FROM Query__c 
                                                    WHERE Search_String__c = :searchString 
                                                   ];
                        for (Contact c : [SELECT Id 
                                          FROM Contact 
                                          WHERE Email = :email.fromAddress
                                         ]
                        ) {
                            responseInstance = new ResponseToSend__c(Query__c = queryList[0].Id,
                                                                     Contact__c = c.Id);
                            insert responseInstance;
                        } // End of for loop
                        System.debug('===response inserted inserted======');
                    } // End of else
                    System.debug('======Email inserted succesffully========');
                } else { 
                    // Contact already present then dont create new one just create a new email
                    emailInstance = new Email__c();
                    emailInstance.Email_Subject__c = email.subject; // Email subject
                    emailInstance.Email_Sender__c = email.fromAddress; // Email sender 
                    emailInstance.Query_String__c = searchString; // Email body
                    insert emailInstance;
                    System.debug('====email inserted inserted======');
                    // If email body(Query String) is not present in set, add it to query object
                    if (!setQueryString.contains(searchString)) { 
                        System.debug('===in if block if setquery not contains query in set======');
                        queryInstance = new Query__c(Search_String__c = searchString);
                        insert queryInstance;
                        for (Contact c : [SELECT Id 
                                          FROM Contact 
                                          WHERE Email = :email.fromAddress
                                         ]
                        ) {
                            responseInstance = new ResponseToSend__c(Query__c = queryInstance.Id,
                                                                     Contact__c = c.Id);
                            insert responseInstance;
                        } // End of for loop
                    } else {
                        System.debug('=in else block setquery  contains query in set======');
                        List<Query__c> queryList = [SELECT Id,
                                                           Search_String__c
                                                    FROM Query__c 
                                                    WHERE Search_String__c = :searchString 
                                                   ];
                        System.debug('==========queryList==========' + queryList);
                        for (Contact instanceContact : [SELECT Id 
                                          FROM Contact 
                                          WHERE Email = :email.fromAddress
                                         ]
                        ) {
                            responseInstance = new ResponseToSend__c(Query__c = queryList[0].Id,
                                Contact__c = instanceContact.Id);
                            insert responseInstance;
                        } // End of for loop
                        System.debug('===Query sent to responsd is generated ======');
                    } // End of else
                    System.debug('======Email inserted succesffully========'); 
                } // End of else block
            } // End of if block 
        } catch(Exception e) {
            result.message = 'Please Send Query in proper Format " Query[Your Query] "';
            System.debug('Error in catch=============' + e.getMessage());
        } // End of catch block
        return result; // Return result
    } // End of method
} // End of class