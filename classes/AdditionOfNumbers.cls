/************************************************************************
*  Sample program of Addition Of two numbers
**************************************************************************/
public class AdditionOfNumbers {
    Integer thirdNumber;  ///declaration of variable
    //Constructor
    public AdditionOfNumbers(Integer firstNumber,Integer secondNumber)
    {
        /**
        *  Constructor
        */
        thirdNumber=firstNumber+secondNumber; //perform addition
        System.debug('Addition is '+thirdNumber); //print result
    } // End of method
} // End of class