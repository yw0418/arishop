package pack.model;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BasketDaoImpl extends SqlSessionDaoSupport implements BasketDaoInter{

	@Autowired
	public BasketDaoImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	}


	@Override
	public boolean insertBasket(BasketDto bdto) {
		int i=getSqlSession().insert("insertBasket",bdto);
		if(i>0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public int selectSangQuan(BasketDto bdto) {
		if(getSqlSession().selectOne("selectSangQuan",bdto)==null)return 0;
		return getSqlSession().selectOne("selectSangQuan",bdto);
	}


	@Override
	public ArrayList<BasketDto> selectBasket(int userNo) {
		return (ArrayList)getSqlSession().selectList("selectBasket",userNo);
	}


	@Override
	public boolean deleteBasket(BasketDto bdto) {
		int i=getSqlSession().delete("deleteBasket",bdto);
		if(i>0) {
			return true;
		}else {
			return false;
		}
	}


	@Override
	public boolean deleteAllBasket(int userNo) {
		int i=getSqlSession().delete("deleteAllBasket",userNo);
		if(i>0) {
			return true;
		}else {
			return false;
		}
	}

	
}
