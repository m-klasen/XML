<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="http://www.w3.org/1999/xhtml">
<xsl:output method="xhtml" indent="yes"/>

<xsl:template match="/book">
	<html>
		<head>
			<title><xsl:value-of select="title"/></title>
		</head>
		<body>
			<table>
				<xsl:for-each select="section">					
					<tr>
					<td><xsl:apply-templates select="title"/></td>
					<xsl:number count="section" format="1" level="any"/>
					<td><xsl:apply-templates select="para"/></td>
						<xsl:for-each select="section">
						<td><xsl:apply-templates select="title"/></td>
						<td><xsl:apply-templates select="para"/></td>
						</xsl:for-each>
					</tr>
				</xsl:for-each>
			</table>
		</body>
	</html>
</xsl:template>


</xsl:stylesheet>