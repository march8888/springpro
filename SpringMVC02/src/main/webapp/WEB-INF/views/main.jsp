<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar","\n"); %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Spring MVC02</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			loadList();
		});
		//리스트 가져오기
		function loadList() {
			//서버와 통신 : 게시판 리스트 가져오기 (비동기전송)
			$.ajax({
				//url : "boardList.do",
				url : "board/all",
				type : "get",
				dataType : "json",
				success : makeView, //콜백함수
				error : function(){alert("error");}
			});
		}
		function makeView(data){
			console.log(data);
			var listHtml = "<table class='table table-bordered'>";
			listHtml += "<tr>";
			listHtml += "<td>번호</td>";
			listHtml += "<td>제목</td>";
			listHtml += "<td>작성자</td>";
			listHtml += "<td>작성일</td>";
			listHtml += "<td>조회수</td>";
			listHtml += "</tr>";
			
			//데이터 배열 반복문으로 리스트 형성
			$.each(data,function(index,obj){
				listHtml += "<tr>";
				listHtml += "<td>"+obj.idx+"</td>";
				listHtml += "<td id='td"+ obj.idx +"'><a href='javascript:goContent("+obj.idx+")'>"+obj.title+"</a></td>";
				listHtml += "<td>"+obj.writer+"</td>";
				listHtml += "<td>"+obj.indate.split(' ')[0]+"</td>";
				listHtml += "<td id='cnt"+ obj.idx +"'>"+obj.count+"</td>";
				listHtml += "</tr>";
				
				listHtml += "<tr id='c"+ obj.idx +"' style='display:none'>";
				listHtml += "<td>내용</td>";
				listHtml += "<td colspan='4'>";
				listHtml += "<textarea id='ta"+ obj.idx +"' rows='7' class='form-control' readonly></textarea>";
				listHtml += "<br/>";
				listHtml += "<span id='ub"+obj.idx+"'><button class='btn btn-success btn-sm' onclick='goUpdateForm("+ obj.idx +")'>수정화면</button></span>&nbsp";
				listHtml += "<button class='btn btn-warning btn-sm' onclick='goDelete("+ obj.idx +")'>삭제</button>";
				listHtml += "</td>";
				listHtml += "</tr>";
			});
			listHtml += "<tr>";
			listHtml += "<td colspan='5' align='center'>";
			listHtml += "<button class='btn btn-primary btn-sm' onclick='goForm()'>글쓰기</button>";
			listHtml += "</td>";
			listHtml += "</tr>";
			listHtml += "</table>";
			
			$("#view").html(listHtml);
			
			$("#view").css("display","block");
			$("#wform").css("display","none");
		}
		//리스트 가져오기
		
		//글쓰기 폼
		function goForm(){
			$("#view").css("display","none");
			$("#wform").css("display","block");
		}
		//글쓰기 폼
		
		//리스트로
		function goList(){
			$("#view").css("display","block");
			$("#wform").css("display","none");
		}
		//리스트로
		
		//글쓰기
		function goInsert(){
			/* 이렇게 하면 번거로움
			var title = $("#title").val();
			var content = $("#content").val();
			var writer = $("#writer").val(); */
			
			var fData = $("#frm").serialize();
			console.log(fData);
			$.ajax({
				//url : "boardInsert.do",
				url : "board/new",
				type : "post",
				data : fData,
				success : loadList, //콜백함수
				error : function(){alert("error");}
			});
			//폼초기화
			/* 이또한 번거로움
			$("#title").val("");
			$("#content").val("");
			$("#writer").val(""); */
			$("#fclear").trigger("click");
		}
		//글쓰기
		
		//글상세
		function goContent(idx){
			if($("#c"+idx).css("display") == "none"){
				
				$.ajax({
					//url : "boardContent.do"
					url : "board/"+idx,
					type : "get",
					data : {"idx" : idx},
					dataType : "json",
					success : function(data){
						$("#ta"+idx).val(data.content);
					}, //콜백함수
					error : function(){alert("error");}
				});
				
				$("#c"+idx).css("display","table-row"); //보이게
				$("#ta"+idx).attr("readonly",true);
			}else{
				$("#c"+idx).css("display","none");//감추기
				
				//조회수
				$.ajax({
					//url : "boardCount.do",
					url : "board/count/"+idx,
					type : "put",
					data : {"idx" : idx},
					dataType : "json",
					success : function(data){
						$("#cnt"+idx).text(data.count);
					}, //콜백함수
					error : function(){alert("error");}
				});
				
			}
		}
		//글상세
		
		//글삭제
		function goDelete(idx) {
			$.ajax({
				//url : "boardDelete.do",
				url : "board/"+idx,
				type : "delete",
				data : {"idx" : idx},
				success : loadList, //콜백함수
				error : function(){alert("error");}
			});
		}
		//글삭제
		
		//수정화면
		function goUpdateForm(idx){
			$("#ta"+idx).attr("readonly",false);//감추기
			var title = $("#td"+idx).text();
			var newInput = "<input type='text' id='nt"+idx+"' class='form-control' value='"+title+"'/>";
			$("#td"+idx).html(newInput);
			
			var newButton = "<button class='btn btn-primary btn-sm' onclick='goUpdate("+idx+")'>수정</button>";
			$("#ub"+idx).html(newButton);
		}
		//수정화면
		
		//수정하기
		function goUpdate(idx) {
			var title = $("#nt"+idx).val();
			var content = $("#ta"+idx).val();
			$.ajax({
				//url : "boardUpdate.do",
				url : "board/update",
				type : "put",
				contentType : 'application/json;charset=utf-8',
				data : JSON.stringify({"title" : title,"idx":idx,"content":content}), //rest는 반드시 contentType과JSON.stringify가 필수 
				success : loadList, //콜백함수
				error : function(){alert("error");}
			});
		}
		//수정하기
		
	</script>

</head>
<body>
 
<div class="container">
  <h2>Spring MVC02</h2>
  <div class="panel panel-default">
    <div class="panel-heading">BOARD</div>
    <div class="panel-body" id="view"></div>
    <div class="panel-body" style="display:none;" id="wform">
    	<form id="frm">
    		<table class="table">
    			<tr>
    				<td>제목</td>
    				<td><input type="text" id="title" name="title" class="form-control"/></td>
   				</tr>
   				<tr>
    				<td>내용</td>
    				<td><textarea rows="7" id="content" class="form-control" name="content"></textarea></td>
   				</tr>
   				<tr>
    				<td>작성자</td>
    				<td><input type="text" id="writer" name="writer" class="form-control"/></td>
   				</tr>
   				<tr>
    				<td colspan="2" align="center">
    					<button type="button" class="btn btn-success btn-sm" onclick="goInsert()">등록</button>
    					<button type="reset" class="btn btn-warning btn-sm" id="fclear">취소</button>
    					<button type="button" class="btn btn-info btn-sm" onclick="goList()">리스트</button>
    				</td>
   				</tr>
    		</table>
    	</form>
    </div>
    <div class="panel-footer">인프런 스프1탄 박매일</div>
  </div>
</div>

</body>
</html>
