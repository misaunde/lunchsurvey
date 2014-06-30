%import urllib.parse
<div class="panel panel-default">
    <strong>{{name}}</strong>
    <span class="pull-right">
        <a class="{{'visible' if menu else 'invisible'}}" href="{{menu}}" target="_blank"><span class="glyphicon glyphicon-cutlery"></span></a>
        <a class="{{'visible' if loc else 'invisible'}}" href="http://maps.google.com/maps?q={{urllib.parse.quote(loc, safe='')}}" target="_blank"><span class="glyphicon glyphicon-map-marker"></span></a>
    </span>
</div>
