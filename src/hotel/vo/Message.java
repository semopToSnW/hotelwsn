package hotel.vo;

import java.io.File;
import java.util.Arrays;
import java.util.List;

public class Message {

	private String fileName;
	private String contentType;
	private String content;
	private String title;
	private byte[] file;
	private String byteCode;
	private int id;
	private String from;
	private String to;
	private int count;
	private String inputdate;
	private String company;
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getContentType() {
		return contentType;
	}
	public void setContentType(String contentType) {
		this.contentType = contentType;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public byte[] getFile() {
		return file;
	}
	public void setFile(byte[] file) {
		this.file = file;
	}
	public String getByteCode() {
		return byteCode;
	}
	public void setByteCode(String byteCode) {
		this.byteCode = byteCode;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getInputdate() {
		return inputdate;
	}
	public void setInputdate(String inputdate) {
		this.inputdate = inputdate;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	@Override
	public String toString() {
		return "Message [fileName=" + fileName + ", contentType=" + contentType
				+ ", content=" + content + ", title=" + title + ", file="
				+ Arrays.toString(file) + ", byteCode=" + byteCode + ", id="
				+ id + ", from=" + from + ", to=" + to + ", count=" + count
				+ ", inputdate=" + inputdate + ", company=" + company + "]";
	}
	public Message(String fileName, String contentType, String content,
			String title, byte[] file, String byteCode, int id, String from,
			String to, int count, String inputdate, String company) {
		super();
		this.fileName = fileName;
		this.contentType = contentType;
		this.content = content;
		this.title = title;
		this.file = file;
		this.byteCode = byteCode;
		this.id = id;
		this.from = from;
		this.to = to;
		this.count = count;
		this.inputdate = inputdate;
		this.company = company;
	}
	public Message() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

}
