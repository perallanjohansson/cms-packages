<xsl:stylesheet exclude-result-prefixes="#all" version="2.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:portal="http://www.enonic.com/cms/xslt/portal" xmlns:util="enonic:utilities" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../../../libraries/utilities/standard-variables.xsl"/>
    <xsl:include href="../../../libraries/utilities/utilities.xsl"/>

    <xsl:output indent="yes" media-type="text/html" method="xhtml" omit-xml-declaration="yes"/>

    <xsl:param name="facebook-share-url" select="'http://www.facebook.com/share.php?u='"/>
    <xsl:param name="twitter-share-url" select="'http://twitter.com/home?status='"/>
    <xsl:param name="digg-share-url" select="'http://digg.com/submit?phase=2'"/>
    <xsl:param name="delicious-share-url" select="'http://del.icio.us/post'"/>

    <xsl:variable name="site-name" select="/result/context/site/name"/>
    <xsl:variable name="current-url" select="/result/context/querystring/@url"/>

    <xsl:template match="/">
        <aside id="spot-share">
            <h1 id="spot-title"><xsl:value-of select="/result/context/resource/display-name" /></h1>
            <nav id="share-bar">
                <a href="{concat($facebook-share-url, $current-url)}" class="facebook" rel="external"><img alt="Share on Facebook" src="{portal:createResourceUrl(concat($theme-public, '/images/icon-facebook.png'))}" /></a>
                <a href="{concat($twitter-share-url, util:menuitem-name(/result/context/resource), ' ', $current-url)}" class="twitter" rel="external"><img alt="Share on Twitter" src="{portal:createResourceUrl(concat($theme-public, '/images/icon-twitter.png'))}" /></a>
                <a href="{concat($digg-share-url, '&amp;url=', $current-url, '&amp;title=', util:menuitem-name(/result/context/resource))}" class="digg" rel="external"><img alt="Digg this" src="{portal:createResourceUrl(concat($theme-public, '/images/icon-digg.png'))}" /></a>
                <a href="{concat($delicious-share-url, '?url=', $current-url, '&amp;title=', util:menuitem-name(/result/context/resource))}" class="delicious" rel="external"><img alt="Share on Delicious" src="{portal:createResourceUrl(concat($theme-public, '/images/icon-delicious.png'))}" /></a>
            </nav>
        </aside>
    </xsl:template>

</xsl:stylesheet>
