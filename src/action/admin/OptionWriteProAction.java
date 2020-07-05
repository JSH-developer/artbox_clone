package action.admin;

import java.io.PrintWriter;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.admin.OptionWriteService;
import svc.admin.ProductViewService;
import svc.admin.ProductWriteService;
import vo.ActionForward;
import vo.OptionBean;
import vo.ProductBean;

public class OptionWriteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 옵션 상품 등록 페이지
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
		
		OptionWriteService optionWriteService = new OptionWriteService();
		String option_code = optionWriteService.makeOptionCode(multi.getParameter("product_code_base"));
		// 옵션과 관련된 정보를 입력합니다.
		OptionBean optionBean = new OptionBean();
		optionBean.setOption_code(option_code);
		optionBean.setOption_name(multi.getParameter("option_name"));
		optionBean.setAdd_price(Integer.parseInt(multi.getParameter("add_price")));

		
		ProductWriteService productWriteService = new ProductWriteService();
		ProductBean productBean = new ProductBean(); //svc에 전달할 ProductBean 생성
		
		ProductViewService productViewService = new ProductViewService();
		ProductBean pb_base = productViewService.infoProduct(multi.getParameter("product_code_base")+"00");
		
		productBean.setProduct_code(multi.getParameter("product_code_base").substring(0, 4) + option_code);
		 
		productBean.setProduct_name(multi.getParameter("product_name"));
		Enumeration images = multi.getFileNames();
		productBean.setProduct_image2(multi.getFilesystemName((String) images.nextElement()));
		productBean.setProduct_image( multi.getFilesystemName((String) images.nextElement()) );
		productBean.setProduct_description(multi.getParameter("product_description"));
		productBean.setProduct_price(pb_base.getProduct_price());
		productBean.setProduct_brand(pb_base.getProduct_brand());
		productBean.setProduct_stock_count(Integer.parseInt(multi.getParameter("product_stock_count")));
		productBean.setProduct_sale_price(Integer.parseInt(multi.getParameter("product_sale_price")));
		productBean.setProduct_keywords(multi.getParameter("product_keywords"));
		productBean.setProduct_category_code(multi.getParameter("product_code_base").substring(0, 4));
		productBean.setProduct_option_code(option_code);
		
		
		boolean isRegist = optionWriteService.registOption(optionBean); //svc에서 옵션등록
		boolean isRegist2 = productWriteService.registProduct(productBean);// svc에서 상품등록
		
		if(isRegist && isRegist2) {
			forward.setPath("ProductList.admin");
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
