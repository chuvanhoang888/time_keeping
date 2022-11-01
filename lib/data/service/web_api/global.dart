const serverName = "192.168.1.79:8080";

class Config {
  static String url = "http://$serverName/api";
  //login
  static String loginURL = url + "/auth/login";
  static String registerURL = url + "/auth/register";
  static String logoutURL = url + "/auth/logout";
  static String imageUserURL = url + "/auth/photo";
  static String allUserURL = url + "/auth/users";
  static String userURL = url + "/auth/detail";

  //Dts
  static String postURL = url + "/posts";
  static String commentURL = url + "/post/comments";
  static String userTagURL = "";
  static String postLikeURL = url + "/post/likes";
  static String commentLikeURL = url + "/comment/likes";

  static String uploadImagePost = url + "/upload_image_post";
  static String deleteImagePost = url + "/posts-image";
  static String checkInUserURL = "/checkIn-user";
  static String checkInUserFullURL = url + "/checkIn-user";
  static String commentReplyFullURL = url + "/comment-reply";
  static String commentReplyURL = "/comment-reply";
  //Account
  static String postsUserFullURL = url + "/posts-user";

  //home
  static String notificationURL = url + "/notifications";

  static String permissionURL = url + "/permission-mails";
  static String historyURL = url + "/history";

  //Work
  static String workURL = url + "/works";
  static String todoURL = url + "/work/todos";
  static String workTodoURL = url + "/work/todos";
  static String workUserURL = url + "/work/users";
  static String workCommentURL = url + "/work/comments";
  static String workImageURL = url + "/work/images";
  //home // permission

  // Errors
  static String serverError = 'Server error';
  static String unauthorized = 'unauthorized';
  static String somethingWentWrong = 'Something went wrong, try again';
}
