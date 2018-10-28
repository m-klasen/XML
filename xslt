XSLT:
	xsl:stylesheet namespace:namespace="URL"

	xsl:template match="123"

	xsl:apply-template select="123"

	xsl:import href="123.xsl"

	xsl:import-schema

	xsl:output method="html"

	Functions:

		xsl:variable name="a" select="value"

		xsl:function name="functioname"

		xsl:param name="parametername" as="parameter type"

		xsl:sequence select="rechnung zb $a * $b"

	xsl:value-of select="path"

	sequence constructor?

	Bedingungen:
		xsl:if test="price &gt; 10"

		xsl:choose
			xsl:when test="price &gt; 10"
			xsl:otherwise

		xsl:apply-imports select=""

		xsl:for-each select=""

		xsl:for-each-group select="" group-by=""

	xsl:sort select="element"

	xsl:number count="elemente" format="1" level="any"

	xsl:copy