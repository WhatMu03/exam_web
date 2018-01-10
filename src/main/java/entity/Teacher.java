package main.java.entity;

import javax.validation.constraints.NotNull;

/**
 * 教师
 * @author yan
 * date:20180110
 */
public class Teacher {
	private String code;
	private String name;
	private Integer sex;
	private String password;

	public String getCode() {
		return code;
	}

	@NotNull
	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	@NotNull
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
