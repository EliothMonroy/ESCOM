<%-- 
    Document   : Frame_Air
    Created on : 1/12/2016, 09:56:28 PM
    Author     : GO_HA
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Piot</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/styles.css">
    </head>
    <body>
        <div style="text-align:center; background: #43C6DB; color: whitesmoke;"><h1>PioT</h1></div>
        <div class="container">
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <div  class="span4 well" style="padding-bottom:0">
                        <form accept-charset="UTF-8" action="Piot_Ser" method="POST">

                            <textarea class="span4" id="message" name="message" style="text-align:justify;width:320px;"
                            placeholder="Write your new Piot" rows="5"></textarea>
                            </br><div class="pull-right">140</div>
                            <button class="btn btn-info" type="submit" style="background: white;  border: solid;  color: #00ccff;"><div style="color: blueviolet;">New Piot</div></button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
         <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="js/jquery.js"></script>
        <!-- JS de bootstrap -->
        <script src="js/bootstrap.js"></script>
    </body>
</html>
