<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      exclude-result-prefixes="xs"
      version="2.0">


    <xsl:template name="massage-datetime">
        <xsl:param name="rawdate"/>
        <xsl:choose>
            <xsl:when test="string-length($rawdate) = 0">
                <xsl:message>zero-length date string passed to template "massage-datetime"</xsl:message>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message>template "massage-datetime" received date string = <xsl:value-of select="$rawdate"/></xsl:message>
                    <xsl:analyze-string select="$rawdate" regex="(\d+)\-(\d+)\-(\d+)">
                        <xsl:matching-substring>
                            <xsl:message>regex group 1: <xsl:value-of select="regex-group(1)"/></xsl:message>
                            <xsl:variable name="year"><xsl:value-of select="regex-group(1)"/></xsl:variable>
                            <xsl:variable name="month">
                                <xsl:call-template name="leftpad">
                                    <xsl:with-param name="value" select="regex-group(2)"/>
                                    <xsl:with-param name="length">2</xsl:with-param>
                                </xsl:call-template>
                            </xsl:variable>
                            <xsl:variable name="day">
                                <xsl:call-template name="leftpad">
                                    <xsl:with-param name="value" select="regex-group(3)"/>
                                    <xsl:with-param name="length">2</xsl:with-param>
                                </xsl:call-template>
                            </xsl:variable>
                            <xsl:variable name="cookeddate"><xsl:value-of select="$year"/>-<xsl:value-of select="$month"/>-<xsl:value-of select="$day"/></xsl:variable>
                            <xsl:message>template "massage-datetime" calculated date string = <xsl:value-of select="$cookeddate"/></xsl:message>
                            <xsl:value-of select="$cookeddate"/>
                        </xsl:matching-substring>
                    </xsl:analyze-string>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    <xsl:template name="leftpad">
        <xsl:param name="length">1</xsl:param>
        <xsl:param name="value"/>
        <xsl:param name="padchar">0</xsl:param>
        <xsl:choose>
            <xsl:when test="string-length($value) &lt; $length">
            <xsl:text></xsl:text><xsl:value-of select="$padchar"/><xsl:call-template name="leftpad"><xsl:with-param name="length" select="$length - 1"/><xsl:with-param name="padchar" select="$padchar"/><xsl:with-param name="value" select="$value"/></xsl:call-template><xsl:text></xsl:text>
        </xsl:when>        
        <xsl:otherwise>
            <xsl:text></xsl:text><xsl:value-of select="$value"/><xsl:text></xsl:text>
        </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
