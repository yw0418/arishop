package pack.model;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class QnaDaoImpl extends SqlSessionDaoSupport implements QnaDaoInter{
	
	@Autowired
	public QnaDaoImpl(SqlSessionFactory factory) {
		setSqlSessionFactory(factory);
	}

	@Override
	public ArrayList<QnaDto> selectqna() {
		
		return (ArrayList)getSqlSession().selectList("selectqna");
	}

	@Override
	public boolean insertqna(QnaDto qdto) {
		int i=getSqlSession().insert("insertqna",qdto);
		if(i>0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public int selectMaxQno() {
		if(getSqlSession().selectOne("selectMaxQno")==null)return 0;
		return getSqlSession().selectOne("selectMaxQno");
	}

	@Override
	public QnaDto selectdetailqna(int qnaNo) {
		return getSqlSession().selectOne("selectdetailqna", qnaNo);
	}

	@Override
	public boolean updateqna(QnaDto qdto) {
		int i=getSqlSession().update("updateqna",qdto);
		if(i>0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public boolean deleteqna(QnaDto qdto) {
		int i=getSqlSession().delete("deleteqna",qdto);
		if(i>0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public QnaDto selectdetailqna2(QnaDto qdto) {
		return getSqlSession().selectOne("selectdetailqna2",qdto);
	}

}
