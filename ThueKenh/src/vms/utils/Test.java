package vms.utils;


import java.sql.Clob;
import java.sql.SQLException;
import java.util.LinkedHashMap;

import org.apache.commons.lang3.StringUtils;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.simple.JSONValue;



public class Test {
	public static void main(String arg[]) {
		String[] ids = new String[] {"'1'", "'2'"};
		String str = StringUtils.join(ids,",");
		System.out.println("update Accounts set active = 1 where id in ("+str+")");
		System.out.println("Done!");
    }
}