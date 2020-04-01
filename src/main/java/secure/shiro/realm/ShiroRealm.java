package secure.shiro.realm;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;

import java.util.HashSet;
import java.util.Set;

/**
 * 自定义realm实现认证和授权方法，login方法会调用该类，将数据库查询的结果封装到SimpleAuthenticationInfo
 * 然后再由securityManager 将封装的用户信息和用户输入的用户信息进行比对
 **/

public class ShiroRealm extends AuthorizingRealm {

    /**
     * 认证方法：认证成功则返回认证信息，否则返回null
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        System.out.println("[FirstReaml] doGetAuthenticationInfo");
        //1.把AuthenticationToken 转换为 UsernamePasswordToken
        UsernamePasswordToken upToken = (UsernamePasswordToken)token;

        //2.从 UsernamePasswordToken 中获取 username
        String username = upToken.getUsername();

        //3.根据用户名从数据库中查询 username 对应的密码、盐值
        System.out.println("从数据库获取username--->"+username);

        //4.若用户不存在,则可以抛出 UnknownAccountException 异常
        if ("unknown".equals(username)){
            throw new UnknownAccountException("用户不存在");
        }

        //5.根据用户信息的情况,决定是否需要抛出其他的 AuthenticationException 异常
        if ("monster".equals(username)){
            throw new LockedAccountException("用户被锁定");
        }
        //6.根据用户的情况,来构建 AuthenticationInfo 对象并返回,通常实现类为:SimpleAuthenticationInfo
        //以下信息都是从数据库中获取的
        //1.principal:认证的实体信息.可以是username,也可以是数据表对应的用户的实体类对象.
        Object principal = username;
        //2.credentials :密码
        Object credentials = null;// "4a95737b032e98a50c056c41f2fa9ec6";
        if ("admin".equals(username)){
            credentials = "038bdaf98f2037b31f1e75b5b4c9b26e";
        }else if("user".equals(username)){
            credentials = "098d2c478e9c11555ce2823231e02ec1";
        }
        //3.realmName:当前realm对象的name,调用父类的getName()方法即可
        String realmName = getName();
        //4.盐值，用于将用户输入的密码转化
        ByteSource credentialsSalt = ByteSource.Util.bytes(username);
        SimpleAuthenticationInfo info = null;
        info = new SimpleAuthenticationInfo(principal,credentials,credentialsSalt,realmName);
        return info;
    }

    public static void main(String[] args) {
        String hashAlgorithnName="MD5";
        Object credentials = "123456";
        Object salt = ByteSource.Util.bytes("user");
        int hashIterations = 1024;

        Object result = new SimpleHash(hashAlgorithnName,credentials,salt,hashIterations);
        System.out.println(result);
    }

    //授权方法，会被 shiro 回调
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        //1.从 PrincipalCollection 中来获取登陆用户的信息
        Object principal = principals.getPrimaryPrincipal();
        //2.利用登陆的用户的信息来获取当前用户的角色或权限(可能需要查询数据库),这里直接赋值
        Set<String> roles = new HashSet<>();
        roles.add("user");
        if ("admin".equals(principal)){
            roles.add("admin");
        }

        //3.创建SimpleAuthorizationInfo 并设置其 roles 属性
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo(roles);

        //4.返回SimpleAuthorizationInfo 对象
        return info;
    }
}