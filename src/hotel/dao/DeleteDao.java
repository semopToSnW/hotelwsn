package hotel.dao;

import java.util.ArrayList;
import java.util.Map;

import hotel.mybatis.MybatisConfig;
import hotel.vo.Room;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;


public class DeleteDao {

	private SqlSession sql;
	private Logger log = Logger.getLogger(DeleteDao.class);
	
	public void deleteRoom(String hotelId) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();		
		log.info("deleteRoomDao");
		int result = sql.delete("hotel.mybatis.deleteMapper.deleteRoom", hotelId);
		log.info(result);
		if(result==0){
			sql.rollback();
		}else{
			sql.commit();
		}
		sql.commit();
		sql.close();	
		
	}

	public void deleteRank(ArrayList<Room> roomList) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();		
		log.info("deleteRankDao");
		int result =sql.delete("hotel.mybatis.deleteMapper.deleteRank", roomList);
		log.info(result+"개 삭제 ");
		if(result==0){
			sql.rollback();
		}else{
			sql.commit();
		}
		sql.close();
	}

	public void deleteDayroom(Map<String, Object> source) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();		
		log.info("deleteDayRoomDao");
		int result =sql.delete("hotel.mybatis.deleteMapper.deleteDayroom", source);
		log.info(result+"개 삭제 deleteDayRoomDao");
		if(result==0){
			sql.rollback();
		}else{
			sql.commit();
		}
		sql.close();
		
	}

}
