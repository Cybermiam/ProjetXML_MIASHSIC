<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes" />
    <xsl:template match="/">
        <svg xmlns="http://www.w3.org/2000/svg" version="1.1" width="1500" height="800">
            <style>
                .victory {
                  font: bold 25px sans-serif;
                  fill: limegreen;
                }
                .error {
                  font: bold 15px sans-serif;
                  fill: red;
                }

              </style>
            <xsl:apply-templates select="//grille" />
            <xsl:apply-templates select="//cell" />
        </svg>
    </xsl:template>

    <xsl:template match="grille">
        <rect width="700" height="600" fill="mediumpurple" stroke="black" stroke-width="2" />
        <xsl:variable name="nombreTurquoise" select="count(//cell[@couleur='turquoise'])" />
        <xsl:variable name="nombreRose" select="count(//cell[@couleur='hotpink'])" />
        <xsl:variable name="difference" select="$nombreTurquoise - $nombreRose" />
        <xsl:variable name="couleur" select="./cell[@couleur]" />
        <xsl:choose>
            <xsl:when test="$difference > 1">
                <text x="720" y="300" class="error">Un joueur a au moins 2 pions de plus que l'autre, c'est un tricheur</text>
            </xsl:when>
            <xsl:when test="-1 > $difference">
                <text x="720" y="300" class="error">Un joueur a au moins 2 pions de plus que l'autre, c'est un tricheur</text>
            </xsl:when>
        </xsl:choose>

    <xsl:if test="count(//cell[@couleur='lavender']) = 0" >
        <text x="300" y="650" class="victory">Egalité</text>
    </xsl:if>
    </xsl:template>

    <xsl:template match="cell">
        <xsl:variable name="currentRow" select="@ligne" />
        <xsl:variable name="currentColumn" select="@colonne" />
        <xsl:if test="@couleur != 'lavender'">
            <xsl:variable name="rightCell1" select="../cell[@ligne = $currentRow and @colonne = $currentColumn + 1]" />
            <xsl:variable name="rightCell2" select="../cell[@ligne = $currentRow and @colonne = $currentColumn + 2]" />
            <xsl:variable name="rightCell3" select="../cell[@ligne = $currentRow and @colonne = $currentColumn + 3]" />
            <xsl:variable name="diagonaleDCell1" select="../cell[@ligne = $currentRow + 1 and @colonne = $currentColumn + 1]" />
            <xsl:variable name="diagonaleDCell2" select="../cell[@ligne = $currentRow + 2 and @colonne = $currentColumn + 2]" />
            <xsl:variable name="diagonaleDCell3" select="../cell[@ligne = $currentRow + 3 and @colonne = $currentColumn + 3]" />
            <xsl:variable name="bottomCell1" select="../cell[@ligne = $currentRow + 1 and @colonne = $currentColumn]" />
            <xsl:variable name="bottomCell2" select="../cell[@ligne = $currentRow + 2 and @colonne = $currentColumn]" />
            <xsl:variable name="bottomCell3" select="../cell[@ligne = $currentRow + 3 and @colonne = $currentColumn]" />
            <xsl:variable name="diagonaleGCell1" select="../cell[@ligne = $currentRow + 1 and @colonne = $currentColumn -1]"/>
            <xsl:variable name="diagonaleGCell2" select="../cell[@ligne = $currentRow + 2 and @colonne = $currentColumn -2]"/>
            <xsl:variable name="diagonaleGCell3" select="../cell[@ligne = $currentRow + 3 and @colonne = $currentColumn -3]"/>
            <xsl:choose>
                <xsl:when test="@couleur = $rightCell1/@couleur and @couleur = $rightCell2/@couleur and @couleur = $rightCell3/@couleur">
                    <text x="225" y="650" class="victory"> <xsl:value-of select="@couleur"/> a gagné !</text>
                </xsl:when>
                <xsl:when test="@couleur = $diagonaleDCell1/@couleur and @couleur = $diagonaleDCell2/@couleur and @couleur = $diagonaleDCell3/@couleur">
                    <text x="225" y="650" class="victory"> <xsl:value-of select="@couleur"/> a gagné !</text>
                </xsl:when>
                <xsl:when test="@couleur = $bottomCell1/@couleur and @couleur = $bottomCell2/@couleur and @couleur = $bottomCell3/@couleur">
                    <text x="225" y="650" class="victory"> <xsl:value-of select="@couleur"/> a gagné !</text>
                </xsl:when>
                <xsl:when test="@couleur = $diagonaleGCell1/@couleur and @couleur = $diagonaleGCell2/@couleur and @couleur = $diagonaleGCell3/@couleur">
                    <text x="225" y="650" class="victory"> <xsl:value-of select="@couleur"/> a gagné !</text>
                </xsl:when>
            </xsl:choose>
        </xsl:if>      
        <xsl:variable name="nextRow" select="$currentRow + 1" />
        <xsl:variable
            name="nextCircle" select="../cell[@ligne = $nextRow and @colonne = $currentColumn]" />
        <xsl:choose>
            <xsl:when test="@couleur != 'lavender' and $nextCircle/@couleur = 'lavender'">
                <text x="720" y="350" class="error">Le pion placé en l = <xsl:value-of select="@ligne + 1" /> et c = <xsl:value-of select="@colonne + 1" /> flotte, et c'est impossible</text>
                <circle>
                    <xsl:attribute name="cx">
                        <xsl:value-of select="(@colonne * 100) + 50" />
                    </xsl:attribute>
                    <xsl:attribute name="cy">
                        <xsl:value-of select="(@ligne * 100) + 50" />
                    </xsl:attribute>
                    <xsl:attribute name="r">45</xsl:attribute>
                    <xsl:attribute name="stroke">black</xsl:attribute>
                    <xsl:attribute name="stroke-width">2</xsl:attribute>
                    <xsl:attribute name="fill">
                        <xsl:value-of select="@couleur" />
                    </xsl:attribute>
                </circle>
            </xsl:when>
            <xsl:otherwise>
                <circle>
                    <xsl:attribute name="cx">
                        <xsl:value-of select="(@colonne * 100) + 50" />
                    </xsl:attribute>
                    <xsl:attribute name="cy">
                        <xsl:value-of select="(@ligne * 100) + 50" />
                    </xsl:attribute>
                    <xsl:attribute name="r">45</xsl:attribute>
                    <xsl:attribute name="stroke">black</xsl:attribute>
                    <xsl:attribute name="stroke-width">2</xsl:attribute>
                    <xsl:attribute name="fill">
                        <xsl:value-of select="@couleur" />
                    </xsl:attribute>
                </circle>
            </xsl:otherwise>
        </xsl:choose>      
    </xsl:template> 
</xsl:stylesheet>