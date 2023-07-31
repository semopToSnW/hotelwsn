package hotel.ajax;

import hotel.dao.SelectDao;
import hotel.vo.Reservation;
import hotel.vo.ReservationInfo;
import hotel.vo.ReservationInfo2;
import hotel.vo.User;

import java.util.ArrayList;
import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class TakeReservationInfoForMainAjax extends ActionSupport {

	Logger log= Logger.getLogger(TakeReservationInfoForMainAjax.class);
	
	private ArrayList<ReservationInfo2> reservationList;
	
	private SelectDao sdao = new SelectDao();
	private Map<String, Object> session = ActionContext.getContext().getSession();
	
	public String takeReservationInfoForMain(){
		log.info("takeReservationInfoForMainAjax");
		reservationList = (ArrayList<ReservationInfo2>) sdao.getReservationList(((User)(session.get("loginedUser"))).getCompany_id());
		log.info(reservationList);
		log.info(reservationList.size());
		return SUCCESS;
	}

	public ArrayList<ReservationInfo2> getReservationList() {
		return reservationList;
	}

	public void setReservationList(ArrayList<ReservationInfo2> reservationList) {
		this.reservationList = reservationList;
	}


	
}
