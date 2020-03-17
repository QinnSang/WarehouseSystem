package constant;

public enum StateType {

    /**
     * 不存在该属性
     */
    Not_EXistsEnum(-1,"不存在该属性"),

    /**
     * 成功返回状态
     */
    OK(0,"success"),

    //---------------------------注册登录状态1**  start
    /**
     * 该账号已被注册
     */
    AlreadyExistsUserCode(11,"该账号已被注册"),

    /**
     * 该邮箱已被注册
     */
    EmailAlreadyExists(12,"该邮箱已被注册"),

    /**
     * 注册失败
     */
     RegisterFailed(13,"注册失败"),

    /**
     * 该用户账号不存在
     */
    UserNotExists(14,"该用户不存在"),

    /**
     * 该账户未激活
     */
    UserNotValidate(15,"该账户未激活"),

    /**
     * 验证码错误
     */
    VercodeError(16,"验证码错误"),

    /**
     * 用户名或密码错误
     */
    UserOrPwdError(17,"用户名或密码错误"),

    //---------------------------注册登录状态1**  end

    UpdateSuccess(20,"修改成功"),

    UpdateFailed(21,"修改成功"),


    /**
     * 请求格式错误
     */
    BAD_REQUEST(400,"bad request"),
    /**
     * 未授权
     */
    UNAUTHORIZED(401,"unauthorized"),
    /**
     * 没有权限
     */
    FORBIDDEN(403,"forbidden"),

    /**
     * 请求的资源不存在
     */
    NOT_FOUND(404,"not found"),
    /**
     * 该http方法不被允许
     */
    NOT_ALLOWED(405,"method not allowed"),
    /**
     * 请求处理发送异常
     */
    PROCESSING_EXCEPTION(406,"Handling Exceptions"),
    /**
     *
     * 请求处理未完成
     */
    PROCESSING_UNFINISHED(407,"To deal with unfinished"),

    /**
     * 登录过期
     */
    BEOVERDUE(408,"Be overdue"),

    /**
     * 用户未登录
     */
    NOT_LOGIN(409,"Not logged in"),

    /**
     * 这个url对应的资源现在不可用
     */
    GONE(410,"gone"),
    /**
     * 请求类型错误
     */
    UNSUPPORTED_MEDIA_TYPE(415,"unsupported media type"),
    /**
     * 校验错误时用
     */
    UNPROCESSABLE_ENTITY(422,"unprocessable entity"),
    /**
     * 请求过多
     */
    TOO_MANY_REQUEST(429,"too many request");


    private int status;
    private String value;

     StateType(int status, String value) {
        this.status = status;
        this.value = value;
    }

    public int getstatus(){
        return status;
    }

    public String getValue(){
        return value;
    }

    public static StateType getStateType(int status){
         for(StateType stateType:values()){
             if(status==stateType.status){
                 return stateType;
             }
         }
         return Not_EXistsEnum;
    }
}
