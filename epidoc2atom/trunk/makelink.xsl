<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      exclude-result-prefixes="xs"
      version="2.0">

    <xsl:template name="makelink">
        <xsl:param name="rel">alternate</xsl:param>
        <xsl:param name="href"/>
        <xsl:element name="link" namespace="http://www.w3.org/2005/Atom">
            <xsl:attribute name="rel"><xsl:value-of select="$rel"/></xsl:attribute>
            <xsl:attribute name="href"><xsl:value-of select="normalize-space($href)"/></xsl:attribute>
        </xsl:element>        
    </xsl:template>
    
</xsl:stylesheet>
