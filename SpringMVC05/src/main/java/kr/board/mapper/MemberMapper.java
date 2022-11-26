package kr.board.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Update;

import kr.board.entity.AuthVO;
import kr.board.entity.Board;
import kr.board.entity.Member;

@Mapper //- MyBatis API
public interface MemberMapper {
	public Member registerCheck(String memID);
	public int register(Member m); //회원등록(1,0)
	public Member memLogin(Member mvo);//로그인
	public int memUpdate(Member m);//회원수정
	public Member getMember(String memID); //회원정보
	public void memProfileUpdate(Member mvo);//이미지저장
	public void authInsert(AuthVO saveVO);
	public void authDelete(String memID);
}
