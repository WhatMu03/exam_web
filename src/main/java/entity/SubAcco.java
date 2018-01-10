package main.java.entity;


/**
 * Created with IntelliJ IDEA
 * Created by sunyt22618 on 2017/8/22.
 */
public class SubAcco {
    /**
     * 子账户编号(主键)
     */
    private String loginNo;
    /**
     * 子账户名
     */
    private String loginName;
    /**
     * 客户编号
     */
    private String customerNo;
    /**
     * 登录密码
     */
    private String password;
    /**
     * 创建日期
     */
    private String createTime;
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
     * 职位
     */
    private String post;
    /**
     * 部门
     */
    private String depth;
    /**
     * 账户状态
     * 0:启用
     * 1:登录
     * 2:锁定
     * 3:禁用
     * 4:注销
     */
    private String status;
    /**
     * 上次登录日期
     */
    private String lastLoginTime;
    /**
     * 锁定日期
     */
    private String lockTime;
    /**
     * 注销日期
     */
    private String writtenOffTime;

    public String getLoginNo() {
        return loginNo;
    }

    public void setLoginNo(String loginNo) {
        this.loginNo = loginNo;
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName;
    }

    public String getCustomerNo() {
        return customerNo;
    }

    public void setCustomerNo(String customerNo) {
        this.customerNo = customerNo;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
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

    public String getPost() {
        return post;
    }

    public void setPost(String post) {
        this.post = post;
    }

    public String getDepth() {
        return depth;
    }

    public void setDepth(String depth) {
        this.depth = depth;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getLastLoginTime() {
        return lastLoginTime;
    }

    public void setLastLoginTime(String lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }

    public String getLockTime() {
        return lockTime;
    }

    public void setLockTime(String lockTime) {
        this.lockTime = lockTime;
    }

    public String getWrittenOffTime() {
        return writtenOffTime;
    }

    public void setWrittenOffTime(String writtenOffTime) {
        this.writtenOffTime = writtenOffTime;
    }
}
