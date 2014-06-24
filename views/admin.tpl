<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Lunch Survey</title>

    <!-- Bootstrap -->
    <link href="static/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body>

    <div class="container">
        <div class="col-md-4">
            <form action="user" method="post">
                <div class="form-group">
                    <input type="text" name="name" placeholder="Name" required=""/>
                    <input type="text" name="weight" placeholder="Weight" required=""/>
                </div>
            <button class="btn btn-lg btn-primary btn-block" type="submit">Add User</button>
            </form>
        </div>
        <div class="col-md-4">
            <form action="reset" method="post">
                <button class="btn btn-lg btn-danger btn-block" type="submit">Reset Votes</button>
            </form>
            %if started:
                <form action="stop" method="post">
                    <button class="btn btn-lg btn-warning btn-block" type="submit">Stop Survey</button>
                </form>
            %else:
                <form action="start" method="post">
                    <button class="btn btn-lg btn-success btn-block" type="submit">Start Survey</button>
                </form>
            %end
                <form action="results" method="post">
                    <button class="btn btn-lg btn-primary btn-block" type="submit">Tabulate Results</button>
                </form>
        </div>
    </div>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="static/js/bootstrap.min.js"></script>
  </body>
</html>
