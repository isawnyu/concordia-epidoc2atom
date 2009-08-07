<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">

    <xsl:template name="atteststo">
        <xsl:comment>attestations</xsl:comment>
        <xsl:text> 
    </xsl:text>
        <xsl:apply-templates select="//placeName[@reg and ancestor::div[@type='edition']]"
            mode="attestation"/>
        <xsl:text>            
            
   </xsl:text>
    </xsl:template>

    <xsl:template match="placeName" mode="attestation">
        <xsl:variable name="placeName"><xsl:value-of select="normalize-space(@reg)"/></xsl:variable>
        <xsl:variable name="match-candidates" select="document($nameiddoc)//other[string = $placeName]/ancestor::name"/>
        <xsl:comment>got <xsl:value-of select="count($match-candidates)"/> for <xsl:value-of select="$placeName"/></xsl:comment>
        <xsl:for-each select="$match-candidates">
            <xsl:choose>
                <xsl:when test="pleiades">
                    <xsl:comment>writing link for match with pleiades URL</xsl:comment>
                    <xsl:call-template name="makelink">
                        <xsl:with-param name="rel"><xsl:value-of select="$term-atteststo"/></xsl:with-param>
                        <xsl:with-param name="href"><xsl:value-of select="pleiades/id"/></xsl:with-param>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:comment>got a match, but no Pleiades URL so can't write link</xsl:comment>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
        <xsl:text>
            
        </xsl:text>
        
    </xsl:template>

</xsl:stylesheet>
