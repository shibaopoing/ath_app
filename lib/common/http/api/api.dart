class Api {
  //首页banner
  static const   String BaseUrl = "http://47.102.217.76:8010/";
  //static const   String BaseUrl = "http://192.168.1.3:8010/";
  static const   String ImageUrl = "http://47.102.217.76:88/ath/";
  static const   String GET_USER_INFO = "getUserInfo";
  static const   String SEND_SMS_CODE= "sendSmsCode";
  static const   String SET_FACE_IMAGE= "setFaceImage";
  //登录,注册;
  static const   String USER_LOGIN = "login";
  static const   String REGISTER = "userRegister";
  static const   String BANNER = "banner/json";
  //首页文章列表 http://www.wanandroid.com/article/list/0/json
  // 知识体系下的文章http://www.wanandroid.com/article/list/0/json?cid=60
  static const   String ARTICLE_LIST = "article/list/";
  //收藏文章列表
  static const   String COLLECT_LIST = "lg/collect/list/";
  //搜索
  static const   String ARTICLE_QUERY = "article/query/";
  //收藏,取消收藏
  static const   String COLLECT = "lg/collect/";
  //我的收藏列表中取消收藏
  static const   String UNCOLLECT_LIST = "lg/uncollect/";
  //知识体系
  static const   String TREE = "tree/json";
  //常用网站
  static const   String FRIEND = "friend/json";
  //搜索热词
  static const   String HOTKEY = "hotkey/json";
}