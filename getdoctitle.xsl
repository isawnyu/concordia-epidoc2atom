<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template name="getdoctitle">
        <xsl:text></xsl:text><xsl:value-of select="normalize-space(//teiHeader/fileDesc/titleStmt/title)"/><xsl:text></xsl:text>
    </xsl:template>
</xsl:stylesheet>
