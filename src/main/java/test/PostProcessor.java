package main.java.test;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;

/**
 * 
 * @author shenda20467
 * 定义bean初始化前后的动作
 */
public class PostProcessor implements BeanPostProcessor{

	public void init(){
		System.out.println("这是初始化init");
	}
	
	@Override
	public Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException {
	    System.out.println("对象" + beanName + "开始实例化");  
		return bean;
	}

	@Override
	public Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException {
        System.out.println("对象" + beanName + "实例化完成"); 
		return bean;
	}

}
