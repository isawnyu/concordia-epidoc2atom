<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      exclude-result-prefixes="xs"
      version="2.0">

    <xsl:template name="origlocation">
        <xsl:comment>original location(s)</xsl:comment><xsl:text> 
    </xsl:text>
        <xsl:apply-templates select="//rs[@type='origLocation']"/>
        <xsl:text>            
            
   </xsl:text>
    </xsl:template>
    
    <xsl:template match="rs[@type='origLocation']">
        <xsl:choose>
            <xsl:when test="contains(lower-case(normalize-space(.)), 'unknown')"/>
            <xsl:when test="contains(lower-case(normalize-space(.)), 'findspot')"><xsl:comment>findspot</xsl:comment></xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="rs[@type='monuList']"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="rs[@type='monuList']">
        <!-- need iaph monulist to actually do something with this -->
    </xsl:template>

</xsl:stylesheet>
