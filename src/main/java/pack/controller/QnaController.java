package pack.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pack.model.QnaDaoInter;
import pack.model.QnaDto;

@Controller
public class QnaController {
	
	@Autowired
	private QnaDaoInter qdinter;
	
	//게시글 페이징 처리 준비
	private int tot;		//전체 레코드 수
	private int plist=5;	//한 페이지 당 출력 행 수
	private int cpageSu;		//전체 페이지 수
	
	public ArrayList<QnaDto> getcListData(ArrayList<QnaDto> clist, int cpage){
		ArrayList<QnaDto> result=new ArrayList<QnaDto>();
		
		int start=(cpage-1)*plist;	//0, 10, 20 ...
		//clist.size()에서 start를 뺐을때 plist가 작거나 같은가? 참이면 :의 왼쪽값, 거짓이면 :의 오른쪽값 
		int size=plist<=clist.size()-start?plist:clist.size()-start;
		
		for(int i=0; i<size; i++) {
			result.add(i, clist.get(start+i));
		}
		
		return result;
	}
	
	public int getCpageSu() {
		cpageSu=tot/plist;
		if(tot%plist>0)cpageSu+=1;
		return cpageSu;
	}
	
	//qna 페이지 이동 
	@RequestMapping(value="qna_board", method=RequestMethod.GET)
	public ModelAndView qna_board(@RequestParam("cpage") int cpage) {
		
		
		ModelAndView andView=new ModelAndView("qna_board");
		
		ArrayList<QnaDto> qlist=qdinter.selectqna();
		
		//게시글 페이징 처리
		tot=qlist.size();
		//페이지 값 넘겨주기
		
		if(cpage<=0) cpage=1;
		
		ArrayList<QnaDto> result=getcListData(qlist, cpage);
		
		andView.addObject("plist", result);
		andView.addObject("cpage", cpage);
		andView.addObject("cpageSu",getCpageSu());
		
		
		andView.addObject("qlist",qlist);
		return andView;
	}
	
	
	
	
	//qna게시글 작성 페이지 이동 
	@RequestMapping(value="qna_write", method=RequestMethod.GET)
	public ModelAndView qna_write() {
		
		
		ModelAndView andView=new ModelAndView("qna_write");
		
		
		return andView;
	}
	
	//qna게시글 작성 등록
	@RequestMapping(value="qna_write", method=RequestMethod.POST)
	public String qna_write2(HttpSession session,
			QnaDto qdto) {
		
		int qno=qdinter.selectMaxQno()+1;
		qdto.setQnaNo(qno);
		
		if((Integer)session.getAttribute("userNo")!=null) {
			qdto.setUserNo((Integer)session.getAttribute("userNo"));
		}
		qdto.setqOnum(0);
		
		qdinter.insertqna(qdto);
		
		return "redirect:/qna_board?cpage=1";
	}
	
	//게시글 자세히 보기
	@RequestMapping(value="detailpost", method=RequestMethod.GET)
	public ModelAndView detailpost(@RequestParam("no")int qnaNo,
			@RequestParam("no2")int qOnum) {
		QnaDto qdto=new QnaDto();
		qdto.setQnaNo(qnaNo);
		qdto.setqOnum(qOnum);
		QnaDto qdto2=qdinter.selectdetailqna2(qdto);
		
		
		
		if(qdto2.getqSetting()==1) {
			ModelAndView andView=new ModelAndView("pwdpost");
			andView.addObject("qdto", qdto2);
			
			return andView;
		}else {
			ModelAndView andView=new ModelAndView("detailpost");
			andView.addObject("qdto", qdto2);
			
			return andView;
		}
	}
	
	//비밀글의 비밀번호가 일치한지 확인하기  
	@RequestMapping(value="secretpost", method=RequestMethod.POST)
	public ModelAndView secretpost(
			@RequestParam("qPwd")String qPwd,
			@RequestParam("qnaNo")int qnaNo,
			@RequestParam("qOnum")int qOnum,
			HttpSession session) {
		
		QnaDto qdto2=new QnaDto();
		qdto2.setQnaNo(qnaNo);
		qdto2.setqOnum(qOnum);
		QnaDto qdto=qdinter.selectdetailqna2(qdto2);
		
		int userNo=(Integer)session.getAttribute("userNo");
		if(userNo==6) {
			ModelAndView andView=new ModelAndView("detailpost2");
			andView.addObject("qdto", qdto);
			
			return andView;
		}
		
		
		if(qdto.getqPwd().equals(qPwd)) {
			
			ModelAndView andView=new ModelAndView("detailpost2");
			andView.addObject("qdto", qdto);
			
			return andView;
			
			
		}else {
			ModelAndView andView=new ModelAndView("pwd_post_fail");
			return andView;
		}
	}
	
	//게시글 수정 페이지로 이동
	@RequestMapping(value="updatePost", method=RequestMethod.GET)
	public ModelAndView updatePost(@RequestParam("no")int qnaNo,
			@RequestParam("no2")int qOnum) {
		QnaDto qdto=new QnaDto();
		qdto.setQnaNo(qnaNo);
		qdto.setqOnum(qOnum);
		QnaDto qdto2=qdinter.selectdetailqna2(qdto);
		
		ModelAndView andView=new ModelAndView("updatePost");
		andView.addObject("qdto", qdto2);
		
		return andView;
	}
	
	//게시글 수정하기
	@RequestMapping(value="updatePost", method=RequestMethod.POST)
	public String updatePost2(QnaDto qdto) {
		
		qdinter.updateqna(qdto);
		
		
		return "redirect:/qna_board?cpage=1";
	}
	
	//게시글 삭제하기
	@RequestMapping(value="deletePost", method=RequestMethod.GET)
	public String deletePost(@RequestParam("no")int qnaNo,
			@RequestParam("no2")int qOnum) {
		
		QnaDto qdto=new QnaDto();
		qdto.setQnaNo(qnaNo);
		qdto.setqOnum(qOnum);
		qdinter.deleteqna(qdto);
		
		return "deletePost_success";
	}
	
	
	//게시글 답변작성 페이지 이동
	@RequestMapping(value="replyPost", method=RequestMethod.GET)
	public ModelAndView replyPost(@RequestParam("no")int qnaNo) {
		
		QnaDto qdto=qdinter.selectdetailqna(qnaNo);
		
		ModelAndView andView=new ModelAndView("replyPost");
		andView.addObject("qdto", qdto);
		
		return andView;
	}
	
	//게시글 답변작성 페이지 이동
	@RequestMapping(value="replyPost", method=RequestMethod.POST)
	public String replyPost2(QnaDto qdto) {
		
		
		qdto.setqSetting(0);
		qdto.setqOnum(1);
		qdto.setUserNo(6);
		qdto.setqPwd("admin123");
		qdinter.insertqna(qdto);
		
		
		return "redirect:/qna_board?cpage=1";
	}
	
}
