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
import org.springframework.web.bind.annotation.ResponseBody;

import kr.board.entity.Board;
import kr.board.mapper.BoardMapper;

@Controller
public class BoardController {
	
	@Autowired
	private BoardMapper mapper;
	
	@RequestMapping("/boardMain.do")
	public String main() {
		return "board/main";
	}
	
//	//@ResponseBody -> jackson-databind(객체를 -> JSON 데이터 포멧으로 변환)
//	@RequestMapping("/boardList.do")
//	public @ResponseBody List<Board> boardList(){
//		
//		List<Board> list = mapper.getLists();
//		
//		return list; //JSON 데이터 형식으로 변환해서 리턴(응답)하겠다.
//	}
//	
//	@RequestMapping("/boardInsert.do")
//	public @ResponseBody void boardInsert(Board vo){
//		mapper.boardInsert(vo);
//	}
//	
//	@RequestMapping("/boardDelete.do")
//	public @ResponseBody void boardDelete(int idx){
//		mapper.boardDelete(idx);
//	}
//	
//	@RequestMapping("/boardUpdate.do")
//	public @ResponseBody void boardUpdate(Board vo){
//		mapper.boardUpdate(vo);
//	}
//	
//	@RequestMapping("/boardContent.do")
//	public @ResponseBody Board boardContent(int idx){
//		
//		Board vo = mapper.boardContent(idx);
//		
//		return vo;
//	}
//	
//	@RequestMapping("/boardCount.do")
//	public @ResponseBody Board boardCount(int idx){
//		
//		mapper.boardCount(idx);
//		Board vo = mapper.boardContent(idx);
//		
//		return vo;
//	}
	
}
