<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="_csrf" content="${_csrf.token}" />
	<meta name="_csrf_header" content="${_csrf.headerName}" />
    <title>Idea Protection Center</title>
    <script src="https://code.jquery.com/jquery-3.1.0.min.js"></script>  
    <script src="/resources/common/js/comment.js"></script>  
    
    <link href="/resources/common/css/style.css" rel="stylesheet">
    <link href="/resources/common/css/index.css" rel="stylesheet">
    
<script>
$(document).ready(function()
{
	//권한에 따라 보여주기
	if("${user}" == "pl")
	{
		enablePl();
	}
	else if("${user}" == "inventor")
	{
		enableInventor();
	var hideEl = document.getElementsByClassName('box_comment1')
		for(var i =0; i <hideEl.length ; i++)
			hideEl[i].style.display="none";
	}
	else
	{
		location.href="/authError";
	}	
	
	//폼 버튼 이벤트 
	$('#tmpSave').on("click",function()
	{
		ideaSave("tmp");
	});
	$('#agree').on("click",function()
	{
		alert('저장후에는 어쩌구~ 답변을 기다려야~ 어쩌구 저장하시겠습니까~ 어쩌구~');
		ideaSave("save");
	});

	
	//클릭에 따라 내용 바꿔주기
	$('#IdeaModifyList').on("click","tr",function()
	{
		//IdeaModifyList 내부의 tr중 clickedIdea를 가지고있는 요소를 clickedIdea를 제거 
		$(this).parent().find('.clickedIdea').removeClass('clickedIdea');

		var rid = $(this).children('input').attr('value');
		
		if(rid == ${lastRid})
		{
			if("${user}" == "pl")
				enablePl();
			else if("${user}" == "inventor")
				enableInventor();
			else
				alert("유저 어디감 : " + "${user}" );	
		}
		else
		{
			if("${user}" == "pl")
				disablePl();
			else if("${user}" == "inventor")
				disableInventor();
			else
				alert("유저 어디감 : " + "${user}" );	
		}

		//현재 선택된 요소(tr)에 clickedIdea를 붙임
		$(this).addClass('clickedIdea');
		
		showClickedList(rid);	
		
	})

	//예시 
    $(".txt_box > button").click(function(){
        $(this).nextAll(".hiding_box").fadeIn();
    });
    $(".close_btn").click(function(){
        $(this).parents(".hiding_box").fadeOut();
    });

});

</script>
</head>
<body>
    <c:import url="/WEB-INF/views/import/header.jsp"/>
    <div class="wrap_comment">       
        <section>            
           <nav>
                <div id="profile">
                    <img src="#" alt="profile">
                    <h4>${sessionScope.currentUser.getName()} 회원님</h4>
                    <span>${sessionScope.currentUser.getId()}</span>
                </div>
                <div id="profile_menu">
                    <ul>
                        <li>아이디어 진행내역</li>
                        <li>회원정보수정</li>                                                
                    </ul>
                </div>
                <div id="nav_benner">
                    <ul>
                        <li>
                            <img src="#" alt="benner1">
                        </li>
                        <li>
                            <img src="#" alt="benner2">
                        </li>
                        <li>
                            <img src="#" alt="benner3">
                        </li>
                        <li>
                            <img src="#" alt="benner4">
                        </li>
                    </ul>
                </div>
            </nav>            
            <article class="sub_head">                    
                <h1><b>아이디어</b> 초안</h1>                
                <img src="/resources/image/cmt.png" alt="cmt" style="width:100%; float:left;">
            </article>                
            <article class="modify_log">                    
                <h1>아이디어수정내역</h1>   
                <table id="IdeaModifyList">
                	<c:forEach items="${processList}" var="list" varStatus="status">
						<c:if test="${status.index == 0}">
							<tr class="clickedIdea">
								<input type="hidden" value="${list.getRid()}"/>
								<td class="title_td">아이디어 등록(초안)</td>
						       <td class="date_td">${list.getRegistration_date()}</td>
		                	</tr>
						</c:if>
						<c:if test="${status.index > 0}">
							<tr>
								<input type="hidden" value="${list.getRid()}"/>
								<td class="title_td">${status.index}차 전문가 검토 및 수정안</td>
		                        <td class="date_td">${list.getRegistration_date()}</td>
		                  	</tr>
		                </c:if>   	
					</c:forEach>		
				</table>                             
            </article>  
            <article style="width: 100%;>
               <input id="currentPosition" type="hidden" value="${item.getRid()}"/>
               <div class="txt_box">
                    <h2>발명분야</h2>   
                    <button>작성 예시</button>
                    <div id="BeforeCommentTypeOfInvent" class="before_cmt">
                        <textarea disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
                    </div>             
                    <div id="RegtypeOfInvent" class="box_before1">                        
                        <input type="text" value="${item.getTypeOfInvent() }" disabled="disabled" class="disabled" />
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div id="AfterCommentTypeOfInvent" class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..." disabled="disabled" class="disabled"></textarea>
                        </div>
                    </div>
                </div>
                <div class="hr"></div>
                 <div class="txt_box">
                    <h2>제목</h2>
                    <button>작성 예시</button>
                    <div id="BeforeCommentTitle" class="before_cmt">
                        <textarea disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
                    </div>
                    <div id="RegTitle" class="box_before1">                        
                        <input type="text" value="${item.getTitle() }" disabled="disabled" class="disabled"/>
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div id="AfterCommentTitle" class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..." disabled="disabled" class="disabled"></textarea>
                        </div>
                    </div>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>요약</h2>
                    <button>작성 예시</button>
                    <div id="BeforeCommentSummary" class="before_cmt">
                        <textarea disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
                    </div>                    
                    <div id="RegSummary" class="box_before1_b">   
	                    <textarea disabled="disabled" class="disabled">${item.getSummary()}</textarea>                     
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div id="AfterCommentSummary" class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..." disabled="disabled" class="disabled"></textarea>
                        </div>
                    </div>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="txt_box">
                    <h2>필요이유</h2>
                    <button>작성 예시</button>
                    <div id="BeforeCommentWhyInvent" class="before_cmt">
                        <textarea disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
                    </div>
                    <div id="RegWhyInvent" class="box_before1_b">                        
                         <textarea disabled="disabled" class="disabled">${item.getWhyInvent()}</textarea>                     
                   </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div id="AfterCommentWhyInvent" class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..." disabled="disabled" class="disabled"></textarea>
                        </div>
                    </div>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>기존제품설명 및 문제점</h2>
                    <button>작성 예시</button>
                    <div id="BeforeCommentProblem" class="before_cmt">
                    	<textarea disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
                    </div>
                    <div id="RegProblem" class="box_before1_b">                        
                         <textarea disabled="disabled" class="disabled">${item.getProblem()}</textarea>
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div id="AfterCommentProblem" class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..." disabled="disabled" class="disabled"></textarea>
                        </div>
                    </div>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>문제해결방법</h2>
                    <button>작성 예시</button>
                    <div id="BeforeCommentSolution" class="before_cmt">
                    	<textarea disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
                    </div>
                    <div id="RegSolution" class="box_before1_b">                        
                    	<textarea disabled="disabled" class="disabled">${item.getSolution()}</textarea>
                    </div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div id="AfterCommentSolution" class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..." disabled="disabled" class="disabled"></textarea>
                        </div>
                    </div>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>발명의 효과</h2>
                    <button>작성 예시</button>
                    <div id="BeforeCommentEffect" class="before_cmt">
                   		<textarea disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
                    </div>
                    <div id="RegEffect" class="box_before1_b">                        
                    	<textarea disabled="disabled" class="disabled">${item.getEffect()}</textarea>
					</div>
                    <div class="box_comment1">
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div id="AfterCommentEffect" class="comment1_txt">
                           <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..." disabled="disabled" class="disabled"></textarea>
                        </div>
                    </div>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <div class="txt_box">
                    <h2>핵심구성요소</h2>
                    <button>작성 예시</button>
                    <div id="BeforeCommentCore_Element" class="before_cmt">
                    	<textarea disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
                    </div>
                    <div id="RegCore_Element" class="box_before1_b">                        
                    	<textarea disabled="disabled" class="disabled">${item.getCore_element()}</textarea>
					</div>
                    <div class="box_comment1">                    
                        <div class="img_comt">
                            <img src="/resources/image/comment.png" alt="cmt_img">
                        </div> 
                        <div id="AfterCommentCore_Element" class="comment1_txt">
                            <img src="/resources/image/arr.png">
                            <textarea placeholder="Comment..." disabled="disabled" class="disabled"></textarea>
                        </div>
                    </div>
                    <div class="hiding_box">
                        <div class="hiding_box_header">
                            <h3>저작물 명칭</h3>
                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
                        </div>  
                        <div class="hiding_box_content">
                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
                        </div>                                                   
                    </div>
                </div>
                <div class="hr"></div>
                <form id="commentForm">             
	                <div class="txt_box">
	                    <h2 style="width:100%">도면첨부</h2>
	                    <button>작성 예시</button>
	                    <div id="BeforeFileComment" class="before_cmt">
	                    	<textarea disabled="disabled" class="disabled"/> 이전 코멘트</textarea>
	                    </div>
	                    <div id="demo_box">
	                        <div class="demo"></div>
	                        <div class="demo"></div>
	                        <div class="demo"></div>
	                        <div class="demo"></div>
	                        <div class="demo"></div>
	                        <div class="demo"></div>                                            
	                    </div>
	                    <div class="box_comment1">
	                        <div class="img_comt">
	                            <img src="/resources/image/comment.png" alt="cmt_img">
	                        </div> 
	                        <div id="AfterCommentFiles" class="comment1_txt">
	                            <img src="/resources/image/arr.png">
	                            <textarea placeholder="Comment..." disabled="disabled" class="disabled"></textarea>
	                        </div>
	                    </div>
	                    <div class="hiding_box">
	                        <div class="hiding_box_header">
	                            <h3>저작물 명칭</h3>
	                            <img src="/resources/image/close.png" alt="close" class="close_btn"> 
	                        </div>  
	                        <div class="hiding_box_content">
	                            <span><b>예 ) </b> 전자상거래, 플랫폼, 금융, 서비스 화학...</span>
	                        </div>                                                   
	                    </div>
	                </div>     
	                <div class="hr"></div>           
	                <div id="fin"> 
	                    <button type="button" id="tmpSave">임시저장</button>
	                    <button type="button" id="agree">저장</button>                    
	                </div>
	            </form>
            </article>
        </section>
    </div>
    <c:import url="/WEB-INF/views/import/footer.jsp"/>
</body>
</html>