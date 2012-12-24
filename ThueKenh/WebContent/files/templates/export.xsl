<?xml version="1.0" encoding="UTF-8"?>
<?mso-application progid="Excel.Sheet"?>
<xsl:stylesheet version="1.0" 
xmlns:html="http://www.w3.org/TR/REC-html40"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns="urn:schemas-microsoft-com:office:spreadsheet"
	xmlns:o="urn:schemas-microsoft-com:office:office" 
	xmlns:x="urn:schemas-microsoft-com:office:excel"
	xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet">

<xsl:template match="/">
	<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:o="urn:schemas-microsoft-com:office:office"
 xmlns:x="urn:schemas-microsoft-com:office:excel"
 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:html="http://www.w3.org/TR/REC-html40">
  <Styles>
  <Style ss:ID="Default" ss:Name="Normal">
   <Alignment ss:Vertical="Bottom"/>
   <Borders/>
   <Font/>
   <Interior/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="s23">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font x:Family="Swiss" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s24">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font x:Family="Swiss" ss:Bold="1"/>
  </Style>
  <Style ss:ID="Text">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
  </Style>
  <Style ss:ID="Number">
	<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
    <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="Double">
	<Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
    <NumberFormat ss:Format="Standard"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="Sheet1">
  <Table>
	<xsl:for-each select="/root/header/cell">
		<Column ss:AutoFitWidth="1"/>
	</xsl:for-each>
	<Row ss:AutoFitHeight="0" ss:Height="19.5" ss:StyleID="s23">
		<xsl:for-each select="/root/header/cell">
			<Cell ss:StyleID="s24"><Data ss:Type="String"><xsl:value-of select='.'/></Data></Cell>
		</xsl:for-each>
   </Row>
   <xsl:apply-templates select="/root/rows/row"/>
  </Table>
 </Worksheet>
</Workbook>
</xsl:template>
<xsl:template match="rows/row">
	<Row ss:AutoFitHeight="0" ss:Height="15">
		<xsl:for-each select="cell">
			<xsl:variable name="hid" select="./@hid"/> 
			<xsl:variable name="type" select="/root/header/cell[@id=$hid]/@type"/>
			<xsl:variable name="style" select="/root/header/cell[@id=$hid]/@style"/>
			<Cell ss:StyleID="{$style}"><Data ss:Type="{$type}"><xsl:value-of select="."/></Data></Cell>
		</xsl:for-each>
	</Row>
</xsl:template>
</xsl:stylesheet>