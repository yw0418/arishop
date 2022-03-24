package pack.model;

public class QnaDto {
	int qnaNo, userNo, qSetting, qOnum;
	String qContent, qTitle, qPwd, qDate;
	
	
	public String getqDate() {
		return qDate;
	}
	public void setqDate(String qDate) {
		this.qDate = qDate;
	}
	public int getQnaNo() {
		return qnaNo;
	}
	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public int getqSetting() {
		return qSetting;
	}
	public void setqSetting(int qSetting) {
		this.qSetting = qSetting;
	}
	public int getqOnum() {
		return qOnum;
	}
	public void setqOnum(int qOnum) {
		this.qOnum = qOnum;
	}
	public String getqContent() {
		return qContent;
	}
	public void setqContent(String qContent) {
		this.qContent = qContent;
	}
	public String getqTitle() {
		return qTitle;
	}
	public void setqTitle(String qTitle) {
		this.qTitle = qTitle;
	}
	public String getqPwd() {
		return qPwd;
	}
	public void setqPwd(String qPwd) {
		this.qPwd = qPwd;
	}
}
