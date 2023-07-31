package hotel.ajax;

import hotel.dao.InsertDao;
import hotel.dao.SelectDao;
import hotel.dao.UpdateDao;
import hotel.vo.Image;
import hotel.vo.Product;
import hotel.vo.Reservation;

import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Toolkit;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.swing.text.PlainDocument;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;

import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFCellUtil;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellReference;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ReservationListExcel extends ActionSupport implements Preparable {		
	
	private Logger log = Logger.getLogger(UpdateProductAjax.class);
	
	private ArrayList<Reservation> reservationList;
		
	private String filename;
	private byte[] dataBuffer = null;
	private String contentDisposition;	
	private InputStream inputStream;
	private FileOutputStream outputStream;
	private long contentLength;			
	
	private SelectDao sdao = new SelectDao();
	private java.awt.Image test;	
	private Map<String, Object> session = ActionContext.getContext().getSession();
	
	public String downExcel() throws Exception{
		   log.info("downExcel test");
		   reservationList = (ArrayList<Reservation>) session.get("reservationList");
		   log.info(reservationList);
		   int listlenght = reservationList.size();		   	    
	       XSSFWorkbook  book  = new XSSFWorkbook();	       
	       XSSFCellStyle style_odd = book.createCellStyle();
	       setCellColorStyle(style_odd,0xFAFFFF);
	       style_odd.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
	       XSSFCellStyle style_evn = book.createCellStyle();
	       setCellColorStyle(style_evn,0xC3D0D8);
	       style_evn.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
	       XSSFCellStyle style_3 = book.createCellStyle();
	       setCellColorStyle(style_3,0xE5F5FF);
	       
	       CellStyle styleB = book.createCellStyle();	       
	       styleB.setFillBackgroundColor(IndexedColors.BLACK.getIndex());
	       	
	       XSSFCellStyle styleF3 = book.createCellStyle();	       
	       XSSFFont font3 = book.createFont();   
	       setCellColorStyle(styleF3,0x0B0C0C);
	       font3.setColor(HSSFColor.WHITE.index);
	       font3.setFontHeightInPoints((short)24); 
	       styleF3.setFont(font3);
	       
	       XSSFCellStyle styleF = book.createCellStyle();	       
	       XSSFFont font = book.createFont(); 	      
	       font.setColor(HSSFColor.BLACK.index);
	       styleF.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	       styleF.setFont(font); 
	       
	       XSSFCellStyle styleF2 = book.createCellStyle();	       
	       XSSFFont font2 = book.createFont();   
	       setCellColorStyle(styleF2,0x0B0C0C);
	       font2.setColor(HSSFColor.WHITE.index);	       
	       styleF2.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
	       styleF2.setFont(font2);
	       
	       XSSFSheet sheet= book.createSheet("List-"+1); //첫번째 시트	 
	       
	       sheet.addMergedRegion(new CellRangeAddress(0, 0, 1, 12));
	       sheet.setColumnWidth((short)0, (short)500);
	       for (int i = 1; i < 12; i++) {
	    	   sheet.setColumnWidth((short)i, (short)2600);
	       }
	       sheet.setColumnWidth((short)2, (short)1400);
	       sheet.setColumnWidth((short)2, (short)4400);
	       sheet.setColumnWidth((short)3, (short)4400);
	       sheet.setColumnWidth((short)5, (short)4400);	 	       
	       sheet.setColumnWidth((short)10, (short)3800);
	       sheet.setColumnWidth((short)12, (short)3200);
	       
	       XSSFRow row0= sheet.createRow(0);
	       row0.setHeightInPoints(30);	 	       
	       
	       XSSFCell cell0= row0.createCell(1,Cell.CELL_TYPE_STRING);		   
		   cell0.setCellValue("ReservationList");		   	       
	       cell0.setCellStyle(styleF3);          
	       
	       XSSFRow row1= sheet.createRow(1);
	       XSSFCell cell18= row1.createCell(1,Cell.CELL_TYPE_STRING);		   
		   cell18.setCellValue("Channel Management System");
		   
	       XSSFCell cell19= row1.createCell(11,Cell.CELL_TYPE_STRING);		   
		   cell19.setCellValue("출력일자");
	       
	       XSSFCell cell20= row1.createCell(12,Cell.CELL_TYPE_STRING);
	       XSSFDataFormat xssformat = book.createDataFormat();
	       CellStyle styleD = book.createCellStyle();	       
	       styleD.setDataFormat(xssformat.getFormat("yyyy/mm/dd")); 
	       cell20.setCellStyle(styleD);	      
	       cell20.setCellValue(new Date());	       
	      	       
	       for(int s=0;s<1;++s){ // 컬럼명
		    XSSFRow row= sheet.createRow(2);
		    XSSFCell cell= row.createCell(s+1,Cell.CELL_TYPE_STRING);
		    cell.setCellValue("예약번호");		  	    	    
		    cell.setCellStyle(styleF2); 
		    XSSFCell cell2= row.createCell(s+2,Cell.CELL_TYPE_STRING);
		    cell2.setCellStyle(style_evn);
		    cell2.setCellValue("체크인");
		    cell2.setCellStyle(styleF2); 
		    XSSFCell cell3= row.createCell(s+3,Cell.CELL_TYPE_STRING);
		    cell3.setCellStyle(style_evn);
		    cell3.setCellValue("체크아웃");
		    cell3.setCellStyle(styleF2);  
		    XSSFCell cell4= row.createCell(s+4,Cell.CELL_TYPE_STRING);
		    cell4.setCellStyle(style_evn);
		    cell4.setCellStyle(styleF2);  
		    cell4.setCellValue("숙박인원수");
		    XSSFCell cell5= row.createCell(s+5,Cell.CELL_TYPE_STRING);
		    cell5.setCellStyle(style_evn);
		    cell5.setCellStyle(styleF2);  
		    cell5.setCellValue("숙박자");
		    XSSFCell cell6= row.createCell(s+6,Cell.CELL_TYPE_STRING);
		    cell6.setCellStyle(style_evn);
		    cell6.setCellStyle(styleF2);  
		    cell6.setCellValue("예약자");
		    XSSFCell cell7= row.createCell(s+7,Cell.CELL_TYPE_STRING);
		    cell7.setCellStyle(style_evn);
		    cell7.setCellStyle(styleF2);  
		    cell7.setCellValue("국가");
		    XSSFCell cell8= row.createCell(s+8,Cell.CELL_TYPE_STRING);
		    cell8.setCellStyle(style_evn);
		    cell8.setCellStyle(styleF2);  
		    cell8.setCellValue("등록");
		    XSSFCell cell9= row.createCell(s+9,Cell.CELL_TYPE_STRING);
		    cell9.setCellStyle(style_evn);
		    cell9.setCellStyle(styleF2);  
		    cell9.setCellValue("수정");
		    XSSFCell cell10= row.createCell(s+10,Cell.CELL_TYPE_STRING);
		    cell10.setCellStyle(style_evn);
		    cell10.setCellStyle(styleF2);  
		    cell10.setCellValue("등록일");
		    XSSFCell cell11= row.createCell(s+11,Cell.CELL_TYPE_STRING);
		    cell11.setCellStyle(style_evn);
		    cell11.setCellStyle(styleF2);  
		    cell11.setCellValue("갱신일");
		    
		    
		   }
	       
	       for(int r=0;r<listlenght;++r){ //내용
	        	 XSSFRow row= sheet.createRow(r+3);
	        	 XSSFCellStyle style= row.getRowStyle();	        	 
	           	        	 
		        for(int c=1;c<2;++c){	        	
		            
		        	XSSFCell cell= row.createCell(c,Cell.CELL_TYPE_STRING);
		            cell.setCellValue(reservationList.get(r).getId());
		            cell.setCellStyle(r%2==0?style_odd:style_evn);
		            
		            XSSFCell cell2= row.createCell(c+1,Cell.CELL_TYPE_STRING);
		            cell2.setCellValue(reservationList.get(r).getCheckin());
		            cell2.setCellStyle(r%2==0?style_odd:style_evn);
		            		            
		            XSSFCell cell5= row.createCell(c+2,Cell.CELL_TYPE_STRING);
		            cell5.setCellValue(reservationList.get(r).getCheckout());
		            cell5.setCellStyle(r%2==0?style_odd:style_evn);
		            
		            XSSFCell cell6= row.createCell(c+3,Cell.CELL_TYPE_STRING);
		            cell6.setCellValue(reservationList.get(r).getPersons());
		            cell6.setCellStyle(r%2==0?style_odd:style_evn);
		            		            
		            XSSFCell cell7= row.createCell(c+4,Cell.CELL_TYPE_STRING);
		            cell7.setCellValue(reservationList.get(r).getStayPerson());
		            cell7.setCellStyle(r%2==0?style_odd:style_evn);
		            
		            XSSFCell cell8= row.createCell(c+5,Cell.CELL_TYPE_STRING);
		            cell8.setCellValue(reservationList.get(r).getRes_person());
		            cell8.setCellStyle(r%2==0?style_odd:style_evn);
		            
		            XSSFCell cell9= row.createCell(c+6,Cell.CELL_TYPE_STRING);
		            cell9.setCellValue(reservationList.get(r).getNation());
		            cell9.setCellStyle(r%2==0?style_odd:style_evn);
		            
		            XSSFCell cell10= row.createCell(c+7,Cell.CELL_TYPE_STRING);
		            cell10.setCellValue(reservationList.get(r).getReg_person());
		            cell10.setCellStyle(r%2==0?style_odd:style_evn);
		            
		            XSSFCell cell11= row.createCell(c+8,Cell.CELL_TYPE_STRING);
		            cell11.setCellValue(reservationList.get(r).getRenewDate());
		            cell11.setCellStyle(r%2==0?style_odd:style_evn);
		            
		            XSSFCell cell12= row.createCell(c+9,Cell.CELL_TYPE_STRING);
		            cell12.setCellValue(reservationList.get(r).getRegDate());
		            cell12.setCellStyle(r%2==0?style_odd:style_evn);
		            
		            XSSFCell cell13= row.createCell(c+10,Cell.CELL_TYPE_STRING);
		            cell13.setCellValue(reservationList.get(r).getRenewDate());
		            cell13.setCellStyle(r%2==0?style_odd:style_evn);
		            
		           
		        }
	        } 
	        
	        
	        File ff = new File("ReservationList.xlsx");	
	        FileOutputStream os =new FileOutputStream(ff);
	        book.write(os);
	        os.close();
	        filename="ReservationList.xlsx";
	        setContentLength(ff.length());
	 		setContentDisposition("attatchment;filename="+URLEncoder.encode(filename, "UTF-8"));
	 		setInputStream(new FileInputStream(filename));          
	        	    
		return SUCCESS;
		
	}	
	static void setCellColorStyle(XSSFCellStyle style,int rgb){
	      byte[] color={(byte)((rgb>>16)&0xFF) 
	                   ,(byte)((rgb>>8)&0xFF) 
	                   ,(byte)((rgb)&0xFF)};  
	      style.setFillForegroundColor(new XSSFColor(color));
	      style.setFillPattern(CellStyle.SOLID_FOREGROUND); 
	      style.setBorderTop(CellStyle.BORDER_THIN);        
	      style.setBorderBottom(CellStyle.BORDER_THIN);    
	      style.setBorderLeft(CellStyle.BORDER_THIN);      
	      style.setBorderRight(CellStyle.BORDER_THIN);	      
	 }
	@Override
	public void prepare() throws Exception {
		
	}
	public Logger getLog() {
		return log;
	}
	public void setLog(Logger log) {
		this.log = log;
	}
	public ArrayList<Reservation> getReservationList() {
		return reservationList;
	}
	public void setReservationList(ArrayList<Reservation> reservationList) {
		reservationList = reservationList;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public byte[] getDataBuffer() {
		return dataBuffer;
	}
	public void setDataBuffer(byte[] dataBuffer) {
		this.dataBuffer = dataBuffer;
	}
	public String getContentDisposition() {
		return contentDisposition;
	}
	public void setContentDisposition(String contentDisposition) {
		this.contentDisposition = contentDisposition;
	}
	public InputStream getInputStream() {
		return inputStream;
	}
	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}
	public FileOutputStream getOutputStream() {
		return outputStream;
	}
	public void setOutputStream(FileOutputStream outputStream) {
		this.outputStream = outputStream;
	}
	public long getContentLength() {
		return contentLength;
	}
	public void setContentLength(long contentLength) {
		this.contentLength = contentLength;
	}
	public SelectDao getSdao() {
		return sdao;
	}
	public void setSdao(SelectDao sdao) {
		this.sdao = sdao;
	}
	public java.awt.Image getTest() {
		return test;
	}
	public void setTest(java.awt.Image test) {
		this.test = test;
	}	
	

}
