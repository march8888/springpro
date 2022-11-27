package kr.board.config;

import org.springframework.security.web.context.AbstractSecurityWebApplicationInitializer;

//이 클래스가 있어야 시큐리티 사용가능
//AbstractSecurityWebApplicationInitializer(시큐리티 컨테이너(독립)) : 시큐리티 내부적으로 동작시킴								
public class SecurityInitializer extends AbstractSecurityWebApplicationInitializer {
	
	//환경설정파일 먼저 만들고 오자 SecurityConfig.java

}
