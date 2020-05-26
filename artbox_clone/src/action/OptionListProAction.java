package action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.OptionListService;
import vo.ActionForward;
import vo.OptionBean;

public class OptionListProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		OptionListService optionListService = new OptionListService();
		ArrayList<OptionBean> optionList =optionListService.getOptionList();
		
		request.setAttribute("optionList", optionList);
		
		forward.setPath("/admin/listOption.jsp");
		
		return forward;
	}

}
