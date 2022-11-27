package kr.board.entity;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Data;
//인증후 사용자 정보를 저장하기 - 3
@Data
public class MemberUser extends User {
	
	private Member member;
	
	public MemberUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	public MemberUser(Member mvo) {
		//권한정보는 컬렉션으로.. 리스트는 안돼
		super(mvo.getMemID(), mvo.getMemPassword(), 
				//List<AuthVO> -> Collection<SimpleGrantedAuthority>
				mvo.getAuthList().stream()
				.map(auth->new SimpleGrantedAuthority(auth.getAuth()))
				.collect(Collectors.toList()));
		
		//사용자의 다른 정보
		this.member = mvo;
	}
	
}
