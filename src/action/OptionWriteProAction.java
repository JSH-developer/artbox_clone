package action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import svc.OptionWriteService;
import vo.ActionForward;
import vo.OptionBean;

public class OptionWriteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = new ActionForward();
		
		OptionWriteService optionWriteService = new OptionWriteService();
		String option_code = optionWriteService.makeOptionCode(request.getParameter("product_index"));
		
		OptionBean optionBean = new OptionBean();
		optionBean.setOption_code(option_code);
		optionBean.setOption_name(request.getParameter("option_name"));
		optionBean.setAdd_price(Integer.parseInt(request.getParameter("add_price")));
		
		boolean isRegist = optionWriteService.registOption(optionBean);
		
		if(isRegist) {
			forward.setPath("/OptionList.admin");
		}else {
			forward.setRedirect(true);
			forward.setPath("./home.admin");
		}
		
		return forward;
	}

}
