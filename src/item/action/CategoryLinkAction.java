package item.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.admin.Action;
import item.svc.CategoryMajorCountSVC;
import item.svc.CategoryMajorLinkSVC;
import item.svc.CategoryMinorCountSVC;
import item.svc.CategoryMinorLinkSVC;
import vo.ActionForward;
import vo.ProductBean;

public class CategoryLinkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward actionForward = new ActionForward();
		String majorCategory = request.getParameter("major");
		String minorCategory = request.getParameter("minor");
		ArrayList<ProductBean> productBean = new ArrayList<ProductBean>();
		int count = 0;
		
		if(minorCategory==null) {
			//대분류 파라미터 검증 
			if(majorCategory.equals("DT"))majorCategory="DT";
			if(majorCategory.equals("FA"))majorCategory="FA";
			if(majorCategory.equals("FS"))majorCategory="FS";
			if(majorCategory.equals("KB"))majorCategory="KB";
			if(majorCategory.equals("LD"))majorCategory="LD";
			if(majorCategory.equals("DI"))majorCategory="DI";
			if(majorCategory.equals("TR"))majorCategory="TR";
			if(majorCategory.equals("BE"))majorCategory="BE";
			
			System.out.println("major : "+majorCategory);
			//대분류 파라미터에 해당하는 상품목록 불러오기 
			CategoryMajorLinkSVC majorLinkSVC = new CategoryMajorLinkSVC();
			CategoryMajorCountSVC majorCountSVC = new CategoryMajorCountSVC();
			count = majorCountSVC.getCount(majorCategory);
			productBean = majorLinkSVC.linkSVC(majorCategory);
			request.removeAttribute("productBean");
			request.setAttribute("productBean", productBean);
			request.removeAttribute("count");
			request.setAttribute("count", count);
			System.out.println(productBean);
			for(ProductBean b : productBean) {
				System.out.println(b.getProduct_image());
			}
			
		}else {
			//소분류 파라미터에 해당하는 상품목록 불러오기 
			CategoryMinorLinkSVC minorLinkSVC = new CategoryMinorLinkSVC();
			productBean = minorLinkSVC.minorLinkSVC(minorCategory);
			CategoryMinorCountSVC minorCountSVC = new CategoryMinorCountSVC();
			count = minorCountSVC.getCount(minorCategory);
			request.removeAttribute("productBean");
			request.setAttribute("productBean", productBean);
			request.removeAttribute("count");
			request.setAttribute("count", count);
		}
		
		actionForward.setPath("/item/itemList.jsp");
		return actionForward;
	}
	

}
