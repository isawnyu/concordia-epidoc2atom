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
            <xsl:when test="contains(lower-case(normalize-space(.)), 'findspot')">
                <xsl:comment>found in situ</xsl:comment>
                <xsl:call-template name="linkobservedat">
                    <xsl:with-param name="observedatkey"><xsl:value-of select="//placeName[@type='ancientFindspot']/@key"/></xsl:with-param>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="rs[@type='monuList']"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="rs[@type='monuList']">
        <!-- need iaph monulist to actually do something with this -->
    </xsl:template>
    
    <xsl:template name="linkobservedat">
        <xsl:param name="observedatkey"/>
        <xsl:param name="rel"><xsl:value-of select="$term-observedat"/></xsl:param>
        <xsl:variable name="pleiadesid">
            <xsl:call-template name="getpleiades4findspot">
                <xsl:with-param name="findspotkey" select="$observedatkey"/>
            </xsl:call-template>
        </xsl:variable>       
        <xsl:variable name="batlasid">
            <xsl:call-template name="getbatlas4findspot">
                <xsl:with-param name="findspotkey" select="$observedatkey"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:if test="$batlasid != '' or $pleiadesid != ''">
            <xsl:call-template name="makelink">
                <xsl:with-param name="rel"><xsl:value-of select="$rel"/></xsl:with-param>
                <xsl:with-param name="href">
                    <xsl:choose>
                        <xsl:when test="$pleiadesid != ''"><xsl:value-of select="$pleiadesid"/></xsl:when>
                        <xsl:when test="$pleiadesid = '' and $batlasid != ''"><xsl:value-of select="$batlasid"/></xsl:when>
                    </xsl:choose>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
        </xsl:template>
        

</xsl:stylesheet>
