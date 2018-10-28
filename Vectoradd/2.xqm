module namespace local="http://wob.iai.uni-bonn.de/exercises/xquery/calculator";

declare function local:add($x as element(vector), $y as element(vector)) as element(vector) {
	<vector>
	{
		for $i in $x/
	}
	</vector>
}; 