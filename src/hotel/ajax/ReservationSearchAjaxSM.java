package hotel.ajax;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;

import hotel.common.Paging;
import hotel.dao.SelectDao;
import hotel.vo.Reservation;
import hotel.vo.User;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class ReservationSearchAjaxSM extends ActionSupport {

	private Logger log = Logger.getLogger(ReservationSearchAjaxSM.class);
	private String checkinDateSelect;
	private ArrayList<Reservation> reservationList;
	private String personSelect;
	private String selectedDate;
	private int totalPage;
	private Paging paging = new Paging();
	//dao
	private SelectDao sdao = new SelectDao();
	private Map<String, Object> session = ActionContext.getContext().getSession();
	
//싱미 / 0510(일 am1:00) 예약데이터된 데이터 출력
	public String reservationSearch(){
		
	return SUCCESS;
	}

//싱미 / 사용자정의 No:ho-fro-051/0511(월 am11:00) 방예약된 검색합니다.   //
/*	public String reservationSeachButton(){
	  log.info(aaa);
	  log.info("ajax/예약된 내역 검색");
	  log.info(((User)session.get("loginedUser")).getCompany_id());
	  //여기까지 콘솔창에 안뜨다가. 
	  reservation=(Reservation) sdao.reservedDateSearch(regDate);
	  log.info("ㅇ");
	  return SUCCESS;	
	}*/
//싱미 / 사용자정의 No:ho-fro-051 날짜로 검색합니다.
	public String checkinCheckoutSearch()throws Exception{
		log.info(checkinDateSelect);
		Map<String, Object> source = new HashMap<String, Object>();
		source.put("companyId", ((User)session.get("loginedUser")).getCompany_id());
		source.put("pageAmount", paging.getPageAmount());
		totalPage = sdao.getTotalPage(source);
		source= paging.getRange(((User)session.get("loginedUser")).getCompany_id());
		if(checkinDateSelect.equals("regDateoption")){
			source.put("regDate", selectedDate);
		}
		else if(checkinDateSelect.equals("checkinDate")){
			source.put("checkin", selectedDate);
			
		}else if(checkinDateSelect.equals("checkoutDate")){
			source.put("checkout", selectedDate);
		}
		log.info(source);
		reservationList =(ArrayList<Reservation>) sdao.getReservation(source);
		log.info(reservationList);
		log.info("reservationList 사이즈"+reservationList.size());
		Calendar cal = Calendar.getInstance();
		for(Reservation res : reservationList){
			String date =res.getCheckin();
			SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyy.M.d" );
			Calendar cal2 = Calendar.getInstance();
			cal2.setTime(dateFormat.parse(res.getCheckin()));
			int result = cal.compareTo(cal2);
			
		}
		session.put("reservationList", reservationList);
		return SUCCESS;
	}
	
	
	
	
//------------------------------사람검색-------------------------------------------	
	public String personReservationSearch(){		
		log.info("사람검색 에이젝스 입구" + personSelect);
		//셀렉트가  예약담당자일 경우 
		if(personSelect.equals("registerPerson")){
			
		}
		//셀렉트가 예약손님인경우  
		else if(personSelect.equals("resPerson")){
		}	
		//셀렉트가 숙박손님인 경우 stayP
		else if(personSelect.equals("stayP")){
		
		}
		return SUCCESS;
	}

	public String getCheckinDateSelect() {
		return checkinDateSelect;
	}

	public void setCheckinDateSelect(String checkinDateSelect) {
		this.checkinDateSelect = checkinDateSelect;
	}

	public ArrayList<Reservation> getReservationList() {
		return reservationList;
	}

	public void setReservationList(ArrayList<Reservation> reservationList) {
		this.reservationList = reservationList;
	}

	public String getPersonSelect() {
		return personSelect;
	}

	public void setPersonSelect(String personSelect) {
		this.personSelect = personSelect;
	}

	public String getSelectedDate() {
		return selectedDate;
	}

	public void setSelectedDate(String selectedDate) {
		this.selectedDate = selectedDate;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public Paging getPaging() {
		return paging;
	}

	public void setPaging(Paging paging) {
		this.paging = paging;
	}
	
}

