<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Idea Protection Center</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi" />
<script src="/resources/common/js/jquery-3.1.0.min.js"></script> 
<!-- <script src="/webjars/bootstrap/3.3.7/dist/js/bootstrap.min.js"></script> -->
<link rel="stylesheet" href="/resources/common/css/index.css">
<link rel="stylesheet" href="/resources/common/css/style.css">
<link rel="stylesheet" href="/resources/common/css/inventor.css">
<link rel="icon" href="/resources/image/pavicon.png">


<script>
//js파일 밖으로 빼기 
$(document).ready(function()
{
	$('.ideaList').on("click","p",(function()
	{
		var r = $(this).parent().parent().children('input').attr('value');
		if(r=="undefind") alert('mainPage] rid 찾기 에러, 관리자에게 문의하세요');
		else location.href="/detail/"+r;
	}));
	$('.ideaList').on("click","button",function()
	{
		
	});
});
</script>
</head>
<body>
<c:import url="/WEB-INF/views/import/header.jsp"/>
<div id="hide_menu">
	<img src="/resources/image/hide_menu.png" alt="ham">	
</div>
<div id="hide_nav">
	<div id="hide_nav_cont">
	    <div id="profile">	    
	        <img src="${userVo.getProfileimg()}" alt="profile">		                
	        <h4>${currentUser.getName() }</h4>
	        <span>ideaconcert</span>
	    </div>
	    <div id="profile_menu">
	        <ul style="padding-left:0;">
	            <li>회원정보수정</li>
	            <li>1:1질문하기</li>
	            <li>아이디어 진행내역</li>
	         	<!-- 
	            <li>임시저장함</li>
	            <li>결제대기</li>
	            <li>결제내역</li>
	             -->
	        </ul>
	    </div>	    
	</div>
</div>
<div id="inven">
    <div id="inven_wrap">
        <nav>
            <div id="profile">
                <!-- 프로필 이미지 없을때-->                              
                <!-- <img src="/resources/image/attonrney_profile.jpg" alt="img1"> -->
                <!-- 프로필 이미지 있을때-->
                <img src="${userVo.getProfileimg()}" alt="profile">
                <h4>${currentUser.getName() }</h4>
                <span>${currentUser.getId() }</span>
            </div>
            <div id="profile_menu">
                <ul style="padding-left:0;">
		            <li onclick="location.href='/signup/editUser'">회원정보수정</li>
		            <li onclick="location.href='/qna/qnaBoard'">1:1질문하기</li>
		            <li onclick="location.href='#'">아이디어 진행내역</li>
		            <c:choose>
               	        	<c:when test="${currentUser.getRole()=='ROLE_PATIENTENTLAWYER'}">
                   	    		<li onclick="location.href='#'">정산 내역</li>
                       		</c:when>
					</c:choose>                       		
		         	<!-- 
		            <li>임시저장함</li>
		            <li>결제대기</li>
		            <li>결제내역</li>
		             -->
                </ul>
            </div>
            <div id="nav_benner">
                <ul style="padding-left:0;">
                    <li onclick="location.href='/registration/addidea'">
                    <c:choose>
               	        	<c:when test="${currentUser.getRole()=='ROLE_INVENTOR'}">
                   	    		<img src="/resources/image/sub_banner_1.jpg" alt="benner1" style="cursor:pointer" onclick='location.href="/registration/addidea"'>
                       		</c:when>
					</c:choose>                        
                    </li>
                    <!-- 
                    <li>
                        <img src="/resources/image/sub_banner_2.jpg" alt="benner2">
                    </li>
                    <li>
                        <img src="/resources/image/sub_banner_3.jpg" alt="benner3">
                    </li>
                    <li>
                        <img src="/resources/image/sub_banner_4.jpg" alt="benner4">
                    </li>
                    -->
                </ul>
            </div>
        </nav>
        <article>
            <section id="msg_section">
                <div id="now_count">
                    <h2>
			                    현재까지 진행중인<br>
			                    아이디어 ${ingIdea}건,<br>
			                    완료 ${comIdea}건이 있습니다.
                    </h2>
                </div> 
                <div id="now_msg">
                	<table>
                	<c:forEach var="message" items="${MessageList}" varStatus="status">
                		<tr>
                			<td>${message.getDate()} <br> ${message.getContent()}</td>
                			<td><img src="/resources/image/msg.png"></td>
                		</tr>
                	</c:forEach>
                	</table>
                </div>               
            </section>
            <div id="cont_header">
                <h2>아이디어 진행내역</h2>
            </div>
            <div id="cont_table">
                
                <!-- <ol>
                    <li style="font-size:1.3rem; font-weight:bold;">분류</li>
                    <li>                        
                        <select>
                            <option>전체</option>                            
                            <option>특허</option>   
                            <option>디자인권</option>   
                            <option>상표</option>                            
                            <option>저작권</option>                            
                        </select>
                    </li>
                    <li style="font-size:1.3rem; font-weight:bold;">상태</li>
                    <li>                        
                        <select>
                            <option>전체</option>                            
                            <option>전문가 지정</option>   
                            <option>컨설팅</option>   
                            <option>변리사 검토</option>                            
                            <option>가출원중</option>                            
                            <option>가출원완료</option>                            
                        </select>
                    </li>
                </ol> -->                
                <table style="margin-top:50px;">
                    <tr> 
                        <th>번호</th>
                        <th>등록날짜</th>
                        <th>분류</th>
                        <th>제목</th>
                        <th>상태</th>
                        <th>가출원일</th>
                        <th>출원일</th>
                        <th>비고</th>
                    </tr>
                   	<c:forEach var="process" items="${processList}" varStatus="status">
						<tr class="ideaList">
							<input type="hidden" value="${process.getRid()}"/>
							<td style="background:#f1f1f1;">${status.count }</p></td>
	                        <td><p>${process.getRegistration_date() }</p></td>
	                        <td><p>${process.getTypeOfInvent() }</p></td>
	                        <td><p>${process.getTitle()}</p></td>
	                        <td><p>${process.getReg_condition()}</p></td>
	                        <td><p>${process.getPre_apply_date()}</p></td>
	                        <td><p>${process.getApply_date()}</p></td>
	                        <c:choose>
		                        <c:when test="${process.getReg_condition() eq '출원완료' }">
		                        	<c:choose>
		                	        	<c:when test="${currentUser.getRole()=='ROLE_INVENTOR'}">
		                    	    		<td><button style="box-shadow:inset 0 -4px rgba(0,0,0,.1); background:#45d4fe;" class="btn_chul" onclick="location.href='/getDoc/${process.getRid()}'">출원서 다운로드</button></td>
		                        		</c:when>
		                        		<c:otherwise>
		                        			<td>-</td>
		                        		</c:otherwise>
		                        	</c:choose>
		                        </c:when>
		                        <c:when test="${process.getReg_condition() eq '결제대기중' }">
		                        	<c:choose>
		                	        	<c:when test="${currentUser.getRole()=='ROLE_INVENTOR'}">
		                    	    		<td><button style="box-shadow:inset 0 -4px rgba(0,0,0,.1); background:#45d4fe;" class="btn_chul">결제하기</button></td>
		                        		</c:when>
		                        		<c:otherwise>
		                        			<td>-</td>
		                        		</c:otherwise>
		                        	</c:choose>
		                        </c:when>
		                        <c:otherwise>
	                        		<td>-</td>
	                        	</c:otherwise>
	                        </c:choose>
	                        
						</tr>
					</c:forEach>
                </table>                
                <div id="notice_title">
                    <h2>공지사항</h2>
                </div>
                <div id="table_notice">
                    <table>
                        <c:forEach items="${noticeList}" var="list" varStatus="status">
    					<tr onclick="location.href='/notice/noticeList/${list.getNid()}'">
    						<td>${list.getTitle()}</td>			    		
			    			<td>관리자</td>			    			
			    			<td>${list.getDate()}</td>			    			
			    		</tr>
					</c:forEach>
                    </table>
                <button style="box-shadow:inset 0 -4px rgba(0,0,0,.1); background:#45d4fe;" onclick="location.href='/notice/noticePage'">
                        더보기
                </button>
            </div>                
            </div>
        </article>
    </div>    
</div>
<c:import url="/WEB-INF/views/import/footer.jsp"/>
<script>
function getApplyDoc(start_rid){
	
	location.href="/getDoc/"+start_rid;
}
	$("#hide_menu").click(function(){
		$("#hide_nav").animate({width:"200px"});		
	});
	$(document).click(function(e){
		if($('#hide_nav').css('width') == '200px'){
			if($("#hide_nav").has(e.target).length == 0){
				$('#hide_nav').animate({width:"0"});
			}
		}
	});
</script>
</body>
</html>