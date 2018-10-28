import module namespace local="http://wob.iai.uni-bonn.de/exercises/xquery/calculator" at "2.xqm";

declare variable $x := (
<vector>
	<x1>1</x1>
	<x2>2</x2>
	<x3>2</x3>
</vector>

);

declare variable $y := (
<vector>
	<y1>1</y1>
	<y2>2</y2>
	<y3>2</y3>
</vector>
);

let $output := local:add($x,$y)
return $output