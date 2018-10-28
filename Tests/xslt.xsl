<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

	<xsl:template match="*">
		<x><xsl:apply-templates/></x>
	</xsl:template>

	<xsl:template match="d|g"/>
	
	<xsl:template match="b">
		<xsl:apply-templates/>
	</xsl:template>
		
	<xsl:template match="h"/>

	<xsl:template match="text()">
		<xsl:text>T</xsl:text>
	</xsl:template>

</xsl:stylesheet>
