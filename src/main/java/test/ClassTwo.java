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
public class ClassTwo {

	public static void main(String args[]) {
		Element element = null;
		File f = new File("1.xml");

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
				if ("Account".equals(node1.getNodeName())) {
					System.out.println(
							"1: " + node1.getAttributes().getNamedItem("type").getNodeValue() + ". ");
					NodeList nodeDetail = node1.getChildNodes();
					for (int j = 0; j < nodeDetail.getLength(); j++) {
						Node detail = nodeDetail.item(j);
						if ("code".equals(detail.getNodeName())) {
							System.out.println("1" + detail.getTextContent());
						} else if ("pass".equals(detail.getNodeName())) {
							System.out.println("1 " + detail.getTextContent());
						} else if ("name".equals(detail.getNodeName())) {
							System.out.println("1 " + detail.getTextContent());
						} else if ("money".equals(detail.getNodeName())) {
							System.out.println("1" + detail.getTextContent());
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
