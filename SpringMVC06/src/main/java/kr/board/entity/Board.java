package kr.board.entity;

import lombok.Data;

@Data //- Lombok API
public class Board {
	private int idx; //번호
	private String title;
	private String content;
	private String writer;
	private String indate;
	private int count;
	private String memID;
	
	
}
