<%@page import="java.awt.Toolkit"%>
<%@page import="java.awt.Dimension"%>
<%@page import="java.util.ArrayList"%>
<%@page import="hotel.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="org.json.simple.*" %>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="http://d3js.org/d3.v3.min.js"></script>
<style>
  /* #myGraph { width: 500px; height: 240px; } */
  .line { fill: none; stroke: black; }
  .axis text {
		font-family: sans-serif;
		font-size: 11px;
	}
  .axis path,
  .axis line {
		fill: none;
		stroke: black;
	}
  .axis_x line {
		fill: none;
		stroke: black;
	}
  .itemA { stroke: #6699FF; }
  .itemB { stroke: #FF9933; }
  .itemC { stroke: #ccc; }
</style>



<%
	//자기 호텔 이름
	String hotel_Name = (String)session.getAttribute("loginedHotel_Name");
	/* User u =  (User)session.getAttribute("loginedUser");
	String s = u.getCompany_id();	 */
	//1단락	
	ArrayList<Integer> hotelRemain = new ArrayList<Integer>();
	hotelRemain = (ArrayList<Integer>)session.getAttribute("hotelRemain");	//호텔 남은 수량
	//out.println(hotelRemain);	
	
	//2단락		
	ArrayList<String> hotelSold_RoomType = new ArrayList<String>();
	hotelSold_RoomType = (ArrayList<String>)session.getAttribute("hotelSold_RoomType");
	ArrayList<ArrayList<Integer>> hotelSold_RoomType_Amount = new ArrayList<ArrayList<Integer>>();
	hotelSold_RoomType_Amount =	(ArrayList<ArrayList<Integer>>)session.getAttribute("hotelSold_RoomType_Amount");
	
	
	//out.println(hotelSold_RoomType);
	//out.println("size      :     "+hotelSold_RoomType);    //  << size = 4
	/* 	
	for (int i = 0 ; i < hotelSold_RoomType.size() ; i++) {
		out.println(hotelSold_RoomType_Amount.get(i));		
		out.println("size      :     "+hotelSold_RoomType_Amount.get(i).size());
	} */
	
	//3단락	
	ArrayList<String> tourSold_OTA = (ArrayList<String>)session.getAttribute("tourSold_OTA");
	ArrayList<ArrayList<String>> tourSold_OTA_RoomType = (ArrayList<ArrayList<String>>)session.getAttribute("tourSold_OTA_RoomType");
	ArrayList<ArrayList<ArrayList<Integer>>> tourSold_OTA_RoomType_Amount = (ArrayList<ArrayList<ArrayList<Integer>>>)session.getAttribute("tourSold_OTA_RoomType_Amount");
	//out.println(tourSold_OTA);
	
	//4단락		
	ArrayList<Integer> tourRemain = (ArrayList<Integer>)session.getAttribute("tourRemain");
	
	//끝
	
	
	//공용 길이
	int maxday = hotelRemain.size();
	//out.print(maxday);
	//조립1단락	
	JSONObject tap1ob2 = new JSONObject();
	JSONArray tap1ar1 = new JSONArray();	
	
	for (int i = 0 ; i < maxday ; i++){
		tap1ar1.add(i,hotelRemain.get(i));
	}	  
	tap1ob2.put("size", tap1ar1);	
	tap1ob2.put("name", "Hotel Remain");			

	//조립2단락	
	JSONObject tap2ob4 = new JSONObject();  
	JSONArray  tap2ar3 = new JSONArray();
	JSONObject tap2ob2 = new JSONObject();  
	JSONArray  tap2ar1 = new JSONArray();
	
	//hotelSold_RoomType.size();
	//hotelSold_RoomType_Amount.get(i);
	
	//tap2ob4.put("size", );			
	//tap2ob4.put("name", "Hotel Sold");
	
	/* tap2ar3 = new JSONArray();	
	for(int k = 0 ; ){ */
	
	tap2ob4 = new JSONObject();  
	tap2ar3 = new JSONArray();	
	for	(int j = 0 ; j < hotelSold_RoomType.size() ; j++){			
		tap2ob2 = new JSONObject();
		tap2ar1 = new JSONArray();
		for (int i = 0 ; i < maxday ; i++){
			tap2ar1.add(i,hotelSold_RoomType_Amount.get(j).get(i));
		}
		tap2ob2.put("size",tap2ar1);
		tap2ob2.put("name",hotelSold_RoomType.get(j));			// 타입	
		//out.println("tap2ar1"+tap2ar1);					//타입 출력 테스트
		tap2ar3.add(j,tap2ob2);
		
	}
	tap2ob4.put("name", "Hotel Sold");
	tap2ob4.put("children", tap2ar3);
	
	//조립3단락
	JSONObject tap3ob6 = new JSONObject();  
	JSONArray  tap3ar5 = new JSONArray();
	JSONObject tap3ob4 = new JSONObject();  
	JSONArray  tap3ar3 = new JSONArray();
	JSONObject tap3ob2 = new JSONObject();  
	JSONArray  tap3ar1 = new JSONArray();	
	
	
	tap3ob6 = new JSONObject();  
	tap3ar5 = new JSONArray();
	for(int k = 0 ; k < tourSold_OTA.size() ; k++){		
		tap3ob4 = new JSONObject();  
		tap3ar3 = new JSONArray();	
		for	(int j = 0 ; j < hotelSold_RoomType.size() ; j++){			
			tap3ob2 = new JSONObject();
			tap3ar1 = new JSONArray();
			for (int i = 0 ; i < maxday ; i++){
				tap3ar1.add(i,tourSold_OTA_RoomType_Amount.get(k).get(j).get(i));			//수량
			}
			tap3ob2.put("size",tap3ar1);
			tap3ob2.put("name",hotelSold_RoomType.get(j));			// 타입	
			tap3ar3.add(j,tap3ob2);
		}
		tap3ob4.put("name", tourSold_OTA.get(k));				// 여행사
		tap3ob4.put("children", tap3ar3);
		tap3ar5.add(k,tap3ob4);	
	}
	tap3ob6.put("name","OTA Sold");
	tap3ob6.put("children",tap3ar5);
	
	//조립4단락
	JSONObject tap4ob2 = new JSONObject();
	JSONArray tap4ar1 = new JSONArray();
	
	for (int i = 0 ; i < maxday ; i++){
		tap4ar1.add(i,tourRemain.get(i));
	}	  
	tap4ob2.put("size", tap4ar1);	
	tap4ob2.put("name", "OTA Remain");
	
	//조립끝
	JSONObject jsonMain = new JSONObject();  
	JSONArray  jsonMainArray = new JSONArray();	
	jsonMainArray.add(0,tap1ob2);
	jsonMainArray.add(1,tap2ob4);
	jsonMainArray.add(2,tap3ob6);
	jsonMainArray.add(3,tap4ob2);		
	
	jsonMain.put("name",hotel_Name);
	jsonMain.put("children",jsonMainArray);	
	
	//-------------------------------
	//ArrayList<String> hotelSold_RoomType = (ArrayList<String>)session.getAttribute("hotelSold_RoomType");
	//ArrayList<ArrayList<Integer>> hotelSold_RoomType_Amount = (ArrayList<ArrayList<Integer>>)session.getAttribute("hotelSold_RoomType_Amount");
	
	//호텔 측 판매 (타입별을 다 더해서)
	JSONArray hotelSoldJSONArray = new JSONArray();		
	for(int i = 0 ; i < maxday ; i++){		// 365
		int sum = 0;		
		for(int j = 0 ; j < hotelSold_RoomType_Amount.size() ; j++){		// 4
			sum += hotelSold_RoomType_Amount.get(j).get(i);
		}		
		hotelSoldJSONArray.add(i,sum);
		//out.print(i+""+sum + " ");
	}
	/* 
	ArrayList<String> tourSold_OTA 
	ArrayList<ArrayList<String>> tourSold_OTA_RoomType 
	ArrayList<ArrayList<ArrayList<Integer>>> tourSold_OTA_RoomType_Amount  */
	/* 
	
	int a = tourSold_OTA.size();
		
	alert("tourSold_OTA : "+a);
	
	alert("tourSold_OTA_RoomType : "+tourSold_OTA_RoomType.size() );
	
	alert("tourSold_OTA_RoomType_Amount : "+tourSold_OTA_RoomType_Amount.size() ); */
	
	out.println(" ");
	out.println(" ");
	
	JSONArray tourSoldJSONArray = new JSONArray();
	
	JSONArray sumSoldJSONArray = new JSONArray();
	
	for(int i = 0 ; i < maxday ; i++){		// 365일
		
		int hsum = 0;
		int sum = 0;
		
		for(int j = 0 ; j < tourSold_OTA_RoomType.get(0).size() ; j++){		//타입
			hsum += hotelSold_RoomType_Amount.get(j).get(i);
			for(int k = 0 ; k < tourSold_OTA.size() ; k++){		//여행사 수
				sum += tourSold_OTA_RoomType_Amount.get(k).get(j).get(i);
			}
		}
		//out.print(i+""+sum+" ");
		tourSoldJSONArray.add(i,sum);
		sumSoldJSONArray.add(i,hsum+sum);
		//out.print(i+""+(hsum+sum)+" ");
	}
	
	Dimension dim = Toolkit.getDefaultToolkit().getScreenSize();    
	String graphW =  Integer.toString(dim.width/2 - 60)+"px";
	System.out.println(graphW); 
	
%>

<style>
html{
 	width:100%;
	height:100%; 
	/* background-color:rgb(255,225,230);
 */
}
body{
	width:100%;
	height:100%;
	display:table;
}
#leftCircle{
	float:left;
	z-index:999;
	display:table-cell;
}
#mainDiv{
	width:80%;
	height:40%;
	display:table-cell;
	vertical-align: middle;
}
#mainTable{
	width:100%;
	height:100%;
}
#topTd{
	border-bottom: black 1px solid;
	text-align: center;
}
#leftButton{
	width:70px;
	height:70px;
	border-radius:100px;
	border:rgb(117,221,136) 1px solid;
	background-color:white;
	font-size:35px;
	color:rgb(117,221,136);
	
}
#rightButton{
	width:70px;
	height:70px;
	border-radius:100px;
	border:rgb(117,221,136) 1px solid;
	background-color:white;
	font-size:35px;
	color:rgb(117,221,136);
}
#bottomTd{
	text-align: center;
	height: 280px;
}
sgv{
	text-align: center;
}
#slider-time{
	margin-left:0px;
}
</style>

<script>

var t1 = window.innerHeight	//775
//alert(t1);

var t2 = window.innerWidth	//1600
//alert(t2);


</script>

</head>

<body>

	<div id="leftCircle">
	<svg id = "Graph1"></svg>
	</div>
	
<div id="mainDiv">
		<table id="mainTable">
			<tr style="height: 415px; padding: 0px;">
				<td id="topTd" style="padding: 0px;">
					<table style="align:center; padding: 0px;">
						<tr style="align: center ;">
						<td style="width: 900px">
							<input id="leftButton" type="button" value="◀"
									onclick="goleft()">
							<span>&nbsp&nbsp</span>
							<span>&nbsp&nbsp</span>
							<span id="percentage0" style="font-size:45px;height:45px;text-align:center;"></span>
							<span>&nbsp&nbsp</span>
							<span>&nbsp&nbsp</span>
							<input id="rightButton" type="button" value="▶" onclick="goright()">		
						</td>
					</tr>	
					<tr style="height: 325px;">
						<td>
							<p id="percentage1" style="height:30px;text-align:center;"></p>
							<p id="percentage2" style="height:30px;text-align:center;"></p>
							<p id="percentage3" style="height:30px;text-align:center;"></p>
							<p id="percentage4" style="height:30px;text-align:center;"></p>	
						</td>
					</tr>
				</table>	
					
				</td>
			</tr>
			<tr>
				<td id="bottomTd">
					<div id="graph2" style="z-index: 5;">
						<%-- <svg id = "myGraph"></svg> s--%>
					</div>
					<div>
						<input type="range" name="points" min="1"
							max="<%=maxday%>" step="1" value="0" id="slider-time"
							style="width: <%=graphW%>;">
					</div>
					
				</td>
			</tr>
		</table>
</div>


















<%-- <div id="mainDiv">
	<div id="graph2" style="z-index:5;" >
		<svg id = "myGraph"></svg> s
	</div>
	
	<div style="left:40px">
		<span>&nbsp&nbsp</span>
		<input type="range" name="points" min="1" max="<%=maxday%>" step="1" value="0" id="slider-time" style="width:400px">
	</div>
	
	<div>
	<table width="460px">
		<tr>
			<td	width="400px">
				<input type="button"  value="◀"  onclick="goleft()" >
			</td>
			<td>
				<input type="button"  value="▶" onclick="goright()" >
			</td>
			
		</tr>
	</table>
	</div>
	
	
	<div style=" top: 100px; align: center; width: 300px;  float: left">
	<table style="align:center;  ">
		<tr style="align: center ;">
			<td style="width: 500px">
				<p id="percentage0" style="height:30px;text-align:center;"></p>
				<p id="percentage1" style="height:30px;text-align:center;"></p>
				<p id="percentage2" style="height:30px;text-align:center;"></p>
				<p id="percentage3" style="height:30px;text-align:center;"></p>
				<p id="percentage4" style="height:30px;text-align:center;"></p>			
			</td>		
		</tr>	
	</table>	
	</div>
</div> --%>
<script>

//var svgWidth = 500;	// SVG 요소의 넓이
var svgWidth = t2/2;	// SVG 요소의 넓이
var svgHeight = 240;	// SVG 요소의 높이
var offsetX = 30;	// 가로 오프셋
var offsetY = 20;	// 세로 오프셋
var scale = 0.5;	// 배 크기로 그리기
var dataSet1 = <%=sumSoldJSONArray%>	 // 데이터셋1

var maxdataset1 = Math.max.apply(null, dataSet1);




	domainMax = maxdataset1;


var margin = svgWidth /(dataSet1.length - 1);	//  그래프의 간격 계산

var svg = d3.select("#graph2")
	.append("svg")
	.attr("width",svgWidth)
	.attr("height",svgHeight)
	.attr("id","myGraph")
	
svg.selectAll("rect")
.data(dataSet1)
.enter()
.append("rect")	
.style("opacity",0.5)
.style("fill","#3399FF")

.attr("height",0)			// 초기 값

.transition()				// 모션 (svg가 위에서 부터 좌표가 설정 되어 있어서 위에서 부터 그리는 문제가 있음)
.duration(2000)
.attr("x",function(d,i){
return (i *  ( (svgWidth-(offsetX)) / dataSet1.length )+15) ;
})
.attr("y",function(d){
return svgHeight - d*scale - offsetY;
})
.attr("width", (svgWidth-(2*offsetX))/dataSet1.length)		
.attr("height",function(d){			// 음수 값은 통하지 않는다
return d*scale;
})
 
//-------------------------------

drawScale();

// 그래프의 눈금을 표시하는 함수
function drawScale(){
	// 눈금을 표시하기 위해 D3 스케일 설정
	var yScale = d3.scale.linear()  // 스케일 설정
	  .domain([0, domainMax])   // 원래 크기
	  .range([svgHeight-offsetY-offsetY,20]) // 실제 표시 크기	  
	// 눈금 표시
	d3.select("#myGraph")	// SVG 요소를 지정
		  .append("g")	// g 요소 추가. 이것이 눈금을 표시하는 요소가 됨
		  .attr("class", "axis")	// CSS 클래스 지정
		  .attr("transform", "translate("+offsetX+","+offsetY+")")
		  .style("opacity", 0.9) 
		  .call(
				d3.svg.axis()
			  .scale(yScale)  //스케일 적용
			  .orient("left") //눈금 표시 위치를 왼쪽으로 지정
			)
		// 가로 방향의 선을 표시
		d3.select("#myGraph")
		  .append("rect")	// rect 요소 추가
		  .attr("class", "axis_x")	// CSS 클래스 지정
		  .attr("width", svgWidth-(2*offsetX))	// 선의 굵기를 지정
		  .attr("height", 1)	// 선의 높이를 지정
		  .attr("transform", "translate("+offsetX+","+(svgHeight-offsetY-0.5)+")")
		  .style("opacity", 0.8) 
}







var sliderVal;
var width = 400,
    height = 750,       
    radius = height / 2,				
    color = d3.scale.category20c();						
var received ;

var svg = d3.select("#Graph1")	
	//.append("svg")
    .attr("width", width)
    .attr("height", height)
 	.append("g")
    .attr("transform", "translate(" + 0+ "," + height * .52 + ")")
    .attr("id","hotelGraph");
    			//위치를 잡기 위해
var s = '';
var partition = d3.layout.partition()
    .sort(null)
    			//null 이면 특별한 정렬 방식 없이 입력 순서대로 하는듯함.
    .size([Math.PI ,  110000])
    			//partition의 사이즈
    			//Math.PI는 원주율에 가까운 double을 반환
    			//Math.PI	  는 180도 
    			//Math.PI * 2 는 360도
    					//radius * radius 는 원의 전체적인 크기를 나타낸다
    					//radius * radius 가 지금은 122500을 나타내지만 왜 이렇게 쓰는지는 모름
    .value(function(d) { return d.size[0]; });
    			//  return d.size 로 설정시 json에서 설정한 value값으로 크기가 지정 된다.
    			

var arc = d3.svg.arc()
    .startAngle(function(d) { return d.x; })
    .endAngle(function(d) { return d.x + d.dx; })
    .innerRadius(function(d) { return Math.sqrt(d.y); })
    .outerRadius(function(d) { return Math.sqrt(d.y + d.dy); });
    			
var loc =  "hotelTestSemi.json"; 			

//d3.json(loc, function(error, root) {
//d3.json("파일 경로", 파일을 다 읽어 왔을때 호출할 함수(비동기 통신을 수행하는 객체?, 불러온 데이터)	
  														//(XMLHttpRequest)에러가 발생했는지 알려주는 객체	
 var path = svg.datum( <%=jsonMain%> ).selectAll("path") 		
  //var path = svg.datum(justJSONCode).selectAll("path")  		
      .data(partition.nodes)
   	  .enter()   	  
  	  .append("g")						// < 그룹화		//제거시 에니메이션이 동작하지 않음      
  	  .append("path")  	 
      //.attr("class","package")
      .attr("display", function(d) { return d.depth ? null : "none"; }) // hide inner ring
      										//	"none"은 표시하지 않는것을 의미
      										// 	삼항 연산에 의해 depth == 0 일때는 "none"
      										//  				 depth != 0 일때는 null	
      //.append("text","Hotel")
      .attr("d", arc)						//부채꼴의 좌표 계산
											//arc는 원 을 의미
      .style("stroke", "#fff")
      .style("fill", function(d) { return color((d.children ? d : d.parent).name); })
      .style("fill-rule", "evenodd")
      .style("opacity", 0.7) 
      
      //.on("click",click)
      .on("mouseover",mouseover)
      .on("mouseout",mouseout)
      
      .each(stash) 
      
      d3.selectAll("#slider-time").on("change",change)
            
      d3.select("#percentage0")	
  			 .style({
  			 fontSize:'60px',
  			 width:'30%'	 
  			 });
        
      function change() {	
  	   
		sliderVal = this.value; 
		//alert(sliderVal);
  	    received = function(d) { return d.size[sliderVal-1]; };
  	  	//alert(received);
  	    
  	    //path
  	    svg.selectAll("path")
  	        .data(partition.value(received).nodes)
  	     	.transition()
  	        .duration(1500)
  	        .attrTween("d", arcTween);
  	    
  	  var myDate = new Date(2015, 0, 1);
  	  myDate.setDate($('#slider-time').val());	
  	   
  	var Mtemp = myDate.getMonth()-(-1);  	
  	var Dtemp = myDate.getDate();	
	var SM, SD;
	if (Mtemp < 10){
		SM = "0"+Mtemp	
	}else SM = Mtemp
	if (Dtemp < 10){
		SD= "0"+Dtemp	
	}else SD = Dtemp    	
  	var barTime = myDate.getFullYear()+"."+SM+"."+SD;    	
  	
  
  	    d3.select("#percentage0").text(barTime);
  	    d3.select("#percentage1").text("");
  	    d3.select("#percentage2").text("");
  	    d3.select("#percentage3").text("");
  	    d3.select("#percentage4").text("");
  	  }
      
 	function changeS(num) {	
	   
		sliderVal = num; 
		//alert(sliderVal);
	    received = function(d) { return d.size[sliderVal-1]; };
	  	//alert(received);
	    
	    //path
	    svg.selectAll("path")
	        .data(partition.value(received).nodes)
	     	.transition()
	        .duration(1500)
	        .attrTween("d", arcTween);
	    
	    var myDate = new Date(2015, 0, 1);
	  	  myDate.setDate($('#slider-time').val());	
	  	  
	  	var Mtemp = myDate.getMonth()-(-1);  	
	  	var Dtemp = myDate.getDate();	
		var SM, SD;
		if (Mtemp < 10){
			SM = "0"+Mtemp	
		}else SM = Mtemp
		if (Dtemp < 10){
			SD= "0"+Dtemp	
		}else SD = Dtemp    	
	  	var barTime = myDate.getFullYear()+"."+SM+"."+SD; 
	  	  	
	  	//var barTime = myDate.getFullYear()+"."+(myDate.getMonth()-(-1))+"."+myDate.getDate();
	  	    
	    
	    d3.select("#percentage0").text(barTime);
	    d3.select("#percentage1").text("");
	    d3.select("#percentage2").text("");
	    d3.select("#percentage3").text("");
	    d3.select("#percentage4").text("");
	  }
       
       
    
    d3.select("#hotelGraph")  	
    	.append("text")  	  	
    	.style("font-size","28px")		// 크기 바꿔짐
    	.style("font-weight", "bold")
    	.attr("width", "150px")
    	.attr("transform","translate(0,10)")
     	.text(function(d){
    		s = d.name;
    		return s;
    	})  	
    	
  //});

  // Stash the old values for transition.
  function stash(d) {
    d.x0 = d.x;
    d.dx0 = d.dx;
  }

  // Interpolate the arcs in data space.
  function arcTween(a) {
    var i = d3.interpolate({x: a.x0, dx: a.dx0}, a);
    return function(t) {
      var b = i(t);
      a.x0 = b.x;
      a.dx0 = b.dx;
      return arc(b);
    };
  }

  function mouseover(d){	
	  
	//alert(d3.select(this).style);
  
  	var myDate = new Date(2015, 0, 1);
  	
  	myDate.setDate($('#slider-time').val());

  	 
  	var Mtemp = myDate.getMonth()-(-1);  	
  	var Dtemp = myDate.getDate();	
	var SM, SD;
	if (Mtemp < 10){
		SM = "0"+Mtemp	
	}else SM = Mtemp
	if (Dtemp < 10){
		SD= "0"+Dtemp	
	}else SD = Dtemp    	
  	var barTime = myDate.getFullYear()+"."+SM+"."+SD; 
  	
  	 
  	  if (d.depth == 1){
  		  t=(d.name+" "+d.value);
  		  d3.select("#percentage0")	
  			 .style("font-size","45px")	//45
  			 .style("height","45px")
  		     .text(barTime);
  		  d3.select("#percentage1")	
  			 .style("font-size","50x")	//40
  			 .style("height","50px")
  			 .style("opacity", 1) 
  		     .text(d.name); 		  	 
  		  d3.select("#percentage2")
  		  	 .style("font-size","50px")	//40
  		  	 .style("height","50px")
  		  	 .style("opacity", 1) 
  		     .text(d.value+" 개");
  		  d3.select("#percentage3")
  		  	.style("height","10px")
  		     .text("");
  		  d3.select("#percentage4")	
  		  	.style("height","10px")
  		     .text("");
  		  		  
  	  }else if (d.depth == 2){		 
  		  t=(d.parent.name+" "+d.name+" "+d.value)
  		  d3.select("#percentage0")	
  			 .style("font-size","45px")
  			 .style("height","45px")
  			 .text(barTime);
  		  d3.select("#percentage1")	
  			 .style("font-size","30px")
  		     .style("height","30px")
  		     .style("opacity", 0.7) 
  			 .text(d.parent.name); 		  	 
  		  d3.select("#percentage2")
  		  	 .style("font-size","40px") 
  		     .style("height","40px")
  		     .style("opacity", 1) 
  		  	 .text(d.name);
  		  d3.select("#percentage3")	
  			 .style("font-size","40px") 
  		     .style("height","40px")
  			 .text(d.value+" 개") 	
  			 .style("opacity", 1) 
  		  d3.select("#percentage4")	
  		  	.style("height","10px")
  		     .text("");
  		 
  	  }else {
  		 t=(d.parent.parent.name+" "+d.parent.name+" "+d.name+" "+d.value)
  		  d3.select("#percentage0")	
  			 .style("font-size","45px") //45
  			 .style("height","30px")
  			 .text(barTime);
  		  d3.select("#percentage1")	
  			 .style("font-size","15px") //45
  			 .style("height","15px")
  		     .style("opacity", 0.4) 
  			 .text(d.parent.parent.name); 		  	 
  		  d3.select("#percentage2")
  		   	 .style("font-size","30px") //45
  		     .style("height","30px")
  		     .style("opacity", 0.7) 
  		   	 .text(d.parent.name);
  		  d3.select("#percentage3")	
  			 .style("font-size","35px") //45
  		     .style("height","35px")
  		     .style("opacity", 1) 
  			 .text(d.name); 
  		  d3.select("#percentage4")	
  			 .style("font-size","40px") //45
  		     .style("height","40px")
  			 .text(d.value+" 개");
  		 
  	  }	
  	  
  
  	  
  	  
  	  d3.select(this)					//d3.select 로 다시 선택해 줘야 함
  	  .style("opacity", 1) 							
  	   	  
  	  
  	  svg.selectAll("path")
        .filter(function(node) {
            return (sequenceArray.indexOf(node) >= 0);
          })
  	  .style("opacity", 1);
  }

  function mouseout(){
  	d3.select(this)
  	  .style("opacity", 0.7)
  }


  function click(g){
  	g.style("opacity", 0.7)
  }

  d3.select("svg")					//여기까진 작동
  	.select("g")					//path를 선책하면 안 먹히고 g를 선택하면 먹힘	
  	.on("click",function(g){	
  		this.style("opacity", 0);
  	})
  	
  	
  function opa(){
  	this.select(path)
  	.style("opacity", 0.6);
  }


  d3.select(self.frameElement).style("height", height + "px");


 
function goleft(){
	$('#slider-time').val($('#slider-time').val()-1);	
	var left = $('#slider-time').val();			//undefined
	//var left = $('#slider-time');			//undefined
	//var left = d3.select("#slider-time");			//undefined
	//var left = d3.select("#slider-time").val();			//무반응
	//alert(left);
	changeS(left);
	
}


function goright(){
	$('#slider-time').val( ($('#slider-time').val()-(-1)) );
	var right = $('#slider-time').val();		//undefined
	//var right = $('#slider-time');		//undefined
	//var right = d3.select("#slider-time").value();		//무반응
	//alert(right);
	changeS(right);
}

function findToday(){
	var todayDate = new Date();
	var startDate = new Date('2015','0','1');	
	var betweenTime = (todayDate.getTime() - startDate.getTime()) / 1000 / 60 / 60 / 24;	
	betweenTime = Math.floor(betweenTime) -(-1);
	$('#slider-time').val(betweenTime);	
	changeS(betweenTime);
	
}

findToday();

</script>



</body>
</html>
