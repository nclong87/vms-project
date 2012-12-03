package vms.utils;

import java.util.ArrayList;
import java.util.Hashtable;
import javax.naming.Context;
import javax.naming.NameClassPair;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.ldap.LdapContext;
import javax.naming.ldap.InitialLdapContext;

public class LdapHelper {

    private String rootDN;
    private String ldapURL;
    private LdapContext context;

    /**
     * @return the adminDN
     */
    public String getRootDN() {
            return rootDN;
    }

    /**
     * @param rootDN
     *            the rootDN to set
     */
    public void setRootDN(String rootDN) {
            this.rootDN = rootDN;
    }

    /**
     * @return the ldapURL
     */
    public String getLdapURL() {
            return ldapURL;
    }

    /**
     * @param ldapURL
     *            the ldapURL to set
     */
    public void setLdapURL(String ldapURL) {
            this.ldapURL = ldapURL;
    }

    public DirContext getDirContext() {
                return context;
        }

    public LdapHelper() {
    }

    public LdapHelper(final String rootDN,
                    final String ldapURL) {
            this.rootDN = rootDN;
            this.ldapURL = ldapURL;
    }

    /**
     * Authenticate user.
     *
     * @param userName
     * @param password
     * @return
     */
   @SuppressWarnings({ "rawtypes", "unchecked" })
   public boolean checkValidUser(final String userName, final String password)
    {
        try {
            Hashtable env = new Hashtable();
            env.put(Context.INITIAL_CONTEXT_FACTORY,
                    "com.sun.jndi.ldap.LdapCtxFactory");
            env.put(Context.PROVIDER_URL, ldapURL);
            env.put(Context.SECURITY_AUTHENTICATION, "simple");
            env.put("com.sun.jndi.ldap.read.timeout", "5000");
           // env.put(Context.SECURITY_PRINCIPAL, "vms\\"+userName);
            env.put(Context.SECURITY_PRINCIPAL, "vms\\"+userName);
            env.put(Context.SECURITY_CREDENTIALS, password);
            context = new InitialLdapContext(env, null);
            return true;
        }
        catch (NamingException e)
        {
            System.err.println(e.getMessage());
            return false;
                //throw new BoBException(e, "Login.login");
        }

        //return true;

        //return true;
    }

    @SuppressWarnings({ "rawtypes", "unchecked" })
	public void listAllUsers(ArrayList result, final DirContext context, final String rootContext)
                        throws NamingException {
        //String[] attributeNames = { "memberOf", "name", "sAMAccountName", "distinguishedName" };
        String[] attributeNames = { "cn", "name", "sAMAccountName"};
        NamingEnumeration contentsEnum = context
                        .list(rootContext);
        while (contentsEnum.hasMore()) {
            NameClassPair ncp = (NameClassPair)contentsEnum.next();
            String userName = ncp.getName();
            Attributes attr1 = context.getAttributes(userName + ","
                            + rootContext, new String[] { "objectcategory" });
            if (attr1.get("objectcategory").toString().indexOf("CN=Person") == -1) {
                listAllUsers(result, context, userName + "," + rootContext);
            } else {
                Attributes attrs = context.getAttributes(userName + ","
                                + rootContext, attributeNames);
                Attribute accountAttribute = attrs.get("sAMAccountName");
                if (accountAttribute != null) {
                    for (int i = 0; i < accountAttribute.size(); i++) {
                        result.add(accountAttribute.get(i).toString().toLowerCase());
                    }
                }
            }
        }
  }

  @SuppressWarnings("rawtypes")
public ArrayList getAllUserName(final String rootContext) throws NamingException{
      LdapContext context = this.context;
      ArrayList result = new ArrayList();
      listAllUsers(result, context, rootContext);
      return result;
  }


    /**
     * Modify attributes.
     *
     * @param name
     * @param attributes
     * @return
     */
    /*public boolean modifyAttributes(final String name,
                    final HashMap<String, String> attributes) {
            List<ModificationItem> items = new ArrayList<ModificationItem>();

            for (String key : attributes.keySet()) {
                    Attribute attr = new BasicAttribute(key, attributes.get(key));
                    ModificationItem item = new ModificationItem(
                                    context.REPLACE_ATTRIBUTE, attr);
                    items.add(item);
            }
            try {
                    context.modifyAttributes(name,
                                    items.toArray(new ModificationItem[attributes.size()]));
            } catch (NamingException e) {
                    e.printStackTrace();
                    return false;
            }
            return true;
    }*/



}
