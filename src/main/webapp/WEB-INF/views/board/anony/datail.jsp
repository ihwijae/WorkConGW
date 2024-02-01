<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<head>
</head>

<style>
.pagination {
	text-align: center;
}

#tr1 {
/* 	text-align: center; */
	padding-left: -10px;
}

tbody {
	text-align: center;
}

.td2 {
	text-align: left;
}

.card{
/* 	text-align: center; */
	padding-bottom: 30px;
}

.button1{
	text-align: right;
    padding-right: 18px;
}

.body{	
    padding-top: 15px;
    padding-left: 17px;
    padding-right: 17px;	
}

.btn1{
	text-align: right;
}

th{
	vertical-align: bottom;
    border-bottom: 2px solid #dee2e6;
}

</style>

<body>

<!-- 메인 content -->
	<div id="main-content" >
		<div class="container-fluid">
			<form:form commandName="boardFormVO" name="detailForm" action="${pageContext.request.contextPath }/board/anony/detail">
				<form:hidden path="anonyVO.pageIndex"/>
		        <form:hidden path="anonyVO.annoy_Board_Id" />
		        <form:hidden path="anonyVO.annoy_Board_Title"/>
		        <form:hidden path="anonyVO.annoy_Board_Content"/>
		        <form:hidden path="anonyVO.annoy_Board_ReadCnt"/>
		        <form:hidden path="anonyVO.annoy_Board_Create_Dt"/>

		<div class="row clearfix">
			<div class="col-12" style="margin-top: 2%;">
				<h2 style="font-family: S-CoreDream-6Bold">
					<i class="icon-bubbles"></i>&nbsp;익명 게시판
					<button type="button" class="btn btn-secondary float-right" onclick="window.close('<%=request.getContextPath()%>/board/notice/list');"
						style="margin-right: 22px; font-family: S-CoreDream-4Regular" > 
						<i class="icon-close"></i> <span>닫기</span>
					</button>
					<c:if test="${loginUser.emp_Id == anony.emp_Writer_Id }">
						<button class="btn btn-danger float-right m-r-5"
							data-type="confirm" onclick="remove_go();">
							<i class="fa fa-trash-o"></i> <span>삭제</span>
						</button>
						<button type="button" class="btn btn-info float-right m-r-5" onclick="modify_go();">
							<i class="fa fa-eraser"></i> <span>수정</span>
						</button>
					</c:if>
				</h2>
				<hr>
			</div>
		</div>
	<div class="div2">
		<div class="row clearfix" >
			<div class="col-lg-12 col-md-12" >
				<div class="card" style="font-family: S-CoreDream-4Regular">
					<div class="body project_report" >
						<div class="body" style="padding-left: 0px; padding-right: 0px;">
							<div class="table-responsive">
								<table class="table table-hover m-b-0">
									<thead class="shadow-none p-3 mb-5 bg-light rounded">
										<tr id="tr1">
											<td style="width:130px;">
												<h6 id="h6" style="font-weight: bold;">제목</h6>
											</td>
											<td colspan="5">
												<div style="padding-left:15px;border-left: 1px dotted gray; ">
													${anony.anony_Board_Title }&nbsp;&nbsp;&nbsp;

												</div>
											</td>
										</tr>
										<tr style= "vertical-align: bottom; border-bottom: 2px solid #dee2e6;">
											<td>
												<strong>작성일자</strong>
											</td>
											<td>
												<div style="padding-left:15px;border-left: 1px dotted gray;">
													<fmt:formatDate value="${anony.anony_Board_Create_Dt }" pattern="yyyy-MM-dd"/>
												</div>
											</td>
											<td style="width:130px;">
												<strong>조회수</strong>
											</td>
											<td>
												<div style="padding-left:15px;border-left: 1px dotted gray;">${anony.anony_Board_ReadCnt }</div>
											</td>
										</tr>
									</thead>
										<tr style="vertical-align: bottom; border-bottom: 2px solid #dee2e6;">
										</tr>
										</table>
<!-- 내용 -->
	<div style="margin-top: 20px; margin-top: 20px;padding-left: 13px;padding-right: 13px;">${anony.anony_Board_Content}</div>
						</div>
					</div>
				</div>
	<div class="header" style="padding-bottom: 0px;">
      <h2><b>💬 댓글 ${paginationInfo.totalRecordCount}</b></h2>
    </div>
<!-- 댓글 등록 -->
  <div class="body">
   	<form>
      <div class="form-group">
       	<textarea id="reply_Content" rows="4" class="form-control no-resize" placeholder="댓글을 입력해주세요"></textarea>
      </div>
      <div class="btn1">
       <button class="btn btn-primary" onclick="registAnonyReply();"><i class="fa fa-check-square"></i> 등록</button>
<!--     <a href="javascript:void(0);" class="float-right">13K users active</a> -->
	  </div>
    </form>
       <c:if test="${anony.anonyReplyList.size() == 0 }">
         <hr>
           <div style="height:70px;text-align: center;padding:10px;">
              <span>등록된 댓글이 없습니다.</span>
                 </div>
               		</c:if>
               		<br>
               		<c:if test="${anony.anonyReplyList.size() > 0 }">
               			<c:forEach items="${anony.anonyReplyList }" var="anonyReply">
                            <ul class="right_chat list-unstyled mb-0" id="replyList_${anonyReply.reply_Id }">
                                <li class="offline"> 
                                    <a href="javascript:void(0);">
                                        <div class="media">
                                        	<i class="icon-user" style="font-size: large;"></i>
	                                            <div class="media-body">
	                                                <span class="name" style="padding-left: 5px;">
	                                                	<c:if test="${anony.emp_Writer_Id == anonyReply.emp_Writer_Id }">
	                                                		글쓴이 
		                                            	</c:if>
	                                                	<c:if test="${anony.emp_Writer_Id != anonyReply.emp_Writer_Id }">
	                                                		익명
		                                            	</c:if>
	                                               	<small class="float-right"><i class="fa fa-clock-o"></i>
	                                                </small>
	                                                </span>
	                                                <c:if test="${loginUser.emp_Id == anonyReply.emp_Writer_Id }">
				                                    <div class="float-right">
				                                        <a href="javascript:void(0);" onclick="modifyReplyForm(${anonyReply.reply_Id},'${anonyReply.reply_Content }');"><i class="fa fa-edit"></i> 수정</a>
				                                        <a href="javascript:void(0);" style="margin-left:10px;" onclick="removeReply(${anonyReply.reply_Id});"><i class="fa fa-trash-o"></i> 삭제</a>
				                                    </div>
				                                    </c:if>
	                                                <span class="message">
	                                                	<h6 style="margin-bottom:5px; color: grey;">${anonyReply.reply_Content }</h6>
	                                                </span>
	<!--                                                 <span class="badge badge-outline status"></span> -->
	                                            </div>
                                        </div>
                                      </a>
                                  </li>
                                  </ul> 
                            </c:forEach>
                               <nav aria-label="Page navigation example" style="height:45px;text-align: center;margin-top:15px;">
				                  <ul class="pagination" style="display: inline-block;">
				                  </ul>z
                     			</nav>
                     	</c:if>
							<div class="button1" >
<!-- 								<button type="button" class="btn btn-outline-info"> -->
<!-- 									<i class="fa fa-paperclip">링크복사</i> -->
<!-- 								</button> -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>




<form name="replyRegistForm">
   <input type="hidden" name="anonyReplyVO.anony_Board_Id" value="${anony.anony_Board_Id }" />
   <input type="hidden" name="anonyReplyVO.reply_Content" />
</form>

<script type="text/javascript">


//댓글 등록
function registAnonyReply(){
   if($.trim($('textarea#reply_Content').val())==""){
      alert('내용을 입력하세요.');
      $('textarea#reply_Content').focus();
      return;
   }
   
   $('input[name="anonyReplyVO.reply_Content"]').val($('textarea#reply_Content').val());
   
   $.ajax({
      url:'<c:url value="/board/anony/reply/regist"/>',
      type:'post',
      data:$('form[name="replyRegistForm"]').serialize(),
      success:function(){
         alert('댓글 등록 완료');
         window.location.reload(true);
      },
      error:function(){
         alert('댓글 등록이 실패했습니다.');
      }
   });
}

// 댓글 수정창 표시
function modifyReplyForm(reply_Id, reply_Content){
   if($('#replyListModify_'+reply_Id).children().length>0){
      return;
   }
   var modifyForm = '<div id="replyListModify_'+reply_Id+'" class="body" style="background-color: #eee;margin-top:15px;">'
                   +'<div class="form-group">'
                         +'<textarea id="reply_Content" rows="3" class="form-control no-resize">'+reply_Content+'</textarea>'
                   +'</div>'
                   +'<div class="post-toolbar-b align-right">'
                       +'<button class="btn btn-info" onclick="modifyReply('+reply_Id+');">수정</button>'
                       +'<button style="margin-left:5px;" class="btn btn-secondary" onclick="modifyCancel('+reply_Id+');">취소</button>'
                  +'</div>'
               +'</div>'
   $('#replyList_'+reply_Id).append(modifyForm);
}

// 댓글 수정
function modifyReply(reply_Id){
   var textarea = $('#replyListModify_'+reply_Id+' textarea');
   if($.trim(textarea.val()) == ""){
      alert('내용을 입력하세요.');
      textarea.focus();
      return;
   }
   
   $.ajax({
      url:'<c:url value="/board/anony/reply/modify"/>',
      type:'post',
      data:{'reply_Id':reply_Id,'reply_Content':textarea.val()},
      success:function(){
         alert('댓글이 수정되었습니다.');
         window.location.reload(true);
      },
      error:function(){
         alert('댓글 수정 실패');
         window.location.reload(true);
      }
   });
}

// 댓글 수정 취소
function modifyCancel(reply_Id){
   $('#replyListModify_'+reply_Id).remove();
}

// 댓글 삭제
function removeReply(reply_Id){
   var chk = confirm('댓글을 삭제하시겠습니까?');
   if(!chk) return;
   
   $.ajax({
      url:'<c:url value="/board/anony/reply/remove"/>',
      type:'post',
      data:{'reply_Id':reply_Id},
      success:function(){
         alert('댓글이 삭제되었습니다.');
         window.location.reload(true);
      },
      error:function(){
         alert('댓글 삭제 실패');
      }
   });
}

// 댓글 페이지네이션
function searchAnonyReplyList(pageNo){
   if(!pageNo){
      pageNo = 1;
   }
   var detailForm = document.detailForm;
   $('input[name="anonyVO.pageIndex"]').val(pageNo);
   detailForm.submit();
}

//수정 페이지
function modify_go(){
	var anonyModifyForm = document.detailForm;
	anonyModifyForm.action = '${pageContext.request.contextPath }/board/anony/modifyForm';
	
	anonyModifyForm.submit();
}

//게시글 삭제
function remove_go(){
	var check = confirm('글을 삭제하시겠습니까?');
	if(!check) return;
	
	var detailForm = document.detailForm;
	detailForm.action = '${pageContext.request.contextPath }/board/anony/remove';
	
	var form = new FormData(detailForm);
	
	$.ajax({
		url:detailForm.action,
		type:'post',
		data:form,
		processData:false,
		contentType:false,
		success:function(){
			alert('글이 삭제되었습니다.');
			window.opener.location.reload(true);
			window.close();
		},
		error:function(){
			alert('삭제 실패');
		}
	});
}
// $(function () {
//     $('.js-sweetalert').on('click', function () {
//         var type = $(this).data('type');
//         if (type === 'basic') {
//             showBasicMessage();
//         }
        
//         else if (type === 'confirm') {
//             showConfirmMessage();
//         }
//     });
// });

// function showConfirmMessage() {
//     swal({
//         title: "정말 삭제하시겠습니까?",
// //         text: "You will not be able to recover this imaginary file!",
//         type: "warning",
//         showCancelButton: true,
//         confirmButtonColor: "#dc3545",
//         confirmButtonText: "삭제",
//         closeOnConfirm: false
//     }, function () {
//         swal("삭제가 완료되었습니다.", "  ", "success");
//     });
// }
</script>



</body>