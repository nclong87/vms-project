package vms.test;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;


import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.XMLReaderFactory;

import vms.utils.XMLParser;
import vms.utils.XMLUtil;


public class TestXML {
	public static void main(String arg[]) {
		System.out.println("Begin");
		try {
			String str = "<root><element><id>27</id><tenphuluc>Phu luc 01</tenphuluc></element></root>";
			List<Map<String,String>> list = XMLUtil.parseXMLString(str);
            System.out.println(list.get(0).get("tenphuluc"));
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("Done!");
    }
}