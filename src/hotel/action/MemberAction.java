package hotel.action;

import java.net.Socket;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import hotel.client.ClientSocket;
import hotel.dao.InsertDao;
import hotel.dao.SelectDao;
import hotel.dao.UpdateDao;
import hotel.vo.Company;
import hotel.vo.Connection;
import hotel.vo.DayRoom;
import hotel.vo.Rank;
import hotel.vo.Room;
import hotel.vo.User;
import hotel.vo.User.User_signal;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class MemberAction extends ActionSupport{
	
	private Logger log = Logger.getLogger(MemberAction.class);
	private SelectDao sdao = new SelectDao();
	private InsertDao idao = new InsertDao();
	private UpdateDao udao = new UpdateDao();
	//세션
	private Map<String, Object> session = ActionContext.getContext().getSession();
	//VO
	private User user;
	private Company company;
	private ArrayList<Company> companyList;
	private String type;
	private String message;
	private ArrayList<Rank> rankList;
	private ArrayList<Room> roomList;
	private ArrayList<DayRoom> dayroomList;
	private int roomListSize;
	
	//변수
	private String companyId;
	
	public String login(){
		User tempUser = sdao.getMember(user.getId());
		log.info(type);
		log.info(user);
		log.info(tempUser);
		if((!isHotel() && !user.getId().substring(0,2).equals(type)) || tempUser==null || !tempUser.getPw().equals(user.getPw())){
			//아이디가 없거나 비밀번호 틀림 
			message="아이디 또는 비밀번호를 확인하세요.";
			return "error";
		}else{
			//비밀번호 확인
			tempUser.setPw(null);
			session.put("loginedUser", tempUser);
			if(tempUser.getCompany_id()!=null){
			Company com =sdao.selectCompany(tempUser.getCompany_id());
			session.put("company", com);
			log.info(com);
			}
		}
		
		if(type.equals("HO")){
			//호텔정보가 있는지 확인
			log.info(tempUser.getCompany_id());		
			udao.updateSatus(tempUser.getCompany_id());
			roomList = (ArrayList<Room>) sdao.getCheckroom(tempUser.getCompany_id());	
			roomListSize=roomList.size();
			Company com =sdao.selectCompany(tempUser.getCompany_id());
			log.info(com);
			session.put("company", com);
			if(roomList==null || roomList.isEmpty()){
				log.info(roomList);			
				log.info("입력된 정보가 없음 noinfo로 이동");		
				return "NoInfo";	
			}
			
			rankList = (ArrayList<Rank>) sdao.getCheckrank(roomList.get(0).getId());			
			if(rankList==null ||rankList.isEmpty()){
				log.info(rankList);			
				log.info("입력된 랭크정보가 없음 secondStep로 이동");		
				return "secondStep";
			}
			
			dayroomList = (ArrayList<DayRoom>) sdao.getCheckdayroom(roomList.get(0).getId());
			Company company = sdao.selectCompany(tempUser.getCompany_id());
			if(dayroomList==null || dayroomList.isEmpty()){
				log.info(dayroomList);			
				log.info("입력된 dayroom정보가 없음 finalStep로 이동");		
				return "finalStep";
			}else if(dayroomList!=null && company.getInfocompleted().equalsIgnoreCase("false")){
				log.info(dayroomList);			
				log.info("dayroom완료안됨 finalStep로 이동");	
				message="아직 설정이 완료되지 않았습니다. [완료하기] 버튼을 누르세요";
				return "finalStep";
			}
			
		}
		return type; 
	}
	///ajax에러 테스트  결론: sturts 왜 다른 메서드들은 private으로 설정하시오//
	/*public int ishetl4(){user.getId(); return 1;}*/
	/*public String ishotel3(){user.getId();return "ddd";}*/ //됨
	/*public void ishotel2(){user.getId();}*/ //됨
	/*public boolean ishotel3(){
		user.getId();
		return true;}*/ //안됨
	/*public boolean ishotel3(){}*/ //됨
	
	
	private boolean isHotel(){
		boolean isHotel=false;
		if((user.getId().substring(0,2).equals("HM") || 
				user.getId().substring(0,2).equals("HS")) && 
				type.equals("HO")) isHotel= true;
		return isHotel;
	}
	
	//고준호
	//각종 id생성 페이지를 가기전에 가지고 가야할 정보를 가지고 옴
	//등록 : 4/30 완성
	public String goInsertPage(){
		log.info(type);
		if(type.equals("asp")){
			String number = Integer.toString(sdao.getUserNumber("AM%"));
			user=new User();
			user.setId(generateId("AM", number));
		}else if(type.equals("hotel")){
			//호텔일때 여행사 리스트를 가지고 옴
			companyList = (ArrayList<Company>) sdao.selectAllTour();
			log.info(companyList);
		}
		return type;
	}
	
	
	//고준호
	//회사ID발급시 이미 있는 회사인지 검색한후 join
	//등록: 4/30 14:03 완성
	public String join(){
		log.info(type);
		log.info(user);
		log.info(company);
		String userNum =null;
		String companyNum = null;
		//ASP 관리자 ID 등록
		if(type.equals("asp")){
			idao.userInsert(user);
		//여행사 ID 생성 및 등록 EMAIL 전송(명희야 부탁해)
		}else if(type.equals("tour")){
			if(company.getId()!=null){
				//여행사가 이미 등록된 경우 만들고자 하는 아이디에 해당 회사 ID(FOREIGN KEY)를 셋팅
				user.setCompany_id(company.getId());
			}else{
				/*여행사 등록이 안돼있을경우 여행사 등록을 먼저 한후 만들고자 하는 아이디에 해당
				 * 회사ID(FOREIGN KEY를 셋팅)
				 * */
				companyNum = Integer.toString(sdao.getCompanyNumber("TC%"));
				company.setId(generateId("TC", companyNum));
				idao.companyInsert(company);
				user.setCompany_id(company.getId());
			}
			userNum = Integer.toString(sdao.getUserNumber("TM%"));
			user.setId(generateId("TM", userNum));
			//id생성
			idao.userInsert(user);
			
			sendEmail(user);
		//호텔 ID 생성 및 등록  EMAIL 전송(명희야 부탁해)
		}else if(type.equals("hotel")){
		if(company.getId()!=null){
				//호텔이 이미 등록된 경우 만들고자 하는 아이디에 해당 회사 ID(FOREIGN KEY)를 셋팅
				user.setCompany_id(company.getId());
			}else{
				/*호텔이 등록이 안돼있을경우 호텔 등록을 먼저 한후 만들고자 하는 아이디에 해당
				 회사ID(FOREIGN KEY를 셋팅)
				 */
				companyNum = Integer.toString(sdao.getCompanyNumber("HC%"));
				company.setId(generateId("HC", companyNum));
				//세팅한 제휴회사 리스트 생성 Connection 테이블에 insert
				ArrayList<String> companyIdList = new ArrayList<String>();
				for(Company company : companyList){
					companyIdList.add(company.getId());
				}
				Connection conncetion = new Connection(company.getId(), companyIdList);
				idao.companyInsert(company);
				idao.insertConnection(conncetion);
				user.setCompany_id(company.getId());
			}
			if(user.getLevel().equals("HM")){
				userNum = Integer.toString(sdao.getUserNumber("HM%"));
				user.setId(generateId("HM", userNum));
			}else if(user.getLevel().equals("HS")){
				userNum = Integer.toString(sdao.getUserNumber("HS%"));
				user.setId(generateId("HS", userNum));
			}
			log.info(companyList);
			log.info(user);
			//id등록
			idao.userInsert(user);
			
			sendEmail(user);
		}
		return SUCCESS;
	}
	
	//고준호
	//패스워드생성
	//등록 : 05/01 UI-014
	public String createPassword(){
		User tempUser = sdao.getMember(user.getId());
		if(tempUser==null){
			message="아이디를 올바르게 입력하지 않았거나. 유효하지 않습니다.";
			return ERROR;
		}else{
			message = "비밀번호가 생성되었습니다.";
			udao.updatePassword(user);
		}
		return SUCCESS;
	}
	
	//고준호
	//검색폼으로
	//등록 : 05/01 
	public String showSearchForm(){
		return SUCCESS;
	}
	
	
	//나중에 쪽지기능 만들때 쓸거
	/*	public Object loginCheckFromSocketServer(Object o){
		ClientSocket client = new ClientSocket();
		Object o2 =null;
		client.send(o);
		o2 =client.take();
		client.close();
		return o2;
	}*/
	
	//고준호
	//아이디의 마지막 번호로 해당 기관의 아이디를 생성하여 리턴하는 메서드
	//등록 : 4/30 완성
	public String generateId(String type, String num){
		StringBuffer temp = new StringBuffer(type);
		while(temp.length()+num.length()!=7){
			temp.append("0");
		}
		temp.append(num);
		return temp.toString();
	}
	
	//김명희
		//email인증을 위해 id와 url을 보냅니다.
		//등록 : 5/01 완성
		public void sendEmail(User user){
				
			  String  from  = "semop92"; 
			  String password = "tmdskal82" ;
			  String to =  (sdao.searchCompanyById(user.getCompany_id())).getEmail(); 
			  String subject = "메일인증" ; 
			
			Properties properties =  new  Properties (); 
			
			  properties . put ( "mail.smtp.host" ,  "smtp.gmail.com" ); 
		      properties . put ( "mail.smtp.socketFactory.port" ,  "465" ); 
		      properties . put ( "mail.smtp.socketFactory.class" , "javax.net.ssl.SSLSocketFactory" ); 
		      properties . put ( "mail.smtp.auth" ,  "true" ); 
		      properties . put ( "mail.smtp.port" ,  "465" ); 
			
		      Session session =  Session . getDefaultInstance ( properties ,   
		              new javax . mail . Authenticator ()  { 
		              protected  PasswordAuthentication  
		              getPasswordAuthentication ()  { 
		              return  new  
		              PasswordAuthentication ( from , password ); 
		              }});   

		         Message message =  new  MimeMessage ( session ); 
		         
		         try {
		        	 message . setFrom ( new  InternetAddress ( from )); 
			         message . setRecipients ( Message . RecipientType . TO ,  
			            InternetAddress . parse ( to )); 
			         // 제목 설정
			         message . setSubject ( subject ); 
			         
			         String htmlBody = "<div style='border: 1px dashed #BDBDBD; width: 500px; float:center; text-align:center;'>" 
			        		   +"<p style='background-color:orange;'>가입을 환영합니다.</p>"
			        		   +"<p>고객님의 아이디는 "+user.getId()+"입니다.</p>"
			        		   +"<p><a href='http://localhost:9090/Hotel/member/goPasswordForm'>이 링크를 클릭해서 가입인증 절차를 진행하여 주십시오</a></p>"
				        	 +"</div>";
			       
			         
			         message.setContent(htmlBody,"text/html; charset=UTF-8");

			         
			         Transport . send ( message ); 
			         
				} catch (Exception e) {}
		         
	  
		}
	
	
	
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
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
	public String getCompanyId() {
		return companyId;
	}
	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	public ArrayList<Rank> getRankList() {
		return rankList;
	}

	public void setRankList(ArrayList<Rank> rankList) {
		this.rankList = rankList;
	}

	public ArrayList<Room> getRoomList() {
		return roomList;
	}

	public void setRoomList(ArrayList<Room> roomList) {
		this.roomList = roomList;
	}

	public ArrayList<DayRoom> getDayroomList() {
		return dayroomList;
	}

	public void setDayroomList(ArrayList<DayRoom> dayroomList) {
		this.dayroomList = dayroomList;
	}

	public int getRoomListSize() {
		return roomListSize;
	}

	public void setRoomListSize(int roomListSize) {
		this.roomListSize = roomListSize;
	}
	
}
