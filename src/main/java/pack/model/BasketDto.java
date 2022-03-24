package pack.model;

public class BasketDto {
	int userNo, sangNo, price, sangQuan;
	String sangName, sImage;
	
	

	public String getSangName() {
		return sangName;
	}

	public void setSangName(String sangName) {
		this.sangName = sangName;
	}

	public String getsImage() {
		return sImage;
	}

	public void setsImage(String sImage) {
		this.sImage = sImage;
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

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getSangQuan() {
		return sangQuan;
	}

	public void setSangQuan(int sangQuan) {
		this.sangQuan = sangQuan;
	}
}
