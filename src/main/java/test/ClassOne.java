package main.java.test;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/**
 * 读取properties文件
 * @author shenda20467
 *
 */
public class ClassOne {

	public static void main(String[] args) throws IOException {

		for (int i = 0; i < 10; i++) {
			System.out.println(i);
		}

		Object[] arr = { 1, 2, 3, 4, 5 };
		for (Object i : arr) {
			System.out.println(i instanceof Integer);
		}

		InputStream inputStream = ClassLoader.getSystemClassLoader().getResourceAsStream("App.properties");
		Properties pro = new Properties();
		pro.load(inputStream);
		System.out.println(pro.getProperty("db"));

	}

}
