<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<style>
	.formGroup{
		display:none;
	}
	.dropdown-toggle::after{
		display: none;
	}
</style>

<body>
<!-- 헤더인클루드 -->
<%@ include file="../include/header.jsp"%>
<section class="subPageContain">
	<!-- 사이드바 -->
	<%@ include file="boardSidebar.jsp"%>
	<!--컨텐츠 영역-->
	<div class="contentConteiner">
		<!-- Overlay For Sidebars -->
		<div id="main-content">
			<div class="container-fluid">
				<div class="block-header">
					<div class="row">
						<div class="col-sm-3" >
							<h2 style="padding-left:10px; font-size:2em ; font-family:paybooc-Bold ; "><i class="far fa-sticky-note"></i>&nbsp;글작성 </h2>
						</div>
						<div class="col-sm-9" style="font-family: S-CoreDream-4Regular">
							<div style="float:right;">
								<button type="button" class="btn btn-primary" style="width:100px;font-size:1.2em;" onclick="submit_go();">등록</button>
								<button type="button" onclick="goBackToList();" class="btn btn-secondary" style="width:100px;font-size:1.2em;">목록</button>
							</div>
						</div>
					</div>
				</div>

				<div class="row clearfix" style="font-family: S-CoreDream-4Regular">
					<div class="col-lg-12 col-md-12 col-sm-12">
						<div class="card">
							<div class="body">
								<form:form modelAttribute="boardFormVO" name="boardRegistForm">
									<form:hidden path="noticeVO.emp_writer_id" value="${loginUser.emp_Id }"/>
									<form:hidden path="noticeVO.notice_update_id" value="${loginUser.emp_Id }"/>
									<form:hidden path="noticeVO.notice_content" />
									<div id="fileUploadForm">
									</div>
									<div class="row clearfix">
										<!-- 게시판 선택 -->
										<div class="col-md-3">
											<label>게시판선택</label>
											<div class="form-group">
												<select id="selectBoard" class="form-control show-tick" onchange="changeCategory(this);">
													<option value="default">게시판 선택</option>
													<option value="notice">사내공지</option>
													<option value="anony">익명게시판</option>
												</select>
											</div>
										</div>
										<!-- 본문 -->
										<div class="col-md-3 col-sm-12 formGroup noticeForm">
											<label class="boardWriter">작성자</label>
											<div class="form-group">
												<input type="text" readonly class="form-control" placeholder="" value="${loginUser.emp_Name }" >
											</div>
										</div>
										<div class="col-md-3 col-sm-12 formGroup noticeForm">
											<label class="notice_important_yn">필독여부</label>
											<div class="form-group">
												<div class="form-group notice_important_yn">
													<select name="noticeVO.notice_important_yn" id="selectNoticeYN" class="form-control show-tick">
														<option value="default">-필독여부-</option>
														<option value="Y">설정</option>
														<option value="N">해제</option>
													</select>
												</div>
											</div>
										</div>
										<div class="col-sm-12 formGroup noticeForm anonyForm">
											<div class="form-group">
												<label class="boardTitle">제목</label>
												<input type="text" name="noticeVO.notice_title" id="boardTitle" class="form-control" placeholder="">
											</div>
										</div>
									</div>


									<div class="row clearfix">
										<!-- 파일 입력 -->
										<div class="col-12 formGroup noticeForm">
												<%--	                                <label>파일 첨부</label>--%>
												<%--	                                    <input type="file" name="fileUploadCommand.uploadFile" class="dropify" style="height: 100px;">--%>
												<%--	                                    <div class="mt-3"></div>--%>
											<input type="file" id="fileInput" style="display: none;" />
											<button type="button" class="btn btn-secondary" style="margin-bottom:5px;" onclick="myFileUpload();">파일 추가</button>
											<span class="float-right" style="margin:15px 10px 0 0;">파일 개수 <span id="fileCount">${empty boardFormVO.noticeVO.noticeAttachList ? 0 : boardFormVO.noticeVO.noticeAttachList.size()}</span>/5</span>
											<div style="border:1px solid gray;height:200px;overflow-y: scroll;">
												<table class="table table-hover center-aligned-table" style="margin-bottom: 0;">
													<thead style="height:50px;">
													<tr>
														<th style="width:200px;">타입</th>
														<th style="width:300px;">파일명</th>
														<th style="width:200px;">확장자</th>
														<th style="width:200px;">용량</th>
														<th style="width:100px;"><i class="fas fa-trash-alt" style="cursor: pointer;" onclick="removeAll();"></i>
														</th>
													</tr>
													</thead>
													<tbody id="appendTbody">
													<!-- 파일 입력 -->
													<c:if test="${!empty boardFormVO.noticeVO.noticeAttachList }">
														<c:forEach items="${boardFormVO.noticeVO.noticeAttachList }" var="noticeAttach" varStatus="status">
															<tr>
																<td>
																	<c:choose>
																		<c:when test="${noticeAttach.attach_type eq 'JPG' || noticeAttach.attach_type eq 'PNG' || noticeAttach.attach_type eq 'GIF'}">
																			이미지
																		</c:when>
																		<c:otherwise>
																			파일
																		</c:otherwise>
																	</c:choose>
																</td>
																<td style="font-weight: normal;">
																		${noticeAttach.attach_name }
																</td>
																<td style="font-weight: normal;">
																		${noticeAttach.attach_type }
																</td>
																<td style="font-weight: normal;">
																		${noticeAttach.attach_size }
																</td>
																<td>
																	<i class="fas fa-times" data-id="${status.index }" data-attach_id="${noticeAttach.attach_id }" style="cursor: pointer;" onclick="removeEl(this)"></i>
																</td>
															</tr>
														</c:forEach>
													</c:if>
													</tbody>
												</table>
											</div>
										</div>

										<!-- 내용 입력 -->
										<div class="col-sm-12 formGroup noticeForm anonyForm">
											<div class="summernote"style="height: 200px;"></div>
										</div>
									</div>
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<form name="anonyRegistForm" method="post">
			<input type="hidden" name="anony_Board_Title">
			<input type="hidden" name="anony_Board_Content">
		</form>

		<script>
			function goBackToList() {
				location.href = "${pageContext.request.contextPath}/board/notice/noticeList";
			}

			// 게시판 그룹 변경시 입력 폼 설정
			function changeCategory(obj){
				$('.formGroup').css('display','none');
				$('.boardWriter').text('작성자');
				$('.boardTitle').text('제목');
				$('.note-editable').html("");
				$('.'+obj.value+"Form").css("display",'block');
			}

			// 글 등록
			function submit_go(){
				let boardCategory = $('#selectBoard').val();
				let form = document.boardRegistForm;

				if(boardCategory=='default'){
					alert('게시판을 선택하세요.');
					return;
				}
				if($.trim($('#boardTitle').val())==""){
					alert('제목을 입력하세요.');
					$('#boardTitle').focus();
					return;
				}
				if($.trim($('.note-editable').text())==""){
					alert('내용을 입력하세요.');
					$('.note-editable').focus();
					return;
				}

				//사내공지
				if(boardCategory=='notice'){
					let notice_important_yn = $('select[name="noticeVO.notice_important_yn"]').val();
					if(notice_important_yn == "default"){	//위에서 option value가 default일 경우에 해당할때
						alert('필독여부를 선택해주세요.');
						return;
					}
					$('input[name="noticeVO.notice_content"]').val($('.note-editable').html());

					form.action = "<c:url value='/board/notice/regist'/>";
					form.encoding = "multipart/form-data";
				}

				//익명 게시판
				else if(boardCategory=='anony'){
					form = document.anonyRegistForm;
					var boardTitle = $('input#boardTitle').val();
					$('input[name="anony_Board_Title"]').val(boardTitle);

					var boardContent = $('div.note-editable').html();
					$('input[name="anony_Board_Content"]').val(boardContent);

					form.action = "<c:url value='/board/anony/regist'/>";
				}

				// 글 등록
				var formData = new FormData(form);
				$.ajax({
					url:form.action,
					type:'post',
					data:formData,
					processData:false,
					contentType:false,
					dataType:"text",
					success:function(data){
						if(boardCategory=='notice'){
							alert("공지게시판에 글이 등록되었습니다.");
							window.close();
							window.location.href='<c:url value="/board/notice/noticeList" />';

						}else if(boardCategory=='anony'){
							alert("익명게시판에 글이 등록되었습니다.");
							window.close();
							window.location.href='<c:url value="/board/anony/list" />'
						}
					},
					error:function(){
						alert("글 등록에 실패했습니다.");
						window.location.reload(true);
						window.close();
					}
				});
			}

			//파일 삭제용 고유 아이디
			var uuid = ${empty boardFormVO.noticeVO.noticeAttachList ? 0 : boardFormVO.noticeVO.noticeAttachList.size()};

			// 파일 업로드 버튼 클릭시
			function myFileUpload() {
				// document.getElementById('fileInput').click();
				if($('#appendTbody').children().length == 5){
					alert('파일은 5개까지만 첨부할 수 있습니다.');
					return;
				}

				// 선택 안된 파일 지우기
				$('.attach_'+uuid).remove();

				var input = $('<input>').attr({"type":"file",'class':'attach_'+uuid,"name":"fileUploadCommand.uploadFile",'onchange':'myFileChange();'}).css('display','none');
				$("#fileUploadForm").append(input);

				// 파일 선택
				var inputFileTag = $("input[name='fileUploadCommand.uploadFile']");
				inputFileTag.eq(inputFileTag.length-1).click();

			}
			//파일 선택시
			function myFileChange(){
				var inputFileTag = $("input[name='fileUploadCommand.uploadFile']");
				var filesLength = inputFileTag.length;

				var fileName = inputFileTag.eq(filesLength-1)[0].files[0].name;
				var extension = getExtensionOfFilename(fileName);
				var fileSize = (inputFileTag.eq(filesLength-1)[0].files[0].size)/1000 + "KB";
				var fileType;

				if(!(extension == 'PNG' || extension == 'DOC' || extension == 'DOCX' || extension == 'GIF' || extension == 'JAVA' || extension == 'JPG' || extension == 'PDF'|| extension == 'PPT' || extension == 'PPTX'|| extension == 'TXT' || extension == 'XLSX'|| extension == 'ZIP')){
					alert("지원하지 않는 파일 형식입니다.");
					inputFileTag.eq(filesLength-1).remove();
					return;
				}
				if(extension == 'PNG' || extension == 'GIF' || extension == 'JPG'){
					fileType = '이미지';
				}else{
					fileType = '파일';
				}

				// 파일 업로드 창에 표시하기
				var fileTag = '<tr>'
						+'<td>'+fileType+'</td>'
						+'<td style="font-weight: normal;">'+fileName+'</td>'
						+'<td style="font-weight: normal;">'+extension+'</td>'
						+'<td style="font-weight: normal;">'+fileSize+'</td>'
						+'<td><i class="fas fa-times" data-id="'+uuid+'" style="cursor: pointer;" onclick="removeEl(this)"></i></td>'
						+'</tr>';
				$('#appendTbody').append(fileTag);

				// 파일개수 수정
				$('#fileCount').text($('#appendTbody').children().length);

				$('#noFile').remove();

				uuid++;
			}

			//파일 확장자 추출 함수
			function getExtensionOfFilename(filename) {

				var _fileLen = filename.length;

				var _lastDot = filename.lastIndexOf('.');

				var _fileExt = filename.substring(_lastDot+1, _fileLen).toUpperCase();

				return _fileExt;
			}

			//파일 전체 삭제
			function removeAll(){
				if($('#appendTbody').children().length == 0) return;

				var check = confirm('파일을 전부 삭제하시겠습니까?');
				if(!check) return;

				$("input[name='fileUploadCommand.uploadFile']").remove();
				$('#appendTbody').children().each(function(){
					if($(this).find('i').attr('data-attach_id')){
						$('#deleteFile').append('<input type="hidden" name="fileUploadCommand.deleteFileIds" style="display:none;" value="'+$(this).find('i').attr('data-attach_id')+'"/>');
					}
					$(this).remove();
				});

				$('#attachInline').children().remove();
				$('#attachInline').append('<span id="noFile" style="font-weight: normal;">없음</span>');

				// 파일개수 수정
				$('#fileCount').text(0);
			}

			// 선택 파일 삭제
			function removeEl(obj){
				var check = confirm('파일을 삭제하시겠습니까?');
				if(!check) return;

				if($(obj).attr('data-attach_id')){
					$('#deleteFile').append('<input type="hidden" name="fileUploadCommand.deleteFileIds" style="display:none;" value="'+$(obj).attr('data-attach_id')+'"/>');
				}

				$(obj).closest('tr').remove();
				$(".attach_"+$(obj).attr('data-id')).remove();

				// 파일개수 수정
				$('#fileCount').text($('#appendTbody').children().length);
			}

		</script>
	</div>
</section>
<!-- 푸터 인클루드 -->
<%@ include file="../include/footer.jsp"%>
</body>
