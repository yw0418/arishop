package pack.model;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDaoImpl extends SqlSessionDaoSupport implements MemberDaoInter{

	@Autowired
	public MemberDaoImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	}

	@Override
	public boolean insertMember(MemberDto mdto) {
		int i=getSqlSession().insert("insertMember",mdto);
		if(i>0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public boolean checkId(String mId) {
		int i=getSqlSession().insert("checkId",mId);
		if(i>0) {
			return false;
		}else {
			return true;
		}
	}

	@Override
	public int selectMaxUno() {
		if (getSqlSession().selectOne("selectMaxUno")==null) return 0;
		return getSqlSession().selectOne("selectMaxUno");
	}

	@Override
	public String selectPwd(String mId) {
		if (getSqlSession().selectOne("selectPwd", mId)==null) return null;
		return getSqlSession().selectOne("selectPwd", mId);
	}

	@Override
	public MemberDto selectInfoId(String mId) {
		return getSqlSession().selectOne("selectInfoId", mId);
	}

	@Override
	public MemberDto selectInfoUno(int userNo) {
		return getSqlSession().selectOne("selectInfoUno", userNo);
	}

	@Override
	public String selectPwd2(int userNo) {
		return getSqlSession().selectOne("selectPwd2", userNo);
	}

	@Override
	public boolean updateMember(MemberDto mdto) {
		int i=getSqlSession().update("updateMember",mdto);
		if(i>0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public boolean deleteMember(int userNo) {
		int i=getSqlSession().delete("deleteMember",userNo);
		if(i>0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public MemberDto selectInfoName(String userName) {
		return getSqlSession().selectOne("selectInfoName", userName);
	}

	@Override
	public String selectidpwdQ(String mId) {
		return getSqlSession().selectOne("selectidpwdQ", mId);
	}

	@Override
	public String selectidpwdA(String mId) {
		return getSqlSession().selectOne("selectidpwdA", mId);
	}


	
	
}
