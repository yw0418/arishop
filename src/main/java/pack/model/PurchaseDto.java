package pack.model;

public class PurchaseDto {
	int purchaseNo, userNo, sangNo, pState, sangQuan, price, pAddressNo; 
	String pAddress, pDate;
	
	
	
	
	public String getpDate() {
		return pDate;
	}
	public void setpDate(String pDate) {
		this.pDate = pDate;
	}
	public int getpAddressNo() {
		return pAddressNo;
	}
	public void setpAddressNo(int pAddressNo) {
		this.pAddressNo = pAddressNo;
	}
	public int getPurchaseNo() {
		return purchaseNo;
	}
	public void setPurchaseNo(int purchaseNo) {
		this.purchaseNo = purchaseNo;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	public int getSangNo() {
		return sangNo;
	}
	public void setSangNo(int sangNo) {
		this.sangNo = sangNo;
	}
	public int getpState() {
		return pState;
	}
	public void setpState(int pState) {
		this.pState = pState;
	}
	public int getSangQuan() {
		return sangQuan;
	}
	public void setSangQuan(int sangQuan) {
		this.sangQuan = sangQuan;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getpAddress() {
		return pAddress;
	}
	public void setpAddress(String pAddress) {
		this.pAddress = pAddress;
	}
}
