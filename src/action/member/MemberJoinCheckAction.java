package action.member;



import svc.member.MemberJoinCheckService;

public class MemberJoinCheckAction{

	public boolean execute(String id) {
		System.out.println("MemberJoinCheckAction");
		MemberJoinCheckService MemberJoinCheckService = new MemberJoinCheckService();
		
//		System.out.println("action에 id값 왔냐?"+id);
		
		boolean dbid = MemberJoinCheckService.idcheckSuccess(id);
//		System.out.println("action 에서 찍은 dbid값 : "+dbid);
		
		
		return dbid;
	}

}
