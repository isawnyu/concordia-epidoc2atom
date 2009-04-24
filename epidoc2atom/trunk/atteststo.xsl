<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      exclude-result-prefixes="xs"
      version="2.0">

    <xsl:template name="atteststo">
        <xsl:comment>attestations</xsl:comment><xsl:text> 
    </xsl:text>
        <xsl:apply-templates select="//placeName[ancestor::div[@type='edition']]"/>
        <xsl:text>            
            
   </xsl:text>
    </xsl:template>
    
    <xsl:template match="placeName[@full='yes' and @reg]">
        <xsl:variable name="placeName"><xsl:value-of select="normalize-space(@reg)"/></xsl:variable>
        <xsl:for-each select="document($nameiddoc)//other[string = $placeName]/ancestor::name">
            <xsl:if test="pleiades">
                <xsl:call-template name="makelink">
                    <xsl:with-param name="rel"><xsl:value-of select="$term-atteststo"/></xsl:with-param>
                    <xsl:with-param name="href"><xsl:value-of select="pleiades/id"/></xsl:with-param>
                </xsl:call-template>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>
