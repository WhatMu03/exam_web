package main.java.test.timeout;

import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;

import com.alibaba.fastjson.JSON;

/**
 * 行程序超时模拟
 * @author shenda20467
 *
 */
public class Test {
	
	public static void main(String[] args) {
		final ExecutorService exec = Executors.newFixedThreadPool(1);  
        Callable<String> call = new Callable<String>() {  
            public String call() throws Exception {  
        		try {
        			Thread.sleep(1000);
        		} catch (InterruptedException e) {
        			e.printStackTrace();
        		} 
        		return "ss";
            }  
        };   
		
        try {  
            Future<String> future = exec.submit(call);  
            String obj = future.get(200*10, TimeUnit.MILLISECONDS); //任务处理超时时间设为 1 秒  
            System.out.println("任务成功返回:" + obj);  
        } catch (TimeoutException ex) {  
            System.out.println("处理超时啦....");  
            ex.printStackTrace();  
        } catch (Exception e) {  
            System.out.println("处理失败.");  
            e.printStackTrace();  
        }  
        // 关闭线程池  
        exec.shutdown();  
		
		
	}
	
	//数据放入队列，作为一个线程，超时即返回
	public void sendDataToQueue(){
		final ExecutorService exec = Executors.newFixedThreadPool(1);  
        Callable<String> call = new Callable<String>() {  
            public String call() throws Exception {  
//				messageSender.sendDataToQueue(JSON.toJSONString(param));// 发送消息
        		return "成功放入队列";
            }  
        };   
		
        try {  
            Future<String> future = exec.submit(call);  
          	future.get(1000 * 2, TimeUnit.MILLISECONDS); //任务处理超时时间设为 2 秒  
        } catch (TimeoutException ex) {  
            ex.printStackTrace();  
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally {
            exec.shutdown();             // 关闭线程池 
//			cleanParam(request, session);
//			return obj;
        }
	}

}
