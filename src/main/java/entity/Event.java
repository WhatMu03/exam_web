package main.java.entity;

import javax.validation.constraints.NotNull;

/**
 * Created with IntelliJ IDEA
 * Created by sunyt22618 on 2017/8/17.
 * 事件信息event_info
 */
public class Event {
    /**
     * 事件编号
     */
    private String eventNo;
    /**
     * 事件标题
     */
    private String eventTitle;
    /**
     * 事件类型
     */
    private String type;
    /**
     * 事件描述
     */
    private String description;
    /**
     * 事件来源
     */
    private String eventSource;
    /**
     * 数据来源(web/ITSM)
     */
    private String dataSource;
    /**
     * 客户编号
     */
    private String customerNo;
    /**
     * 销售产品名称，同业务系统
     */
    private String saleProductName;
    /**
     * 技术产品名称
     */
    private String tecProductName;
    /**
     * 版本号
     */
    private String version;
    /**
     * 提交人编号同loginNo
     */
    private String submitterNo;
    /**
     * 邮箱
     */
    private String email;
    /**
     * 手机号
     */
    private String mobile;
    /**
     * 座机号
     */
    private String phone;
    /**
     * 创建时间
     */
    private String createTime;
    /**
     * 受理人编号,贵公司员工号
     */
    private String dealingUserNo;
    /**
     * 受理时间
     */
    private String acceptDateTime;
    /**
     * 解决方案
     */
    private String solution;
    /**
     * 响应时限
     */
    private String responseLimitDatetime;
    /**
     * 流程状态
     */
    private String flowStatus;
    /**
     * 解决状态
     */
    private String endStatus;
    /**
     * 附件
     */
    private String attachment;

    @NotNull
    public String getEventNo() {
        return eventNo;
    }

    public void setEventNo(String eventNo) {
        this.eventNo = eventNo;
    }

    public String getEventTitle() {
        return eventTitle;
    }

    public void setEventTitle(String eventTitle) {
        this.eventTitle = eventTitle;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getEventSource() {
        return eventSource;
    }

    public void setEventSource(String eventSource) {
        this.eventSource = eventSource;
    }

    public String getDataSource() {
        return dataSource;
    }

    public void setDataSource(String dataSource) {
        this.dataSource = dataSource;
    }

    public String getCustomerNo() {
        return customerNo;
    }

    public void setCustomerNo(String customerNo) {
        this.customerNo = customerNo;
    }

    public String getSaleProductName() {
        return saleProductName;
    }

    public void setSaleProductName(String saleProductName) {
        this.saleProductName = saleProductName;
    }

    public String getTecProductName() {
        return tecProductName;
    }

    public void setTecProductName(String tecProductName) {
        this.tecProductName = tecProductName;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getSubmitterNo() {
        return submitterNo;
    }

    public void setSubmitterNo(String submitterNo) {
        this.submitterNo = submitterNo;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getDealingUserNo() {
        return dealingUserNo;
    }

    public void setDealingUserNo(String dealingUserNo) {
        this.dealingUserNo = dealingUserNo;
    }

    public String getAcceptDateTime() {
        return acceptDateTime;
    }

    public void setAcceptDateTime(String acceptDateTime) {
        this.acceptDateTime = acceptDateTime;
    }

    public String getSolution() {
        return solution;
    }

    public void setSolution(String solution) {
        this.solution = solution;
    }

    public String getResponseLimitDatetime() {
        return responseLimitDatetime;
    }

    public void setResponseLimitDatetime(String responseLimitDatetime) {
        this.responseLimitDatetime = responseLimitDatetime;
    }

    public String getFlowStatus() {
        return flowStatus;
    }

    public void setFlowStatus(String flowStatus) {
        this.flowStatus = flowStatus;
    }

    public String getEndStatus() {
        return endStatus;
    }

    public void setEndStatus(String endStatus) {
        this.endStatus = endStatus;
    }

    public String getAttachment() {
        return attachment;
    }

    public void setAttachment(String attachment) {
        this.attachment = attachment;
    }
}
