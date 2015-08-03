/**********************************************************************************
 *  BasicProgramming class performs different operations like
 *  1. To check number is prime or not.
 *  2. To check String is palindrome or not.
 *  3. To replace every occurrence of a character from each String in an array.
 *  4. To count the length of a String.
 *  5. To find only the unique numbers in an array.
***********************************************************************************/
public class BasicProgramming {
    /**
     *  CheckPrimeNumber Method which will accept Integer as parameter and determine & 
     *  print the number is prime or not
     */
     public Boolean checkPrimeNumber(Integer sampleNumber) {
         Integer i = 0, x;
         Boolean flag  =  false; // Variable declaration
         if(sampleNumber<0) {
               // Check for negative number
            sampleNumber = math.abs(sampleNumber); // If negative number then convert it
         }
         for(i = 2; i <= sampleNumber/2; i++) {
             x = math.mod(sampleNumber,i); // Find mod for number
             if(x == 0) { // If yes then set flag 
                 flag = true; 
                 break;
             } // End of if
         } // End of For loop
         if(flag == true) {
             System.debug(sampleNumber + ' is not Prime Number'); // Print result
         } else {
            System.debug(sampleNumber + ' is Prime Number'); // Print result
        }
        return flag;
    } // End of method checkPrimeNumber
    
    /**
     *  CheckPalindromeString method accept String as a parameter and 
     *  print whether it is a palindrome or not
     */
    public Boolean checkPalindromeString(String StringMain) {
        Boolean flag  =  false;
        if(StringMain == ' ') {
            System.debug(' Please enter valid String' ); // Print result
            return flag;
        } else if(StringMain.equalsIgnoreCase(StringMain.reverse())) {  // Check for palindrome
            flag = true;
            System.debug(' String '+ StringMain +' is palindrome' ); // Print result
        } else {
            System.debug(' String '+ StringMain +' is not palindrome' ); // Print result
        }
        return flag;
    } // End of method checkPalindromeString
    
    /**
     *  FindLengthOfString method to count the length of a String (not using length function)
     */
    public Integer findLengthOfString(String StringMain) {
        Integer count  =  0;
        List<Integer> intList  =  new  List<Integer>(); // List of integer
        intList = StringMain.getChars(); // Store chracters of string in List 
        count = intList.size(); // Get size of string
        System.debug('Length of String '+StringMain+' is : '+ count); // Print result
        return count;
    } // End of method findLengthOfString
    
    /**
     *  ReplaceOccuranceOfStringArray method to replace every occurrence of a character from each 
     *  String in an array (accept both character and array of Strings as param)
     */
    public String replaceOccuranceOfStringArray(String CharToReplace,String arrayString ) {
        String arrayStringReplaced = arrayString.replaceAll(CharToReplace, 'x'); // Replace character
        System.debug('Replaced String Array is : '+arrayStringReplaced); // Print result
        return arrayStringReplaced;
    } // End of replaceOccuranceOfStringArray
    
    /**
     *  FindUniqueValuesInArray method to find only the unique numbers in an array 
     *  (accept array as a parameter)
     */
     public Set<Integer> findUniqueValuesInArray( List<Integer> intarray) {
        System.debug(' Given array is : '+intarray);
        Set<Integer> setArray = new Set<Integer>(intarray); // Store List into array     
        System.debug(' Unique numbers from array are : '+setArray);
        return setArray;
    } // End of findUniqueValuesInArray
} // End of class BasicProgramming