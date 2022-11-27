package kr.board.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import kr.board.entity.Member;
import kr.board.entity.MemberUser;
import kr.board.mapper.MemberMapper;

//UserDetailsService - 2 -> MemberUser생성하러가기..
public class MemberUserDetailsService implements org.springframework.security.core.userdetails.UserDetailsService{
	
	@Autowired
	private MemberMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		//로그인 처리하기
		Member mvo = mapper.memLogin(username);
		//이미 내부에 필터 클래스가 있기 때문에 거기에 맞춰야함
		// ---> UserDetails ---> User extends ---> MemberUser(커스텀)
		if(mvo != null) {
			System.out.println("시큐리티 로그인");
			return new MemberUser(mvo);	//new MemberUser(mvo); //Member,AuthVO
		}else {
			throw new UsernameNotFoundException("User with username [" + username + "] does not exist.");
		}
		
	}
	
	
	
}
