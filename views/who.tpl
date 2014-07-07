<div class="col-md-4 col-md-offset-4">
    <form action="who" method="post">
        <div class="form-group">
            <label for="user">Who are you?</label>
            <select class="form-control" id="user" name="user">
                %for name, weight in users:
                    <option>{{name}}</option>
                %end
            </select>
        </div>
    <button class="btn btn-lg btn-primary btn-block" type="submit">Embark</button>
    </form>
</div>
%rebase('base.tpl')