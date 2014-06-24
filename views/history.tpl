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
    <div class="col-md-6 col-md-offset-3">
        <h1>Survey History
            <small>Team Awesome</small>
        </h1>
    </div>
    <div class="col-md-6 col-md-offset-1">
        %weights, voters, users_old = results
        <div class="page-header">
            <h3>Results</h3>
        </div>

        <ul class="list-group" id="foodout">
            %for food, weight in weights:
                %votes = ['{} ({:d})'.format(voter, rank+1) for voter,rank in voters[food]]
            <li class="list-group-item">
                <strong>{{food}}</strong> ({{weight}}): {{', '.join(votes)}}
            </li>
            %end
        </ul>
    </div>

    <div class="col-md-3">
        <div class="page-header">
            <h3>Effective Weights</h3>
        </div>
        <ul class="list-group">
            %for name, weight in users_old.items():
            <li class="list-group-item"><strong>{{name}}:</strong> {{weight}}</li>
            %end
        </ul>
        <div class="page-header">
            <h3>Past Results</h3>
        </div>
        <form action="history" method="get">
            <div class="form-group">
                <select class="form-control" name="date">
                    %for date in dates:
                        <option {{'selected=""' if date == sel_date else ''}}>{{date}}</option>
                    %end
                </select>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-default">Show</button>
            </div>
        </form>
    </div>
</div>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="static/js/bootstrap.min.js"></script>
</body>
</html>