import module namespace local="http://wob.iai.uni-bonn.de/exercises/xquery/calculator" at "calculator.xqm";

declare variable $x1 := (
	<product>
		<sum>
			<fraction>
				<numerator>1</numerator>
				<denominator>2</denominator>
			</fraction>
			<fraction>
				<numerator>2</numerator>
				<denominator>3</denominator>
			</fraction>
			<fraction>
				<numerator>1</numerator>
				<denominator>4</denominator>
			</fraction>
		</sum>
		<sum>
			<fraction>
				<numerator>1</numerator>
				<denominator>2</denominator>
			</fraction>
			<fraction>
				<numerator>1</numerator>
				<denominator>4</denominator>
			</fraction>
		</sum>
		<fraction>
			<numerator>2</numerator>
			<denominator>3</denominator>
		</fraction>
	</product>
);

declare variable $x2 := (
	<product>
		<sum>
			<fraction>
				<numerator>1</numerator>
				<denominator>2</denominator>
			</fraction>
			<fraction>
				<numerator>1</numerator>
				<denominator>4</denominator>
			</fraction>
		</sum>
		<fraction>
			<numerator>2</numerator>
			<denominator>3</denominator>
		</fraction>
	</product>
);

declare variable $x3 := (
	<product>
		<sum>
		</sum>
		<fraction>
			<numerator>2</numerator>
			<denominator>3</denominator>
		</fraction>
	</product>

);

let $output := ($x1,$x2,$x3)
for $loop in $output
return (local:print($loop),'=', local:print(local:fraction(local:evaluate($loop))))
