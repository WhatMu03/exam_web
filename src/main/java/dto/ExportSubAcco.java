package main.java.dto;
 
/**
 * 子账户  导出字段对应
 * @author shenda20467
 * 20170823
 */
public enum ExportSubAcco implements IEnum{ 

	customerNo("customerNo", "客户编号",1),
	customerName("customerName", "客户名称",2),
	loginNo("loginNo", "子账户编号",3),
	loginName("loginName", "子账户名称",4), 
	createTime("createTime", "创建日期",5),
	email("email", "邮箱",6),
	mobile("mobile", "手机号",7),
	phone("phone", "座机号",8),
	post("post", "职位",9),
	depth("depth", "部门",10), 
	status("status", "账户状态",11), 
	lastLoginTime("lastLoginTime", "上次登录日期",12), 
	lockTime("lockTime", "锁定日期",13),  
	;

	private final String name;
	private final String label;
	private final Integer order;
	
	private ExportSubAcco(String name, String label,Integer order) {
		this.name = name;
		this.label = label; 
		this.order = order; 
	}

	@Override
	public String getName() {
		return name;
	}

	@Override
	public String getLabel() {
		return label;
	}

	@Override
	public Integer getOrder() {
		return order;
	}

	@Override
	public String fileName() {
		return "子账户";
	}
	
	
	
}  