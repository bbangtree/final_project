<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<title>스터디그룹</title>
<link rel="stylesheet" href="<%=application.getContextPath()%>/resources/css/subject/list.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
</head>

<body onload="showmethe()">
	
<%@ include file="../comm/header.jsp" %>

<div id="middle">
	<input type="hidden" id="m_yy" value="${m_yy}">
		<input type="hidden" id="m_mm" value="${m_mm}">


 <div id="show"></div>	
	<div id="middle_right">
		<table class="table table-bordered">
			<tr>
			<td>진행일</td><td>참석자</td><td>제목</td><td>작성일</td><td>작성자</td><td>삭제</td>
			</tr>
			<c:forEach items="${list}" var="i">
			<tr>
				<td><input type="hidden" class="s_year" id="s_yy" value="${i.s_yy}">${i.s_yy}-<input type="hidden" id="s_mm" class="s_month" value="${i.s_mm}">${i.s_mm}-<input type="hidden" id="s_dd" class="s_day" value="${i.s_dd}">${i.s_dd}</td>
				<td><input type="hidden" class="s_joinmem" value="${i.s_Joinmem}">${i.s_Joinmem}</td>
				<td><input type="hidden" class="s_title" value="${i.s_Title}"><button type='button' onclick='getDate(${i.s_yy},${i.s_mm},${i.s_dd})' class='btn btn-link dd' value="+i +" data-toggle='modal' data-target='#add'>${i.s_Title}</td>
				<td><input type="hidden" class="s_date" value="${i.s_Date}">${i.s_Date}</td>
				<td><input type="hidden" class="m_id" value="${i.m_Id}">${i.m_Id}
					<input type="hidden" class="s_contents" value="${i.s_Contents}">
				</td>
				<td><button type="button"  class="btn btn-danger" onclick='deleteSubject(${i.s_yy},${i.s_mm},${i.s_dd})'>삭제</button></td>
			</tr>
			</c:forEach>
		</table>
		<input type="hidden" id="m_yy" value="${m_yy}">
		<input type="hidden" id="m_mm" value="${m_mm}">
	</div>
	 
 </div><!--middle-->
 	
 
 
 <!--일정추가 modal-->
 <div class="modal fade" id="add" tabindex="-1" role="dialog" aria-labelledby="gridSystemModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="gridSystemModalLabel">모임추가 </h4>
      </div>
  		
  	<form action="./setSubject" method="post">
      <div class="modal-body">    	
		<table class="table">
		<tr>
		<td>작성자</td><td><input type="text" id="m_id" name="m_Id"></td>
		</tr>
		<tr>
		<td>그룹이름</td><td><input type="text" id="g_name"><input type="hidden" id="g_num" value="0" name="g_Num"></td>
		</tr>
		<tr>
		<td>날짜</td><td><input type="text" id="s_date" readonly="readonly">
			<input type="hidden" id="ss_yy" name="s_yy"><input type="hidden" id="ss_mm" name="s_mm"><input type="hidden" id="ss_dd" name="s_dd">
		</td>
		</tr>
		<tr>
		<td>참석자<input type="hidden" id="td_joinmem" name="s_Joinmem" readonly="readonly"></td></td>
		<td id="tdMem"></td>
		</tr>
		<tr>
		<td>주제</td><td><input type="text" id="s_title" name="s_Title"></td>
		</tr>
		<tr>
		<td>세부내용 </td><td><textarea rows="10" cols="50" id="s_contents" name="s_Contents"></textarea></td>
		</tr>
		</table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <span id="alterbtn"></span>
        <span id="span_setbtn"><button type="submit" class='btn btn-warning' onclick='setSubject()'>작성완료</button></span>
      </div>
      </form>
      
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
 
  
<%@ include file="../comm/footer.jspf" %>
</body>

<script type="text/javascript">

 
 var yy = document.getElementById("m_yy").value;  // 년도와 달을 불러온다
 var mm = document.getElementById("m_mm").value;
 
 
	var subject_yy=document.getElementsByClassName("s_year");
	var subject_mm=document.getElementsByClassName("s_month");
	var subject_dd=document.getElementsByClassName("s_day");
	var title=document.getElementsByClassName("s_title");
	var m_id=document.getElementsByClassName("m_id");
	var contents=document.getElementsByClassName("s_contents");	
	var s_date=document.getElementsByClassName("s_date");
	var joinmem=document.getElementsByClassName("s_joinmem");

 
 function prev() { // 지난달 
  var middle = document.getElementById("middle_right");
  var yy = $("#m_yy").val();
  var mm = $("#m_mm").val();
  		mm--;
  		if(mm <= 0){
  			 mm = 12;
  			 yy--;
		  }
  		
  	var load_subject1 ="<table class='table table-bordered'><tr>";
  		load_subject1 +="<td>진행일</td><td>참석자</td><td>제목</td><td>작성일</td><td>작성자</td><td>삭제</td></tr>";	 
	
		$.ajax({
			url:"ajaxList",
			type:"post",
			data:{
				g_num:0,
				s_yy:yy,
				s_mm:mm
			},
		success:function(result){
			$(result).each(function(){
				load_subject1 +="<tr>";
				load_subject1 +="<td><input type='hidden' class='s_year' id='s_yy' value="+this.s_yy+">"+this.s_yy;
				load_subject1 +="-<input type='hidden' id='s_mm' class='s_month' value="+this.s_mm+">"+this.s_mm;
				load_subject1 +="-<input type='hidden' id='s_dd' class='s_day' value="+this.s_dd+">"+this.s_dd+"</td>";
				load_subject1 +="<td><input type='hidden' class='s_joinmem' value="+this.s_Joinmem+">"+this.s_Joinmem+"</td>";
				load_subject1 +="<td><input type='hidden' class='s_title' value="+this.s_Title+">";
				load_subject1 +="<button type='button' onclick='getDate("+this.s_yy+","+this.s_mm+","+this.s_dd+")' class='btn btn-link dd' data-toggle='modal' data-target='#add'>";	
  				load_subject1 += this.s_Title+"</td>";
				load_subject1 +="<td><input type='hidden' class='s_date' value="+this.s_Date+">"+this.s_Date+"</td>";
				load_subject1 +="<td><input type='hidden' class='m_id' value="+this.m_Id+">"+this.m_Id;
				load_subject1 +="<input type='hidden' class='s_contents' value="+this.s_Contents+"></td>";
				load_subject1 +="<td><button type='button'  class='btn btn-danger' onclick='deleteSubject("+this.s_yy+","+this.s_mm+","+this.s_dd+")'>삭제</button></td>";			
				load_subject1 +="</tr>";
			});
				load_subject1 +="</table>";
				middle.innerHTML = load_subject1;
				$("#m_yy").val(yy);
				$("#m_mm").val(mm);
     			showmethe(); 
		}
	});

 }


 function next() { // 다음달
	 var middle = document.getElementById("middle_right");
	 var yy = $("#m_yy").val();
	  var mm = $("#m_mm").val();
 		 mm++;
  		if(mm > 12){
 			  mm = 1;
			  yy++;
  			}
  		
  		var load_subject ="<table class='table table-bordered'><tr>";
  			load_subject +="<td>진행일</td><td>참석자</td><td>제목</td><td>작성일</td><td>작성자</td><td>삭제</td></tr>";		
  		
  	  		$.ajax({
  				url:"ajaxList",
  				type:"post",
  				data:{
  					g_num:0,
  					s_yy:yy,
  					s_mm:mm
  				},
  			success:function(result){
  				$(result).each(function(){
  					load_subject +="<tr>";
  					load_subject +="<td><input type='hidden' class='s_year' id='s_yy' value="+this.s_yy+">"+this.s_yy;
  					load_subject +="-<input type='hidden' id='s_mm' class='s_month' value="+this.s_mm+">"+this.s_mm;
  					load_subject +="-<input type='hidden' id='s_dd' class='s_day' value="+this.s_dd+">"+this.s_dd+"</td>";
  					load_subject +="<td><input type='hidden' class='s_joinmem' value="+this.s_Joinmem+">"+this.s_Joinmem+"</td>";
  					load_subject +="<td><input type='hidden' class='s_title' value="+this.s_Title+">";
  					load_subject +="<button type='button' onclick='getDate("+this.s_yy+","+this.s_mm+","+this.s_dd+")' class='btn btn-link dd' data-toggle='modal' data-target='#add'>";	
  					load_subject += this.s_Title+"</td>";
  					load_subject +="<td><input type='hidden' class='s_date' value="+this.s_Date+">"+this.s_Date+"</td>";
  					load_subject +="<td><input type='hidden' class='m_id' value="+this.m_Id+">"+this.m_Id;
  					load_subject +="<input type='hidden' class='s_contents' value="+this.s_Contents+"></td>";
  					load_subject +="<td><button type='button'  class='btn btn-danger' onclick='deleteSubject("+this.s_yy+","+this.s_mm+","+this.s_dd+")'>삭제</button></td>";			
  					load_subject +="</tr>";
  				});
  					load_subject +="</table>";
  					middle.innerHTML = load_subject;
  					$("#m_yy").val(yy);
  					$("#m_mm").val(mm);
  	     		showmethe(); 
  			}
  		});
  		
 }
 
//일정 수정하기
	function alterSubject(yyy,mmm,ddd){
		setSubject();
		$.ajax({
			url:"alterSubject",
			type:"post",
			data:{
				s_yy:yyy,
				s_mm:mmm,
				s_dd:ddd,
				s_Title:$("#s_title").val(),
				s_Contents:$("#s_contents").val(),
				s_Joinmem:$("#td_joinmem").val()
			},
			success:function(result){
				alert("수정성공");
				location.href="getList?g_num=0&s_yy="+yyy+"&s_mm="+mmm+"";
			}
			
		});
		
	
}
 
//일정지우기
 function deleteSubject(yyy,mmm,ddd){
	 $.ajax({
		url:"deleteSubject",
		type:"post",
		data:{
			s_yy:yyy,
			s_mm:mmm,
			s_dd:ddd
		},
		success:function(result){
			alert("삭제");
			location.href="getList?g_num=0&s_yy="+yyy+"&s_mm="+mmm+"";
		},	 
	 });	 
 }
 
 //일정입력할때 참석자 값 넘기기
 function setSubject(){
	 var join="";
	   $('#mem:checked').each(function(){ 
	       join=join+$(this).val()+" ";
	   });
	   $("#td_joinmem").val(join);   
 }
 	
 
 //클릭한 날짜로 모달의 value값 주기
  function getDate(yyy,mmm,ddd){
	var inputday=yyy+"년 "+mmm+"월 "+ddd+"일";
	$("#s_date").val(inputday);
	$("#ss_yy").val(yyy);
	$("#ss_mm").val(mmm);
	$("#ss_dd").val(ddd);
	
	var ck=true;
	
	for(var i=0;i<subject_yy.length;i++){
		if(subject_yy[i].value==yyy && subject_mm[i].value==mmm && subject_dd[i].value==ddd){
			$("#gridSystemModalLabel").html("모임조회");
			$("#m_id").val(m_id[i].value);
			
			$("#s_title").val(title[i].value);
			$("#s_title").attr("readonly","readonly");
			
			$("#s_contents").html(contents[i].value);
			$("#s_contents").attr("readonly","readonly");
			
			$("#tdMem").html(joinmem[i].value+"&nbsp;&nbsp;");
			$("#alterbtn").html("<button type='button' onclick='alterMember("+yyy+","+mmm+","+ddd+")' class='btn btn-warning'>수정하기</button>");
			$("#span_setbtn").html("");
			ck=false;
			}		
		}
		if(ck){
			$("#gridSystemModalLabel").html("모임추가");
			$("#alterbtn").html("");
			$("#s_title").attr('readonly', false);
			$("#s_contents").attr('readonly', false);
			$("#span_setbtn").html("<button type='submit' class='btn btn-warning' onclick='setSubject()'>작성완료</button>");
			//그룹멤버 불러오기
			SearchMember();		
		}//if문 끝
	}//function 끝
	
	
	//일정조회, 수정연결
	function alterMember(yyy,mmm,ddd){
		$.ajax({
			url:"searchGMember",
			type:"post",
			data:{
				g_num:0
			},
		    dataType:'json',
			success:function(result){
				$("#tdMem").html("");
				$(result).each(function(){	
					$("#tdMem").append("&nbsp;&nbsp;"+"&nbsp;<input type='checkbox' name='s_joinmem' class='s_joinmem' id='mem' value="+this.m_id+">"+this.m_id);
				});
/* 				$("#m_id").attr('readonly', false); */
				$("#s_title").attr('readonly', false);
				$("#s_contents").attr('readonly', false);
				$("#alterbtn").html("");
				$("#span_setbtn").html("<button type='button' onclick='alterSubject("+yyy+","+mmm+","+ddd+")' class='btn btn-warning'>수정완료</button>");			
				
			},
			}); 		
		}
	
	//그룹내 회원조회
	function SearchMember(){
	$.ajax({
		url:"searchGMember",
		type:"post",
		data:{
			g_num:0
		},
	    dataType:'json',
		success:function(result){
			$("#tdMem").html("");
			$("#m_id").val("");
			$("#s_title").val("");
			$("#s_contents").html("");
			
			$(result).each(function(){	
				$("#tdMem").append("&nbsp;&nbsp;"+"&nbsp;<input type='checkbox' name='s_joinmem' id='mem' value="+this.m_id+">"+this.m_id)		
			});
			
		},
		}); 		
	}

 function showmethe(){ // 다 로드되고 바로 시작되는 함수
    var yy = document.getElementById("m_yy").value;  // 년도와 달을 불러온다
    var mm = document.getElementById("m_mm").value;
    var show = document.getElementById("show"); //  출력할 곳 div태그
    
	subject_yy=document.getElementsByClassName("s_year");
	subject_mm=document.getElementsByClassName("s_month");
	subject_dd=document.getElementsByClassName("s_day");
	title=document.getElementsByClassName("s_title");
	m_id=document.getElementsByClassName("m_id");
	contents=document.getElementsByClassName("s_contents");	
	s_date=document.getElementsByClassName("s_date");
	joinmem=document.getElementsByClassName("s_joinmem");

  var sum = "<table id='calendar' class='table table-bordered' align='center'>";
   sum += "<tr>";
   sum += "<td colspan='7' align='center'>";
   sum += "<a href='#' onclick='prev()'>◀</a>&nbsp;&nbsp;&nbsp;";
   sum += yy + "년 "+mm + "월";
   sum += "&nbsp;&nbsp;&nbsp;<a href='#' onclick='next()'>▶</a>";
   sum += "</td>";
   sum += "</tr>";
   sum += "<tr>";
   sum += "<th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th>";  
   sum += "</tr>";
   sum += "<tr>";

   var w = new Date(yy,mm-1,1).getDay(); // 이번달 1일이 무슨요일인지 보거 일요일(0)~토요일(0) 까지 알아서 공백을 채워준다
   	for( var i = 0 ; i < w ; i++){
   		 sum += "<td>&nbsp;</td>"
 	  }

 
   var m = [31,28,31,30,31,30,31,31,30,31,30,31]; // 월의 마지막 날짜를 배열에 넣는다.
   m[1] = (yy%400==0 || yy%4==0 && yy%100!=0) ? 29 : 28;	
	
		for( i = 1 ; i <= m[mm-1] ; i++ ){    // 월마지막달 배열 중 이번달 꺼 빼서 요일에 맞게 알아서 넣음 ... !!!
			//일 뿌려주는 곳          
			   var ch = true;
			   for(var j=0;j<subject_dd.length;j++){
			      if(subject_yy[j].value == yy && subject_mm[j].value == mm && subject_dd[j].value == i){	         
			    	  sum += "<td align='center'>"+"<button type='button' onclick='getDate("+yy+","+mm+","+i+")' class='btn btn-link dd' value="+i +" data-toggle='modal' data-target='#add'>"+i+"<br><img src='<%=request.getContextPath()%>/resources/img/subject/check.png'>"+"</td>";
			         ch = false;
			      }   
			   }
			   if(ch){
			      sum += "<td align='center'>"+"<button type='button' onclick='getDate("+yy+","+mm+","+i+")' class='btn btn-link dd' value="+i +" data-toggle='modal' data-target='#add'>"+i+"</td>";  			      
			   }
		
		   
	   if(new Date(yy,mm-1,i).getDay() == 6){  // 토요일이면 행 바꿔주고
    	 sum += "</tr>";
     if(i != m[m-1]){ // 달마지막과 i 값을 비교하여 같지 않다면 새로운 행을 시작한다.
    	  sum += "<tr>";
     }
    }
   } //for문 끝
   
  	
   w = new Date(yy,mm,1).getDay(); // 다음달 1일의 요일 정보를 찾아온다 
   if(w != 0){
    for(var i = w ; i <= 6 ; i++){ // 다음달 1일이 시작하는 요일 부터 토요일까지 테이블에 빈칸을 넣어준다.
     sum += "<td>&nbsp;</td>";
    }
   }
   
   sum += "</tr>";
   sum += "</table>";
   
   show.innerHTML = sum;
 }


</script>


</html>

