package pack.model;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PurchaseDaoImpl extends SqlSessionDaoSupport implements PurchaseDaoInter{

	@Autowired
	public PurchaseDaoImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	}

	
	@Override
	public boolean insertPurchase(PurchaseDto pdto) {
		int i=getSqlSession().insert("insertPurchase",pdto);
		if(i>0) {
			return true;
		}else {
			return false;
		}
	}


	@Override
	public int selectMaxPno() {
		if(getSqlSession().selectOne("selectMaxPno")==null)return 0;
		return getSqlSession().selectOne("selectMaxPno");
	}


	@Override
	public ArrayList<PurchaseDto> selectPurchase(int userNo) {
		
		return (ArrayList)getSqlSession().selectList("selectPurchase", userNo);
	}


	@Override
	public boolean updatePstate(PurchaseDto pdto) {
		int i=getSqlSession().update("updatePstate",pdto);
		if(i>0) {
			return true;
		}else {
			return false;
		}
	}


	@Override
	public ArrayList<PurchaseDto> selectPlist() {
		return (ArrayList)getSqlSession().selectList("selectPlist");
	}

	
	
}
