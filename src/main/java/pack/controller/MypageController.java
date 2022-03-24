package pack.controller;

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

import pack.model.MemberDaoInter;
import pack.model.MemberDto;

@Controller
public class MypageController {
	
	@Autowired
	private MemberDaoInter mdinter;

	//회원정보수정 전 비밀번호 확인 
	@RequestMapping(value="pwd_check", method=RequestMethod.GET)
	public String pwd_check() {
		
		return "pwd_check";
	}
	
	//비밀번호 일치 확인 
	@RequestMapping(value="pwdSame", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> pwdSame(
			@RequestParam("checkpwd")String checkpwd,
			@RequestParam("userNo")int userNo){
		
		
		String mpwd=mdinter.selectPwd2(userNo);
		
		
		boolean b=checkpwd.equals(mpwd);
		Map<String, String> map=new HashMap<String, String>();

		System.out.println(b);
		if(b) {
			System.out.println("비밀번호가 일치합니다.");
			map.put("result", "y");
			System.out.println(map);
			return map;
		}else {
			System.out.println("비밀번호가 일치하지 않습니다.");
			map.put("result", "n");
			System.out.println(map);
			return map;
		}
	}
	
	//회원정보 수정 폼 이동
	@RequestMapping(value="modify_member", method=RequestMethod.POST)
	public ModelAndView modify_member(HttpSession session) {
		
		int userNo=(Integer)session.getAttribute("userNo");
		MemberDto mdto=mdinter.selectInfoUno(userNo);
		
		ModelAndView andView=new ModelAndView();
		andView.addObject("mdto", mdto);
		
		return andView;
	}
	
	//회원 정보 수정 처리 
	@RequestMapping(value="update_member", method=RequestMethod.POST)
	public String update_member(MemberDto mdto,
			HttpSession session) {
		
		mdto.setUserNo((Integer)session.getAttribute("userNo"));
		mdinter.updateMember(mdto);
		
		return "update_success";
	}
	
	//회원 탈퇴 처리 delete_member
	@RequestMapping(value="delete_member", method=RequestMethod.GET)
	public String delete_member(HttpSession session) {
		
		int userNo=(Integer)session.getAttribute("userNo");
		mdinter.deleteMember(userNo);	
		
		//유저번호, 유저이름, 장바구니의 세션 값이 없어진다.
		session.removeAttribute("userNo");
		session.removeAttribute("userName");
		session.removeAttribute("basket");
		
		return "goodbye";
	}
	

}