package vms.utils;






public class Test {
	public static void main(String arg[]) {
		String str = "19-Sep-2012";
		System.out.println(DateUtils.SQLtoDisplay(str, "dd/MM/yyyy HH"));
		//System.out.println("update Accounts set active = 1 where id in ("+str+")");
		System.out.println("Done!");
    }
}