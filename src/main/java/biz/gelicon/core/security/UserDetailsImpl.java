package biz.gelicon.core.security;

import biz.gelicon.core.model.admin.Capcode;
import biz.gelicon.core.model.admin.Proguser;
import org.aopalliance.intercept.MethodInvocation;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

public class UserDetailsImpl implements UserDetails {

    private final Proguser pu;
    private List<GrantedRole> grantedRoles;

    // используется в Method Security для передачи в PermissionEvaluator
    // имеет значенеи при вычислении прав
    // Внимание! не потокобезопасный, поэотому на каждый запрос должен
    // создаваться собственный UserDetails
    private MethodInvocation methodInvocation;

    public UserDetailsImpl(Proguser pu) {
        this.pu = pu;
        // неавторизированный пользователь
        this.grantedRoles = null;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return grantedRoles;
    }

    @Override
    public String getPassword() {
        // используется CredentialProvider
        return null;
    }

    public Proguser getProgUser() {
        return pu;
    }

    @Override
    public String getUsername() {
        return pu.getProguserName();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return pu.getStatusId()== Capcode.USER_IS_ACTIVE;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    public boolean isSysDba() {
        return pu.getProguserId()==Proguser.SYSDBA_PROGUSER_ID;
    }

    static class GrantedRole implements GrantedAuthority{
        private String authority;

        @Override
        public String getAuthority() {
            return authority;
        }
    }

    public MethodInvocation getMethodInvocation() {
        return methodInvocation;
    }

    public void setMethodInvocation(MethodInvocation mi) {
        this.methodInvocation = mi;
    }
}
