<%@tag description="Home Layout" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>TITLE</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/js/jquery.js"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min.js"></script>

    <c:set var="action" value="${requestScope['javax.servlet.forward.request_uri']}"/>

    <style>
        #main-nav > li {
            margin-bottom: 4px;
        }
        #main-nav > li > a {
            padding: 10px 8px;
            font-size: 12px;
            font-weight: 600;
            color: #4A515B;
            background: #E9E9E9;
            border: 1px solid #D5D5D5;
            border-radius: 0px;
        }
        #main-nav > li.active > a, #main-nav > li > a:hover {
            color: #FFF;
            background: #3C4049;
            border-color: #2B2E33;
        }

        .second-nav > li > a {
            padding: 10px 8px;
            font-size: 12px;
            color: #4A515B;
            border-radius: 0px;
        }

        .second-nav > li.active > a, .second-nav > li > a:hover {
            background: #CCCCCC;
        }
    </style>

</head>
<body style="padding:0 15px;">

<div class="navbar" role="navigation" style="background-color: #cccccc;margin: 5px 15px;;border-radius: 0px;">
    <div class="container-fluid">
        <a class="navbar-brand" href="/">TITLE | ${action}</a>
    </div>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-xs-3">
            <jsp:include page="/view/include/main-nav.jsp"/>
        </div>
        <div class="col-sm-9 col-xs-9">
            <div style="margin: 0 0 0 -15px;">
                <c:if test="${error != null}">
                    <div width="80%" align="center" class="alert alert-danger" role="alert">${error}</div>
                </c:if>

                <c:if test="${flash != null}">
                    <div width="80%" align="center" class="alert alert-success" role="alert">${flash}</div>
                </c:if>
                <jsp:doBody />
            </div>
        </div>
    </div>
</div>
</body>
</html>