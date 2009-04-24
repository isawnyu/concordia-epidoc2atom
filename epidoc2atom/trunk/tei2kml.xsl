<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    
    <xsl:import  href="getdoctitle.xsl"/>
    <xsl:import href="sanitize.xsl"/>
    
    <xsl:output encoding="UTF-8" indent="yes" method="xml"  exclude-result-prefixes="#all" />
    
    <xsl:param name="altdomain">insaph.kcl.ac.uk</xsl:param>
    <xsl:param name="altcommonpath">iaph2007/</xsl:param>
    <xsl:param name="altcommonextension">.html</xsl:param>
    
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="TEI.2">
        <Placemark xmlns="http://www.opengis.net/kml/2.2" id="{@id}">
            <name><xsl:call-template name="getdoctitle"/></name>
            <description>
                <!-- <xsl:apply-templates select="//text"/> -->
                <xsl:text></xsl:text>http://<xsl:value-of select="$altdomain"/>/<xsl:value-of select="$altcommonpath"/><xsl:value-of select="@id"/><xsl:value-of select="$altcommonextension"/><xsl:text></xsl:text>
            </description>
        </Placemark>
    </xsl:template>
    
    <xsl:template match="text">
        <xsl:text></xsl:text><xsl:apply-templates mode="sanitize" select="descendant::div[@n='monument']/p"/><xsl:text></xsl:text>
        <xsl:text></xsl:text><xsl:apply-templates mode="sanitize" select="descendant::div[@n='text']/p"/><xsl:text></xsl:text>
        <xsl:text></xsl:text>Date: <xsl:apply-templates mode="sanitize" select="descendant::div[@n='date']/p"/><xsl:text></xsl:text>
        <xsl:if test="descendant::div[@n='photographs']"><xsl:text></xsl:text>Photo<xsl:if test="count(descendant::div[@n='photographs']/descendant::figure) &gt; 1">s</xsl:if>.<xsl:text> </xsl:text></xsl:if>
        <xsl:text></xsl:text><xsl:apply-templates mode="sanitize" select="descendant::div[@n='record']/p"/><xsl:text></xsl:text>
        <xsl:text></xsl:text><xsl:apply-templates mode="sanitize" select="descendant::div[@type='bibliography']/p"/><xsl:text></xsl:text>
    </xsl:template>
    
    
</xsl:stylesheet>
