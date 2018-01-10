package main.java.dto;
 
/**
 * 我的需求  导出字段对应
 * @author shenda20467
 * 20170817
 */
public enum ExportRequest implements IEnum{ 
	
	description("description", "需求描述",1),
	dealDesc("dealDesc", "处理意见",2),
	saleProductName("saleProductName", "业务系统",3),
	createTime("createTime", "提交日期",4),
	promiseDate("promiseDate", "承诺日期",5),
	publishVer("publishVer", "升级版本",6),
	reqStatus("reqStatus", "流程状态",7),
	;

	private final String name;
	private final String label;
	private final Integer order;
	
	private ExportRequest(String name, String label,Integer order) {
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
		return "需求";
	}
	
	
	
}  