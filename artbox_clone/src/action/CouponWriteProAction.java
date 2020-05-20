package action;

import java.text.DateFormat;
import java.text.SimpleDateFormat;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.CouponService;
import vo.ActionForward;
import vo.CouponBean;

public class CouponWriteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println(request.getParameter("ActionForward"));
		
		ActionForward forward = new ActionForward();
		
		ServletContext context = request.getServletContext();
		
		String saveFolder="/upload";
		String realFolder = context.getRealPath(saveFolder);
	
		int fileSize = 1024 * 1024 * 10; // 1024Byte = 1KByte * 1024 = 1MB * 10 = 10MB
		
		MultipartRequest multi = new MultipartRequest(
				request, // request 객체
				realFolder,  // 파일이 업로드 될 실제 폴더
				fileSize, // 한 번에 업로드 가능한 파일 최대 크기
				"UTF-8",  // 파일명에 대한 인코딩 방식
				new DefaultFileRenamePolicy()); // 파일명 중복 시 중복 파일명을 처리할 객체
		
		
		
		CouponBean couponBean = new CouponBean();
		couponBean.setCoupon_name(multi.getParameter("coupon_name"));
		couponBean.setCoupon_price(Integer.parseInt(multi.getParameter("coupon_price")));
		couponBean.setCoupon_condition(multi.getParameter("coupon_condition"));
		couponBean.setCoupon_start(multi.getParameter("coupon_start"));
		couponBean.setCoupon_limit(multi.getParameter("coupon_limit"));
		couponBean.setCoupon_reason(multi.getParameter("coupon_reason"));
		couponBean.setCoupon_member_id(multi.getParameter("coupon_member_id"));
		couponBean.setCoupon_img( multi.getFilesystemName((String) multi.getFileNames().nextElement()) );
		
		CouponService couponService = new CouponService();
		boolean isRegist = couponService.registCoupon(couponBean);
		
		if(isRegist) {
			System.out.println("쿠폰 등록 성공 -"+multi.getParameter("coupon_name"));
			
			forward = new ActionForward();
			forward.setPath("/event/registCoupon.jsp");
			
			
		}else {
			forward = new ActionForward();
			forward.setRedirect(true);
			forward.setPath("registCouponWrite.event");
			System.out.println("쿠폰 등록 실패!");
		}
		
		
		return forward;
	}

}
