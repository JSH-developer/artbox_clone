package item.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import vo.ActionForward;

public class SelectBoxAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward fw = new ActionForward();
		fw.setPath("/item/itemList.jsp");
		String kwd = request.getParameter("select");
		String status = request.getParameter("status");
		
		System.out.println("kwd = "+kwd);
		System.out.println("status = "+status);
		
		if(status.equals("1")) {//대분류카테고리까지 선택 
			
		}if(status.equals("2")) {//소분류카테고리까지 선택 
			
		}if(status.equals("0")) {//검색함 
			
		}
		
		return fw;
	}

}
