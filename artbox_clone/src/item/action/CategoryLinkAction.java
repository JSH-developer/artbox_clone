package item.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import action.Action;
import item.svc.CategoryMajorLinkSVC;
import item.svc.CategoryMinorLinkSVC;
import vo.ActionForward;
import vo.MajorCategory;
import vo.PrintCategory;
import vo.ProductBean;

public class CategoryLinkAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward actionForward = new ActionForward();
		HttpSession session = request.getSession();
		String majorCategory = request.getParameter("major");
		String minorCategory = request.getParameter("minor");
		ArrayList<ProductBean> productBean = new ArrayList<ProductBean>();
		int count = 0;
		PrintCategory print = new PrintCategory();
		String[] printCategory = null;
		if(minorCategory==null) {
			//대분류 파라미터 검증 
			if(majorCategory.equals(MajorCategory.디지털가전.getCode())) {
				majorCategory=MajorCategory.디지털가전.getCode();
				printCategory = print.디지털가전();
				session.setAttribute("code", MajorCategory.디지털가전.getCode().toString());
			}
			if(majorCategory.equals(MajorCategory.리빙데코.getCode())) {
				majorCategory=MajorCategory.리빙데코.getCode();
				printCategory = print.리빙데코();
				session.setAttribute("code", MajorCategory.리빙데코.getCode().toString());
			}
			if(majorCategory.equals(MajorCategory.문구.getCode())) {
				majorCategory=MajorCategory.문구.getCode();
				printCategory = print.문구();
				session.setAttribute("code", MajorCategory.문구.getCode().toString());
			}
			if(majorCategory.equals(MajorCategory.여행.getCode())) {
				majorCategory=MajorCategory.여행.getCode();
				printCategory = print.여행();
				session.setAttribute("code", MajorCategory.여행.getCode().toString());
			}
			if(majorCategory.equals(MajorCategory.뷰티.getCode())) {
				majorCategory=MajorCategory.뷰티.getCode();
				printCategory = print.뷰티();
				session.setAttribute("code", MajorCategory.뷰티.getCode().toString());
			}
			if(majorCategory.equals(MajorCategory.인형토이.getCode())) {
				majorCategory=MajorCategory.인형토이.getCode();
				printCategory = print.인형토이();
				session.setAttribute("code", MajorCategory.인형토이.getCode().toString());
			}
			if(majorCategory.equals(MajorCategory.주방욕실.getCode())) {
				majorCategory=MajorCategory.주방욕실.getCode();
				printCategory = print.주방욕실();
				session.setAttribute("code", MajorCategory.주방욕실.getCode().toString());
			}
			if(majorCategory.equals(MajorCategory.패션.getCode())) {
				majorCategory=MajorCategory.패션.getCode();
				printCategory = print.패션();
				session.setAttribute("code", MajorCategory.패션.getCode().toString());
			}
			session.setAttribute("printCategory", printCategory);
			
			
			//대분류 파라미터에 해당하는 상품목록 불러오기 
			CategoryMajorLinkSVC majorLinkSVC = new CategoryMajorLinkSVC();
			productBean = majorLinkSVC.linkSVC(majorCategory);
			count = productBean.size();
			request.setAttribute("productBean", productBean);
			request.setAttribute("count", count);
			
		}else {
			//소분류 파라미터에 해당하는 상품목록 불러오기 
			CategoryMinorLinkSVC minorLinkSVC = new CategoryMinorLinkSVC();
			productBean = minorLinkSVC.minorLinkSVC(minorCategory);
			count = productBean.size();
			request.setAttribute("productBean", productBean);
			request.setAttribute("count", count);
		}
		
		
		
		actionForward.setPath("/item/itemList.jsp");
		return actionForward;
	}
	

}
