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
%rebase('base.tpl', subtitle='Administration')