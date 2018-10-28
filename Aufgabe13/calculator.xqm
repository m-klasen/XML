module namespace local="http://wob.iai.uni-bonn.de/exercises/xquery/calculator";


declare function local:print($tree as element()) as xs:string {
	let $x := $tree
	return 	if (exists($x/sum))
			then (
				fn:substring(concat(string-join(
				for $a in $x/sum
					return concat("* (", fn:substring( string-join(
						for	$b in $a/fraction
						return $b/concat(" +", $b/numerator/text(), "/", $b/denominator/text())
					) , 3) ,")"))
					, string-join(
						for $c1 in $x/fraction
						return $c1/concat(" * ", $c1/numerator/text(), "/", $c1/denominator/text()))
					), 2)
				)
			else ( 
				 concat( $x/numerator/text(), "/", $x/denominator/text())
				)
};

declare function local:evaluate($tree as element())as element(fraction){
	   
	<fraction>
	    <numerator>
	        {
	            if($tree/product)then(
	                if($tree/product/sum)then(
	                    let $sumnumerator := sum(for$x in $tree/product/sum/fraction
	                    	return $x/numerator/text())
	                    let $i := (for $x in $tree/product/fraction
	                    	return $x/numerator/text())
	                    let $j := count($i)
	                    let $numerator := local:numeratorcheck($tree/product/fraction, 1)
	                    let $numerator := $numerator * $sumnumerator
	                    	return $numerator
	                )
	                else(
	                    let $j := count(for$x in $tree/product/fraction
	                    	return $x/numerator/text())
	                    let $i := (for$x in $tree/product/fraction
	                    	return $x/numerator/text())
	                    let $numerator := local:numeratorcheck($tree/product/sum/fraction, 1)
	                   
	                    return $numerator
	                )
	            )
	            else(
	                if($tree/sum)then(
	                    let $sumnumerator := sum(for$x in $tree/sum/fraction
	                    	return $x/numerator/text())
	                    	return $sumnumerator
	                )
	                else(
	                    let $sumnumerator := 0
	                    return $sumnumerator
	                )
	            )
	        }
	    </numerator>
	    <denominator>
	        {
	            if($tree/product)then(
	                if($tree/product/sum)then(
	                    let $sumnumerator := sum(for$x in $tree/product/sum/fraction
	                    	return $x/denominator/text())
	                    let $i := (for $x in $tree/product/fraction
	                    	return $x/denominator/text())
	                    let $j := count($i)
	                    let $numerator := local:denominatorcheck($tree/product/fraction, 1)
	       	            let $numerator := $numerator * $sumnumerator
	                    	return $numerator
	                )
	                else(
	                    let $j := count(for$x in $tree/product/fraction
	                    return $x/denominator/text())
	                    let $i := (for$x in $tree/product/fraction
	                    return $x/denominator/text())
	                    let $numerator := local:denominatorcheck($tree/product/sum/fraction, 1)
	                   
	                    return $numerator
	                )
	            )
	            else(
	                if($tree/sum)then(
	                    let $sumnumerator := sum(for$x in $tree/sum/fraction
	                    return $x/denominator/text())
	                    return $sumnumerator
	                )
	                else(
	                    let $sumnumerator := 0
	                    return $sumnumerator
					)
			)
			}
		</denominator>
	</fraction>
};
	
declare function local:fraction($x as element(fraction)) as element(fraction) {

		<fraction>
			<numerator>
			{
			let $a := xs:integer($x/numerator/text())
			let $b := xs:integer($x/denominator/text())
			return
				if($a lt 0)
					then(	if($b >= 0)
							then( 	let $ans := concat("-" , string(local:kuerzen((local:betrag($a)), local:euclid( local:betrag($a) , local:betrag($b)) ))) 
									return $ans
								)
							else(	let $ans := string(local:kuerzen((local:betrag($a)), local:euclid( local:betrag($a) , local:betrag($b))))
									return $ans
								)
						)	
					else(	if($b lt 0)
							then( 	let $ans := concat("-" , string(local:kuerzen((local:betrag($a)), local:euclid( local:betrag($a) , local:betrag($b))))) 
									return $ans
								)
								
							else(	let $ans := string(local:kuerzen($a, local:euclid( local:betrag($a) , local:betrag($b)) ))	
									return $ans
								)
						)


			}
			</numerator>
			<denominator>
			{
				let $a := xs:integer($x/numerator/text())
				let $b := xs:integer($x/denominator/text())
				return
					if($a lt 0)
					then(	if($b >= 0)
							then( 	let $ans := string(local:kuerzen((local:betrag($b)), local:euclid( local:betrag($a) , local:betrag($b)) ))
														 
									return $ans
								)
							else(	let $ans := string(local:kuerzen((local:betrag($b)), local:euclid( local:betrag($a) , local:betrag($b)) ))
									return $ans
								)
						)	
					else(	if($b lt 0)
							then( 	let $ans := string(local:kuerzen((local:betrag($b)), local:euclid( local:betrag($a) , local:betrag($b))))
														 
									return $ans
								)
								
							else(	let $ans := string(local:kuerzen($b, local:euclid( local:betrag($a) , local:betrag($b))))	
									return $ans
								)
						)

		}
			</denominator>
		</fraction>
	

	
};

declare function local:numeratorcheck($x as item()*,$y as item()*) as item()* {
	if (fn:empty($x))
	then $y
	else local:numeratorcheck(tail($x), head($x)/numerator * $y)
};
 
declare function local:denominatorcheck($x as item()*, $y as item()*) as item()* {
	if (fn:empty($x))
	then $y
	else local:denominatorcheck(tail($x), head($x)/denominator * $y)
};

declare function local:betrag($a as xs:integer) as xs:integer{
	if($a lt 0)
	then 	let $b := $a * (-1)
			return $b
			
	else	let $c := $a
			return $a
};

declare function local:kuerzen($zahl as xs:integer, $kuerzer as xs:integer) as xs:decimal {
	if ($kuerzer eq 0)
	then $kuerzer
	else(
		let $a := $zahl div $kuerzer
		return $a
	)
};

declare function local:euclid($a as xs:integer, $b as xs:integer){
	if($a eq $b)
	then let $k := $a return $k
	else if($a > $b) then let $k := local:euclid($a - $b, $b) return $k
			else let $k := local:euclid($b - $a, $a) return $k
};