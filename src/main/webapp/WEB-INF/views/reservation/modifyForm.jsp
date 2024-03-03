<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<title>${meetRoomVO.meet_Room_Name } 회의실 </title>
<style>
    #main-content{
        margin: 0px;
    }
    *, ::after, ::before{
        box-sizing: border-box;
    }
    .container-fluid-header, .container-fluid-footer{
        display: flex;
        justify-content: space-between;
        padding-top: 15px;
    }
    body {
        padding: 0px 30px 30px 30px;
    }
    .form-header > div {
        margin-top: 20px;
    }
    .col-xs-12 {
        padding: 5px;
    }
    div#main-content{
        border: solid 1px rgba(0,0,0,.03);
        border-radius: 1%;
        background-color: #ffffff;
        padding: 0px 10px 10px;
        margin-top: 20px;
    }
    body{
        padding: 0px 30px 30px 30px;
        background-color: rgba(0,0,0,.03);
    }
    .form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control{
        background-color: #ffffff;
    }
    #edit-participater{
        cursor: pointer;
    }
</style>

<body>
<%@ include file="../include/header.jsp"%>
<div id="main-content">
    <div class="container-fluid">
        <div class="form-header container-fluid-header">
            <h3 class="form-title">${meetRoomVO.meet_Room_Name } 회의실 수정</h3>

            <div>
                <button type="button" id="modifyBtn" onclick="modifyRoom();" class="btn btn-info header-btn">&nbsp;&nbsp;&nbsp;수 &nbsp;&nbsp;정&nbsp;&nbsp;&nbsp;</button>
                <button type="button" class="btn btn-danger" onclick="removeRoom();">삭제</button>
                <button type="button" class="btn btn-default" onclick="location.href='<%=request.getContextPath()%>/reservation/adminMain';">닫기</button>
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="col-md-4">
                <form:form modelAttribute="meetRoomVO" id="detailForm" name="meetRoomModifyForm" class="form-horizontal" >
                    <form:hidden id="" path="meet_Room_Id" value="${meetRoomVO.meet_Room_Id}"/>
                    <div class="row">
                        <div class="col-xs-12">
                            <label class="col-xs-4" for="edit-title">활성화 상태</label>
                            <br>
                            <form:select path="meet_Room_St" class="form-control selectSearch RoomSt" style="width:150px;font-size: 1.2em;float:left;margin-left: 10px;">
<%--                                <form:option value="${meetRoomVO.meet_Room_St}">--%>
<%--                                    <c:if test="${meetRoomVO.meet_Room_St} == 1" > 활성화</c:if>--%>
<%--                                    <c:if test="${meetRoomVO.meet_Room_St} == 0" > 비활성화</c:if>--%>
<%--                                </form:option>--%>
                                <form:option value="1">사용가능</form:option>
                                <form:option value="0">사용불가능</form:option>
                            </form:select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label class="col-xs-4" for="edit-title">회의실명</label>
                            <div class="col-sm-10 input-group-sm">
                                <form:input path="meet_Room_Name" id="meetRoomName" class="form-control roomName" value="${meetRoomVO.meet_Room_Name}" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label class="col-xs-4" for="edit-start">회의실 위치</label>
                            <div class="col-sm-10 input-group-sm">
                                <form:input path="meet_Room_No" id="meetRoomNo" class="form-control roomNo" value="${meetRoomVO.meet_Room_No}"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label class="col-xs-4" for="edit-end">수용인원</label>
                            <div class="col-sm-10 input-group-sm">
                                <form:input path="meet_Room_Capacity" id="meetRoomCapacity" class="form-control roomCapacity" value="${meetRoomVO.meet_Room_Capacity}"/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <label class="col-xs-4" for="edit-end">내용</label>
                            <div class="col-sm-10 input-group-sm">
                                <form:textarea path="meet_Room_Content" id="meetRoomContent" class="form-control roomContent" rows="4" cols="40" placeholder="${meetRoomVO.meet_Room_Content}" />
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
            <div class="col-md-8">
                <%-- 				<div class="mailbox-attachment-icon has-img" id="pictureView" style="background-image: url('getPicture?picture=${meetRoomVO.meetRoomAttachPath}');"></div> --%>
                <img alt="" src="getPicture?picture=${meetRoomVO.meet_Room_Attach_Origin}" style="width: 550px;border-top-width: 10px;margin-top: 50px;">
            </div>
        </div>

    </div>
</div>

<script>


    function modifyRoom(){
        var regex= /^[0-9]/g; // 숫자 정규식

        var roomName =$(".roomName").val();
        var roomNo =$(".roomNo").val();
        var roomCapacity= $(".roomCapacity").val();
        var roomContent= $(".roomContent").val();
        var image= $(".image").val();


        if (roomName == ""||roomName.length >20) {
            alert("회의실 이름을 적어주세요");
            return;
        }else if (roomNo == "" || roomNo.length >20) {
            alert("몇호인지 입력해주세요");
            return;
        }else if (!regex.test(roomCapacity) || roomCapacity <= 0 || roomCapacity >= 99) {
            alert("수용인원은 숫자만 입력해주세요");
            return;
        }else if (roomContent == "" || roomContent.length >100) {
            alert('내용을 입력해주세요');
        }

        var modifyForm = $('form[name="meetRoomModifyForm"]')[0];
        modifyForm.action = "<c:url value='/reservation/modify'/>";
        var formData = new FormData(modifyForm);
            console.log(formData);
        console.log(JSON.stringify(modifyForm))
        console.log(formData.values());
        $.ajax({
            url:modifyForm.action,
            type:'post',
            data: formData,
            processData:false,
            contentType:false,
            success:function(){
                alert("회의실을 수정하였습니다 ");
                window.location.href='<c:url value="/reservation/detail?meet_Room_Id=${meetRoomVO.meet_Room_Id}"/>';
            },
            error:function(){
                alert("오류가  발생했습니다. 연결이 유실됩니다");
            }
        });

    }
</script>
<script>
    var modifyForm = $('form[name="meetRoomModifyForm"]')[0];
    var formData = new FormData(modifyForm);
    function remove_go(){
        var check = confirm('회의실을 삭제하시겠습니까?');
        if(!check) return;

        var detailForm = document.detailForm;
        detailForm.action = '${pageContext.request.contextPath }/board/duty/remove';

        var form = new FormData(detailForm);

        $.ajax({
            url:detailForm.action,
            type:'post',
            data:form,
            processData:false,
            contentType:false,
            success:function(){
                alert('글이 삭제되었습니다.');
                window.close();
            },
            error:function(){
                alert('삭제 실패');
            }
        });
    }
</script>
<script type="text/javascript">
    function removeRoom(){
        if(confirm('해당 회의실을 삭제하시겠습니까?')){
            var detailForm = $('form[name="meetRoomModifyForm"]')[0];
            var formData = new FormData(detailForm);
            $.ajax({
                url:"<c:url value='/reservation/remove'/>",
                type:'post',
                data:formData,
                processData:false,
                contentType:false,
                success:function(response){
                    if(response && response > 0){
                        alert("회의실이 삭제되었습니다.");
                        location.href='<%=request.getContextPath()%>/reservation/adminMain';
                    }else{
                        alert("회의실 삭제에 실패했습니다..");
                        location.href='<%=request.getContextPath()%>/reservation/adminMain';
                    }

                },
                error:function(request, status, error){
                    alert("주소록 삭제에 실패했습니다..");
                    console.log(error);
                    window.close();
                }
            });
        }
    }
</script>
