<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template match="*" mode="sanitize">
        <xsl:variable name="theval" select="normalize-space(.)"/>
        <xsl:text></xsl:text><xsl:value-of select="$theval"/><xsl:if test="not(substring($theval,string-length($theval), 1) = '.')">.</xsl:if><xsl:text> </xsl:text>
    </xsl:template>
    
    
</xsl:stylesheet>
