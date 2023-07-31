package hotel.ajax;

import hotel.dao.InsertDao;
import hotel.dao.SelectDao;
import hotel.dao.UpdateDao;
import hotel.vo.Image;
import hotel.vo.Product;
import hotel.vo.User;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.text.PlainDocument;

import org.apache.log4j.Logger;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;

import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFCellUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellReference;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class UpdateProductAjax extends ActionSupport implements Preparable {		
	
	private Logger log = Logger.getLogger(UpdateProductAjax.class);
	private Map<String, Object> session = ActionContext.getContext().getSession();
	private Product product;
	private ArrayList<Product> productList;		
	private ArrayList<Image> imageList;	
	private ArrayList<Image> imageListDn;	
	private ArrayList<Product> productListEx;	
	
	private ArrayList<File> uploads;
	private ArrayList<String> uploadsFileName;
	private ArrayList<String> uploadsContentType;
	
	private Image image;	
	/*private File upload;
	private String uploadFileName;*/
	private String filename;
	private byte[] dataBuffer = null;
	private String contentDisposition;	
	private InputStream inputStream;
	private FileOutputStream outputStream;
	private long contentLength;			
	
	private UpdateDao udao = new UpdateDao();
	private InsertDao idao = new InsertDao();
	private SelectDao sdao = new SelectDao();	
			
	
	public String updateProductImage() throws Exception{
		
		product.setCompany_id(((User)session.get("loginedUser")).getCompany_id());
		
		System.out.println("product"+product);		
		
		product = idao.insertProduct(product);
		
		log.info(uploads);
		log.info(imageList);
		log.info(uploadsContentType);
		log.info("uploads - size : "+uploads.size());
		log.info(product.getId());
		
		for (int i = 0; i < uploads.size(); i++) {	
			FileInputStream inputStream = new FileInputStream(uploads.get(i));
			byte[] buffer = new byte[inputStream.available()];
			inputStream.read(buffer);
			inputStream.close();
			imageList.get(i).setPicture(buffer);
			imageList.get(i).setFilename(uploadsContentType.get(i));
			imageList.get(i).setProduct_id(product.getId());
			imageList.get(i).setPicnum(i+1);
		}
		log.info("productid"+product.getId());
		log.info("imageListSize : "+imageList.size());
		idao.insertProductImage(imageList);		
		
		return SUCCESS;
	}
	
	public String downImage() throws Exception{
		log.info("downImage");
		
		String product_id = "78";
		imageListDn = (ArrayList<Image>) sdao.downImage(product_id);
				
		log.info(imageListDn.size());		
		int in = 0; 
		in = imageListDn.get(0).getPicture().length;
		
		dataBuffer = imageListDn.get(0).getPicture();		
		log.info(dataBuffer);
		log.info(in);
		filename = imageListDn.get(0).getFilename();
				
		File ff = new File(imageListDn.get(0).getFilename());				
		FileOutputStream fos = new FileOutputStream(ff);
		fos.write(dataBuffer,0,in);				
		fos.close();		
		setContentLength(ff.length());
		setContentDisposition("attatchment;filename="+URLEncoder.encode(filename, "UTF-8"));
		setInputStream(new FileInputStream(filename));
		
		return SUCCESS;
	}
	
	public String downExcel() throws Exception{
		   log.info("downExcel test");
		   
		   productListEx = (ArrayList<Product>) sdao.getProductListByCompany_id(((User)session.get("loginedUser")).getCompany_id());		   
		   int listlenght = productListEx.size(); 
		   
	       XSSFWorkbook  book  = new XSSFWorkbook();	       
	       XSSFCellStyle style_odd = book.createCellStyle();
	       setCellColorStyle(style_odd,0xFAFFFF);
	       XSSFCellStyle style_evn = book.createCellStyle();
	       setCellColorStyle(style_evn,0xE5F5FF);
	       
	     
	       
	       XSSFSheet sheet= book.createSheet("Sheet-"+1); //첫번째 시트
	       for (int i = 1; i < 9; i++) {
	    	   sheet.setColumnWidth((short)i, (short)2840);
	       }	         
	               
	       
	       XSSFRow row0= sheet.createRow(0);
		   XSSFCell cell0= row0.createCell(0,Cell.CELL_TYPE_STRING);		   
		   cell0.setCellValue("호텔 예약 정보 출력 테스트");
		   
		   
	       for(int s=0;s<1;++s){ // 컬럼명
		    XSSFRow row= sheet.createRow(1);
		    XSSFCell cell= row.createCell(s+1,Cell.CELL_TYPE_STRING);
		    cell.setCellStyle(style_evn);
		    cell.setCellValue("ID");
		    XSSFCell cell2= row.createCell(s+2,Cell.CELL_TYPE_STRING);
		    cell2.setCellStyle(style_evn);
		    cell2.setCellValue("NAME");
		    XSSFCell cell3= row.createCell(s+3,Cell.CELL_TYPE_STRING);
		    cell3.setCellStyle(style_evn);
		    cell3.setCellValue("Explain");
		    XSSFCell cell4= row.createCell(s+4,Cell.CELL_TYPE_STRING);
		    cell4.setCellStyle(style_evn);
		    cell4.setCellValue("Period");
		    XSSFCell cell5= row.createCell(s+5,Cell.CELL_TYPE_STRING);
		    cell5.setCellStyle(style_evn);
		    cell5.setCellValue("MealTypes");
		    XSSFCell cell6= row.createCell(s+6,Cell.CELL_TYPE_STRING);
		    cell6.setCellStyle(style_evn);
		    cell6.setCellValue("checkIn");
		    XSSFCell cell7= row.createCell(s+7,Cell.CELL_TYPE_STRING);
		    cell7.setCellStyle(style_evn);
		    cell7.setCellValue("checkOut");
		    XSSFCell cell8= row.createCell(s+8,Cell.CELL_TYPE_STRING);
		    cell8.setCellStyle(style_evn);
		    cell8.setCellValue("Amount");
		    XSSFCell cell9= row.createCell(s+9,Cell.CELL_TYPE_STRING);
		    cell9.setCellStyle(style_evn);
		    cell9.setCellValue("prices");
		    
		   }
	       
	       for(int r=0;r<listlenght;++r){ //내용
	        	 XSSFRow row= sheet.createRow(r+2);
	        	 XSSFCellStyle style= row.getRowStyle();	        	 
	           	        	 
		        for(int c=1;c<2;++c){	        	
		            
		        	XSSFCell cell= row.createCell(c,Cell.CELL_TYPE_STRING);
		            cell.setCellValue(productListEx.get(r).getId());
		            cell.setCellStyle(r%2==0?style_odd:style_evn);
		            
		            XSSFCell cell2= row.createCell(c+1,Cell.CELL_TYPE_STRING);
		            cell2.setCellValue(productListEx.get(r).getName());
		            cell2.setCellStyle(r%2==0?style_odd:style_evn);
		            
		            XSSFCell cell3= row.createCell(c+2,Cell.CELL_TYPE_STRING);
		            cell3.setCellValue(productListEx.get(r).getExplain());
		            cell3.setCellStyle(r%2==0?style_odd:style_evn);
		            
		            XSSFCell cell4= row.createCell(c+3,Cell.CELL_TYPE_STRING);
		            cell4.setCellValue(productListEx.get(r).getSaleStart()+"~"+productListEx.get(r).getSaleFinish());
		            cell4.setCellStyle(r%2==0?style_odd:style_evn);
		            
		            XSSFCell cell5= row.createCell(c+4,Cell.CELL_TYPE_STRING);
		            cell5.setCellValue(productListEx.get(r).getMealTypes());
		            cell5.setCellStyle(r%2==0?style_odd:style_evn);
		            
		            XSSFCell cell6= row.createCell(c+5,Cell.CELL_TYPE_STRING);
		            cell6.setCellValue(productListEx.get(r).getCheckInTime());
		            cell6.setCellStyle(r%2==0?style_odd:style_evn);
		            		            
		            XSSFCell cell7= row.createCell(c+6,Cell.CELL_TYPE_STRING);
		            cell7.setCellValue(productListEx.get(r).getCheckOutTime());
		            cell7.setCellStyle(r%2==0?style_odd:style_evn);
		            
		            XSSFCell cell8= row.createCell(c+7,Cell.CELL_TYPE_STRING);
		            cell8.setCellValue(productListEx.get(r).getAmount());
		            cell8.setCellStyle(r%2==0?style_odd:style_evn);
		            
		            XSSFCell cell9= row.createCell(c+8,Cell.CELL_TYPE_STRING);
		            cell9.setCellValue(productListEx.get(r).getPrices());
		            cell9.setCellStyle(r%2==0?style_odd:style_evn);
		        }
	        } 
	        
	        
	        File ff = new File("test_out.xlsx");	
	        FileOutputStream os =new FileOutputStream(ff);
	        book.write(os);
	        os.close();
	        filename="test_out.xlsx";
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
	

	public ArrayList<Product> getProductList() {
		return productList;
	}

	public void setProductList(ArrayList<Product> productList) {
		this.productList = productList;
	}

	
	public Image getImage() {
		return image;
	}

	public void setImage(Image image) {
		this.image = image;
	}	

	public Logger getLog() {
		return log;
	}

	public void setLog(Logger log) {
		this.log = log;
	}

	@Override
	public void prepare() throws Exception {
		// TODO Auto-generated method stub		
	}
	public String execute() throws Exception {
		return super.execute();
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public ArrayList<Image> getImageList() {
		return imageList;
	}

	public void setImageList(ArrayList<Image> imageList) {
		this.imageList = imageList;
	}

	public UpdateDao getUdao() {
		return udao;
	}

	public void setUdao(UpdateDao udao) {
		this.udao = udao;
	}

	public InsertDao getIdao() {
		return idao;
	}

	public void setIdao(InsertDao idao) {
		this.idao = idao;
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

	public FileOutputStream getOutputStream() {
		return outputStream;
	}

	public void setOutputStream(FileOutputStream outputStream) {
		this.outputStream = outputStream;
	}

	public ArrayList<Image> getImageListDn() {
		return imageListDn;
	}

	public void setImageListDn(ArrayList<Image> imageListDn) {
		this.imageListDn = imageListDn;
	}

	public ArrayList<Product> getProductListEx() {
		return productListEx;
	}

	public void setProductListEx(ArrayList<Product> productListEx) {
		this.productListEx = productListEx;
	}

	public ArrayList<File> getUploads() {
		return uploads;
	}

	public void setUploads(ArrayList<File> uploads) {
		this.uploads = uploads;
	}

	public ArrayList<String> getUploadsFileName() {
		return uploadsFileName;
	}

	public void setUploadsFileName(ArrayList<String> uploadsFileName) {
		this.uploadsFileName = uploadsFileName;
	}

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public ArrayList<String> getUploadsContentType() {
		return uploadsContentType;
	}

	public void setUploadsContentType(ArrayList<String> uploadsContentType) {
		this.uploadsContentType = uploadsContentType;
	}
}
