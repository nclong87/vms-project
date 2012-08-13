package vms.utils;

import java.text.MessageFormat;

public class PropertiesUtil {
    //private static final PropertyResourceBundle _resBundle=getBaseBundle();
    
    
    /** Creates a new instance of PetstoreUtil */
    public PropertiesUtil() {
    }
    
    /*private static PropertyResourceBundle getBaseBundle() {
        try {
        	//System.out.println("LVWebFilter.URLMODULE_PROPERTIES_PATH: " +LVWebFilter.URLMODULE_PROPERTIES_PATH);
        	InputStream inputStream = new FileInputStream(new File(LVWebFilter.URLMODULE_PROPERTIES_PATH));
        	return new PropertyResourceBundle(inputStream);
            //return new PropertyResourceBundle(PropertiesUtil.class.getResourceAsStream("urlmodule.properties"));
        } catch(IOException io) {
            return null;
        }
        
    }*/
    
    
    public static String getMessage(String key) {
        return getMessage(key, (Object[])null);
    }
    
    
    /**
     * This method uses the default message strings property file to resolve
     * resultant string to show to an end user
     * @param Key to use in MessageString.properties file
     *
     * @return Formated message for external display
     */
    public static String getMessage(String key, Object... arguments) {
        String sxRet=null;
        // get resource bundle and retrive message
        //sxRet=_resBundle.getString(key);
        
        // see if the message needs to be formatted
        if(arguments != null) {
            // format message
            sxRet=MessageFormat.format(sxRet, arguments);
        }
        return sxRet;
    }
}
