package main.java.test;

import java.io.File;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 * 读取xml文件
 * @author shenda20467
 *
 */
public class ClassThree {

	public static void main(String args[]) {
		Element element = null;
		File f = new File("2.xml");

		DocumentBuilder db = null;
		DocumentBuilderFactory dbf = null;
		try {
			dbf = DocumentBuilderFactory.newInstance();
			db = dbf.newDocumentBuilder();

			Document dt = db.parse(f);
			element = dt.getDocumentElement();
			System.out.println("1" + element.getNodeName());

			NodeList childNodes = element.getChildNodes();

			
			
			
			for (int i = 0; i < childNodes.getLength(); i++) {
				Node node1 = childNodes.item(i);
				if ("appSettings".equals(node1.getNodeName())) {   
					NodeList nodeDetail = node1.getChildNodes();
					for (int j = 0; j < nodeDetail.getLength(); j++) {
						Node detail = nodeDetail.item(j);
						if ("add".equals(detail.getNodeName())){
							System.out.println(detail.getAttributes().getNamedItem("key").getNodeValue());
							System.out.println(detail.getAttributes().getNamedItem("value").getNodeValue());
						}  
					}
				}

			}
		}

		catch (Exception e) {
			e.printStackTrace();
		}
	}
}
