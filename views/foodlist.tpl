<%
setdefault('title', 'Restaurants')
setdefault('droppable', False)
%>
<div class="panel panel-primary">
    <div class="panel-heading">
        <h3 class="panel-title">{{title}}</h3>
    </div>
    <div class="panel-body">
        <ul class="{{'fooddrop' if droppable else ''}} foodlist list-unstyled" {{!'id="{}"'.format(listid) if defined('listid') else ''}}>
            %for name, menu, loc in foods:
            <li class="foodplace">
                %include('foodplace.tpl', name=name, menu=menu, loc=loc)
            </li>
            %end
        </ul>
    </div>
</div>