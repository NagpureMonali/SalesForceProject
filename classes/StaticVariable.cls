/***************************************************************
*  class for static variable
****************************************************************/
public class StaticVariable  
{
    static Integer i;
    public void value() 
    {    
        /**
        *   Method for value to initial set
        */
        System.debug('initial value of i in value method is ' +i);
        i=1;
    }
    public void valueChange() // Method for valuechange
    {   
        /**
        *   Method for value to change
        */
        System.debug('initial value of i in ValueChange method is ' +i);
    } // End of method
} // End of class