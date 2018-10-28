<?xml version="1.1" encoding="UTF-8"?>

<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:local="http://example.com/local"
	exclude-result-prefixes="local">
	<xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes" />
	<xsl:template match="/">
		<html>
			<head>
				<meta charset="UTF-8"/>
				<meta name="viewport" content="width=device-width, initial-scale=1"/>
				<title>Library</title>
				<link href="library.css" rel="stylesheet"/>
			</head>
			<body>
				<h1>Library</h1>
				<ul>
					<xsl:apply-templates select="/library/author">
						<xsl:sort select="@id"/>
					</xsl:apply-templates>
				</ul>
				<ul>
					<xsl:for-each-group select="$cleanedTokens" 
						group-by="substring(.,1,1)">
						<xsl:if test="not(every $i in current-group() satisfies $i = $stopwords)">
						<li>
							<xsl:value-of select="upper-case(substring(current-grouping-key(),1,1))"/>
							<ul>
						<xsl:for-each select="current-group()">
							<xsl:variable name="rec" select="."/>
							<xsl:if test="not($rec = $stopwords)">
								<li>
									<xsl:value-of select="$rec"/>
									<ul>
										<xsl:for-each select="$doc//title">
											<xsl:sort select="."/>
											<xsl:variable name="tokens" 
												select="local:getWords(current())"/>
											<xsl:if test="$rec = $tokens">
												<xsl:apply-templates select="." mode="abc"/>
											</xsl:if>
										</xsl:for-each>
									</ul>
								</li>
							</xsl:if>
						</xsl:for-each>
						</ul>
						</li>
					</xsl:if>
					</xsl:for-each-group>
				</ul>
			</body>
		</html>
	</xsl:template>

	<xsl:function name="local:getWords">
		<xsl:param name="title"/>
		<xsl:sequence select="tokenize(lower-case(replace($title, '[^ \p{Nd}\p{L}-]','')),'\s')" />
	</xsl:function>

	<xsl:variable name="doc" select="/"/>

	<xsl:variable name="stopwords" 
		select="tokenize(replace(unparsed-text('stopwords.txt'),'&#xD;',' '))"/>

		<xsl:variable name="tokens">
			<xsl:for-each select="//title">
				<xsl:value-of select="."/>
				<xsl:text> </xsl:text>
			</xsl:for-each>
		</xsl:variable>

		<xsl:variable name="cleanedTokens" 
			select="remove(distinct-values(sort(local:getWords($tokens))),1)"/>

		<xsl:template match="title" mode="abc">
			<li>
				<a href="#{generate-id()}"><xsl:value-of select="."/></a>
			</li>
		</xsl:template>

		<xsl:template match="author">
			<li>
				<h2><xsl:apply-templates select="first-name"/><xsl:text> </xsl:text><xsl:apply-templates select="last-name"/></h2>
				<xsl:apply-templates select="/library/book[author-ref=current()/@id]">
					<xsl:sort select="title"/>
				</xsl:apply-templates>
			</li>
		</xsl:template>

		<xsl:template match="book">
			<p id="{generate-id(title)}"><xsl:apply-templates select="title"/><xsl:apply-templates select="language"/><xsl:apply-templates select="year"/></p>
		</xsl:template>

		<xsl:template match="language">, <xsl:apply-templates/></xsl:template>

		<xsl:template match="year">, <xsl:apply-templates/></xsl:template>

	</xsl:stylesheet>
