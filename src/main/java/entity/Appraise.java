package main.java.entity;

/**
 * Created with IntelliJ IDEA
 * Created by sunyt22618 on 2017/8/24.
 * 评价
 */
public class Appraise {
    /**
     * 评论编号 主键
     */
    private String appraiseNo;
    /**
     * 评价对象(事件/需求)
     */
    private String appraiseObj;
    /**
     * 评价对象,即事件编号/需求编号
     */
    private String appraiseObjNo;
    /**
     * 建议
     */
    private String suggest;
    /**
     * 评分(1~5)
     */
    private String score;
    /**
     * 评价人编号，同loginNo
     */
    private String appraiserNo;
    /**
     * 评价日期
     */
    private String appraiseTime;

    public String getAppraiseNo() {
        return appraiseNo;
    }

    public void setAppraiseNo(String appraiseNo) {
        this.appraiseNo = appraiseNo;
    }

    public String getAppraiseObj() {
        return appraiseObj;
    }

    public void setAppraiseObj(String appraiseObj) {
        this.appraiseObj = appraiseObj;
    }

    public String getAppraiseObjNo() {
        return appraiseObjNo;
    }

    public void setAppraiseObjNo(String appraiseObjNo) {
        this.appraiseObjNo = appraiseObjNo;
    }

    public String getSuggest() {
        return suggest;
    }

    public void setSuggest(String suggest) {
        this.suggest = suggest;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getAppraiserNo() {
        return appraiserNo;
    }

    public void setAppraiserNo(String appraiserNo) {
        this.appraiserNo = appraiserNo;
    }

    public String getAppraiseTime() {
        return appraiseTime;
    }

    public void setAppraiseTime(String appraiseTime) {
        this.appraiseTime = appraiseTime;
    }
}
