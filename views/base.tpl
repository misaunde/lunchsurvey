<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Lunch Survey</title>

    <!-- Bootstrap -->
    <link href="static/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .fooddrop { padding: 15px }
        .fooddrop li { padding: 15px }
    </style>

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
        <h1>Lunch Survey
            <small>Team Awesome</small>
        </h1>
    </div>
    <div class="col-md-6 col-md-offset-1">
        %if results:
        %weights, voters = results
        <div class="page-header">
            <h3>Results</h3>
        </div>

        <ul class="list-group" id="foodout">
            %for food, weight in weights:
            <li class="list-group-item">
                <strong>{{food}}</strong> ({{weight}}): {{', '.join(['{} ({:d})'.format(voter, rank+1) for voter,rank in
                voters[food]])}}
            </li>
            %end
        </ul>
        %elif has_voted:
        <div class="page-header">
            <h3>Waiting for Results...</h3>
        </div>
        %else:
        <div class="page-header">
            <h3>Survey</h3>
        </div>
        <form action="survey" method="post">
            <div class="form-group row">
                <div class="col-md-6">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">Rank by preference (max {{max_votes}})</h3>
                        </div>
                        <div class="panel-body">
                            <ul class="list-group fooddrop" id="foodin">
                            </ul>
                        </div>
                    </div>
                </div>
                <input type="hidden" name="food" value="__sentinel__"/>

                <div class="col-md-6">
                    <div class="panel panel-primary">
                        <div class="panel-heading">
                            <h3 class="panel-title">Available choices</h3>
                        </div>
                        <div class="panel-body">
                            <ul class="list-group fooddrop" id="foodout">
                                %for item in foods:
                                <li class="list-group-item">
                                    <strong>{{item.name}}</strong>
                                    <input type="hidden" name="food" value="{{item.name}}"/>
                                </li>
                                %end
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Submit</button>
            </div>
        </form>
        %end
        <div class="page-header">
            <h3>Add Restaurant</h3>
        </div>
        <form action="food" method="post">
            <div class="form-group">
                <input type="text" name="name" placeholder="Restaurant" required=""/>
                <input type="url" name="menu" placeholder="Menu URL"/>
                <input type="text" name="loc" placeholder="Address"/>
            </div>
            <button type="submit" class="btn btn-primary">Add</button>
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Add</button>
            </div>
        </form>
    </div>

</div>
<div class="col-md-3">
    <div class="page-header">
        <h3>Current Weights</h3>
    </div>
    <ul class="list-group">
        %for name, weight in users.items():
        <li class="list-group-item"><strong>{{name}}:</strong> {{weight}}</li>
        %end
    </ul>
</div>

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<!-- Include all compiled plugins (below), or include individual files as needed -->
<script src="static/js/bootstrap.min.js"></script>
<script>
    $(function() {
    $( ".fooddrop" ).sortable({
        connectWith: ".fooddrop",
        stop : function(event, ui) { return $("#foodin li").length <= {{max_votes}}; }
    });
    $( ".fooddrop" ).disableSelection();
    });

</script>
</body>
</html>