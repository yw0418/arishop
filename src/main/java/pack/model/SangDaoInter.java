package pack.model;

import java.util.ArrayList;

public interface SangDaoInter {
	boolean insertSang(SangDto sdto);
	int selectMaxSno();
	ArrayList<SangDto> selectSangList();
	SangDto selectSang(int sangNo);
	boolean updateSang(SangDto sdto);
	boolean deleteSang(int sangNo);
	ArrayList<SangDto> searchSang(String searchName);
}
