package pack.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import pack.model.BasketDaoImpl;
import pack.model.BasketDaoInter;
import pack.model.BasketDto;
import pack.model.MemberDaoInter;
import pack.model.MemberDto;
import pack.model.PurchaseDaoInter;
import pack.model.PurchaseDto;
import pack.model.SangDaoInter;
import pack.model.SangDto;


@Controller
public class PurchaseController {
	
	@Autowired
	private BasketDaoInter bdinter;
	
	@Autowired
	private MemberDaoInter mdinter;
	
	@Autowired
	private PurchaseDaoInter pdinter;
	
	@Autowired
	private SangDaoInter sdinter;

	
	@RequestMapping(value="purchase", method=RequestMethod.GET)
	public ModelAndView purchase(HttpSession session) {
		int userNo=(Integer)session.getAttribute("userNo");
		ArrayList<BasketDto> list=bdinter.selectBasket(userNo);
		
		ModelAndView andView=new ModelAndView("purchase");
		andView.addObject("list",list);
		
		int sumprice=0;
		for(int i=0; i<list.size(); i++) {
			sumprice+=list.get(i).getPrice();
		}
		andView.addObject("sumprice", sumprice);
		
		MemberDto mdto=mdinter.selectInfoUno(userNo);
		andView.addObject("mdto", mdto);
		
		
		return andView;
	}
	
	
	//결제하기시 구매내역에 추가하고 장바구니에 있는 물건을 지우기
	@RequestMapping(value="purchase", method=RequestMethod.POST)
	public String purchase2(
			@RequestParam("userNo")int userNo,
			@RequestParam("addressNo")int addressNo,
			@RequestParam("address")String address){
		
		PurchaseDto pdto=new PurchaseDto();
		
		ArrayList<BasketDto> blist=bdinter.selectBasket(userNo);
		
		for(int i=0; i<blist.size(); i++) {
			
			
			int sangNo=blist.get(i).getSangNo();
			int sangQuan=blist.get(i).getSangQuan();
			int price=blist.get(i).getPrice();
			
			int pno=pdinter.selectMaxPno()+1;
			pdto.setPurchaseNo(pno);
			pdto.setUserNo(userNo);
			pdto.setSangNo(sangNo);
			pdto.setpAddressNo(addressNo);
			pdto.setpAddress(address);
			pdto.setpState(0);
			pdto.setSangQuan(sangQuan);
			pdto.setPrice(price);
			
			pdinter.insertPurchase(pdto);
		}
		
		//장바구니에 있는 물건 모두 지우기
		boolean b=bdinter.deleteAllBasket(userNo);
		
		System.out.println("결과 : "+b);
		
		return "purchaseSuccess";
	}
	
	
	@RequestMapping(value="pList", method=RequestMethod.GET)
	public ModelAndView pList(HttpSession session) {
		int userNo=(Integer)session.getAttribute("userNo");
		System.out.println("유저번호 : "+userNo);
		ArrayList<PurchaseDto> datas=pdinter.selectPurchase(userNo);
		System.out.println("datas : "+datas);
		ModelAndView andView=new ModelAndView();
		andView.addObject("datas", datas);
		
		ArrayList<SangDto> slist=new ArrayList<SangDto>();
		for(int i=0; i<datas.size(); i++) {
			int sangNo=datas.get(i).getSangNo();
			slist.add(sdinter.selectSang(sangNo));
			
		}
		andView.addObject("slist", slist);
		
		return andView;
	}
	
	
	@RequestMapping(value="reset_purchase", method=RequestMethod.GET)
	public String reset_purchase(HttpSession session, 
			@RequestParam("no")int sangNo) {
	
		int userNo=(Integer)session.getAttribute("userNo");
		PurchaseDto pdto=new PurchaseDto();
		pdto.setUserNo(userNo);
		pdto.setSangNo(sangNo);
		pdto.setpState(3);
		pdinter.updatePstate(pdto);
		
		return "redirect:/pList";
	}
}
