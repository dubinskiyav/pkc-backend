package biz.gelicon.core.config;

import biz.gelicon.core.service.admin.ProguserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.security.web.authentication.AnonymousAuthenticationFilter;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.security.web.util.matcher.RequestMatcher;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    ProguserService proguserService;

    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Override
    protected void configure(HttpSecurity httpSecurity) throws Exception {
        httpSecurity
                .csrf().disable()
                .formLogin().disable()
                .logout().disable()
                .sessionManagement().disable()
                .addFilterBefore(authenticationFilter(), AnonymousAuthenticationFilter.class)
                .authorizeRequests()
                //Доступ разрешен всем пользователей
                .antMatchers("/*", "/security/**", "/swagger-ui/**", "/v3/api-docs/**").permitAll()
                //Все остальные страницы требуют аутентификации
                .antMatchers(HttpMethod.OPTIONS, "/**").permitAll()
                .anyRequest().authenticated();
    }

    @Bean
    AuthenticationFilter authenticationFilter() throws Exception {
        final AuthenticationFilter filter = new AuthenticationFilter();
        filter.setAuthenticationManager(authenticationManager());
        return filter;
    }
    static class AuthenticationFilter extends AbstractAuthenticationProcessingFilter {

        private static final String AUTHORIZATION = "Authorization";

        protected AuthenticationFilter() {
            super(new AntPathRequestMatcher("/v" + Config.CURRENT_VERSION + "/apps/**", "POST"));
        }

        @Override
        public Authentication attemptAuthentication(HttpServletRequest httpServletRequest,
                HttpServletResponse httpServletResponse)
                throws AuthenticationException, IOException, ServletException {
            String token = httpServletRequest.getHeader(AUTHORIZATION);
            if (token == null) {
                token = ""; //empty token
            }
            token = StringUtils.removeStart(token, "Bearer").trim();
            Authentication requestAuthentication = new UsernamePasswordAuthenticationToken(token,
                    token);
            return getAuthenticationManager().authenticate(requestAuthentication);
        }
        @Override
        protected void successfulAuthentication(final HttpServletRequest request,
                final HttpServletResponse response,
                final FilterChain chain, final Authentication authResult)
                throws IOException, ServletException {
            SecurityContextHolder.getContext().setAuthentication(authResult);
            chain.doFilter(request, response);
        }

    }


}
