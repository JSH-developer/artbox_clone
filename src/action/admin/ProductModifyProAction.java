package action.admin;

import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.admin.ProductModifyService;
import svc.admin.ProductWriteService;
import vo.ActionForward;
import vo.ProductBean;

public class ProductModifyProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		String opt = ""; // 검색기능 사용시 opt(분류기준)값 받아오기
		if(request.getParameter("opt") != null) {
			opt = request.getParameter("opt");
		}
				
		String kwd = ""; // 검색기능 사용시 kwd(검색단어)값 받아오기
		if(request.getParameter("kwd") != null) {
			opt = request.getParameter("kwd");
		}
		
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
		
//		ProductWriteService productWriteService = new ProductWriteService();
		ProductModifyService productModifyService = new ProductModifyService();
		ProductBean productBean = new ProductBean(); // svc에 전달할 ProductBean 생성
		productBean.setProduct_num(Integer.parseInt(multi.getParameter("num")));
		productBean.setProduct_code(multi.getParameter("product_category_code") + multi.getParameter("product_option_code_origin")); // 상품코드 = 카테고리 + 옵션
		productBean.setProduct_name(multi.getParameter("product_name"));
//		Enumeration images = multi.getFileNames();
//		productBean.setProduct_image2(multi.getFilesystemName((String) images.nextElement()));
//		productBean.setProduct_image( multi.getFilesystemName((String) images.nextElement()) );
		productBean.setProduct_image( multi.getParameter("product_image") );
		productBean.setProduct_image2( multi.getParameter("product_image2") );
		productBean.setProduct_description(multi.getParameter("product_description"));
		productBean.setProduct_price(Integer.parseInt(multi.getParameter("product_price")));
		productBean.setProduct_brand(multi.getParameter("product_brand"));
		productBean.setProduct_stock_count(Integer.parseInt(multi.getParameter("product_stock_count")));
		productBean.setProduct_sale_price(Integer.parseInt(multi.getParameter("product_sale_price")));
		productBean.setProduct_keywords(multi.getParameter("product_keywords"));
		productBean.setProduct_category_code(multi.getParameter("product_category_code"));
		productBean.setProduct_option_code(multi.getParameter("product_option_code_origin"));
		productBean.setProduct_option_code(multi.getParameter("product_option_code"));
		
		boolean isUpdate = productModifyService.modifyProduct(productBean); // svc에 ProductBean 전달 후 수정
		
		if(isUpdate) {
			forward.setPath("ProductView.admin?num="+Integer.parseInt(multi.getParameter("num"))+"&page="+multi.getParameter("page")+"&opt="+opt+"&kwd="+kwd);
		}else { // 실패시 alert창 생성
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script type=\"text/javascript\">");
			out.println("alert('등록에 실패하였습니다!!')");
			out.println("history.back();");
			out.println("</script>");
		}
		
		return forward;
	}

}
