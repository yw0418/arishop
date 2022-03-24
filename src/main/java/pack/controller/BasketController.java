package pack.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.google.common.collect.ArrayListMultimap;

import pack.model.BasketDaoImpl;
import pack.model.BasketDto;
import pack.model.SangDaoInter;
import pack.model.SangDto;

@Controller
public class BasketController {

	@Autowired
	private SangDaoInter sdinter;
	
	@Autowired
	private BasketDaoImpl bdinter;
	
	
	//장바구니 클릭 시
	@RequestMapping(value="basket", method=RequestMethod.GET)
	public ModelAndView basket(HttpSession session) {
		
		ModelAndView andView=new ModelAndView();
		
		//유저번호가 비어있지 않으면(=로그인이 되어있으면)
		if(session.getAttribute("userNo")!=null) {
			//유저번호를 통해 장바구니를 불러오기
			ArrayList<BasketDto> blist=bdinter.selectBasket((Integer)session.getAttribute("userNo"));
			andView.addObject("blist", blist);
			
			int sumprice=0;
			for(int i=0; i<blist.size(); i++) {
				sumprice+=blist.get(i).getPrice();
			}
			andView.addObject("sumprice", sumprice);
			
		}
		return andView;
	}
	
	
	//장바구니에서 물건 삭제
	@RequestMapping(value="delete_b_sang", method=RequestMethod.GET)
	public String delete_b_sang(HttpSession session, 
			@RequestParam("sNo")int sangNo) {
	
		int userNo=(Integer)session.getAttribute("userNo");
		BasketDto bdto=new BasketDto();
		bdto.setUserNo(userNo);
		bdto.setSangNo(sangNo);
		
		boolean b=bdinter.deleteBasket(bdto);
		
		
		
		if(b) {
			return "redirect:/basket";
		}else {
			return "error";
		}
		
	}
	
	
}
