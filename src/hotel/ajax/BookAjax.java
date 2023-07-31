package hotel.ajax;

import hotel.dao.InsertDao;
import hotel.dao.SelectDao;
import hotel.vo.DayRoom;
import hotel.vo.Rank;
import hotel.vo.Res_Group;
import hotel.vo.Reservation;
import hotel.vo.ReservationInfo;
import hotel.vo.Room;
import hotel.vo.User;

import java.util.ArrayList;
import java.util.Map;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class BookAjax extends ActionSupport {
	
	private Logger log = Logger.getLogger(BookAjax.class);
	
	private ArrayList<DayRoom> dayRoomList;
	private ArrayList<Reservation> reservationList;
	private Reservation reservation;
	private Map<String, Object> session = ActionContext.getContext().getSession();
	private SelectDao sdao = new SelectDao();
	private InsertDao idao = new InsertDao();
	private Res_Group res_group = new Res_Group(); 
	private ArrayList<Res_Group> res_groupList = new ArrayList<Res_Group>();
	
	public String book()throws Exception{
		log.info(reservation);
		log.info("res_group리스트 : "+ res_groupList);
		log.info("res_group사이즈 : "+ res_groupList.size());
		reservation.setReg_person(((User)session.get("loginedUser")).getId());
		reservationList = new ArrayList<Reservation>();
		reservation = idao.insertReservation(reservation);
		idao.insertstatus(reservation.getId());
		
		log.info(reservation);
		for(Res_Group res : res_groupList){
			res.setReservation_id(reservation.getId());
		}
		log.info("res_group리스트(수정후) :" +res_groupList);
		idao.insertRes_group(res_groupList);
		return SUCCESS;
	}

	public ArrayList<DayRoom> getDayRoomList() {
		return dayRoomList;
	}

	public void setDayRoomList(ArrayList<DayRoom> dayRoomList) {
		this.dayRoomList = dayRoomList;
	}

	public ArrayList<Reservation> getReservationList() {
		return reservationList;
	}

	public void setReservationList(ArrayList<Reservation> reservationList) {
		this.reservationList = reservationList;
	}

	public Reservation getReservation() {
		return reservation;
	}

	public void setReservation(Reservation reservation) {
		this.reservation = reservation;
	}

	public Res_Group getRes_group() {
		return res_group;
	}

	public void setRes_group(Res_Group res_group) {
		this.res_group = res_group;
	}

	public ArrayList<Res_Group> getRes_groupList() {
		return res_groupList;
	}

	public void setRes_groupList(ArrayList<Res_Group> res_groupList) {
		this.res_groupList = res_groupList;
	}
	
}
