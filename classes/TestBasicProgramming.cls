/***********************************************************************************************
 *  BasicProgramming Test class performs different operations like
 *  1. To test number is prime or not.
 *  2. To test string is palindrome or not.
 *  3. To test every occurrence of a character from each string in an array is replaced or not.
 *  4. To test the length of a string.
 *  5. To test unique numbers in an array or not.
***********************************************************************************************/
@isTest // Annotation 
private class TestBasicProgramming {
       /**
        *  This method to test number is prime.
        */
    static testMethod void testForPrimeNumber() {
        Test.startTest(); // Start test
        // Instance of a class basicprogramming
        BasicProgramming objBasicProgramming  =  new BasicProgramming(); 
        Test.stopTest(); // End test
        System.assertEquals(false,objBasicProgramming.checkPrimeNumber(1)); // Check for result
    } // End of method
    
    /**
     *  This method to test number not prime number.
     */
    static testMethod void testForNotPrimeNumber() {
        Test.startTest(); // Start test
        // Instance of a class basicprogramming
        BasicProgramming objBasicProgramming = new BasicProgramming(); 
        Test.stopTest(); // End test
        System.assertEquals(true,objBasicProgramming.checkPrimeNumber(9)); // Check for result
    } // End of method
    
    /**
     *  This method to test negative prime number.
     */
    static testMethod void testForNegativePrimeNumber() {
        Test.startTest(); // Start test
        // Instance of a class basicprogramming
        BasicProgramming objBasicProgramming = new BasicProgramming();
        Test.stopTest(); // End test
        System.assertEquals(false,objBasicProgramming.checkPrimeNumber(-2)); // Check for result
    } // End of method
    
    /**
     *  This method to test negative number not prime number.
     */
    static testMethod void testForPositiveNotPrimeNumber() {
        Test.startTest(); // Start test
        // Instance of a class basicprogramming
        BasicProgramming objBasicProgramming = new BasicProgramming(); 
        Test.stopTest(); // End test
        System.assertEquals(true,objBasicProgramming.checkPrimeNumber(-8)); // Check for result
    } // End of method
    
    /**
     *  Method to test palindrome String
     */
    static testMethod void testPalindromeString() {
        Test.startTest(); // Start test
        // Instance of a class basicprogramming
        BasicProgramming objBasicProgramming = new BasicProgramming(); 
        Test.stopTest(); // End test
        System.assertEquals(true,objBasicProgramming.checkPalindromeString('madam')); 
    } // End of method
    
    /**
     *  Method to test Not a palindrome String
     */
    static testMethod void testNotPalindromeString() {
        Test.startTest(); // Start test
        // Instance of a class basicprogramming
        BasicProgramming objBasicProgramming = new BasicProgramming(); 
        Test.stopTest(); // End test
        // Check for result
        System.assertEquals(false,objBasicProgramming.checkPalindromeString('mona')); 
    } // End of method
    
    /**
     *  Method to test blank String
     */
    static testMethod void testBlankString() {
        Test.startTest(); // Start test
        // Instance of a class basicprogramming
        BasicProgramming objBasicProgramming = new BasicProgramming(); 
        Test.stopTest(); // End test
        // Check for result
        System.assertEquals(false,objBasicProgramming.checkPalindromeString(' ')); 
    } // End of method
    
    /**
     *  Method to test length of String
     */
    static testMethod void testLengthOfString() {
        Test.startTest(); // Start test
        // Instance of a class basicprogramming
        BasicProgramming objBasicProgramming = new BasicProgramming(); 
        Test.stopTest(); // End test
        System.assertEquals(6,objBasicProgramming.findLengthOfString('monali')); // Check for result
    } // End of method
    
    /**
     *  Method to test length of blank String
     */
    static testMethod void testLengthOfblankString() {
        Test.startTest(); // Start test
        // Instance of a class basicprogramming
        BasicProgramming objBasicProgramming = new BasicProgramming(); 
        Test.stopTest(); // End test
        System.assertEquals(0,objBasicProgramming.findLengthOfString('')); // Check for result
    } // End of method
    
    /**
     *  method to test every occurrence of a character from each 
     *  string in an array is replaced (accept both character and array of strings as param)
     */
    static testMethod void testReplaceOccuranceOfStringArray() {
        Test.startTest(); // Start test
        // Instance of a class basicprogramming
        BasicProgramming objBasicProgramming = new BasicProgramming();  
        Test.stopTest(); // End test
        // Check for result
        System.assertEquals('monxli sonxli',objBasicProgramming.replaceOccuranceOfStringArray('a','monali sonali'));
     } // End of method
     
     /**
      *  method to check occurrence of a character is present in string of an 
      *  array (accept both character and array of strings as param)
      */
     static testMethod void testOccurancePresentInArray() {
        Test.startTest(); // Start test
        // Instance of a class basicprogramming
        BasicProgramming objBasicProgramming = new BasicProgramming(); 
        Test.stopTest(); // End test
        // Check for result
        System.assertEquals('test sample',objBasicProgramming.replaceOccuranceOfStringArray('z','test sample')); 
     } // End of method
     
     /**
      *  method to test unique numbers in an array (accept array as a parameter)
      */
     static testMethod void testFindUniqueValuesInArray() {
        Test.startTest(); // Start test
        List<Integer> sampleList = new List<Integer>(); // List of integers
        sampleList.add(1);
        sampleList.add(1);
        sampleList.add(2);
        sampleList.add(3);
        sampleList.add(3);
        Set<Integer> testSet = new Set<Integer>(); // Set of integers
        testSet.add(1);
        testSet.add(2);
        testSet.add(3);
        // Instance of a class basicprogramming
        BasicProgramming objBasicProgramming = new BasicProgramming(); 
        Test.stopTest(); // End test
        // Check for result
        System.assertEquals(testSet,objBasicProgramming.findUniqueValuesInArray(sampleList)); 
     } // End of method
     
     /**
      *  method to test unique numbers in an array if array has only one element
      */
     static testMethod void testUniqueValuesInArray() {
        Test.startTest(); // Start test
        List<Integer> sampleList = new List<Integer>(); // List of integers
        sampleList.add(1);
        Set<Integer> testSet = new Set<Integer>(); // Set of integers
        testSet.add(1);
        // Instance of a class basicprogramming
        BasicProgramming objBasicProgramming = new BasicProgramming(); 
        // Check for result 
        Test.stopTest(); // End test
        System.assertEquals(testSet,objBasicProgramming.findUniqueValuesInArray(sampleList));
     } // End of method
     
     /**
      *  method to test unique numbers in an array if array has all same element
      */
     static testMethod void testUniqueInArray() {
        Test.startTest(); // Start test
        List<Integer> sampleList = new List<Integer>(); // List of integers
        sampleList.add(1);
        sampleList.add(1);
        sampleList.add(1);
        Set<Integer> testSet = new Set<Integer>(); // Set of integers
        testSet.add(1);
        // Instance of a class basicprogramming
        BasicProgramming objBasicProgramming = new BasicProgramming(); 
        Test.stopTest(); // End test
        System.assertEquals(testSet,objBasicProgramming.findUniqueValuesInArray(sampleList)); // Check for result
     } // End of method
} // End of testt class