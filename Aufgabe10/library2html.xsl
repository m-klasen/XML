<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
	<xsl:output method="xhtml" indent="yes"/>

	<xsl:template match="/">
		<html>
			<head><title>Books</title></head>
			<body>
				<table>
					<tr>
						<td>Titel</td>
						<td>Jahr</td>
						<td>Sprache</td>
						<td>Authoren</td>
					</tr>

					<xsl:apply-templates select="library/book"/>
				</table>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="book">
		<tr>			
			<td><xsl:apply-templates select="title"/></td>
			<td><xsl:apply-templates select="year"/></td>
			<td><xsl:apply-templates select="language"/></td>
			<td><xsl:apply-templates select="author-ref"/></td>
		</tr>
	</xsl:template>

</xsl:stylesheet> 

