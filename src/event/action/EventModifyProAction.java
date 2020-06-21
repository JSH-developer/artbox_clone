package event.action;

import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import action.Action;
import svc.EventService;
import vo.ActionForward;
import vo.EventBean;

public class EventModifyProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		ServletContext context = request.getServletContext();
		
		// 프로젝트 상에서의 가상 업로드 폴더 위치 지정
		String saveFolder ="/eventUpload"; // 현재 위치(Webcontent)의 하위폴더이므로 "/폴더명" 사용 
		
		// ServletContext객체를 사용하여 가상 폴더에 대응하는 실제 폴더 위치 가져오기
		// => 이클립스 사용시 실제 업로드 폴더 위치
		// D:\workspace_model2\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\MVC_Board\boardUpload
		// 프로젝트명에 해당하는 폴더가 있으면 그 폴더 내에 업로드 폴더가 위치함
		String realFolder =context.getRealPath(saveFolder); // 가상 폴더로부터 실제 위치 가져오기
		
		// 업로드 할 최대 파일 사이즈 지정(전체 숫자 입력보단 단위별로 분리하는 것이 좋다!)
		int fileSize = 1024 * 1024 * 10; // 1024byte = 1KByte * 1024 = 1MB * 10 = 10MB
		
		// MultiPartrRequest 객체 생성
		MultipartRequest multi = new MultipartRequest(
				request,	// request객체
				realFolder,	// 파일이 업로드될 실제 폴더
				fileSize,	// 한번에 업로드 가능한 파일 최대 크기
				"UTF-8",	// 파일명에 대한 인코딩 방식
				new DefaultFileRenamePolicy()); // 파일명 중복 시 중복 파일 명을 처리할 객체
		
		EventBean eventBean = new EventBean();
		eventBean.setEvent_num(Integer.parseInt(multi.getParameter("event_num")));
		eventBean.setEvent_titie(multi.getParameter("event_title"));
		eventBean.setEvent_content(multi.getParameter("event_content"));
		eventBean.setEvent_condition(multi.getParameter("event_condition"));
		eventBean.setEvent_discount(Integer.parseInt(multi.getParameter("event_discount")));
		eventBean.setEvent_start(multi.getParameter("event_start"));
		eventBean.setEvent_limit(multi.getParameter("event_limit"));
		eventBean.setEvent_category(multi.getParameter("event_category"));
		eventBean.setEvent_img(multi.getOriginalFileName((String)multi.getFileNames().nextElement()));
		
		
		EventService eventService = new EventService();
		boolean isModifySuccess = eventService.updateEvent(eventBean);
		
		if(!isModifySuccess){
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>"); // 자바스크립트 시작 태그
			out.println("alert('이벤트 수정 실패')"); // 다이얼로그 메세지 출력
			out.println("history.back()"); // 이전 페이지로 돌아가기
			out.println("</script>"); // 자바스크립트 끝 태그
			
		}else {
			System.out.println("글수정성공!");
			
			
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("EventList.event?event_category=sale_event");
			
		}
		
		
		
		return forward;
	}

}
