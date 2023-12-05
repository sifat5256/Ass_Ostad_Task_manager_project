import 'package:apps/widget/task_card.dart';

class Urls{
static const String _baseurl="https://task.teamrabbil.com/api/v1";
static const String registation="$_baseurl/registration";
static const String login="$_baseurl/login";
static const String creatnewtask="$_baseurl/createTask";
static  String getnewtask ="$_baseurl/listTaskByStatus/${TaskStatus.New.name}";
static const String gettasksummary="$_baseurl/taskStatusCount";
static  String completedscreen="$_baseurl/listTaskByStatus/${TaskStatus.Completed.name}";
static  String improgressScreen ="$_baseurl/listTaskByStatus/${TaskStatus.Progress.name}";
static  String cancellscreen ="$_baseurl/listTaskByStatus/${TaskStatus.Cancelled.name}";
static String updatedtaskstatus (String taskId,String status)=>"$_baseurl/updateTaskStatus/$taskId/$status";
static String Deketedid (String Deletid)=>"$_baseurl/deleteTask/$Deletid";
static String emailotp(String email)=>"$_baseurl/RecoverVerifyEmail/$email";
static const String upgradeprofile="$_baseurl/profileUpdate";
static String otpfrom(String email,String otp)=>"$_baseurl/RecoverVerifyOTP/$email/$otp";
static const String Resetpassword="$_baseurl/RecoverResetPass";
}