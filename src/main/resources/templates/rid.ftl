<!doctype html>
<html lang="en" xmlns="http://java.sun.com/jsf/core">
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <title>Hl7 Message Client</title>
    <script type="application/javascript" src="http://cdn.bootcss.com/jquery/1.9.1/jquery.min.js"></script>

    <script type="application/javascript">
        $(document).ready(function () {
            $('#requestType').change(function(){
                if ($(this).val() == "SUMMARY"){
                    $("#url").val("http://202.105.136.186:7016/source/IHERetrieveSummaryInfo");
                    $("#patientID_div").show();
                    $("#lowerDateTime_div").show();
                    $("#upperDateTime_div").show();
                    $("#mostRecentResults_div").show();
                    $("#documentUID_div").hide();
                    $("#preferredContentType_div").hide();
                }else if ($(this).val() == "DOCUMENT"){
                    $("#url").val("http://202.105.136.186:7016/source/IHERetrieveDocument");
                    $("#patientID_div").hide();
                    $("#lowerDateTime_div").hide();
                    $("#upperDateTime_div").hide();
                    $("#mostRecentResults_div").hide();
                    $("#documentUID_div").show();
                    $("#preferredContentType_div").show();
                }else if ($(this).val() == "LIST-MEDS"){
                    $("#patientID_div").show();
                }else if ($(this).val() == "LIST-ALLERGIES"){
                    $("#patientID_div").show();
                }
            });


            $("#send").click(function () {
                var type = $("#requestType").val();
                var url = $("#url").val();
                if (type == "SUMMARY"){
                    url += "?requestType=SUMMARY";
                    url += "&patientID=" + $("#patientID").val();
                    url += "&lowerDateTime=" + $("#lowerDateTime").val();
                    url += "&upperDateTime=" + $("#upperDateTime").val();
                    url += "&mostRecentResults=" + $("#mostRecentResults").val();

                }else if (type == "DOCUMENT"){
                    url += "?requestType=DOCUMENT";
                    url += "&documentUID=" + $("#documentUID").val();
                    url += "&preferredContentType=" + $("#preferredContentType").val();

                }else if (type == "LIST-MEDS"){
                    url += "?requestType=LIST-MEDS";
                    url += "&patientID=" + $("#patientID").val();
                }else if (type == "LIST-ALLERGIES"){
                    url += "?requestType=LIST-ALLERGIES";
                    url += "&patientID=" + $("#patientID").val();
                }else {
                    if ($("custom_params").length > 0){
                        url += $("#custom_params").val();
                    }
                }
                window.open(url);
            });
        });
    </script>
</head>
<body>
<h2>IHE RID Display 测试</h2>
<div class="row">
    <div class="col-md-6">
        <form class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-10 control-label">请求url</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="url" placeholder="url" value="http://202.105.136.186:7016/source/IHERetrieveSummaryInfo">
                </div>
            </div>
            <div class="form-group">
                <label  class="col-sm-6 control-label">请求类型</label>
                <select class="col-sm-6" id="requestType">
                    <option selected="selected">SUMMARY</option>
                    <option>DOCUMENT</option>
                    <option>LIST-ALLERGIES</option>
                    <option>LIST-MED</option>
                    <option>OTHER</option>
                </select>
            </div>

            <div class="form-group" id="patientID_div">
                <label  class="col-sm-6 control-label">patientID</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control" id="patientID" placeholder="" value="1">
                </div>
            </div>
            <div class="form-group" style="display: none" id="documentUID_div">
                <label  class="col-sm-6 control-label">documentUID</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control" id="documentUID" placeholder="" value="111">
                </div>
            </div>
            <div class="form-group" id="lowerDateTime_div">
                <label  class="col-sm-6 control-label">lowerDateTime</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control" id="lowerDateTime" placeholder="" value="2018-01-08T00:00:00">
                </div>
            </div>
            <div class="form-group" id="upperDateTime_div">
                <label class="col-sm-6 control-label">upperDateTime</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control" id="upperDateTime" placeholder="" value="2018-03-08T00:00:00">
                </div>
            </div>
            <div class="form-group" id="mostRecentResults_div">
                <label class="col-sm-6 control-label">mostRecentResults</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control" id="mostRecentResults" placeholder="" value="0">
                </div>
            </div>
            <div class="form-group" style="display: none" id="preferredContentType_div">
                <label class="col-sm-6 control-label">preferredContentType</label>
                <select class="col-sm-6" id="preferredContentType">
                    <option selected="selected">application/jpg</option>
                    <option>application/pdf</option>
                    <option>application/error</option>
                </select>
                <!--<div class="col-sm-6">-->
                    <!--<input type="text" class="form-control" id="preferredContentType" placeholder="" value="application/jpg">-->
                <!--</div>-->
            </div>
        </form>
    </div>
    <div class="col-md-6">
        <form class="form-horizontal">
            <div class="form-group">
                <label class="col-sm-6 control-label">自定义参数</label>
                <div class="col-sm-6">
                    <input type="text" class="form-control" id="custom_params" placeholder="默认为null">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-6 col-sm-12">
                    <button type="button" class="btn btn-success" id="send">发送请求</button>
                </div>
            </div>
            <!--<table class="table table-condensed">-->
                <!--<tr>-->
                    <!--<th>本地时间信息</th>-->
                    <!--<th>服务器时间信息</th>-->
                <!--</tr>-->
                <!--<tr>-->
                <!--<tr>-->
                    <!--<td>TIME:</td>-->
                    <!--<td>2017-03-03 21:21:12</td>-->
                <!--</tr>-->
                <!--<tr>-->
                    <!--<td>TIME:</td>-->
                    <!--<td>2017-03-03 21:21:12</td>-->
                <!--</tr>-->
                <!--</tr>-->
            <!--</table>-->
        </form>

    </div>

</div>
<!--<label>自定义消息：</label>-->
<!--<div class="jumbotron" id="custom_message_input">-->
    <!--&lt;!&ndash;<p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>&ndash;&gt;-->
<!--</div>-->
<!--<label>消息面板：</label>-->
<!--<div class="jumbotron" id="message_output">-->
    <!--&lt;!&ndash;<p><a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>&ndash;&gt;-->
<!--</div>-->
<!-- Optional JavaScript -->
<!-- jQuery first, then Popper.js, then Bootstrap JS -->
<!--<script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>-->
<script src="https://cdn.bootcss.com/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.bootcss.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</body>
</html>