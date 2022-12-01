package kr.bit.service;

import java.util.List;

import kr.bit.entity.Board;
import kr.bit.entity.Member;

public interface BoardIService {
	public List<Board> getList();
	public void insertSelectKey(Board vo);
	public Member login(Member vo);
	public Board get(int idx);
	public void modify(Board vo);
	public void remove(int idx);
	public void reply(Board vo);
}
