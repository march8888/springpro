package kr.board.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.filter.CharacterEncodingFilter;

import kr.board.security.MemberUserDetailsService;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	@Bean
	public UserDetailsService memberUserDetailsService() {
		return new MemberUserDetailsService();
	}
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(memberUserDetailsService()).passwordEncoder(passwordEncoder());
		System.out.println("인증매니저 시작");
	}
	
	
	//요청에대한 설정
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		//한글 인코딩
		//시큐리티 설정하면 여기를 통해서 데이터를 주고 받기 때문에 한글설정 필수
		CharacterEncodingFilter filter = new CharacterEncodingFilter();
		filter.setEncoding("UTF-8");
		filter.setForceEncoding(true);
		http.addFilterBefore(filter,CsrfFilter.class);
		
		//요청에 대한 보안 설정
		//get방식은 상관없은 post방식일 때가 보안이 걸림
		
		//요청에 따른 권한을 확인하여 서비스하는 부분 - 1 -> UserDetailsService생성하러...
		http
			.authorizeRequests() //요청 권한에 따라서 
				.antMatchers("/") //어떤경로로 왔을때, /루트는 특별한 경로 없이도 허용
				.permitAll()
				.and()	//그리고
			.formLogin() //커스텀 로그인 페이지 
				.loginPage("/memLoginForm.do") //해당 url로 요청이 들어오면 로그인 화면으로
				.loginProcessingUrl("/memLogin.do") //해당 url로 요청이 들어오면 로그인 프로세스 가동
				.permitAll()
				.and()
			.logout()
				.invalidateHttpSession(true)	//session제거
				.logoutSuccessUrl("/")	//로그아웃처리후 이동
				.and()
			.exceptionHandling().accessDeniedPage("/access-denied");
				
		
	}
	
	//패스워드 인코딩 객체 설정
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
	

	
	
}
