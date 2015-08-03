/******************************************************************************
*  It is controller class for Invoice Statement
********************************************************************************/
public with sharing class InvoiceVfPageController {
    public List<Invoice_Statement__c> listInvoice;
    public List<Line_Item__c> lineItemList;
    public Id invoice_Id{get;set;}
    public Id invoiceIdToPass{get;set;}
    /*
     *  Method To show all records of invoice statement to a table page 
     */
    public List<Invoice_Statement__c> getlistInvoice() {
        listInvoice=[SELECT Id,
                            Name,
                            City__c,
                            Company_Name__c,
                            Email_Address__c,
                            Name_Of_Customer__c,
                            Phone_Number__c,
                            Stree_Address__c
                     FROM Invoice_Statement__c];
        return listInvoice;
    }
    
    /*
     *  Method To show pdf page 
     */
     public PageReference goToPdfPage() {
        invoice_Id= apexpages.currentpage().getparameters().get('invoiceId');
        System.debug('====id in page diveert==='+invoice_Id);
        PageReference pdfPage=Page.InvoicePdf; 
        pdfPage.setRedirect(True);
        pdfPage.getparameters().put('invoiceID',invoice_Id);
        return pdfPage;
    } // End of method   
    
    public List<Line_Item__c> getlineItemList()
    {
        invoiceIdToPass=apexPages.currentPage().getParameters().get('invoiceID');
        System.debug('====idd==='+invoiceIdToPass);
        lineItemList=[SELECT Id,
                             Name,
                             Amount__c,
                             Description_of_Item__c
                      FROM Line_Item__c 
                      WHERE Invoice_Statement_No__c= :invoiceIdToPass];
         listInvoice=[SELECT Id,
                            Name,
                            City__c,
                            Company_Name__c,
                            Email_Address__c,
                            Name_Of_Customer__c,
                            Phone_Number__c,
                            Stree_Address__c,
                            Grand_Total__c
                     FROM Invoice_Statement__c];
         System.debug('====List==='+lineItemList);
                      
        return lineItemList;
    }
} // End of controller class