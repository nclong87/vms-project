package vms.utils;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class ObjectUtil {
	public static Object excuteMethod(String nameMethod, Object objExt, Object[] args) throws SecurityException, NoSuchMethodException{
		Method _method = objExt.getClass().getMethod(nameMethod);				
		try {
			if (args != null && args.length > 0)
				return _method.invoke(objExt, args);
			else
				return _method.invoke(objExt);
		} catch (IllegalArgumentException e) {
				// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
		
}
