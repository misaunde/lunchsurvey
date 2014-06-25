<div class="row">
    <div class="col-md-8">
        %if not started:
        <div class="page-header">
            <h3>Waiting for Survey to Start...</h3>
        </div>
        <div class="page-header">
            <h3>Add Restaurant</h3>
        </div>
        <form action="food" method="post">
            <div class="form-group">
                <input type="text" name="name" placeholder="Restaurant" required=""/>
            </div>
            <div class="form-group">
                <input type="url" name="menu" placeholder="Menu URL"/>
                <input type="text" name="loc" placeholder="Address"/>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-primary">Add</button>
            </div>
        </form>
        <div class="panel panel-primary">
            <div class="panel-heading">
                <h3 class="panel-title">Available choices</h3>
            </div>
            <div class="panel-body">
                <ul class="list-unstyled list-inline">
                    %for name, menu, loc in foods:
                    <li>
                        %include('foodplace.tpl', name=name, menu=menu, loc=loc)
                    </li>
                    %end
                </ul>
            </div>
        </div>
        %elif results:
        %weights, voters, users_old = results
        <div class="page-header">
            <h3>Results</h3>
        </div>

        <ul class="list-group">
            %for food, weight in weights:
                %votes = ['{} ({:d})'.format(voter, rank+1) for voter,rank in voters[food]]
            <li class="list-group-item">
                <strong>{{food}}</strong> ({{weight}}): {{', '.join(votes)}}
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
                            <ul class="list-unstyled fooddrop" id="foodin">
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
                            <ul class="list-unstyled fooddrop" id="foodout">
                                %for name, menu, loc in foods:
                                <li>
                                    %include('foodplace.tpl', name=name, menu=menu, loc=loc)
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
    </div>

    <div class="col-md-3 col-md-offset-1">
        <div class="page-header">
            <h3>Current Weights</h3>
        </div>
        <ul class="list-group">
            %for name, weight in users.items():
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
                        <option>{{date}}</option>
                    %end
                </select>
            </div>
            <div class="form-group">
                <button type="submit" class="btn btn-default">Show</button>
            </div>
        </form>
    </div>
</div>
<%
style = '''
        .fooddrop { padding: 15px }
        .fooddrop li { cursor: move; }
        .list-group li { padding: 2px }
'''
script = '''
    $(document).ready(function () {
        $( ".fooddrop" ).sortable({
            connectWith: ".fooddrop",
            stop : function(event, ui) { return $("#foodin li").length <= ''' + str(max_votes) + '''; }
        });
        $( ".fooddrop" ).disableSelection();
    });
'''
rebase('base.tpl', style=style, script=script)
%>