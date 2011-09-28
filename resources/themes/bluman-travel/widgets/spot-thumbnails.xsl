<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:util="enonic:utilities"
                xmlns:portal="http://www.enonic.com/cms/xslt/portal"
                xmlns:math="http://exslt.org/math"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:import href="../../../libraries/utilities/standard-variables.xsl"/>
    <xsl:include href="../../../libraries/utilities/utilities.xsl"/>
    <xsl:include href="../../../libraries/utilities/frame.xsl"/>

    <xsl:output indent="yes" media-type="text/html" method="xhtml" omit-xml-declaration="yes"/>

    <xsl:template match="/">
        <div id="spot-thumbnails">
            <xsl:if test="/result/spot-images/contents/content[@contenttype='Image']">
                <div class="spot-thumbnails">
                    <ul id="sdt_menu" class="sdt_menu">
                        <xsl:apply-templates select="/result/spot-images/contents/content[@contenttype='Image']" mode="spot-thumbnails"/>
                    </ul>
                </div>
            </xsl:if>
        </div>
        <xsl:call-template name="jquery-scripts" />
    </xsl:template>
    <xsl:template match="content" mode="spot-thumbnails">
           <li class="spot-thumbnail">
                <figure>
                    <img id="{@key}" onclick="changeBkgPermanently('{portal:createImageUrl(@key, '')}')" class="image-spot-thumbnail" alt="{title}" src="{portal:createImageUrl(@key, 'scalesquare(36)')}" />
                </figure>
            </li>
    </xsl:template>

    <xsl:template name="jquery-scripts">
        <script  type="text/javascript">
            var numberOfBackgroundImages = "<xsl:value-of select="count(/result/spot-images/contents/content[@contenttype='Image'])"/>";
            var currentBackgroundImage = 1;
            var toggle = true;
            var first = true;
            var imageUrl = "";
            var backgroundSlideshow = 0;

            function changeBkgPermanently(url){
                clearTimeout(backgroundSlideshow);
                $('#background1').css("background-image",'none');
                $('#background2').css("background-image",'none');
                $('#background').css("background-image",'url('+url+')');
                $('#background').css({opacity:0}).animate({opacity:1},500);
            }
            function slideshow(){
                if (toggle){
                    if (currentBackgroundImage==1){
                        imageUrl = "<xsl:value-of select="portal:createImageUrl(/result/spot-images/contents/content[@contenttype='Image'][1]/@key, '')" />";
                    }else if (currentBackgroundImage==2){
                        imageUrl = "<xsl:value-of select="portal:createImageUrl(/result/spot-images/contents/content[@contenttype='Image'][2]/@key, '')" />";
                    }else if (currentBackgroundImage==3){
                        imageUrl = "<xsl:value-of select="portal:createImageUrl(/result/spot-images/contents/content[@contenttype='Image'][3]/@key, '')" />";
                    }else if (currentBackgroundImage==4){
                        imageUrl = "<xsl:value-of select="portal:createImageUrl(/result/spot-images/contents/content[@contenttype='Image'][4]/@key, '')" />";
                    }else if (currentBackgroundImage==5){
                        imageUrl = "<xsl:value-of select="portal:createImageUrl(/result/spot-images/contents/content[@contenttype='Image'][5]/@key, '')" />";
                    }else{
                        imageUrl = "<xsl:value-of select="portal:createImageUrl(/result/spot-images/contents/content[@contenttype='Image'][6]/@key, '')" />";
                    }
                    if (numberOfBackgroundImages == currentBackgroundImage || currentBackgroundImage == 6){
                        currentBackgroundImage = 1;
                    }else{
                        currentBackgroundImage++;
                    }

                    if(first){
                        $('#background1').css("background-image",'url('+imageUrl+')');
                        $('#background1').css({opacity:0}).animate({opacity:1},5000);
                        toggle=false;
                        first=false;
                    }else{
                        $('#background2').css("background-image",'url('+imageUrl+')');
                        $('#background2').css({opacity:0}).animate({opacity:1},5000);
                        toggle = false;
                        first=true;
                    }
                    backgroundSlideshow = setTimeout(slideshow, 5000);
                }else{
                    if (first)
                        $('#background2').css({opacity:1}).animate({opacity:0},5000);
                    else
                        $('#background1').css({opacity:1}).animate({opacity:0},5000);
                    toggle = true;
                    backgroundSlideshow = setTimeout(slideshow, 0);
                }
            }
            $(document).ready(function(){
                slideshow();
            });
        </script>
    </xsl:template>
</xsl:stylesheet>
