package pack.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

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
public class LoginController {

	@Autowired
	private MemberDaoInter mdinter;
	
	//회원가입 폼 전송시
	@RequestMapping(value="index", method=RequestMethod.POST)
	public String signup2(MemberDto mdto) {
		
		int uno=mdinter.selectMaxUno()+1;
		mdto.setUserNo(uno);
		boolean b=mdinter.insertMember(mdto);
		
		if(b) return "../../index";
		else return "../../error";
	}
	
	//사용 가능한 아이디인지 확인하기
	@RequestMapping(value="inputId", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> inputId(
			@RequestParam("inputId")String inputId){
		
		boolean b=mdinter.checkId(inputId);
		
		Map<String, String> map=new HashMap<String, String>();

		if(b) {
			System.out.println("사용할 수 있는 아이디입니다.");
			map.put("result", "y");
			System.out.println(map);
			return map;
		}else {
			System.out.println("사용 불가합니다.");
			map.put("result", "n");
			System.out.println(map);
			return map;
		}
	}
	
	//로그인 폼 전송시
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String login(HttpSession session,
			@RequestParam("id")String id,
			@RequestParam("pwd")String pwd) {
		
		
		if(mdinter.selectPwd(id)!=null) {
		String mpwd=mdinter.selectPwd(id);
			if(mpwd.equals(pwd)) {
				MemberDto mdto=mdinter.selectInfoId(id);
				session.setAttribute("userNo", mdto.getUserNo());
				session.setAttribute("userName", mdto.getUserName());
				return "../../index";
			}
			else {
				return "loginfail";
			}		
		}	
		else {
			return "loginfail";
		}
	}
	
	//로그아웃 클릭시
	@RequestMapping(value="logout", method=RequestMethod.GET)
	public String login(HttpSession session) {
		//유저번호, 유저이름, 장바구니의 세션 값이 없어진다.
		session.removeAttribute("userNo");
		session.removeAttribute("userName");
		session.removeAttribute("basket");
		
		return "../../index";
	}
		
	//존재하는 이름인지 확인하기
	@RequestMapping(value="nameOk", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> nameOk(@RequestParam("nameOk")String nameOk){
		
		System.out.println(nameOk);
		
		Map<String, String> map=new HashMap<String, String>();
		
		if(mdinter.selectInfoName(nameOk)!=null) {
			System.out.println("존재하는 닉네임");
			map.put("result", "y");
			System.out.println(map);
			return map;
		}else {
			System.out.println("없는 닉네임");
			map.put("result", "n");
			System.out.println(map);
			return map;
		}
		
	}
	
	//아이디 찾기 성공 페이지로 이동
	@RequestMapping(value="find_id", method=RequestMethod.POST)
	public ModelAndView find_id2(@RequestParam("userName")String userName) {
		
		if(mdinter.selectInfoName(userName)!=null) {
			
			ModelAndView andView=new ModelAndView("find_id_success");
			andView.addObject("userName", userName);
			andView.addObject("id", mdinter.selectInfoName(userName).getId());
			return andView;
		}else {
			ModelAndView andView=new ModelAndView("error");
			return andView;
		}
	}
	
	
	//비밀번호 찾기 답변 확인
	@RequestMapping(value="chkAnswer", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,String> chkAnswer(
			@RequestParam("hint")String hint,
			@RequestParam("answer")String answer,
			@RequestParam("id")String id){
		
		boolean b=mdinter.checkId(id);
		
		
		
		Map<String, String> map=new HashMap<String, String>();
		
		if(b) {
			String mhint=mdinter.selectidpwdQ(id);
			String manswer=mdinter.selectidpwdA(id);
			
			System.out.println("찾기 : "+manswer+" "+manswer.equals(answer));
			
			
			if(mhint.equals(hint)) {
				if(manswer.equals(answer)) {
					map.put("result", "y");
					return map;
				}else {
					map.put("result", "n");
				}
			}else {
				map.put("result", "n");
			}
		}else {
			map.put("result", "n");
		}
		return map;
	}
	
	//비밀번호 재설정
	@RequestMapping(value="find_pwd", method=RequestMethod.POST)
	public ModelAndView find_pwd2(MemberDto mdto) {
		Random random=new Random();
		int i=random.nextInt(1000000000);
		i+=100000;
		String pwd=i+"2";
		
		MemberDto mdto2=mdinter.selectInfoId(mdto.getId());
		mdto2.setPwd(pwd);
		mdinter.updateMember(mdto2);
		
		ModelAndView andView=new ModelAndView("find_pwd_success");
		andView.addObject("pwd",pwd);
		andView.addObject("userName", mdto2.getUserName());
		
		return andView;
	}
}
