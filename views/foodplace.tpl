%import urllib.parse
<div class="foodplace panel panel-default">
    <strong>{{name}}</strong>
    %if menu:
    <a href="{{menu}}"><span class="glyphicon glyphicon-cutlery"></span></a>
    %end
    %if loc:
    <a href="http://maps.google.com/maps?q={{urllib.parse.quote(loc, safe='')}}" target="_blank"><span class="glyphicon glyphicon-map-marker"></span></a>
    %end
</div>
