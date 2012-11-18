package com.redhat.theses.auth

import org.springframework.security.core.userdetails.UserDetails
import org.slf4j.Logger
import org.slf4j.LoggerFactory
import org.springframework.security.core.authority.GrantedAuthorityImpl
import org.codehaus.groovy.grails.plugins.springsecurity.SpringSecurityUtils
import org.springframework.security.core.userdetails.UsernameNotFoundException
import org.springframework.security.core.GrantedAuthority
import org.codehaus.groovy.grails.plugins.springsecurity.GrailsUser
import org.codehaus.groovy.grails.plugins.springsecurity.GrailsUserDetailsService

/**
 * This user details service authenticates the user by email instead of username
 */
class CustomUserDetailsService implements GrailsUserDetailsService {

    private Logger _log = LoggerFactory.getLogger(getClass())

    /**
     * Some Spring Security classes (e.g. RoleHierarchyVoter) expect at least one role, so
     * we give a user with no granted roles this one which gets past that restriction but
     * doesn't grant anything.
     */
    static final List NO_ROLES = [new GrantedAuthorityImpl(SpringSecurityUtils.NO_ROLE)]

    /**
     * {@inheritDoc}
     * @see org.codehaus.groovy.grails.plugins.springsecurity.GrailsUserDetailsService#loadUserByUsername(
     * 	java.lang.String, boolean)
     */
    UserDetails loadUserByUsername(String email, boolean loadRoles) throws UsernameNotFoundException {

        User.withTransaction { status ->
            def user = User.findByEmail(email)
            if (!user) {
                log.warn "User not found: $email"
                throw new UsernameNotFoundException('User not found', email)
            }

            Collection<GrantedAuthority> authorities = loadAuthorities(user, email, loadRoles)
            createUserDetails user, authorities
        }
    }

    /**
     * {@inheritDoc}
     * @see org.springframework.security.core.userdetails.UserDetailsService#loadUserByUsername(
     * 	java.lang.String)
     */
    UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        loadUserByUsername email, true
    }

    protected Collection<GrantedAuthority> loadAuthorities(User user, String email, boolean loadRoles) {
        if (!loadRoles) {
            return []
        }

        def authorities = user.authorities.collect { new GrantedAuthorityImpl(it.authority) }
        authorities ?: NO_ROLES
    }

    protected UserDetails createUserDetails(User user, Collection<GrantedAuthority> authorities) {
        new GrailsUser(user.email, user.password, user.enabled, !user.accountExpired, !user.passwordExpired,
                !user.accountLocked, authorities, user.id)
    }

    protected Logger getLog() { _log }
}