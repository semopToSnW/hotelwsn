package hotel.dao;

import java.util.ArrayList;
import java.util.List;

import hotel.mybatis.MybatisConfig;
import hotel.vo.Company;
import hotel.vo.Connection;
import hotel.vo.DayRoom;
import hotel.vo.Image;
import hotel.vo.Message;
import hotel.vo.Product;
import hotel.vo.Rank;
import hotel.vo.Res_Group;
import hotel.vo.Reservation;
import hotel.vo.Room;
import hotel.vo.User;

import org.apache.ibatis.session.SqlSession;
import org.apache.log4j.Logger;

public class InsertDao {
	
	private SqlSession sql;
	private Logger log = Logger.getLogger(InsertDao.class);
	
	//고준호
	//기관정보 초기 등록
	//등록 : 04/30 미완성
	public void companyInsert(Company company){
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		int result = sql.insert("hotel.mybatis.insertMapper.insertCompany", company);
		log.info(result+"개 insert성공(companyInsert)");
		if(result==0){
			sql.rollback();
		}else{
			sql.commit();
		}
		sql.close();
	}
	
	//고준호
	//기관정보 초기 등록
	//등록 : 04/30 미완성
	public void userInsert(User user){
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		int result = sql.insert("hotel.mybatis.insertMapper.insertUser", user);
		log.info(result+"개 insert성공(userInsert)");
		if(result==0){
			sql.rollback();
		}else{
			sql.commit();
		}
		sql.close();
	}
	//고준호
	//기관제휴등록
	//등록 : 04/30 미완성
	public void insertConnection(Connection conncetion){
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		int result = sql.insert("hotel.mybatis.insertMapper.insertConnection", conncetion);
		log.info(result+"개 insert성공(insertConnection)");
		if(result==0){
			sql.rollback();
		}else{
			sql.commit();
		}
		sql.close();
	}
	public void insertRoom(ArrayList<Room> roomList) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();		
		int result=  sql.insert("hotel.mybatis.insertMapper.insertRoom", roomList);
		log.info(result+"개 insert성공(insertRoom)");
		if(result==0){
			sql.rollback();
		}else{
			sql.commit();
		}
		sql.commit();
		sql.close();		
	}

	public void insertRank(ArrayList<Rank> rankList) {
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		int result= sql.insert("hotel.mybatis.insertMapper.insertRank", rankList);
		log.info(result+"개 insert성공(insertRank)");
		if(result==0){
			sql.rollback();
		}else{
			sql.commit();
		}
		sql.commit();
		sql.close();
		
	}

	public void insertDayroom(ArrayList<DayRoom> dayroomList) {
		log.info("insertDayroom");
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		int result= sql.insert("hotel.mybatis.insertMapper.insertDayroom", dayroomList);
		log.info(result+"개 insert성공(insertDayroom)");
		if(result==0){
			sql.rollback();
		}else{
			sql.commit();
		}
		sql.commit();
		sql.close();
		
	}

	public Reservation insertReservation(Reservation reservation) {
		log.info(reservation);
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		int result =0;
		try{
			result = sql.insert("hotel.mybatis.insertMapper.insertReservation", reservation);
		}catch(Exception e){
			e.printStackTrace();
		}
		log.info(result+"개 insert성공(userInsert)");
		log.info(reservation);
		if(result==0){
			sql.rollback();
		}else{
			sql.commit();
		}
		sql.close();
		return reservation;
	}

	public void insertRes_group(ArrayList<Res_Group> res_groupList) {
		log.info("insertRes_group");
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		int result= sql.insert("hotel.mybatis.insertMapper.insertRes_group", res_groupList);
		log.info(result+"개 insert성공(insertRes_group)");
		log.info(res_groupList);
		if(result==0){
			sql.rollback();
		}else{
			sql.commit();
		}
		sql.commit();
		sql.close();
	}
	
	public Product insertProduct(Product product) {		
		System.out.println("dao"+product);		
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		int result = sql.insert("hotel.mybatis.insertMapper.insertProduct", product);
		log.info(result+ "개 insert성공(insertProduct)");
		log.info(product);
		sql.commit();	
		sql.close();
		return product;		
	}

	public void insertProductImage(ArrayList<Image> imageList) {
		log.info("image");
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		sql.insert("hotel.mybatis.insertMapper.insertImage", imageList);
		log.info(" insert성공(insertProductImage)");		
		sql.commit();
		sql.close();
	}

	public void insertstatus(int id) {
		log.info("insertstatus");
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		sql.insert("hotel.mybatis.insertMapper.insertstatus", id);
		log.info(" insert성공(insertstatus)");		
		sql.commit();
		sql.close();
	}

	public void sendMessage(Message message) {
		log.info("sendMessage");
		sql=MybatisConfig.getSqlSessionFactory().openSession();
		try{
			sql.insert("hotel.mybatis.insertMapper.sendMessage", message);
		}catch(Exception e){
			e.printStackTrace();
		}
		log.info("sendMessage 성공");
		sql.commit();
		sql.close();
	}
	
	
}
	
	
	
	
