package pack.model;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SangDaoImpl extends SqlSessionDaoSupport implements SangDaoInter{

	@Autowired
	public SangDaoImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	}
	
	
	@Override
	public boolean insertSang(SangDto sdto) {
		int i=getSqlSession().insert("insertSang",sdto);
		if(i>0) {
			return true;
		}else {
			return false;
		}
	}


	@Override
	public int selectMaxSno() {
		if (getSqlSession().selectOne("selectMaxSno")==null) return 0;
		return getSqlSession().selectOne("selectMaxSno");
	}


	@Override
	public ArrayList<SangDto> selectSangList() {
		
		return (ArrayList)getSqlSession().selectList("selectSangList");
	}


	@Override
	public SangDto selectSang(int sangNo) {
		return getSqlSession().selectOne("selectSang", sangNo);
	}


	@Override
	public boolean updateSang(SangDto sdto) {
		int i=getSqlSession().update("updateSang",sdto);
		if(i>0) {
			return true;
		}else {
			return false;
		}
	}


	@Override
	public boolean deleteSang(int sangNo) {
		int i=getSqlSession().delete("deleteSang",sangNo);
		if(i>0) {
			return true;
		}else {
			return false;
		}
	}


	@Override
	public ArrayList<SangDto> searchSang(String searchName) {
		return (ArrayList)getSqlSession().selectList("searchSang", searchName);
	}

}
