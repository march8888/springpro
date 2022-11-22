package kr.board.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@Controller
public class BoardController {
	
	@Autowired
	private BoardMapper mapper;
	
	// /boardList.do
	// HandlerMapping
	//게시판 리스트 화면 이동, 출력
	@RequestMapping("/boardList.do")
	public String boardList(Model model) { 
		
		List<Board> list = mapper.getLists();
		System.out.print(list);
		model.addAttribute("list",list);
		
		return "boardList"; // /WEB-INF/views/boardList.jsp -> forward
	}
	
	//글쓰기 폼 이동
	@GetMapping("/boardForm.do")
	public String boardForm() {
		
		return "boardForm";
	}
	//글쓰기 입력
	@PostMapping("boardInsert.do")
	public String boardInsert(Board vo) {	//파라메터 수집(Board)
		
		mapper.boardInsert(vo);//등록
		
		return "redirect:/boardList.do";
	}
	
	@GetMapping("boardContent.do")
	public String boardContent(int idx,Model model) {//@RequestParam("idx") 이름이 같으면 생략가능
		
		Board vo = mapper.boardContent(idx);
		
		//조회수 증가
		mapper.boardCount(idx);
		
		model.addAttribute("vo", vo);
		
		return "boardContent";
	}
	
	@GetMapping("boardDelete.do/{idx}")
	public String boardDelete(@PathVariable("idx") int idx, Model model) {
		
		mapper.boardDelete(idx);
		
		return "redirect:/boardList.do";
	}
	
	@GetMapping("boardUpdateForm.do/{idx}")
	public String boardUpdateForm(@PathVariable("idx") int idx, Model model) {
		
		Board vo = mapper.boardContent(idx);
		model.addAttribute("vo", vo);
		
		return "boardUpdate";
	}
	
	@PostMapping("boardUpdate.do")
	public String boardUpdate(Board vo) {
		
		mapper.boardUpdate(vo);
		
		return "redirect:/boardList.do";
	}
}
