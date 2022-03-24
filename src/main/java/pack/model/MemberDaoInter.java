package pack.model;

public interface MemberDaoInter {
	boolean insertMember(MemberDto mdto);
	boolean checkId(String mId);
	int selectMaxUno();
	String selectPwd(String mId);
	MemberDto selectInfoId(String mId);
	MemberDto selectInfoUno(int userNo);
	String selectPwd2(int userNo);
	boolean updateMember(MemberDto mdto);
	boolean deleteMember(int userNo);
	MemberDto selectInfoName(String userName);
	String selectidpwdQ(String mId);
	String selectidpwdA(String mId);
}
