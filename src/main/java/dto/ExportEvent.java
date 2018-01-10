package main.java.dto;

/**
 * Created with IntelliJ IDEA
 * Created by sunyt22618 on 2017/8/18.
 */
public enum ExportEvent implements IEnum{

    eventTitle("eventTitle", "事件标题",1),
    solution("solution", "解决方案",2),
    saleProductName("saleProductName", "业务系统",3),
    type("type", "事件类型",4),
    submitterNo("submitterNo", "提交人",5),
    createTime("createTime", "提交日期",6),
    flowStatus("flowStatus", "事件状态",7),
    ;

    private final String name;
    private final String label;
    private final Integer order;

    private ExportEvent(String name, String label,Integer order) {
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
		return "事件";
	}
}
