package hotel.common;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class CalendarTool {

	private String fulldate;
	private int nextMonth;
	private int nextYear;
	private int prevMonth;
	private int prevYear;
	private int curDate;
	private int curMonth;
	private int curYear;
	private int curLastDate;
	private int curFirstDay;
	
	public CalendarTool() {
		Calendar cal= Calendar.getInstance();
		curDate = cal.get(Calendar.DAY_OF_MONTH);
		curMonth =cal.get(Calendar.MONTH)+1;
		curYear = cal.get(Calendar.YEAR);
		Calendar cal2 = Calendar.getInstance();
		cal2.set(curYear, curMonth-1, 1);
		curLastDate=cal2.getActualMaximum(Calendar.DATE);
		curFirstDay=cal2.get(Calendar.DAY_OF_WEEK);
		fulldate = curYear+"."+curMonth+"."+curDate;
		cal2.set(curYear, curMonth, 1);
		nextMonth=cal2.get(Calendar.MONTH)+1;
		nextYear=cal2.get(Calendar.YEAR);
		cal2.set(curYear, curMonth-2, 1);
		prevMonth = cal2.get(Calendar.MONTH)+1;
		prevYear= cal2.get(Calendar.YEAR);
	}

	public CalendarTool(String date) throws ParseException {
		SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyy.M.d" );
		Calendar cal= Calendar.getInstance();
		cal.setTime(dateFormat.parse(date));
		curDate = cal.get(Calendar.DAY_OF_MONTH);
		curMonth =cal.get(Calendar.MONTH)+1;
		curYear = cal.get(Calendar.YEAR);
		Calendar cal2 = Calendar.getInstance();
		cal2.set(curYear, curMonth-1, 1);
		curLastDate=cal2.getActualMaximum(Calendar.DATE);
		curFirstDay=cal2.get(Calendar.DAY_OF_WEEK);
		fulldate = curYear+"."+curMonth+"."+curDate;
		cal2.set(curYear, curMonth, 1);
		nextMonth=cal2.get(Calendar.MONTH)+1;
		nextYear=cal2.get(Calendar.YEAR);
		cal2.set(curYear, curMonth-2, 1);
		prevMonth = cal2.get(Calendar.MONTH)+1;
		prevYear= cal2.get(Calendar.YEAR);
	}
	
		
	public int getNextMonth() {
		return nextMonth;
	}

	public void setNextMonth(int nextMonth) {
		this.nextMonth = nextMonth;
	}

	public int getNextYear() {
		return nextYear;
	}

	public void setNextYear(int nextYear) {
		this.nextYear = nextYear;
	}

	public int getPrevMonth() {
		return prevMonth;
	}

	public void setPrevMonth(int prevMonth) {
		this.prevMonth = prevMonth;
	}

	public int getPrevYear() {
		return prevYear;
	}

	public void setPrevYear(int prevYear) {
		this.prevYear = prevYear;
	}

	public String getFulldate() {
		return fulldate;
	}

	public void setFulldate(String fulldate) {
		this.fulldate = fulldate;
	}

	public int getCurDate() {
		return curDate;
	}

	public void setCurDate(int curDate) {
		this.curDate = curDate;
	}

	public int getCurMonth() {
		return curMonth;
	}

	public void setCurMonth(int curMonth) {
		this.curMonth = curMonth;
	}

	public int getCurYear() {
		return curYear;
	}

	public void setCurYear(int curYear) {
		this.curYear = curYear;
	}

	public int getCurLastDate() {
		return curLastDate;
	}

	public void setCurLastDate(int curLastDate) {
		this.curLastDate = curLastDate;
	}

	public int getCurFirstDay() {
		return curFirstDay;
	}

	public void setCurFirstDay(int curFirstDay) {
		this.curFirstDay = curFirstDay;
	}

	@Override
	public String toString() {
		return "CalendarTool [fulldate=" + fulldate + ", nextMonth="
				+ nextMonth + ", nextYear=" + nextYear + ", prevMonth="
				+ prevMonth + ", prevYear=" + prevYear + ", curDate=" + curDate
				+ ", curMonth=" + curMonth + ", curYear=" + curYear
				+ ", curLastDate=" + curLastDate + ", curFirstDay="
				+ curFirstDay + "]";
	}
	
}
