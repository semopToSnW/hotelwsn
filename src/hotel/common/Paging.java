package hotel.common;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class Paging {
	private int pageAmount =15;
	private int currentPage= 1;
	private int[] pagingCount = new int[10];
	private int pageCount;
	private int totalPage;
	private int pageStart=((currentPage-1)/pageAmount)*pageAmount+1;
	private int moveRight =-1;
	private int moveLeft =-1;
	private Map<String, Object> range;
	private Map<String, Object> valueMap;
	
	public Map<String, Object> getRange(String id){
		int from = (currentPage-1)*pageAmount+1;
		int to = currentPage*pageAmount;
		System.out.println(from);
		System.out.println(to);
		range = new HashMap<String, Object>();
		range.put("from", from);
		range.put("to", to);
		range.put("companyId", id);
		return range;
	}
	
	public Map<String, Object> getValueMap(String id){
		valueMap=new HashMap<String, Object>();
		valueMap.put("pageAmount", pageAmount);
		valueMap.put("companyId", id);
		return valueMap;
	}
	
	public int getPageAmount() {
		return pageAmount;
	}
	public void setPageAmount(int pageAmount) {
		this.pageAmount = pageAmount;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int[] getPagingCount() {
		return pagingCount;
	}
	public void setPagingCount(int[] pagingCount) {
		this.pagingCount = pagingCount;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
		if(currentPage>10){
			moveLeft= pageStart-10;
			moveRight=-1;
		}
		if((pageStart-1)+10<totalPage){
			moveLeft= -1;
			moveRight= pageStart+10;
		}
	}
	public int getPageStart() {
		return pageStart;
	}
	public void setPageStart(int pageStart) {
		this.pageStart = pageStart;
	}
	public int getMoveRight() {
		return moveRight;
	}
	public void setMoveRight(int moveRight) {
		this.moveRight = moveRight;
	}
	public int getMoveLeft() {
		return moveLeft;
	}
	public void setMoveLeft(int moveLeft) {
		this.moveLeft = moveLeft;
	}

	@Override
	public String toString() {
		return "Paging [pageAmount=" + pageAmount + ", currentPage="
				+ currentPage + ", pagingCount=" + Arrays.toString(pagingCount)
				+ ", pageCount=" + pageCount + ", totalPage=" + totalPage
				+ ", pageStart=" + pageStart + ", moveRight=" + moveRight
				+ ", moveLeft=" + moveLeft + ", range=" + range + ", valueMap="
				+ valueMap + "]";
	}

	public Paging(int pageAmount, int currentPage, int[] pagingCount,
			int pageCount, int totalPage, int pageStart, int moveRight,
			int moveLeft, Map<String, Object> range,
			Map<String, Object> valueMap) {
		super();
		this.pageAmount = pageAmount;
		this.currentPage = currentPage;
		this.pagingCount = pagingCount;
		this.pageCount = pageCount;
		this.totalPage = totalPage;
		this.pageStart = pageStart;
		this.moveRight = moveRight;
		this.moveLeft = moveLeft;
		this.range = range;
		this.valueMap = valueMap;
	}

	public Paging() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	
}
