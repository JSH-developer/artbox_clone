package action.admin;

import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.admin.ProductWriteService;
import vo.ActionForward;
import vo.ProductBean;

public class ProductWriteProAction implements Action{

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		
		ProductWriteService productWriteService = new ProductWriteService();
		ProductBean productBean = new ProductBean();
		
		if(multi.getParameter("product_option_code").equals("00")) {
			productBean.setProduct_code(multi.getParameter("product_category_code") + productWriteService.countProduct() + multi.getParameter("product_option_code")); // 상품코드 = 카테고리 + 옵션
		}else {
			productBean.setProduct_code(multi.getParameter("product_category_code") + multi.getParameter("product_option_code")); // 상품코드 = 카테고리 + 옵션
		}
		 
		productBean.setProduct_name(multi.getParameter("product_name"));
		Enumeration images = multi.getFileNames();
		productBean.setProduct_image2(multi.getFilesystemName((String) images.nextElement()));
		productBean.setProduct_image( multi.getFilesystemName((String) images.nextElement()) );
		productBean.setProduct_description(multi.getParameter("product_description"));
		productBean.setProduct_price(Integer.parseInt(multi.getParameter("product_price")));
		productBean.setProduct_brand(multi.getParameter("product_brand"));
		productBean.setProduct_stock_count(Integer.parseInt(multi.getParameter("product_stock_count")));
		productBean.setProduct_sale_price(Integer.parseInt(multi.getParameter("product_sale_price")));
		productBean.setProduct_keywords(multi.getParameter("product_keywords"));
		productBean.setProduct_category_code(multi.getParameter("product_category_code"));
		if(multi.getParameter("product_option_code").equals("00")) { // 기본옵션일 경우 기본옵션코드를 생성해서 등록
			productBean.setProduct_option_code(productWriteService.countProduct() + multi.getParameter("product_option_code"));
		}else {
			productBean.setProduct_option_code(multi.getParameter("product_option_code"));
		}
		
		
		
		boolean isRegist = productWriteService.registProduct(productBean);
		
		if(isRegist) {
			// dispatch 방식으로 이동
			forward.setPath("ProductList.admin");
		}else {
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
