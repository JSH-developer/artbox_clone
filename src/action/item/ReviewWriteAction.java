package action.item;

import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import action.Action;
import svc.item.ReviewWriteSVC;
import vo.ActionForward;
import vo.ReviewBean;

public class ReviewWriteAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("ReviewWriteAction");
		ActionForward forward = new ActionForward();
		ReviewBean reviewBean = new ReviewBean();
		
		HttpSession session = request.getSession();
		if(session.getAttribute("id") == null) {
			session.setAttribute("id", "guest");
		}
		String member_id = (String)session.getAttribute("id");
		
		
		// 현재 컨텍스트(객체) 정보 가져오기 위해 request 객체로부터 getServletContext() 메서드 호출
		ServletContext context = request.getServletContext();
		
		// 프로젝트 상에서의 가상 업로드 폴더 위치 지정
		String saveFolder = "/upload"; // 현재 위치(Webcontent)의 하위폴더이므로 "/폴더명" 사용
		
		// ServletContext 객체를 사용하여 가상 폴더에 대응하는 실제 폴더 위치 가져오기
		// => 이클립스 사용 시 실제 업로드 폴더 위치
		// 워크스페이스\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps 폴더 내의
		// 프로젝트명에 해당하는 폴더가 있으며 그 폴더 내에 업로드 폴더가 위치함
		String realFolder = context.getRealPath(saveFolder);
		
		// 업로드 할 최대 파일 사이즈 지정(전체 숫자 입력 보단 단위별로 분리하는 것이 좋다!)
		int fileSize = 1024 * 1024 * 10; // 1024byte = 1KByte * 1024 = 1MB * 10 = 10MB 
		
		// MultiPartRequest 객체 생성 => cos.jar 필요
		MultipartRequest multi = new MultipartRequest(
			request, // request 객체
			realFolder,  // 파일이 업로드 될 실제 폴더
			fileSize, // 한 번에 업로드 가능한 파일 최대 크기
			"UTF-8", // 파일명에 대한 인코딩 방식
			new DefaultFileRenamePolicy()); // 파일명 중복 시 중복 파일명을 처리할 객체
		
//		//Enumeration은 커서를 사용한 순서있는 배열
//		//inputFileNames 는 순서가 섞여있어 review_img1 로 직접 지정
//		Enumeration inputFileNames = multi.getFileNames();
//		while(inputFileNames.hasMoreElements()) {
//			System.out.println((String)inputFileNames.nextElement());
//		}
		
		request.setCharacterEncoding("UTF-8");
		reviewBean.setReview_skill(Integer.parseInt(multi.getParameter("skill")));
		reviewBean.setReview_design(Integer.parseInt(multi.getParameter("design")));
		reviewBean.setReview_price(Integer.parseInt(multi.getParameter("price")));
		reviewBean.setReview_quality(Integer.parseInt(multi.getParameter("quality")));
		reviewBean.setReview_content(multi.getParameter("content"));
		reviewBean.setReview_img1(multi.getFilesystemName("review_img1"));
		reviewBean.setReview_img2(multi.getFilesystemName("review_img2"));
		reviewBean.setReview_img3(multi.getFilesystemName("review_img3"));
		reviewBean.setReview_img4(multi.getFilesystemName("review_img4"));
		reviewBean.setReview_img5(multi.getFilesystemName("review_img5"));
		reviewBean.setReview_member_id(member_id);
		reviewBean.setReview_product_num(Integer.parseInt(multi.getParameter("product_num")));
		
		ReviewWriteSVC reviewWriteSVC = new ReviewWriteSVC();
		boolean isWriteSuccess = reviewWriteSVC.registReview(reviewBean);
		
		if(!isWriteSuccess) {
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('review 등록 실패!')");
			out.println("history.back()");
			out.println("</script>");
		} else {
			System.out.println("review 등록 성공!");
			forward.setRedirect(true);
			forward.setPath("itemReview.item");
		}
		
		return forward;
	}

}
