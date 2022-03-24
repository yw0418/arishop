package pack.model;

import java.util.ArrayList;

public interface BasketDaoInter {
	boolean insertBasket(BasketDto bdto);
	int selectSangQuan(BasketDto bdto);
	ArrayList<BasketDto> selectBasket(int userNo);
	boolean deleteBasket(BasketDto bdto);
	boolean deleteAllBasket(int userNo);
}
