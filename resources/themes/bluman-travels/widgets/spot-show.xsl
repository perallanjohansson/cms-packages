<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0" xmlns="http://www.w3.org/1999/xhtml" xmlns:portal="http://www.enonic.com/cms/xslt/portal" xmlns:util="enonic:utilities" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema">

  <xsl:import href="/libraries/utilities/standard-variables.xsl"/>
  <xsl:include href="/libraries/utilities/utilities.xsl"/>
  <xsl:include href="/libraries/utilities/xhtml.xsl"/>

  <xsl:output indent="yes" media-type="text/html" method="xhtml" omit-xml-declaration="yes"/>

  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="/result/contents/content">
        <div id="spot" class="clear append-bottom">
          <xsl:apply-templates select="/result/contents/content"/>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <p class="clear">
          <xsl:value-of select="portal:localize('No-spot')"/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="content">
    <!--<xsl:for-each select="/result/spot-images/contents/content/contentdata/image">
        <xsl:choose>
            <xsl:when test="position()=last()"><img id="bg{position()}" class="bg bg-wide" src="{portal:createImageUrl(image/@key,('scalewidth(1200)'))}" alt="{image/image_text}" /></xsl:when>
            <xsl:otherwise><img id="bg{position()}" style="visibility: hidden;" class="bg bg-wide" src="{portal:createImageUrl(image/@key,('scalewidth(1200)'))}" alt="{image/image_text}" /></xsl:otherwise>
        </xsl:choose>
    </xsl:for-each>-->
    <h3>
      <xsl:value-of select="contentdata/spot"/>,
      <span class="capitalize"><xsl:value-of select="location/site/contentlocation/@menuitemname" /> </span>
    </h3>
          <!--
    <xsl:choose>
      <xsl:when test="$device-class = 'mobile'">
      -->
      <!--
      <xsl:if test="/result/contents/relatedcontents/content[@key = current()/contentdata/image[1]/image/@key]">
          <div class="related">
            <div class="image">
              <xsl:call-template name="image.display-image">
                <xsl:with-param name="filter" select="concat('border(', 3, ');', $config-filter)"/>
                <xsl:with-param name="image" select="/result/contents/relatedcontents/content[@key = current()/contentdata/image[1]/image/@key]"/>
                <xsl:with-param name="size" select="'full'"/>
              </xsl:call-template>
              <xsl:value-of select="contentdata/image[position() = 1 and image/@key = /result/contents/relatedcontents/content/@key]/image_text"/>
            </div>
          </div>
        </xsl:if>-->
      <!--
      </xsl:when>

        <xsl:otherwise>
        <xsl:call-template name="related-content">
          <xsl:with-param name="size" select="'regular'"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
    -->
    <xsl:call-template name="xhtml.process">
      <xsl:with-param name="document" select="contentdata/description"/>
      <xsl:with-param name="image" select="/result/contents/relatedcontents/content[contenttype='image']"/>
    </xsl:call-template>
    <xsl:if test="$device-class = 'mobile'">
      <xsl:call-template name="related-content">
        <xsl:with-param name="size" select="'full'"/>
        <xsl:with-param name="start" select="2"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>

  <xsl:template name="related-content">
    <xsl:param name="size"/>
    <xsl:param name="start" select="1"/>
    <xsl:if test="/result/contents/relatedcontents/content[@key = current()/contentdata/image[position() >= $start]/image/@key] or contentdata/link/url != '' or /result/contents/relatedcontents/content[@key = current()/contentdata/articles/content/@key] or /result/contents/relatedcontents/content[@key = current()/contentdata/file/file/file/@key]">
      <div class="related">
        <xsl:if test="not($device-class = 'mobile')">
          <xsl:attribute name="style">
            <xsl:value-of select="concat('width: ', floor($config-region-width * $config-imagesize[@name = $size]/width), 'px;')"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:if test="/result/contents/relatedcontents/content[@key = current()/contentdata/image[position() >= $start]/image/@key]">
          <xsl:for-each select="contentdata/image[position() >= $start and image/@key = /result/contents/relatedcontents/content/@key]">
            <div class="image">
              <xsl:call-template name="image.display-image">
                <xsl:with-param name="image" select="/result/contents/relatedcontents/content[@key = current()/image/@key]"/>
                <xsl:with-param name="size" select="$size"/>
              </xsl:call-template>
              <xsl:value-of select="image_text"/>
            </div>
          </xsl:for-each>
        </xsl:if>
        <xsl:if test="contentdata/link/url != ''">
          <h4>
            <xsl:value-of select="portal:localize('Related-links')"/>
          </h4>
          <ul>
            <xsl:for-each select="contentdata/link[url != '']">
              <li>
                <a href="{url}">
                  <xsl:if test="target = 'new'">
                    <xsl:attribute name="rel">external</xsl:attribute>
                  </xsl:if>
                  <xsl:value-of select="if (description != '') then description else url"/>
                </a>
              </li>
            </xsl:for-each>
          </ul>
        </xsl:if>
        <xsl:if test="/result/contents/relatedcontents/content[@key = current()/contentdata/articles/content/@key]">
          <h4>
            <xsl:value-of select="portal:localize('Related-articles')"/>
          </h4>
          <ul>
            <xsl:for-each select="contentdata/articles/content[@key = /result/contents/relatedcontents/content/@key]">
              <xsl:variable name="current-article" select="/result/contents/relatedcontents/content[@key = current()/@key]"/>
              <li>
                <a href="{portal:createContentUrl($current-article/@key, ())}">
                  <xsl:value-of select="$current-article/title"/>
                </a>
              </li>
            </xsl:for-each>
          </ul>
        </xsl:if>
        <xsl:if test="/result/contents/relatedcontents/content[@key = current()/contentdata/file/file/file/@key]">
          <h4>
            <xsl:value-of select="portal:localize('Related-files')"/>
          </h4>
          <ul>
            <xsl:for-each select="contentdata/file/file/file[@key = /result/contents/relatedcontents/content/@key]">
              <xsl:variable name="current-file" select="/result/contents/relatedcontents/content[@key = current()/@key]"/>
              <li>
                <a href="{portal:createBinaryUrl($current-file/contentdata/binarydata/@key, ('download', 'true'))}">
                  <xsl:call-template name="utilities.icon-image">
                    <xsl:with-param name="file-name" select="$current-file/title"/>
                    <xsl:with-param name="icon-folder-path" select="concat($theme-public, '/images')"/>
                  </xsl:call-template>
                  <xsl:value-of select="$current-file/title"/>
                </a>
                <xsl:value-of select="concat(' (', util:format-bytes($current-file/binaries/binary/@filesize), ')')"/>
                <xsl:if test="$current-file/contentdata/description != ''">
                  <br/>
                  <xsl:value-of select="util:crop-text($current-file/contentdata/description, 200)"/>
                </xsl:if>
              </li>
            </xsl:for-each>
          </ul>
        </xsl:if>
      </div>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>