<div class="col-md-6 col-md-offset-1">
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
%rebase('base.tpl', title='Survey History')