<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
       <xsl:output method="xml" indent="yes"/>
<xsl:template match="/">   
             <keywords>
              <xsl:for-each-group group-by="." select="
                    for $w in //term return $w">   
               <xsl:sort data-type="number" select="count(current-group())"/>
                           <term  freq="{count(current-group())}" form="{current-grouping-key()}"/>
                </xsl:for-each-group>
            </keywords>
 
        </xsl:template>
 

        
</xsl:stylesheet>