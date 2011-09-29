<xsl:stylesheet version="1.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:portal="http://www.enonic.com/cms/xslt/portal"
                xmlns:util="enonic:utilities"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:import href="../../../libraries/utilities/standard-variables.xsl"/>

    <xsl:template match="/">
        <div id="background1">'</div>
        <div id="background2">'</div>
        <xsl:if test="/result/travelinfo-background-images/contents/relatedcontents/content[@contenttype='Image']">
            <script  type="text/javascript">
                $(document).ready(function(){
                    var images=new Array();
                    <xsl:for-each select="/result/travelinfo-background-images/contents/relatedcontents/content[@contenttype='Image'] ">
                        images[<xsl:value-of select="position()-1"/>] ="<xsl:value-of select="portal:createImageUrl(current()/@key, 'scalewidth(1200)','','jpg','50')" />";
                    </xsl:for-each>
                    runSlideshow(images);
                });
            </script>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>