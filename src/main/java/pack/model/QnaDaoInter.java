package pack.model;

import java.util.ArrayList;

public interface QnaDaoInter {
	ArrayList<QnaDto> selectqna();
	boolean insertqna(QnaDto qdto);
	int selectMaxQno();
	QnaDto selectdetailqna(int qnaNo);
	boolean updateqna(QnaDto qdto);
	boolean deleteqna(QnaDto qdto);
	QnaDto selectdetailqna2(QnaDto qdto);
}
