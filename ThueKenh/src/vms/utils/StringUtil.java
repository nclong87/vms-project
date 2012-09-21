package vms.utils;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Clob;
import java.sql.SQLException;


public class StringUtil {
	public static String processKeyword(String keyword) {
		keyword = keyword.trim();
		keyword = keyword.replace('*', '%');
		return keyword;
	}
	public static String clobToString(Clob clob) {
		String result = "";
		try {
			result = clob.getSubString(1, (int) clob.length());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("ERROR: Loi doc Clob!");
			e.printStackTrace();
		}
		return result;
	}

	public static boolean notEmpty(String src) {
		if (src == null)
			return false;
		if (src=="")
			return false;
		return true;
	}
	public static String getUnsignedString(String s) {
		StringBuffer unsignedString = new StringBuffer(1024);	
        for (int i = 0; i < s.length(); i++) {
            unsignedString.append(getUnsignedChar(s.charAt(i)));
        }
        return unsignedString.toString();
		/*StringBuffer unsignedString = new StringBuffer();
		HashMap hash = new HashMap();
		hash.put("áº¥" ,"A");
		hash.put("áº©","A");
		hash.put("áº«","A");
		hash.put("áº­","A");
		hash.put("Ã¢","A");
		hash.put("áº¯","A");
		hash.put("áº±","A");
		hash.put("áº³","A");
		hash.put("áºµ","A");
		hash.put("áº·","A");
		hash.put("Äƒ","A");
		hash.put("Ã¡","A");
		hash.put("Ã ","A");
		hash.put("áº£","A");
		hash.put("Ã£","A");
		hash.put("áº¡","A");
		
		hash.put("áº¤" ,"A");
		hash.put("áº¨","A");
		hash.put("áºª","A");
		hash.put("áº¬","A");
		hash.put("Ã‚","A");
		hash.put("áº®","A");
		hash.put("áº°","A");
		hash.put("áº²","A");
		hash.put("áº´","A");
		hash.put("áº¶","A");
		hash.put("Ä‚","A");
		hash.put("Ã�","A");
		hash.put("Ã€","A");
		hash.put("áº¢","A");
		hash.put("Ãƒ","A");
		hash.put("áº ","A");
		
		hash.put("áº¿" ,"E");
		hash.put("á»�" ,"E");
		hash.put("á»ƒ" ,"E");
		hash.put("á»…" ,"E");
		hash.put("á»‡" ,"E");
		hash.put("Ãª" ,"E");
		hash.put("Ã©" ,"E");
		hash.put("Ã¨" ,"E");
		hash.put("áº»" ,"E");
		hash.put("áº½" ,"E");
		hash.put("áº¹" ,"E");
		
		hash.put("áº¾" ,"E");
		hash.put("á»€" ,"E");
		hash.put("á»‚" ,"E");
		hash.put("á»„" ,"E");
		hash.put("á»†" ,"E");
		hash.put("ÃŠ" ,"E");
		hash.put("Ã‰" ,"E");
		hash.put("Ãˆ" ,"E");
		hash.put("áºº" ,"E");
		hash.put("áº¼" ,"E");
		hash.put("áº¸" ,"E");
		
		hash.put("Ã­" ,"I");
		hash.put("Ã¬" ,"I");
		hash.put("á»‰" ,"I");
		hash.put("Ä©" ,"I");
		hash.put("á»‹" ,"I");
		
		hash.put("Ã�" ,"I");
		hash.put("ÃŒ" ,"I");
		hash.put("á»ˆ" ,"I");
		hash.put("Ä¨" ,"I");
		hash.put("á»Š" ,"I");
		
		hash.put("á»‘" ,"O");
		hash.put("á»“" ,"O");
		hash.put("á»•" ,"O");
		hash.put("á»—" ,"O");
		hash.put("á»™" ,"O");
		hash.put("á»›" ,"O");
		hash.put("á»�" ,"O");
		hash.put("á»Ÿ" ,"O");
		hash.put("á»¡" ,"O");
		hash.put("á»£" ,"O");
		hash.put("Ã³" ,"O");
		hash.put("Ã²" ,"O");
		hash.put("á»�" ,"O");
		hash.put("Ãµ" ,"O");
		hash.put("á»�" ,"O");
		hash.put("Ã´" ,"O");
		hash.put("Æ¡" ,"O");
		
		hash.put("á»�" ,"O");
		hash.put("á»’" ,"O");
		hash.put("á»”" ,"O");
		hash.put("á»–" ,"O");
		hash.put("á»˜" ,"O");
		hash.put("á»š" ,"O");
		hash.put("á»œ" ,"O");
		hash.put("á»ž" ,"O");
		hash.put("á» " ,"O");
		hash.put("á»¢" ,"O");
		hash.put("Ã“" ,"O");
		hash.put("Ã’" ,"O");
		hash.put("á»Ž" ,"O");
		hash.put("Ã•" ,"O");
		hash.put("á»Œ" ,"O");
		hash.put("Ã”" ,"O");
		hash.put("Æ " ,"O");
		
		hash.put("á»©" ,"U");
		hash.put("á»«" ,"U");
		hash.put("á»­" ,"U");
		hash.put("á»¯" ,"U");
		hash.put("á»±" ,"U");
		hash.put("Æ°" ,"U");
		hash.put("Ãº" ,"U");
		hash.put("Ã¹" ,"U");
		hash.put("á»§" ,"U");
		hash.put("Å©" ,"U");
		hash.put("á»¥" ,"U");
		
		hash.put("á»¨" ,"U");
		hash.put("á»ª" ,"U");
		hash.put("á»¬" ,"U");
		hash.put("á»®" ,"U");
		hash.put("á»°" ,"U");
		hash.put("Æ¯" ,"U");
		hash.put("Ãš" ,"U");
		hash.put("Ã™" ,"U");
		hash.put("á»¦" ,"U");
		hash.put("Å¨" ,"U");
		hash.put("á»¤" ,"U");
		
		hash.put("Ã½" ,"Y");
		hash.put("á»³" ,"Y");
		hash.put("á»·" ,"Y");
		hash.put("á»¹" ,"Y");
		hash.put("á»µ" ,"Y");
		
		hash.put("Ã�" ,"Y");
		hash.put("á»²" ,"Y");
		hash.put("á»¶" ,"Y");
		hash.put("á»¸" ,"Y");
		hash.put("á»´" ,"Y");
		
		hash.put("Ä‘" ,"D");
		hash.put("Ä�" ,"D");
				
		
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			String sAppend = String.valueOf(c);
			if(hash.containsKey(sAppend)) {
				sAppend = (String) hash.get(sAppend);
			} 
			unsignedString.append(sAppend);
			//System.out.println("kk");
		}
		return unsignedString.toString();*/
	}

	public static char getUnsignedChar(char c) {
		
		if (c=='\u00E1'||c=='\u00E0'||c=='\u1EA3'||c=='\u00E3'||c=='\u1EA1'||
                c=='\u0103'||c=='\u1EAF'||c=='\u1EB1'||c=='\u1EB3'||c=='\u1EB5'||c=='\u1EB7'||
                c=='\u00E2'||c=='\u1EA5'||c=='\u1EA7'||c=='\u1EA9'||c=='\u1EAB'||c=='\u1EAD') {
                return 'a';
            } else if (c=='\u00C1'||c=='\u00C0'||c=='\u1EA2'||c=='\u00C3'||c=='\u1EA0'||
                c=='\u0102'||c=='\u1EAE'||c=='\u1EB0'||c=='\u1EB2'||c=='\u1EB4'||c=='\u1EB6'||
                c=='\u00C2'||c=='\u1EA4'||c=='\u1EA6'||c=='\u1EA8'||c=='\u1EAA'||c=='\u1EAC') {
                return 'A';
            } else if (c=='\u00E9'||c=='\u00E8'||c=='\u1EBB'||c=='\u1EBD'||c=='\u1EB9'||
                c=='\u00EA'||c=='\u1EBF'||c=='\u1EC1'||c=='\u1EC3'||c=='\u1EC5'||c=='\u1EC7') {
                return 'e';
            } else if (c=='\u00C9'||c=='\u00C8'||c=='\u1EBA'||c=='\u1EBC'||c=='\u1EB8'||
                c=='\u00CA'||c=='\u1EBE'||c=='\u1EC0'||c=='\u1EC2'||c=='\u1EC4'||c=='\u1EC6') {
                return 'E';
            } else if (c=='\u00ED'||c=='\u00EC'||c=='\u1EC9'||c=='\u0129'||c=='\u1ECB') {
                return 'i';
            } else if (c=='\u00CD'||c=='\u00CC'||c=='\u1EC8'||c=='\u0128'||c=='\u1ECA') {
                return 'I';
            } else if (c=='\u00F3'||c=='\u00F2'||c=='\u1ECF'||c=='\u00F5'|c=='\u1ECD'||
                c=='\u00F4'||c=='\u1ED1'||c=='\u1ED3'||c=='\u1ED5'||c=='\u1ED7'||c=='\u1ED9'||
                c=='\u01A1'||c=='\u1EDB'||c=='\u1EDD'||c=='\u1EDF'||c=='\u1EE1'||c=='\u1EE3') {
                return 'o';
            } else if (c=='\u00D3'||c=='\u00D2'||c=='\u1ECE'||c=='\u00D5'|c=='\u1ECC'||
                c=='\u00D4'||c=='\u1ED0'||c=='\u1ED2'||c=='\u1ED4'||c=='\u1ED6'||c=='\u1ED8'||
                c=='\u01A0'||c=='\u1EDA'||c=='\u1EDC'||c=='\u1EDE'||c=='\u1EE0'||c=='\u1EE2') {
                return 'O';
            } else if (c=='\u00FA'||c=='\u00F9'||c=='\u1EE7'||c=='\u0169'|c=='\u1EE5'||
                c=='\u01B0'||c=='\u1EE9'||c=='\u1EEB'||c=='\u1EED'||c=='\u1EEF'||c=='\u1EF1') {
                return 'u';
            } else if (c=='\u00DA'||c=='\u00D9'||c=='\u1EE6'||c=='\u0168'|c=='\u1EE4'||
                c=='\u01AF'||c=='\u1EE8'||c=='\u1EEA'||c=='\u1EEC'||c=='\u1EEE'||c=='\u1EF0') {
                return 'U';
            } else if (c=='\u00FD'||c=='\u1EF3'||c=='\u1EF7'||c=='\u1EF9'||c=='\u1EF5') {
                return 'y';
            } else if (c=='\u00DD'||c=='\u1EF2'||c=='\u1EF6'||c=='\u1EF8'||c=='\u1EF4') {
                return 'Y';
            } else if(c=='\u0111'){
                return 'd';
            }else if(c=='\u0110'){
                return 'D';
            }
            return c;
	}
	public static String TrimTagHTML(String htmlString) {
		//return src.replaceAll("\\<.*?\\>", "");
		 // Remove HTML tag from java String
		int i=htmlString.indexOf("<![CDATA[");
		System.out.println(i);
		if(i>=0) {
			
			htmlString = htmlString.substring(i+9, htmlString.length()-3);
		}
        String noHTMLString = htmlString.replaceAll("\\<.*?\\>", "");

        // Remove Carriage return from java String
        noHTMLString = noHTMLString.replaceAll("\r", "<br/>");

        // Remove New line from java string and replace html break
        noHTMLString = noHTMLString.replaceAll("\n", " ");
        noHTMLString = noHTMLString.replaceAll("\'", "&#39;");
        noHTMLString = noHTMLString.replaceAll("\"", "&quot;");
/*        if(i>=0) {
        	noHTMLString = "<![CDATA[" + noHTMLString + "]]>";
        }*/
        return noHTMLString;
	}
	public static String RemoveStopWords(String htmlString) {
		String regex = "\\b(a ha|a lÃ´|Ã  Æ¡i|Ã¡|Ã |Ã¡ Ã |áº¡|áº¡ Æ¡i|ai|ai ai|ai náº¥y|Ã¡i|Ã¡i chÃ |Ã¡i dÃ |alÃ´|amen|Ã¡ng|Ã o|áº¯t|áº¯t háº³n|áº¯t lÃ |Ã¢u lÃ |áº§u Æ¡|áº¥y|bÃ i|báº£n|bao giá»�|bao lÃ¢u|bao náº£|bao nhiÃªu|bay biáº¿n|báº±ng|báº±ng áº¥y|báº±ng khÃ´ng|báº±ng náº¥y|báº¯t Ä‘áº§u tá»«|báº­p bÃ |báº­p bÃµm|báº­p bÃµm|báº¥t chá»£t|báº¥t cá»©|báº¥t Ä‘á»“|báº¥t giÃ¡c|báº¥t ká»ƒ|báº¥t kÃ¬|báº¥t ká»³|báº¥t luáº­n|báº¥t nhÆ°á»£c|báº¥t quÃ¡|báº¥t|thÃ¬nh lÃ¬nh|báº¥t tá»­|bÃ¢y báº©y|bÃ¢y chá»«|bÃ¢y giá»�|bÃ¢y giá»�|bÃ¢y nhiÃªu|báº¥y|báº¥y giá»�|báº¥y cháº§y|báº¥y chá»«|báº¥y giá»�|báº¥y lÃ¢u|báº¥y lÃ¢u nay|báº¥y nay|báº¥y nhiÃªu|bÃ¨n|bÃ©ng|bá»ƒn|bá»‡t|biáº¿t bao|biáº¿t bao nhiÃªu|biáº¿t chá»«ng nÃ o|biáº¿t Ä‘Ã¢u|biáº¿t Ä‘Ã¢u chá»«ng|biáº¿t Ä‘Ã¢u Ä‘áº¥y|biáº¿t máº¥y|bá»™|bá»™i pháº§n|bÃ´ng|bá»—ng|bá»—ng chá»‘c|bá»—ng dÆ°ng|bá»—ng Ä‘Ã¢u|bá»—ng khÃ´ng|bá»—ng nhiÃªn|bá»� máº¹|bá»›|bá»Ÿi|bá»Ÿi chÆ°ng|bá»Ÿi nhÆ°ng|bá»Ÿi tháº¿|bá»Ÿi váº­y|bá»Ÿi vÃ¬|bá»©c|cáº£|cáº£ tháº£y|cÃ¡i|cÃ¡c|cáº£ tháº£y|cáº£ thá»ƒ|cÃ ng|cÄƒn|cÄƒn cáº¯t|cáº­t lá»±c|cáº­t sá»©c|cÃ¢y|cha |cha cháº£|chÃ nh cháº¡nh|chao Ã´i|cháº¯c|cháº¯c háº³n|cháº¯c cháº¯n|chÄƒng|cháº³ng láº½|cháº³ng nhá»¯ng|cháº³ng ná»¯a|cháº³ng pháº£i|cháº­c|cháº§m cháº­p|cháº¿t ná»—i|cháº¿t tiá»‡t|cháº¿t tháº­t|chÃ­ cháº¿t|chá»‰n|chÃ­nh|chÃ­nh lÃ |chÃ­nh thá»‹|chá»‰|chá»‰ do|chá»‰ lÃ |chá»‰ táº¡i|chá»‰ vÃ¬|chiáº¿c|cho Ä‘áº¿n|cho Ä‘áº¿n khi|cho nÃªn|cho|tá»›i|cho tá»›i khi|choa|chá»‘c chá»‘c|chá»›|chá»› chi|chá»£t|chÃº|chu cha|chÃº mÃ y|chÃº mÃ¬nh|chui cha|chÃ¹n chÃ¹n|chÃ¹n chÅ©n|chá»§n|chung cá»¥c|chung qui|chung quy|chung quy láº¡i|chÃºng mÃ¬nh|chÃºng ta|chÃºng tÃ´i|chá»©|chá»© lá»‹|cÃ³ chÄƒng lÃ |cÃ³ dá»…|cÃ³ váº»|cÃ³c khÃ´|coi bá»™|coi mÃ²i|con|cÃ²n|cÃ´|cÃ´ mÃ¬nh|cá»• lai|cÃ´ng nhiÃªn|cÆ¡|cÆ¡ chá»«ng|cÆ¡ há»“|cÆ¡ mÃ |cÆ¡n|cu cáº­u|cá»§a|cÃ¹ng|cÃ¹ng cá»±c|cÃ¹ng nhau|cÃ¹ng vá»›i|cÅ©ng|cÅ©ng nhÆ°|cÅ©ng váº­y|cÅ©ng váº­y thÃ´i|cá»©|cá»© viá»‡c|cá»±c kÃ¬|cá»±c ká»³|cá»±c lá»±c|cuá»™c|cuá»‘n|dÃ o|dáº¡|dáº§n dÃ |dáº§n dáº§n|dáº§u sao|dáº«u|dáº«u sao|dá»… sá»£|dá»… thÆ°á»�ng|do|do vÃ¬|do Ä‘Ã³|do váº­y|dá»Ÿ chá»«ng|dÃ¹ cho|dÃ¹ ráº±ng|duy|dá»¯|dÆ°á»›i|Ä‘Ã£|Ä‘áº¡i Ä‘á»ƒ|Ä‘áº¡i loáº¡i|Ä‘áº¡i nhÃ¢n|Ä‘áº¡i phÃ m|Ä‘ang|Ä‘Ã¡ng láº½|Ä‘Ã¡ng lÃ­|Ä‘Ã¡ng lÃ½|Ä‘Ã nh Ä‘áº¡ch|Ä‘Ã¡nh Ä‘Ã¹ng|Ä‘Ã¡o Ä‘á»ƒ|náº¥y|nÃªn chi|ná»�n|náº¿u|náº¿u nhÆ°|ngay|ngay cáº£|ngay láº­p tá»©c|ngay lÃºc|ngay khi|ngay tá»«|ngay tá»©c kháº¯c|ngÃ y cÃ ng|ngÃ y ngÃ y|ngÃ y xÆ°a|ngÃ y xá»­a|ngÄƒn ngáº¯t|nghe chá»«ng|nghe Ä‘Ã¢u|nghen|nghiá»…m nhiÃªn|nghá»‰m|ngÃµ háº§u|ngoáº£i|ngoÃ i|ngÃ´i|ngá»�n|ngá»�t|ngá»™ nhá»¡|ngÆ°Æ¡i|nhau|nhÃ¢n dá»‹p|nhÃ¢n tiá»‡n|nháº¥t|nháº¥t Ä‘Ã¡n|nháº¥t Ä‘á»‹nh|nháº¥t loáº¡t|nháº¥t luáº­t|nháº¥t má»±c|nháº¥t nháº¥t|nháº¥t quyáº¿t|nháº¥t sinh|nháº¥t tÃ¢m|nháº¥t tá»�|nháº¥t thiáº¿t|nhÃ©|nhá»‰|nhiÃªn háº­u|nhiá»‡t liá»‡t|nhÃ³n nhÃ©n|nhá»¡ ra|nhung nhÄƒng|nhÆ°|nhÆ° chÆ¡i|nhÆ° khÃ´ng|nhÆ° quáº£|nhÆ°|thá»ƒ|nhÆ° tuá»“ng|nhÆ° váº­y|nhÆ°ng|nhÆ°ng mÃ |nhá»¯ng|nhá»¯ng ai|nhá»¯ng nhÆ°|nhÆ°á»£c báº±ng|nÃ³|nÃ³c|ná»�|ná»•i|ná»›|ná»¯a|ná»©c ná»Ÿ|oai oÃ¡i|oÃ¡i|Ã´ hay|Ã´ hÃ´|Ã´ kÃª|Ã´ kÃ¬a|á»“|Ã´i chao|Ã´i thÃ´i|á»‘i dÃ o|á»‘i giá»�i|á»‘i|giá»�i Æ¡i|Ã´kÃª|á»•ng|Æ¡|Æ¡ hay|Æ¡ kÃ¬a|á»�|á»›|Æ¡i|pháº£i|pháº£i chi|pháº£i chÄƒng|phÄƒn pháº¯t|pháº¯t|phÃ¨|phá»‰ phui|pho|phÃ³c|phá»�ng|phá»�ng nhÆ°|phÃ³t|phá»‘c|phá»¥t|phÆ°Æ¡ng chi|phá»©t|qua quÃ­t|qua quÃ½t|quáº£|quáº£ Ä‘Ãºng|quáº£ lÃ |quáº£ tang|quáº£ tháº­t|quáº£ tÃ¬nh|quáº£ váº­y|quÃ¡|quÃ¡ chá»«ng|quÃ¡ Ä‘á»™|quÃ¡ Ä‘á»—i|quÃ¡ láº¯m|quÃ¡ sÃ¡|quÃ¡ thá»ƒ|quÃ¡ trá»�i|quÃ¡ Æ°|quÃ¡ xÃ¡|quÃ½ há»“|quyá»ƒn|quyáº¿t|quyáº¿t nhiÃªn|ra|ra pháº¿t|ra trÃ²|rÃ¡o|rÃ¡o trá»�i|rÃ y|rÄƒng|ráº±ng|ráº±ng lÃ |ráº¥t|ráº¥t chi lÃ |ráº¥t Ä‘á»—i|ráº¥t má»±c|ren rÃ©n|rÃ©n|rÃ­ch|riá»‡t|riu rÃ­u|rÃ³n rÃ©n|rá»“i|rá»‘t cá»¥c|rá»‘t cuá»™c|rÃºt cá»¥c|rá»©a|sa sáº£|sáº¡ch|sao|sau chÃ³t|sau cÃ¹ng|sau cuá»‘i|sau Ä‘Ã³|sáº¯p|sáº¥t|sáº½|sÃ¬|sá»‘ lÃ |sá»‘t|sá»™t|sá»Ÿ dÄ©|suÃ½t|sá»±|tÃ  tÃ |táº¡i|táº¡i vÃ¬|táº¥m|táº¥n|tá»± vÃ¬|tanh|tÄƒm táº¯p|táº¯p|táº¯p lá»±|táº¥t cáº£|táº¥t táº§n táº­t|táº¥t táº­t|táº¥t tháº£y|tÃªnh|tha há»“|thÃ |thÃ  lÃ |thÃ  ráº±ng|thÃ¡i quÃ¡|than Ã´i|thanh|thÃ nh ra|thÃ nh thá»­|tháº£o hÃ¨n|tháº£o nÃ o|tháº­m|tháº­m chÃ­|tháº­t lá»±c|tháº­t váº­y|tháº­t ra|tháº©y|tháº¿|tháº¿ Ã |tháº¿ lÃ |tháº¿ mÃ |tháº¿ nÃ o|tháº¿ nÃªn|tháº¿ ra|tháº¿ thÃ¬|tháº¿ch|thi thoáº£ng|thÃ¬|thÃ¬nh lÃ¬nh|thá»‰nh thoáº£ng|thoáº¡t|thoáº¡t nhiÃªn|thoáº¯t|thá»�m|thá»�t|thá»‘c|thá»‘c thÃ¡o|thá»™c|thÃ´i|thá»‘t|thuáº§n|thá»¥c máº¡ng|thÃºng tháº¯ng|thá»­a|thá»±c ra|thá»±c váº­y|thÆ°Æ¡ng Ã´i|tiá»‡n thá»ƒ|tiáº¿p Ä‘Ã³|tiáº¿p theo|tÃ­t mÃ¹|tá»� ra|tá»� váº»|tÃ² te|toÃ |toÃ© khÃ³i|toáº¹t|tá»�t|tá»‘c táº£|tÃ´i|tá»‘i Æ°|tÃ´ng tá»‘c|tá»™t|trÃ n cung mÃ¢y|trÃªn|trá»ƒn|trá»‡t|tráº¿u trÃ¡o|trá»‡u tráº¡o|trong|trá»�ng|trá»�i Ä‘áº¥t Æ¡i|trÆ°á»›c|trÆ°á»›c Ä‘Ã¢y|trÆ°á»›c Ä‘Ã³|trÆ°á»›c kia|trÆ°á»›c nay|trÆ°á»›c tiÃªn|trá»« phi|tÃ¹ tÃ¬|tuáº§n tá»±|tuá»‘t luá»‘t|tuá»‘t tuá»“n tuá»™t|tuá»‘t tuá»™t|tuy|tuy nhiÃªn|tuy ráº±ng|tuy tháº¿|tuy váº­y|tuyá»‡t nhiÃªn|tá»«ng|tá»©c thÃ¬|tá»©c tá»‘c|tá»±u trung|á»§a|Ãºi|Ãºi chÃ |Ãºi dÃ o|Æ°|á»© há»±|á»© á»«|á»­|á»«|vÃ |váº£ chÄƒng|váº£ láº¡i|váº¡n|nháº¥t|vÄƒng tÃª|váº«n|vÃ¢ng|váº­y|váº­y lÃ |váº­y thÃ¬|veo|veo veo|vÃ¨o|vá»�|vÃ¬|vÃ¬ chÆ°ng|vÃ¬ tháº¿|vÃ¬ váº­y|vÃ­ báº±ng|vÃ­ dÃ¹|vÃ­ phá»�ng||vÃ­ thá»­|vá»‹ táº¥t|vÃ´ hÃ¬nh trung|vÃ´ ká»ƒ|vÃ´ luáº­n|vÃ´ vÃ n|vá»‘n dÄ©|vá»›i|vá»›i láº¡i|vá»Ÿ|vung tÃ n tÃ¡n|vung tÃ¡n|tÃ n|vung thiÃªn Ä‘á»‹a|vá»¥t|vá»«a má»›i|xa xáº£|xÄƒm xÄƒm|xÄƒm xáº¯m|xÄƒm xÃºi|xá»�nh xá»‡ch|xá»‡p|xiáº¿t bao|xoÃ nh xoáº¡ch|xoáº³n|xoÃ©t|xoáº¹t|xon xÃ³n|xuáº¥t ká»³ báº¥t Ã½|xuá»ƒ|xuá»‘ng|Ã½|Ã½ chá»«ng|Ã½ da)\\b";
		String result = htmlString.replaceAll(regex, "");
		int i=0;
		StringBuffer sb = new StringBuffer(1024);
		
		while(i<result.length()) {
			char c = result.charAt(i);
			sb.append(c);
			if(c==' ' ) {
				while(i+1<result.length() && result.charAt(i+1)==' ') {
					i++;
				}
			}
			i++;
		}
		return sb.toString();
		
	}
	private static String convertToHex(byte[] data) {
		StringBuffer buf = new StringBuffer();
		for (int i = 0; i < data.length; i++) {
			int halfbyte = (data[i] >>> 4) & 0x0F;
			int two_halfs = 0;
			do {
				if ((0 <= halfbyte) && (halfbyte <= 9))
					buf.append((char) ('0' + halfbyte));
				else
					buf.append((char) ('a' + (halfbyte - 10)));
				halfbyte = data[i] & 0x0F;
			} while (two_halfs++ < 1);
		}
		return buf.toString();
	}

	public static String MD5(String text) {
		MessageDigest md;	
		byte[] md5hash = new byte[32];
		try {
			md = MessageDigest.getInstance("MD5");
			md.update(text.getBytes("iso-8859-1"), 0, text.length());
			md5hash = md.digest();
		} catch (UnsupportedEncodingException e) {			
			// FIXME
			System.out.println("ERROR :" + e.getMessage());
		} catch (NoSuchAlgorithmException e) {
			
			// FIXME
			System.out.println("ERROR :" + e.getMessage());
		}	
		return convertToHex(md5hash);
	}
	public static String getExtension(String filename) {    // Lay phan mo rong cua file
		int lastIndex = filename.lastIndexOf(".");
		if(lastIndex == -1)
			return null;
		return filename.substring(lastIndex+1);
	}
	public static boolean isEmpty(String src) {
		if(src == null || src.isEmpty())
			return true;
		return false;
	}
	public static void main(String arg[]) {
		String src ="  Toi  a ha   Long    ";
		long l1 = System.currentTimeMillis();		
		String str = RemoveStopWords(src);		
		System.out.println("test1 =" +(System.currentTimeMillis() - l1));
		l1 = System.currentTimeMillis();		
		System.out.println("test2 =" +(System.currentTimeMillis() - l1));
		System.out.println(str);
		System.out.println("Done!");
    }
}