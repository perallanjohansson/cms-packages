<xsl:stylesheet version="2.0"
                exclude-result-prefixes="#all"
                xmlns:portal="http://www.enonic.com/cms/xslt/portal"
                xmlns:util="enonic:utilities"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="spot-slideshow-jquery-scripts">
        <script  type="text/javascript">
            $(document).ready(function() {
                var currentSlide = 1;
                var totalSlides =  $('.slideshow-image').size();
                var backgroundslideshow = 0;

                function runSlideshow(){
                    cssTransitionsAvailable = $('html').hasClass('csstransitions');
                    if (cssTransitionsAvailable){
                        slideshowTransitions();
                    }else{
                        slideshowAnimation();
                    }
                }
                function slideshowTransitions(){
                    crossFadeCurrentAndNextSlide();
                    backgroundSlideshow = setTimeout(slideshowTransitions, 8000);
                }
                function slideshowAnimation(){
                    console.log('slideshow animation with javascript not implemented');
                }
                function crossFadeCurrentAndNextSlide(){
                    toggleTransparency(currentSlide);
                    increaseOrResetCurrentSlide();
                    toggleTransparency(currentSlide);
                }
                function toggleTransparency(){
                    $("#slideshow-image-"+currentSlide).toggleClass("transparent");
                }
                function increaseOrResetCurrentSlide(){
                    if (currentSlide==totalSlides){
                        currentSlide = 1;
                    }else {
                        currentSlide++;
                    }
                }
                if (totalSlides>1){
                    backgroundSlideshow = setTimeout(runSlideshow, 8000);
                }
            });
        </script>
    </xsl:template>

    <xsl:template name="spot-slideshow">
        <xsl:param name="slideshow-images" select="/result/slideshow-images" as="element()*"/>
        <xsl:if test="exists($slideshow-images)">
            <div id="slideshow-images">
                <xsl:for-each select="$slideshow-images/contents/content">
                    <xsl:choose>
                        <xsl:when test="/result/context/resource/type='Spot' and current()/@key = /result/context/resource/@key">
                            <xsl:call-template name="slideshow-image">
                                <xsl:with-param name="images" select="contentdata/image" />
                                <xsl:with-param name="location" select="display-name" />
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="slideshow-image">
                                <xsl:with-param name="images" select="contentdata/image[1]" />
                                <xsl:with-param name="location" select="display-name" />
                                <xsl:with-param name="position" select="position()" />
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
                <xsl:call-template name="spot-slideshow-jquery-scripts" />
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template name="slideshow-image">
        <xsl:param name="location" />
        <xsl:param name="images" />
        <xsl:param name="position" />
        <xsl:for-each select="$images">
            <figure style="background-image: url('{portal:createImageUrl(image/@key, 'scalewidth(1200)','','jpg','50')}')">
                <xsl:attribute name="id">
                    <xsl:text>slideshow-image-</xsl:text>
                    <xsl:choose>
                        <xsl:when test="$position">
                            <xsl:value-of select="$position"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="position()" />
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:attribute name="class">
                    <xsl:if test="($position and not($position=1)) or (not($position) and not(position()=1))">
                        <xsl:text>transparent </xsl:text>
                    </xsl:if>
                    <xsl:text>slideshow-image</xsl:text>
                </xsl:attribute>

                <figcaption class="slideshow-image-info">
                    <ul>
                        <xsl:if test="$location"><li><xsl:value-of select="$location" /></li></xsl:if>
                        <li><xsl:value-of select="image_text" /></li>
                    </ul>
                </figcaption>
            </figure>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>