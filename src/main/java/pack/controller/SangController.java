package pack.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import pack.model.BasketDaoImpl;
import pack.model.BasketDto;
import pack.model.SangDaoInter;
import pack.model.SangDto;


@Controller
public class SangController {
	
	@Autowired
	private SangDaoInter sdinter;
	@Autowired
	private BasketDaoImpl bdinter;
	
	//상품 목록 클릭시 
	@RequestMapping(value="sanglist", method=RequestMethod.GET)
	public ModelAndView sanglist() {
		
		ArrayList<SangDto> sList=sdinter.selectSangList();
		
		ModelAndView andView=new ModelAndView("sangList");
		andView.addObject("sList", sList);
		
		return andView;
	}
	//상품 목록에 상품 이름 클릭시 
	@RequestMapping(value="sangdetail", method=RequestMethod.GET)
	public ModelAndView sangdetail(
			@RequestParam("no")int sangNo) {
		
		SangDto sdto=sdinter.selectSang(sangNo);
		
		ModelAndView andView=new ModelAndView("sangdetail");
		andView.addObject("sdto", sdto);
		
		return andView;
	}
	
	
	//상품 장바구니 담기 클릭시 
	@RequestMapping(value="sangdetail", method=RequestMethod.POST)
	public ModelAndView sangdetail2(
			@RequestParam("sangNo")int sangNo,
			HttpSession session) {
		
		
		//세션에 상품번호 담기
		if((ArrayList)session.getAttribute("basket")==null){
			ArrayList<Integer> list = new ArrayList<Integer>();
		     session.setAttribute("basket",list);
		     list.add(sangNo);
		}else {
			ArrayList<Integer> list = (ArrayList)session.getAttribute("basket");
			list.add(sangNo);
		}
		
		
		SangDto sdto=sdinter.selectSang(sangNo);
		
		
		//로그인 된 유저라면 db basket 테이블에 추가하기
		if((Integer)session.getAttribute("userNo")!=null) {
		BasketDto bdto=new BasketDto();
		bdto.setUserNo((Integer)session.getAttribute("userNo"));
		bdto.setSangNo(sdto.getSangNo());
		bdto.setsImage(sdto.getsImage());
		bdto.setSangName(sdto.getSangName());
		
		int quan=bdinter.selectSangQuan(bdto);
		if(quan==0) {
			bdto.setPrice(sdto.getPrice());
			bdto.setSangQuan(1);
		}else {
			bdinter.deleteBasket(bdto);
			bdto.setPrice((quan+1)*sdto.getPrice());
			bdto.setSangQuan(quan+1);
		}
		bdinter.insertBasket(bdto);
		}
		
		ModelAndView andView=new ModelAndView("sangdetail2");
		andView.addObject("sdto", sdto);
		
		return andView;
		}
	
	//상품 검색 페이지  search_sang
	@RequestMapping(value="search_sang", method=RequestMethod.GET)
	public ModelAndView search_sang(
			@RequestParam("name")String name) {
		System.out.println(name);
		ArrayList<SangDto> slist=sdinter.searchSang(name);
		
		
		if(slist.size()!=0){
			System.out.println("결과 : "+slist.get(0).getSangNo());
		}
		
				
		ModelAndView andView=new ModelAndView("sangList");
		andView.addObject("sList", slist);
		
		return andView;
	}
}
