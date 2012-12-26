package vms.utils;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.xml.sax.ContentHandler;
import org.xml.sax.Locator;
import org.xml.sax.SAXException;

/**
 *
 * @author Long
 */
public class XMLParser implements ContentHandler{
    private String currentTag;
    Map<String,String> map;
    private List<Map<String,String>> list;
    public XMLParser(){
    	list = new ArrayList<Map<String,String>>();
    }
    public List<Map<String,String>> getData(){
        return list;
    }
    public void setDocumentLocator(Locator locator) {

    }

    public void startDocument() throws SAXException {
        //Bat dau tai lieu xml
        //System.out.print("Bat dau");
    }

    public void endDocument() throws SAXException {
        //Ket thuc tai lieu xml
        //System.out.print("Ket thuc");
        //throw new SAXException();
    }

    public void startPrefixMapping(String prefix, String uri) throws SAXException {

    }

    public void endPrefixMapping(String prefix) throws SAXException {

    }
     public void startElement(String uri, String localName, String qName, org.xml.sax.Attributes atts) throws SAXException {
        if (localName.equals("element")){
        	map = new LinkedHashMap<String, String>();
        } else {
        	currentTag = localName;
        }
    }


    public void endElement(String uri, String localName, String qName) throws SAXException {
        //Ket thuc 1 node
        if (localName.equals("root")){
            this.endDocument();
        }
        if (localName.equals("element")){
            list.add(map);
        }
    }

    public void characters(char[] ch, int start, int length) throws SAXException {
        //Doc noi dung
        String str=new String(ch,start,length);
        str=str.trim();
        if(str.length()>0)
        {
            map.put(currentTag, str);
        }
    }

    public void ignorableWhitespace(char[] ch, int start, int length) throws SAXException {

    }

    public void processingInstruction(String target, String data) throws SAXException {

    }

    public void skippedEntity(String name) throws SAXException {

    }
}
