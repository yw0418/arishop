package pack.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import pack.model.MemberDaoInter;
import pack.model.PurchaseDaoInter;
import pack.model.PurchaseDto;
import pack.model.SangDto;
import pack.model.SangDaoInter;

@Controller
public class AdminController {
	
	@Autowired
	private SangDaoInter sdinter;
	
	@Autowired
	private PurchaseDaoInter pdinter;

	
	//관리자 페이지 이동 
	@RequestMapping(value="admin", method=RequestMethod.GET)
	public String admin() {
		return "admin";
	}	
	
	//상품추가 페이지 이동 
	@RequestMapping(value="insertSang", method=RequestMethod.GET)
	public String insertSang() {
		return "insertSang";
	}
	
	//상품추가
	@RequestMapping(value="insertSang", method=RequestMethod.POST)
	public String insertSang2(
			MultipartHttpServletRequest mtfRequest,
			SangDto sdto,
			MultipartFile file, 
			Model model) {
		
		String src = mtfRequest.getParameter("src");
	    System.out.println("src value : " + src);
        MultipartFile mf = mtfRequest.getFile("file");

        String path = "C:\\mywork\\sprsou\\hw_mall\\src\\main\\webapp\\resources\\img\\sang\\";
        

        String originFileName = mf.getOriginalFilename(); // 원본 파일 명
        long fileSize = mf.getSize(); // 파일 사이즈

        System.out.println("originFileName : " + originFileName);
        System.out.println("fileSize : " + fileSize);

        String safeFile = path + originFileName;

        try {
            mf.transferTo(new File(safeFile));
        } catch (IllegalStateException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        sdto.setsImage(originFileName);
        
        
        int num=sdinter.selectMaxSno()+1;
        
        sdto.setSangNo(num);
        
		boolean b=sdinter.insertSang(sdto);
		if(b) {
			return "admin";
		}else {
			return "insertSangfail.jsp";
		}
	}
	
	//상품관리 페이지 이동 
	@RequestMapping(value="sang_manage", method=RequestMethod.GET)
	public ModelAndView sang_manage() {
		ArrayList<SangDto> sList=sdinter.selectSangList();
		
		ModelAndView andView=new ModelAndView("sang_manage");
		andView.addObject("sList", sList);
		
		return andView;
		

	}
	

	//상품 수정 폼으로 이동 
	@RequestMapping(value="updateSang", method=RequestMethod.GET)
	public ModelAndView updateSang(@RequestParam("no")int sangNo) {
			
		SangDto sdto=sdinter.selectSang(sangNo);
		
		ModelAndView andView=new ModelAndView("updateSang");
		andView.addObject("sdto", sdto);
			
		return andView;
	}
	
	//상품 수정 폼으로 이동 
	@RequestMapping(value="updateSang", method=RequestMethod.POST)
	public String updateSang2(SangDto sdto) {
		
		sdinter.updateSang(sdto);
			
		return "redirect:/sang_manage";
	}
	
	//상품 삭제하기
	@RequestMapping(value="deleteSang", method=RequestMethod.GET)
	public String deleteSang(@RequestParam("no")int sangNo) {
		
		sdinter.deleteSang(sangNo);
		
		return "redirect:/sang_manage";
	}
	
	//주문 확인 페이지로 이동 
	@RequestMapping(value="ordercheck", method=RequestMethod.GET)
	public ModelAndView ordercheck() {
		
		ModelAndView andView=new ModelAndView("ordercheck");
		ArrayList<PurchaseDto> pdlist=pdinter.selectPlist();	
		
		andView.addObject("pdlist", pdlist);
		
		
		ArrayList<SangDto> slist=new ArrayList<SangDto>();
		for(int i=0; i<pdlist.size(); i++) {
			int sangNo=pdlist.get(i).getSangNo();
			slist.add(sdinter.selectSang(sangNo));
			
		}
		andView.addObject("slist", slist);
		
		
		return andView;
	}
	
	//상품준비중인 상태를 상품배송중인 상태로 바꾸기
	@RequestMapping(value="update_state_p1", method=RequestMethod.GET)
	public String update_state_p1(
			@RequestParam("sno")int sangNo, 
			@RequestParam("uno")int userNo) {
		
		PurchaseDto pdto=new PurchaseDto();
		pdto.setSangNo(sangNo);
		pdto.setUserNo(userNo);
		pdto.setpState(1);
		
		pdinter.updatePstate(pdto);
		
		
		return "redirect:/ordercheck";
	}
	
	//상품배송중인 상태를 배송완료 상태로 바꾸기
	@RequestMapping(value="update_state_p2", method=RequestMethod.GET)
	public String update_state_p2(
			@RequestParam("sno")int sangNo, 
			@RequestParam("uno")int userNo) {
		
		PurchaseDto pdto=new PurchaseDto();
		pdto.setSangNo(sangNo);
		pdto.setUserNo(userNo);
		pdto.setpState(2);
		
		pdinter.updatePstate(pdto);
		
		
		return "redirect:/ordercheck";
	}
	
}
