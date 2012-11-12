package vms.utils;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.List;
import java.util.Map;

import javax.xml.namespace.QName;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathExpression;
import org.w3c.dom.Node;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.XMLReaderFactory;


public class XMLUtil {
	public static Object getNode(String strXPath, Node nodeParent, XPath xpath, QName qname) throws Exception{
		XPathExpression xpathExpress = xpath.compile(strXPath);
		Object result = xpathExpress.evaluate(nodeParent, qname);
		if (result == null)
			throw new Exception("Node con voi XPath ");
		return result;
	}
	public static List<Map<String,String>> parseXMLString(String str) throws SAXException, IOException {
		//String str = "<root><element><id>27</id><tenphuluc>Phu luc 01</tenphuluc></element></root>";
		XMLReader r = XMLReaderFactory.createXMLReader();
		System.out.println("str="+str);
		InputStream inputStream= new ByteArrayInputStream( str.getBytes("UTF-8") );
		InputSource source = new InputSource(inputStream);
		XMLParser xmlParser = new XMLParser();
        r.setContentHandler(xmlParser);
        r.parse(source);
        return xmlParser.getData();
	}
	public static String transformStringXML_FileXSL(String sXML, String xsltfilename) {
    	String rs = "";
		try {
			System.out.println(" Executing...transformStringXML_FileXSL, xsltfilename: "+xsltfilename);
			File xsltFile = new File(xsltfilename);
			Source xsltSource = new StreamSource(xsltFile);
			TransformerFactory tFactory = TransformerFactory.newInstance();
			Transformer transformer = tFactory.newTransformer(xsltSource);
			StringWriter sw = new StringWriter();
			StreamResult sr = new StreamResult(sw);
			transformer.transform(new StreamSource(new StringReader(sXML)), sr);
			rs = sw.toString();			
			return rs;
		} catch (Exception e) {
			System.err.println(" ERROR XMLUtils.transformStringXML_FileXSL !!!!");
			e.printStackTrace();
		}
		return rs;
	}	
}
