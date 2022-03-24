package pack.model;

public class SangDto {
	int sangNo, price, sangNumber;
	String sangName, sangDetail, sImage;
	
	
	
	public String getsImage() {
		return sImage;
	}
	public void setsImage(String sImage) {
		this.sImage = sImage;
	}
	public int getSangNo() {
		return sangNo;
	}
	public void setSangNo(int sangNo) {
		this.sangNo = sangNo;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getSangNumber() {
		return sangNumber;
	}
	public void setSangNumber(int sangNumber) {
		this.sangNumber = sangNumber;
	}
	public String getSangName() {
		return sangName;
	}
	public void setSangName(String sangName) {
		this.sangName = sangName;
	}
	public String getSangDetail() {
		return sangDetail;
	}
	public void setSangDetail(String sangDetail) {
		this.sangDetail = sangDetail;
	}
}
