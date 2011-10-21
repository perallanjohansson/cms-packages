<xsl:stylesheet version="2.0"
                exclude-result-prefixes="#all"
                xmlns:portal="http://www.enonic.com/cms/xslt/portal"
                xmlns:util="enonic:utilities"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:template name="spot-slideshow-jquery-scripts">
        <script  type="text/javascript">
            $(document).ready(function() {
                var currentSlide = 0;
                var totalSlides =  $('figure').size();
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
                    takeActionAccordingToImageCount();
                }
                function slideshowAnimation(){
                    console.log('slideshow animation with javascript not implemented');
                }
                function crossFadeCurrentAndNextSlide(){
                    toggleTransparency(currentSlide);
                    currentSlide++;
                }
                function toggleTransparency(){
                    $("figure:not(:eq("+currentSlide+")),figcaption:not(:eq("+currentSlide+"))").addClass("transparent");
                    $("figure:eq("+currentSlide+"),figcaption:eq("+currentSlide+")").toggleClass("transparent");
                }
                function takeActionAccordingToImageCount(){
                    if (totalSlides>1){
                        backgroundSlideshow = setTimeout(slideshowTransitions, 8000);
                    }
                    if (currentSlide==totalSlides){
                        currentSlide = 0;
                    }
                }
                runSlideshow();
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
        <xsl:for-each select="$images">
            <figure class="slideshow-image" style="background-image: url('{portal:createImageUrl(image/@key, 'scalewidth(1200)','','jpg','50')}')">
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