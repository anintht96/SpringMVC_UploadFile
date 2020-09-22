<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<c:url value="/resources/css/bootstrap.min.css" />"rel="stylesheet">
<script src="<c:url value="/resources/js/jquery-3.5.1.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<script src="<c:url value="/resources/js/jquery.form.min.js" />"></script>
<title>index</title>
</head>
<body>

	<form:form id="formUploadFile" method="POST" action="uploadFile" enctype="multipart/form-data" modelAttribute="myFile">
	    File: <input type="file" name="multipartFile" /> <br /> <br/>
	    Description: <form:input path="description"/> <br />
	    <input type="submit" value="Submit" />
  	</form:form>
  
  <br /> <br />
  <div class="progress" id="progressbox" style="height: 45px; width: 70%" >
    <div class="progress-bar progress-bar-striped active" id="progressbar"
      role="progressbar" aria-valuenow="80" aria-valuemin="0"
      aria-valuemax="100" style="width: 0%">
      <div id="status" style="text-align: center; width: 100%; margin-top: 10px"></div>
    </div>
  </div>
</body>
<script>
$(document).ready(function() {
  var exist = false;
  
    $('#formUploadFile').submit(function(e) {  
            e.preventDefault();
            
            $(this).ajaxSubmit({ 
                beforeSubmit: function() {
                  resetProgressBar();
                },
                uploadProgress: function (event, position, total, percentComplete){  
                    console.log(percentComplete+"");
                  $("#progressbar").width(percentComplete + '%');
                  if (percentComplete < 100) {
                    $("#status").html(percentComplete + '%');
                  }
                  if (percentComplete == 100) {
                    $("#status").html("Saving...");
                  }
                },
                success:function (responseText, statusText, xhr){
                  $("#status").html("Completed!");
                    $("#progressbar").removeClass('progress-bar-striped active')
                },
                error: function(responseText, statusText, xhr){
                  resetProgressBar();
              console.log(responseText);
              console.log(statusText);
              console.log(xhr);
                },
                //url:       url         // override for form's 'action' attribute 
                type:      'POST',        // 'get' or 'post', override for form's 'method' attribute 
                //dataType:  null        // 'xml', 'script', or 'json' (expected server response type) 
                clearForm: true,        // clear all form fields after successful submit 
                resetForm: true        // reset the form after successful submit 
            });
    });
    
    
    function resetProgressBar() {
        $("#progressbar").width(0 + '%');
        $("#progressbar").addClass('progress-bar-striped active')
        $("#status").html(0 + '%');
    }
});
</script>
	

</body>
</html>