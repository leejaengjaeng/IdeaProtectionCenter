package com.ipc.vo;

public class DesignAdminVo {
	String userID;
	String userName;
	String patentName;
	String userEmail;
	String title;
	String d_condition;
	String apply_date;
	String pre_apply_date;
	String iscomplete;
	int deid;
	
	public String getIscomplete() {
		return iscomplete;
	}
	public void setIscomplete(String iscomplete) {
		this.iscomplete = iscomplete;
	}
	public String getApply_date() {
		return apply_date;
	}
	public void setApply_date(String apply_date) {
		this.apply_date = apply_date;
	}
	public String getPre_apply_date() {
		return pre_apply_date;
	}
	public void setPre_apply_date(String pre_apply_date) {
		this.pre_apply_date = pre_apply_date;
	}
	public int getDeid() {
		return deid;
	}
	public void setDeid(int deid) {
		this.deid = deid;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPatentName() {
		return patentName;
	}
	public void setPatentName(String patentName) {
		this.patentName = patentName;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getD_condition() {
		return d_condition;
	}
	public void setD_condition(String d_condition) {
		this.d_condition = d_condition;
	}
}
