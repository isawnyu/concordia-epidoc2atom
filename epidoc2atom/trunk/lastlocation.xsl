<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      exclude-result-prefixes="xs"
      version="2.0">

    <xsl:template name="lastlocation">
        <xsl:comment>observed location(s)</xsl:comment><xsl:text> 
    </xsl:text>
        <xsl:apply-templates select="//rs[@type='lastLocation']"/>
        <xsl:text>            
            
   </xsl:text>
    </xsl:template>
    
    <xsl:template match="rs[@type='lastLocation']">
        <xsl:choose>
            <xsl:when test="contains(lower-case(normalize-space(.)), 'unknown')"/>
            <xsl:when test="contains(lower-case(normalize-space(.)), 'findspot')">
                <xsl:variable name="findspotkey-general">
                    <xsl:call-template name="getfindspotkey-general"/>
                </xsl:variable>
                <xsl:call-template name="linkfindspot">
                    <xsl:with-param name="findspotkey" select="$findspotkey-general"/>
                    <xsl:with-param name="rel" select="$term-observedat"/>
                </xsl:call-template>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
