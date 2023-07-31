package hotel.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;

import hotel.mybatis.MybatisConfig;
import hotel.vo.Company;
import hotel.vo.User;

public class UpdateDao {
	
	private SqlSession sql;
	private Logger log = Logger.getLogger(InsertDao.class);
	
	public void updatePassword(User user) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		int result = sql.update("hotel.mybatis.updateMapper.updatePassword", user);
		if(result==0){
			sql.rollback();
		}else{
			sql.commit();
		}
		sql.close();
	}

	public void completeCompanySetting(String companyId) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		int result = sql.update("hotel.mybatis.updateMapper.completeCompanySetting", companyId);
		if(result==0){
			sql.rollback();
		}else{
			sql.commit();
		}
		sql.close();
	}
	
	
	public void updateSatus(String companyId) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		int result = sql.update("hotel.mybatis.updateMapper.updateSatus", companyId);
		if(result==0){
			sql.rollback();
		}else{
			sql.commit();
		}
		sql.close();
	}
	//재학
		//dayroom 에서 호텔의 판매 가능여부바꾸기
		public void onoffChangeHotel(String dayRoom_id, String onoff) {		
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			HashMap<String,String> map = new HashMap<String, String>();		
			map.put("dayRoom_id", dayRoom_id);
			map.put("onoff", onoff);
			int result = sql.insert("hotel.mybatis.updateMapper.onoffChangeHotel",map);		
			if(result==0){
				sql.rollback();
			}else{
				sql.commit();
			}
			sql.close();
			
		}
		//재학
		//dayroom 에서 여행사의 판매 가능여부바꾸기
		public void onoffChangeOTA(String dayRoom_id, String onoff) {		
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			HashMap<String,String> map = new HashMap<String, String>();		
			map.put("dayRoom_id", dayRoom_id);
			map.put("onoff", onoff);
			int result = sql.insert("hotel.mybatis.updateMapper.onoffChangeOTA",map);		
			if(result==0){
				sql.rollback();
			}else{
				sql.commit();
			}
			sql.close();
			
		}
		//재학
		//dayroom 에서 호텔의 수량 바꾸기
		public void AssignChangeHotel(String dayRoom_id, int assign) {
			sql=MybatisConfig.getSqlSessionFactory().openSession();		
			int sum = sql.selectOne("hotel.mybatis.selectMapper.sumAssignDayroom",dayRoom_id);
			int temp = 0;
			int tempOther = 0;
			if(sum >= assign){
				temp = assign;
				tempOther = sum - assign;
			}else{
				temp = sum;
			}		
			String changedAssgin = Integer.toString(temp);
			String otherAssgin = Integer.toString(tempOther);		
			HashMap<String,String> map = new HashMap<String, String>();		
			map.put("dayRoom_id", dayRoom_id);
			map.put("hotelAssign", changedAssgin);
			map.put("OTAAssgin", otherAssgin);
			int result = sql.insert("hotel.mybatis.updateMapper.AssignChange",map);	
			if(result==0){
				sql.rollback();
			}else{
				sql.commit();
			}
			sql.close();
			
		}
		
		//재학
		//dayroom 에서 여행사의 수량 바꾸기
		public void AssignChangeOTA(String dayRoom_id, int assign) {
			sql=MybatisConfig.getSqlSessionFactory().openSession();		
			int sum = sql.selectOne("hotel.mybatis.selectMapper.sumAssignDayroom",dayRoom_id);
			int temp = 0;
			int tempOther = 0;
			if(sum >= assign){
				temp = assign;
				tempOther = sum - assign;
			}else{
				temp = sum;
			}		
			String changedAssgin = Integer.toString(temp);
			String otherAssgin = Integer.toString(tempOther);		
			HashMap<String,String> map = new HashMap<String, String>();		
			map.put("dayRoom_id", dayRoom_id);
			map.put("hotelAssign", otherAssgin);
			map.put("OTAAssgin", changedAssgin);
			int result = sql.insert("hotel.mybatis.updateMapper.AssignChange",map);	
			if(result==0){
				sql.rollback();
			}else{
				sql.commit();
			}
			sql.close();
			
			
		}

		public void updateMyPage(Map<String, Object> updateSource) {
			log.info("왔다여기는 updateDao"+updateSource.get("companyId"));
			log.info("왔다여기는 updateDao"+updateSource.get("type"));
			log.info("왔다여기는 updateDao"+updateSource.get("rankType"));
			log.info("왔다여기는 updateDao"+updateSource.get("price"));
			log.info("왔다여기는 updateDao"+updateSource.get("year"));
			log.info("왔다여기는 updateDao"+updateSource.get("month"));
			log.info("왔다여기는 updateDao"+updateSource.get("dayOfMonth"));
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			int result = sql.update("hotel.mybatis.updateMapper.updateMyPage", updateSource);
			log.info("여기오시니222");
			if(result==0){
				sql.rollback();
				log.info("실패");
			}else{
				sql.commit();
				log.info("성공");
			}
			sql.close();
		}
		
		//김명희 랭크 선택하면 그에 해당하는 요금,랭크수정
		public void modifyPriceAndRank(Map<String, Object> updateSource) {
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			int result = sql.update("hotel.mybatis.updateMapper.modifyPriceAndRank",updateSource);
			if(result==0){
				sql.rollback();
				log.info("업뎃실패");
			}else{
				sql.commit();
				log.info("업뎃성공");
			}
			sql.close();
		}
		//김명희 요금 수정
		public void changePrice(Map<String, Object> updateSource) {
			sql=MybatisConfig.getSqlSessionFactory().openSession();
			int result=0;
			try{
				result = sql.update("hotel.mybatis.updateMapper.changePrice",updateSource);
			}catch(Exception e){
				e.printStackTrace();
			}
			if(result==0){
				sql.rollback();
				log.info("업뎃실패");
			}else{
				sql.commit();
				log.info("업뎃성공");
			}
			sql.close();
		}
}
