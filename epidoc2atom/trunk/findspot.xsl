<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
      xmlns:xs="http://www.w3.org/2001/XMLSchema"
      exclude-result-prefixes="xs"
      version="2.0">

<!-- need to modify to handle both major and minor findspots within the major ones; and also support other templates when shorthand of "findspot" is used in source document -->
    
    <xsl:template name="findspot">
        <xsl:comment>findspot(s)</xsl:comment><xsl:text> 
    </xsl:text>
        <xsl:apply-templates select="//placeName[@type='ancientFindspot']"/>
        <xsl:apply-templates select="//rs[@type='found']"/>
        <xsl:text>            
            
   </xsl:text>
    </xsl:template>
    
    <xsl:template match="placeName[@type='ancientFindspot']">
        <xsl:variable name="findspotkey"><xsl:value-of select="normalize-space(./@key)"/></xsl:variable>    
        <xsl:call-template name="linkfindspot">
            <xsl:with-param name="findspotkey"><xsl:value-of select="$findspotkey"/></xsl:with-param>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template match="rs[@type='found']">
        <xsl:choose>
            <xsl:when test="contains(lower-case(normalize-space(.)), 'stray find')"/>
            <xsl:otherwise>
                <xsl:apply-templates select="rs[@type='monuList']"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="rs[@type='monuList']">
<!-- need to flesh out here -->
    </xsl:template>
    
    <xsl:template name="getpleiades4findspot">
        <xsl:param name="findspotkey"/>
        <xsl:for-each select="document($placeiddoc)//other[id=$findspotkey]/ancestor::place">
            <xsl:value-of select="pleiades/id"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="getbatlas4findspot">
        <xsl:param name="findspotkey"/>
        <xsl:for-each select="document($placeiddoc)//other[id=$findspotkey]/ancestor::place">
            <xsl:text></xsl:text>http://atlantides.org/batlas/<xsl:value-of select="batlas/id"/>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="linkfindspot">
        <xsl:param name="findspotkey"/>
        <xsl:param name="rel"><xsl:value-of select="$term-findspot"/></xsl:param>
        <xsl:variable name="pleiadesid">
            <xsl:call-template name="getpleiades4findspot">
                <xsl:with-param name="findspotkey" select="$findspotkey"/>
            </xsl:call-template>
        </xsl:variable>       
        <xsl:variable name="batlasid">
            <xsl:call-template name="getbatlas4findspot">
                <xsl:with-param name="findspotkey" select="$findspotkey"/>
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
    
    <xsl:template name="getfindspotkey-general">
        <xsl:value-of select="normalize-space(//placeName[@type='ancientFindspot']/@key)"/>
    </xsl:template>

   
</xsl:stylesheet>
