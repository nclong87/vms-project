package vms.utils;

import javax.xml.namespace.QName;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathExpression;
import org.w3c.dom.Node;


public class XMLUtil {
	public static Object getNode(String strXPath, Node nodeParent, XPath xpath, QName qname) throws Exception{
		XPathExpression xpathExpress = xpath.compile(strXPath);
		Object result = xpathExpress.evaluate(nodeParent, qname);
		if (result == null)
			throw new Exception("Node con voi XPath ");
		return result;
	}
}
