<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml"  exclude-result-prefixes="#all"/>
    
    <xsl:param name="tagdomain">insaph.kcl.ac.uk</xsl:param>
    <xsl:param name="tagcommonprefix">iaph2007/</xsl:param>
    <xsl:param name="tagcommonpostfix"/>
    <xsl:param name="altdomain">insaph.kcl.ac.uk</xsl:param>
    <xsl:param name="altcommonpath">iaph2007/</xsl:param>
    <xsl:param name="altcommonextension">.html</xsl:param>
    <xsl:param name="updateddate">2008-04-01T00:00:00.1Z</xsl:param>
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="TEI.2">
        
        <!-- get published date, which we'll need both for the id and atom:published -->
        <xsl:variable name="published">
            <xsl:for-each select="teiHeader/revisionDesc/change[1]/date[1]">
                <xsl:text></xsl:text><xsl:value-of select="."/><xsl:if test="string-length(.) = 10">T00:00:00.1Z</xsl:if><xsl:text></xsl:text>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="tagdate"><xsl:value-of select="substring($published, 1, 10)"/></xsl:variable>
        
        <!-- create an atom:entry -->
        <entry xmlns="http://www.w3.org/2005/Atom">
            <!-- atom:author and atom:rights -->
            <xsl:apply-templates select="teiHeader/fileDesc/publicationStmt"/>
            
            <id>tag:<xsl:value-of select="$tagdomain"/>,<xsl:value-of select="$tagdate"/>:/<xsl:value-of select="$tagcommonprefix"/><xsl:value-of select="@id"/><xsl:value-of select="$tagcommonpostfix"/></id>
            
            <!-- atom:title -->
            <title><xsl:value-of select="normalize-space(teiHeader/fileDesc/titleStmt/title)"/></title>
            
            <xsl:element name="link">
                <xsl:attribute name="rel">alternate</xsl:attribute>
                <xsl:attribute name="href">http://<xsl:value-of select="$altdomain"/>/<xsl:value-of select="$altcommonpath"/><xsl:value-of select="@id"/><xsl:value-of select="$altcommonextension"/></xsl:attribute>
            </xsl:element>
            
            <published><xsl:value-of select="$published"/></published>
            
            <updated><xsl:value-of select="$updateddate"/></updated>
            
            <!-- atom:summary -->
            <xsl:apply-templates select="text"/>
            
        </entry>
    </xsl:template>
    
    <xsl:template match="publicationStmt">
        <xsl:for-each select="descendant::editor">
            <author xmlns="http://www.w3.org/2005/Atom">
                <name><xsl:value-of select="normalize-space(.)"/></name>
            </author>
        </xsl:for-each>
        <xsl:if test="p[not(descendant::editor)]">
            <rights xmlns="http://www.w3.org/2005/Atom">
                <xsl:apply-templates select="p[not(descendant::editor)]" mode="sanitize"/>
            </rights>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="text">
        <summary type="text" xmlns="http://www.w3.org/2005/Atom">
            <xsl:text></xsl:text><xsl:apply-templates mode="sanitize" select="descendant::div[@n='monument']/p"/><xsl:text></xsl:text>
            <xsl:text></xsl:text><xsl:apply-templates mode="sanitize" select="descendant::div[@n='text']/p"/><xsl:text></xsl:text>
            <xsl:text></xsl:text>Date: <xsl:apply-templates mode="sanitize" select="descendant::div[@n='date']/p"/><xsl:text></xsl:text>
            <xsl:if test="descendant::div[@n='photographs']"><xsl:text></xsl:text>Photo<xsl:if test="count(descendant::div[@n='photographs']/descendant::figure) &gt; 1">s</xsl:if>.<xsl:text> </xsl:text></xsl:if>
            <xsl:text></xsl:text><xsl:apply-templates mode="sanitize" select="descendant::div[@n='record']/p"/><xsl:text></xsl:text>
            <xsl:text></xsl:text><xsl:apply-templates mode="sanitize" select="descendant::div[@type='bibliography']/p"/><xsl:text></xsl:text>
        </summary>
    </xsl:template>
    
    <xsl:template match="p" mode="sanitize">
        <xsl:variable name="theval" select="normalize-space(.)"/>
        <xsl:text></xsl:text><xsl:value-of select="$theval"/><xsl:if test="not(substring($theval,string-length($theval), 1) = '.')">.</xsl:if><xsl:text> </xsl:text>
    </xsl:template>
    
    
</xsl:stylesheet>