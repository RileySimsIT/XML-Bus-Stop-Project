<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="html" indent="yes"/>
    <!--set default parameter value to -1-->
    <xsl:param name="routeNum" select="-1"/>

  <xsl:template match="/">
    <h2>
      <xsl:if test="$routeNum = -1">
        Showing all Stops
      </xsl:if>
      <xsl:if test="$routeNum != -1">
        Showing stops on Route <xsl:value-of select="$routeNum"/>
      </xsl:if>
    </h2>
    <p>
       <!--checks if it's the default variable for the parameter or not-->
      <xsl:if test="$routeNum = -1">
        <xsl:value-of select="count(//stop)"/> 
      </xsl:if>
      <xsl:if test="$routeNum != -1">
        <xsl:value-of select="count(//stop[contains(routes, $routeNum)])"/>
      </xsl:if>
      stops found
    </p>
    <table border="1">
      <tr>
        <th>Stop #</th>
        <th>Stop name</th>
        <th>Latitude</th>
        <th>Longitude</th>
        <th>Routes</th>
      </tr>
      <!--checks if it's the default variable for the parameter or not-->
      <xsl:if test="$routeNum != -1">
        <xsl:apply-templates select="//stop[contains(routes, $routeNum)]">
          <xsl:sort select="@number" data-type="number"/>
        </xsl:apply-templates>
      </xsl:if>
      <xsl:if test="$routeNum = -1">
        <xsl:apply-templates select="//stop">
          <xsl:sort select="@number" data-type="number"/>
        </xsl:apply-templates>
      </xsl:if>
    </table>
  </xsl:template>

  <!-- matches the stops and adds to the table-->
  <xsl:template match="stop">
    <tr>
      <td>
        <xsl:value-of select="@number"/>
      </td>
      <td>
        <xsl:value-of select="@name"/>
      </td>
      <td>
        <xsl:value-of select="location/latitude"/>
      </td>
      <td>
        <xsl:value-of select="location/longitude"/>
      </td>
      <td>
        <xsl:value-of select="routes"/>
      </td>
    </tr>
  </xsl:template>
</xsl:stylesheet>