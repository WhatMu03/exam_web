package main.java.validate;

import main.java.util.SpringConfigTool;

/**
 * 密码复杂度
 * @author shenda20467
 *
 */
public class ValidatePassword {
	
	/**
	 * 密码是否符合要求
	 * @param pwd
	 * @return
	 */
	public boolean pwdComplexity(String pwd){ 
		
		SpringConfigTool t = (SpringConfigTool)SpringConfigTool.getBean("validate");
        int lowCount = 0;   //小写字母个数
        int capCount = 0;   //大写字母个数
        int numCount = 0;   //数字个数
        int charCount = 0;  //特殊字符个数
        for(int i=0;i<pwd.length();i++){
            if(Character.isDigit(pwd.charAt(i))){//数字
                numCount=1;
            }else if(Character.isLetter(pwd.charAt(i))){//字母
                int letter = (int)pwd.charAt(i);
                if(97<=letter && letter<=122){
                    lowCount=1;
                }
                if(65<=letter && letter<=90){
                    capCount=1;
                }
            }else{
                if(charCount == 0){
                    charCount+=1;
                }
            }
        }
        String value = t.getPwdComplexity();
        //密码复杂度
        int Complexity = lowCount+capCount+numCount+charCount;
        if(Complexity < Integer.parseInt(value)){
            return false;
        }
        return true;
    }
	 
}
