package main.java.util;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import main.java.common.LoginBinder;
import main.java.entity.SubAcco;

@SuppressWarnings("rawtypes")
public class Aspect { 
	//前置通知
	public void before(JoinPoint call) throws Throwable { 

        HttpServletRequest request =((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest(); 
        HttpSession session =request.getSession();  

		SubAcco subAcco = (SubAcco) session.getAttribute("subAcco");
		LoginBinder.bind(subAcco);

//		Map map=Thread.getAllStackTraces();
//		System.out.println("启:" + map.size());
//        for(int i=0; i<1000; i++){
//            new Thread("" + i){
//               public void run(){
//            	   try {
//					Thread.sleep(1000);
//				} catch (InterruptedException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//            	   System.out.println("Thread: " + getName() + "running");
//               }
//            }.start();
//         }
/*		int i = 0;
		for (Map.Entry<Thread, StackTraceElement[]> stackTrace : Thread.getAllStackTraces().entrySet())
		 {
			Thread thread = (Thread) stackTrace.getKey();
			StackTraceElement[] stack = (StackTraceElement[]) stackTrace.getValue();
			if (thread.equals(Thread.currentThread())) {
				continue;
			}
			for (StackTraceElement stackTraceElement : stack) {
				System.out.println("线程：" + thread.getName() + "---" + stackTraceElement);
			}
			if(stack.length == 0){
				System.out.println("没有stackTraceElement的线程：" + thread.getName());
			}
			i++;
		}
	    Map map=Thread.getAllStackTraces();
	    System.out.println(i);
		System.out.println("线程:" + Thread.currentThread().getName() + " 开始，正在运行线程数:" + map.size());  */
		 
	}

	//返回后通知
	public void afterReturning(JoinPoint call) {
		//System.out.println("返回后通知");
	}
	
	//异常后通知
	public void afterThrowing(JoinPoint call) {
		//System.out.println("异常后通知");
	}	
	
	// 任何通知方法都可以将第一个参数定义为 org.aspectj.lang.JoinPoint类型
	public void after(JoinPoint call) {
		//System.out.println("后通知,不论是正常返回还是异常退出");
//		Map map=Thread.getAllStackTraces();
//		System.out.println("线程:" + Thread.currentThread().getName() + " 结束，正在运行线程数:" + map.size());  
	}
 
}
