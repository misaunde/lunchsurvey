<div class="col-md-4 col-md-offset-2">
    <div class="page-header">
        <h3>Users</h3>
    </div>
    <form action="user" method="post">
        <div class="form-group">
            <input type="text" name="name" placeholder="Name" required=""/>
            <input type="text" name="weight" placeholder="Weight" required=""/>
        </div>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Add User</button>
    </form>
</div>
<div class="col-md-4">
    <div class="page-header">
        <h3>Controls</h3>
    </div>
    <form action="reset" method="post">
        <div class="form-group">
            <button class="btn btn-lg btn-danger btn-block" type="submit">Reset Votes</button>
        </div>
    </form>
    %if started:
    <form action="stop" method="post">
        <div class="form-group">
            <button class="btn btn-lg btn-warning btn-block" type="submit">Stop Survey</button>
        </div>
    </form>
    %else:
    <form action="start" method="post">
        <div class="form-group">
            <button class="btn btn-lg btn-success btn-block" type="submit">Start Survey</button>
        </div>
    </form>
    %end
    <form action="results" method="post">
        <div class="form-group">
            <button class="btn btn-lg btn-primary btn-block" type="submit">Tabulate Results</button>
        </div>
    </form>
</div>
%rebase('base.tpl', subtitle='Administration')