<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs h t"
    xmlns:h="http://www.w3.org/1999/xhtml" xmlns:t="http://www.tei-c.org/ns/1.0" version="2.0">

    <xsl:template match="bibl">
        <xsl:variable name="eeboId">
            <xsl:choose>
                <xsl:when test="contains(@xml:id, '_')">
                    <xsl:value-of select="substring-before(substring-after(@xml:id, 'eebo:'), '_')"
                    />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="substring-after(@xml:id, 'eebo:')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="vid">
            <xsl:value-of select="substring-after(@facs, 'eeboIs:')"/>
        </xsl:variable>
        <xsl:variable name="tcpId">
            <xsl:value-of
                select="document('extracted.xml')/listBibl/bibl[@n eq $eeboId][@vid eq $vid]/@xml:id"/>
        </xsl:variable>
        <bibl>
            <xsl:if test="string-length($tcpId) &gt; 1">
                <xsl:attribute name="n">
                    <xsl:value-of select="concat('tcp:', $tcpId)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
            <xsl:if test="string-length($tcpId) &gt; 1">
                <measure type="pp">
                <xsl:value-of
                    select="document('extracted.xml')/listBibl/bibl[@n eq $eeboId][@vid eq $vid]/@pp"
                />
            </measure></xsl:if>
        </bibl>
    </xsl:template>


    <xsl:template match="* | @* | processing-instruction()">
        <xsl:copy>
            <xsl:apply-templates select="* | @* | processing-instruction() | comment() | text()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="text()">
        <xsl:value-of select="."/>
        <!-- could normalize() here -->
    </xsl:template>
</xsl:stylesheet>
