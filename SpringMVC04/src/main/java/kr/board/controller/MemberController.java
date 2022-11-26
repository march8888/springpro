package kr.board.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.board.entity.Member;
import kr.board.mapper.MemberMapper;

@Controller
public class MemberController {
	
	@Autowired
	MemberMapper mapper;
	
	//회원가입 폼
	@RequestMapping("/memJoin.do")
	public String memJoin() {

		return "member/join";
	}
	
	//아이디 중복확인
	@RequestMapping("memRegisterCheck.do")
	public @ResponseBody int memRegisterCheck(@RequestParam("memID") String memID) {
		
		Member m = mapper.registerCheck(memID);
		
		if(m != null || memID.equals("")) {
			return 0; //이미 존재하는 회원, 혹은 빈칸 입력불가
		}

		return 1; //사용가능한 아이디
	}
	
	//회원가입 처리
	@RequestMapping("/memRegister.do")
	public String memRegister(Member m,String memPassword1,String memPassword2, RedirectAttributes rttr, HttpSession session ) {
		
		//누락체크
		if(m.getMemID() == null || m.getMemID().equals("") ||
			memPassword1 == null || memPassword1.equals("") ||
			memPassword2 == null || memPassword2.equals("") ||
			m.getMemPassword() == null || m.getMemPassword().equals("") ||
			m.getMemID() == null || m.getMemID().equals("") ||
			m.getMemName() == null || m.getMemName().equals("") ||
			m.getMemAge() == 0 ||
			m.getMemGender() == null || m.getMemGender().equals("") ||
			m.getMemEmail() == null || m.getMemEmail().equals("")
			) {
			
			//누락 메세지를 가지고 가기 => 객체 바인딩
			//RedirectAttributes : 리다이랙트 할 때 거기로 값을 보낼 수 있음
			
			rttr.addFlashAttribute("msgType", "누락 메세지");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			
			return "redirect:/memJoin.do";
		}
		
		if(!memPassword1.equals(memPassword2)) {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "비밀번호가 다릅니다.");
			
			return "redirect:/memJoin.do";
		}
		
		m.setMemProfile(""); //사진이미지는 없다는 의미 ""
		
		//회원 테이블 저장
		int result = mapper.register(m);
		if(result == 1) {
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "회원가입에 성공했습니다.");
			
			//회원가입이 성공하면 => 로그인처리하기
			session.setAttribute("mvo", m); //${empty m}
			
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "이미 존재하는 회원입니다.");
			return "redirect:/memJoin.do";
		}
	}
	
	
	//로그아웃 처리
	@RequestMapping("/memLogout.do")
	public String memLogout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
	
	//로그인 화면
	@RequestMapping("memLoginForm.do")
	public String memLoginForm() {
		return "member/memLoginForm";
	}
	
	//로그인 처리
	@RequestMapping("/memLogin.do")
	public String memLogin(Member m, RedirectAttributes rttr, HttpSession session) {
		if(m.getMemID() == null || m.getMemID().equals("") ||
			m.getMemPassword() == null || m.getMemPassword().equals("")
				) {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "모든 내용을 입력해주세요.");
			return "redirect:/memLoginForm.do";
		}
		
		Member mvo = mapper.memLogin(m);
		System.out.println(m);
		System.out.println(mvo);
		if(mvo != null) { //로그인 성공
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "로그인에 성공했습니다.");
			session.setAttribute("mvo", mvo);
			return "redirect:/";
			
		}else { //로그인 실패
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "로그인에 실패했습니다.");
			return "redirect:/memLoginForm.do";
		}

	}
	
	//회원정보 수정화면
	@RequestMapping("/memUpdateForm.do")
	public String memUpdateForm() {
		
		return "member/memUpdateForm";
	}
	
	//회원정보 수정처리
	@RequestMapping("/memUpdate.do")
	public String memUpdate(Member m, RedirectAttributes rttr, 
			String memPassword1,String memPassword2,HttpSession session) {
		
		//누락체크
		if(m.getMemID() == null || m.getMemID().equals("") ||
			memPassword1 == null || memPassword1.equals("") ||
			memPassword2 == null || memPassword2.equals("") ||
			m.getMemPassword() == null || m.getMemPassword().equals("") ||
			m.getMemID() == null || m.getMemID().equals("") ||
			m.getMemName() == null || m.getMemName().equals("") ||
			m.getMemAge() == 0 ||
			m.getMemGender() == null || m.getMemGender().equals("") ||
			m.getMemEmail() == null || m.getMemEmail().equals("")
		) {
				
			//누락 메세지를 가지고 가기 => 객체 바인딩
			//RedirectAttributes : 리다이랙트 할 때 거기로 값을 보낼 수 있음
			
			rttr.addFlashAttribute("msgType", "누락 메세지");
			rttr.addFlashAttribute("msg", "모든 내용을 입력하세요.");
			
			return "redirect:/memUpdateForm.do";
		}
		
		//비밀번호 일치여부
		if(!memPassword1.equals(memPassword2)) {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "비밀번호가 다릅니다.");
			
			return "redirect:/memUpdateForm.do";
		}
		
		//정보수정처리
		int result = mapper.memUpdate(m);
		if(result == 1) {
			rttr.addFlashAttribute("msgType", "성공 메세지");
			rttr.addFlashAttribute("msg", "회원정보 수정에 성공했습니다.");
			
			//회원수정이 성공하면 => 로그인처리하기
			//수정된 정보가 바로 세션에 반영
			Member mvo = mapper.getMember(m.getMemID());
			session.setAttribute("mvo", mvo); //${empty m}
			
			return "redirect:/";
		}else {
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "회원정보 수정에 실패했습니다.");
			return "redirect:/memUpdateForm.do";
		}
	}
	
	//회원 사진등록 화면
	@RequestMapping("memImageForm.do")
	public String memImageForm() {
		return "member/memImageForm";
	}
	
	//회원 사진 등록 처리(upload,디비 저장)
	@RequestMapping("memImageUpdate.do")
	public String memImageUpdate(HttpServletRequest request,RedirectAttributes rttr, HttpSession session) {
		
		//파일 업로드 API(3가지)
		//cos.jar(com.servlets)
		MultipartRequest multi = null;
		int fileMaxSize = 10*1024*1024; //10MB
		String savePath = request.getRealPath("resources/upload"); //실제경로를 가져오기, 실제관리가 되는 곳
		try {
			//이미지 업로드
			//							  사진		저장소		최대크기		한글		이름중복일 경우 변경하여 저장
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
			
		} catch (Exception e) {
			System.out.println(e.toString());
			rttr.addFlashAttribute("msgType", "실패 메세지");
			rttr.addFlashAttribute("msg", "파일의 크기는 10MB를 넘을 수 없습니다.");
			return "redirect:/memImageForm.do";
		}
		
		//데이터베이스 테이블에 회원 이미지를 업데이트
		String memID = multi.getParameter("memID");
		String newProfile = "";
		//파일이 저장되어 있는지 확인 -> file에 이미지 정보 저장
		File file = multi.getFile("memProfile");
		if(file != null) {
			//업로드가 된 상태(.png .jps .gif)
			//이미지 파일 여부 체크 -> 이미지 파일이 아니면 삭제 (1.png)
			String ext = file.getName().substring(file.getName().lastIndexOf(".")+1);
			ext = ext.toUpperCase();
			if(ext.equals("PNG") || ext.equals("JPG") || ext.equals("GIF")) {
				//새로 업로드된 이미지(new-1.png),현재 DB에 있는 이미지(old-4.png)
				
				//기존 이미지 삭제
				String oldProfile = mapper.getMember(memID).getMemProfile();
				System.out.println(oldProfile);
				File oldFile = new File(savePath + "/" + oldProfile);
				if(oldFile.exists()) {
					oldFile.delete();
				}
				
				//새로운 이미지
				newProfile = file.getName();
				
			}else {
				//이미지 파일이 아니면 삭제
				//파일이 존재하는지 다시 한 번 확인
				if(file.exists()) {
					file.delete(); //삭제
				}
				rttr.addFlashAttribute("msgType", "실패 메세지");
				rttr.addFlashAttribute("msg", "이미지 파일만 업로드 가능합니다.");
				return "redirect:/memImageForm.do";
			}
		}
		
		//새로운 이미지를 테이블에 업데이트
		Member mvo = new Member();
		mvo.setMemID(memID);
		mvo.setMemProfile(newProfile);
		
		mapper.memProfileUpdate(mvo); //이미지 업데이트 성공
		Member m = mapper.getMember(memID); //새이미지로 저장된 정보를 가져와서
		//세션을 다시 새롭게 생성한다
		session.setAttribute("mvo", m);
		
		rttr.addFlashAttribute("msgType", "성공 메세지");
		rttr.addFlashAttribute("msg", "이미지 업데이트가 성공했습니다.");
		
		return "redirect:/";
	}
}
