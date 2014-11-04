<div class="row">
    <div class="col-md-8">
        %if not started:
        <div class="page-header">
            <h3>Waiting for Survey to Start...</h3>
        </div>
        <div class="page-header">
            <h3>Add Restaurant</h3>
        </div>
        <div class="row">
            <div class="col-md-6">
                <form action="food" method="post">
                    <div class="form-group">
                        <input type="text" name="name" placeholder="Restaurant" required=""/>
                    </div>
                    <div class="form-group">
                        <input type="url" name="menu" placeholder="Menu URL"/>
                        <input type="text" name="loc" placeholder="Address"/>
                    </div>
                    <div class="form-group">
                        <button type="submit" class="btn btn-lg btn-primary btn-block">Add</button>
                    </div>
                </form>
            </div>
            <div class="col-md-6">
                %include('foodlist.tpl', title='Available choices', droppable=False)
            </div>
        </div>
        %elif results:
        %weights, voters, users_old = results
        %winner_name, winner_menu, winner_loc = winner
        <div class="page-header">
            <h1>Winner: <a href="{{winner_menu if winner_menu else '#'}}">{{winner_name}}</a>!!!!!</h1>
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
            <div class="row">
                <div class="col-md-6">
                    <form action="survey" method="post" id="survey-form">
                        <%
                        foodlist_title = 'Rank by preference (max {:d})'.format(max_votes)
                        include('foodlist.tpl', foods=[], title=foodlist_title, droppable=True, listid='foodin')
                        %>
                        <div class="form-group">
                            <button form="survey-form" type="submit" class=" class="btn btn-lg btn-primary btn-block">Submit</button>
                        </div>
                    </form>
                </div>

                <div class="col-md-6">
                    %include('foodlist.tpl', title='Available choices', droppable=True)
                </div>
            </div>
        %end
    </div>

    <div class="col-md-3 col-md-offset-1">
        <div class="page-header">
            <h3>Current Weights</h3>
        </div>
        <ul class="list-group">
            %for name, weight in users:
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
        .fooddrop .foodplace { cursor: move; }
        .foodlist { max-height: 400px; min-height: 80px; overflow-y: auto;}
'''
script = '''
    $(document).ready(function () {
        $( ".fooddrop" ).sortable({
            connectWith: ".fooddrop",
            stop : function(event, ui) { return $("#foodin .foodplace").length <= ''' + str(max_votes) + '''; }
        });
        $( ".fooddrop" ).disableSelection();
    });
'''
rebase('base.tpl', style=style, script=script)
%>