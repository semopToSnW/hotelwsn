package hotel.ajax;

import hotel.action.MemberAction;
import hotel.dao.InsertDao;
import hotel.dao.SelectDao;
import hotel.dao.UpdateDao;
import hotel.vo.Company;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionSupport;

public class SearchCompanyAjax extends ActionSupport{

	private Logger log = Logger.getLogger(SearchCompanyAjax.class);
	private Company company;
	private ArrayList<Company> companyList;
	private String type;
	private String companyId;
	private SelectDao sdao = new SelectDao();
	private InsertDao idao = new InsertDao();
	private UpdateDao udao = new UpdateDao();
	
	//고준호
		//회사검색 후 조인하기 위한 검색 메서드 name으로 검색
		//등록 : 5/1  UI-011
		public String searchCompany(){
			log.info(type);
			Map<String, String> searchSource = new HashMap<String, String>();
			searchSource.put("name", "%"+company.getName()+"%");
			searchSource.put("type", type+"%");
			companyList= (ArrayList<Company>) sdao.searchCompany(searchSource);
			log.info(companyList);
			return SUCCESS;
		}
		
		//고준호
		//회사id로 회사를 검색함
		//등록 : 5/1 UI-011
		public String searchCompanyById(){
			company= sdao.searchCompanyById(companyId);
			log.info(company);
			return SUCCESS;
		}

		public Company getCompany() {
			return company;
		}

		public void setCompany(Company company) {
			this.company = company;
		}

		public ArrayList<Company> getCompanyList() {
			return companyList;
		}

		public void setCompanyList(ArrayList<Company> companyList) {
			this.companyList = companyList;
		}

		public String getType() {
			return type;
		}

		public void setType(String type) {
			this.type = type;
		}

		public String getCompanyId() {
			return companyId;
		}

		public void setCompanyId(String companyId) {
			this.companyId = companyId;
		}
}
