package pack.model;

import java.util.ArrayList;

public interface PurchaseDaoInter {
	boolean insertPurchase(PurchaseDto pdto);
	int selectMaxPno();
	ArrayList<PurchaseDto> selectPurchase(int userNo);
	boolean updatePstate(PurchaseDto pdto);
	ArrayList<PurchaseDto> selectPlist();
}
