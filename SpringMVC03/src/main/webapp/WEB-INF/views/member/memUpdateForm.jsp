<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar","\n"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			if(${!empty msgType}){
				$("#messageType").attr("class","modal-content panel-warning")
				$("#myMessage").modal("show");
				
			}
		});

		//비밀번호 일치확인
		function passwordCheck() {
			var memPassword1 = $("#memPassword1").val();
			var memPassword2 = $("#memPassword2").val();
			
			if(memPassword1 != memPassword2){
				$("#passMessage").html("비밀번호가 서로 일치하지 않습니다.");
			}else {
				$("#passMessage").html("");
				$("#memPassword").val(memPassword1);
			}
		}
		
		function goUpdate() {
			var memAge = $("#memAge").val();
			if(memAge == null || memAge == "" || memAge == 0){
				alert("나이를 입력하세요");
				return false;
			}
			document.frm.submit(); //전송
		}
		
	</script>
</head>
<body>
<div class="container">
<jsp:include page="../common/header.jsp"/>
  <h2>Spring MVC03</h2>
  <div class="panel panel-default">
    <div class="panel-heading">회원정보수정 양식</div>
    <div class="panel-body">
    	<form name="frm" method="post" action="${contextPath }/memUpdate.do">
    		<input type="hidden" id="memID" name="memID" value="${mvo.memID }"/>
    		<input type="hidden" id="memPassword" name="memPassword" value=""/>
    		<table class="table table-bordered" style="text-align:center; border:1px solid #dddddd;">
    			<tr>
    				<td style="width:110px;vertical-align:middle;">아이디</td>
    				<td>${mvo.memID }</td>
    			</tr>
    			<tr>
    				<td style="width:110px;vertical-align:middle;">비밀번호</td>
    				<td colspan="2"><input id="memPassword1" name="memPassword1" onkeyup="passwordCheck()" class="form-control" type="password" maxlength="20" placeholder="패스워드를 입력하세요"/></td>
    			</tr>
    			<tr>
    				<td style="width:110px;vertical-align:middle;">비밀번호 확인</td>
    				<td colspan="2"><input id="memPassword2" name="memPassword2" onkeyup="passwordCheck()" class="form-control" type="password" maxlength="20" placeholder="패스워드를 확인하세요"/></td>
    			</tr>
    			<tr>
    				<td style="width:110px;vertical-align:middle;">사용자 이름</td>
    				<td colspan="2"><input id="memName" name="memName" class="form-control" type="text" maxlength="20" placeholder="이름을 입력하세요" value="${mvo.memName }"/></td>
    			</tr>
    			<tr>
    				<td style="width:110px;vertical-align:middle;">사용자 나이</td>
    				<td colspan="2"><input id="memAge" name="memAge" class="form-control" type="number" maxlength="20" placeholder="나이를 입력하세요" value="${mvo.memAge }"/></td>
    			</tr>
    			<tr>
    				<td style="width:110px;vertical-align:middle;">사용자 성별</td>
    				<td colspan="2">
    					<div class="form-group" style="text-align: center;margin: 0 auto;">
    						<div class="btn-group" data-toggle="buttons">
    							<label class="btn btn-primary 
    								<c:if test="${mvo.memGender eq '남자' }">active</c:if>">
    								<input id="memGender" name="memGender" type="radio" autocomplete="off" value="남자"
    									<c:if test="${mvo.memGender eq '남자' }">checked</c:if> />남자
    							</label>
    							<label class="btn btn-primary
    							<c:if test="${mvo.memGender eq '여자' }">active</c:if> ">
    								<input id="memGender" name="memGender" type="radio" autocomplete="off" value="여자"
    									<c:if test="${mvo.memGender eq '여자' }">checked</c:if> />여자
    							</label>
    						</div>
    					</div>
    				</td>
    			</tr>
    			<tr>
    				<td style="width:110px;vertical-align:middle;">이메일</td>
    				<td colspan="2"><input id="memEmail" name="memEmail" class="form-control" type="text" maxlength="20" placeholder="이메이를 입력하세요" value="${mvo.memEmail }"/></td>
    			</tr>
    			<tr>
    				<td colspan="3" style="text-align: left;">
    					<span id="passMessage" style="color:red"></span><input onclick="goUpdate()" type="button" value="수정" class="btn btn-primary btn-sm pull-right"/>
    				</td>
    			</tr>
    		</table>
    	</form>
    </div>
    <!-- 다이얼로그창(모달) - 아이디 중복체크 -->
    <div id="myModal" class="modal fade" role="dialog">
		  <div class="modal-dialog">
		
		    <!-- Modal content-->
		    <div id="checkType" class="modal-content">
		      <div class="modal-header panel-heading">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">아이디 중복체크</h4>
		      </div>
		      <div class="modal-body">
		        <p id="checkMessage"></p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		
		  </div>
		</div>
		<!--// 다이얼로그창(모달) - 아이디 중복체크 -->
		
		<!-- 다이얼로그창(모달) - 실패 -->
    <div id="myMessage" class="modal fade" role="dialog">
		  <div class="modal-dialog">
		
		    <!-- Modal content-->
		    <div id="messageType" class="modal-content">
		      <div class="modal-header panel-heading">
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		        <h4 class="modal-title">${msgType }</h4>
		      </div>
		      <div class="modal-body">
		        <p id="checkMessage">
		        	${msg }
		        </p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		
		  </div>
		</div>
		<!--// 다이얼로그창(모달) - 실패 -->
    <div class="panel-footer">스프1탄_인프런</div>
  </div>
</div>

</body>
</html>