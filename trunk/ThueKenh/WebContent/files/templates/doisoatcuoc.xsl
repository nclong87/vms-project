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
   <Font ss:FontName="Calibri" x:Family="Swiss" ss:Size="11" ss:Color="#000000"/>
   <Interior/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="s43" ss:Name="Comma">
   <NumberFormat ss:Format="_(* #,##0.00_);_(* \(#,##0.00\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="m69915296">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="m69915316">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="m69915376">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="m69915396">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="m69915416">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="m69915436">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="m69915456">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="m69915476">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="m69915092">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="m69915112">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="m69915132">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
   <Interior/>
  </Style>
  <Style ss:ID="m69915152">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="m69915172">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="m69915192">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="m69915232">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="m69914848">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="m69914888">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="m69914928">
   <Alignment ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="m69914948">
   <Alignment ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="m69914968">
   <Alignment ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s65">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="11"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s66">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s67">
   <Alignment ss:Vertical="Center" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s68">
   <Alignment ss:Vertical="Center"/>
   <Borders/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s69">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="Short Date"/>
  </Style>
  <Style ss:ID="s70">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s71">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="11"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s72">
   <Alignment ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="11"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s73">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="11"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s74">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="11"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s75">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="11"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s76">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s77">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#FF00FF"/>
  </Style>
  <Style ss:ID="s78">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#FF00FF"/>
   <NumberFormat ss:Format="Scientific"/>
  </Style>
  <Style ss:ID="s79">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s80">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <NumberFormat/>
  </Style>
  <Style ss:ID="s81">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s82">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="Short Date"/>
  </Style>
  <Style ss:ID="s84">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#FF00FF"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s86">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s860">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s87">
   <Alignment ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s88">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="11"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s89">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s90">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="#,##0;[Red]#,##0"/>
  </Style>
  <Style ss:ID="s91">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="#,##0;[Red]#,##0"/>
  </Style>
  <Style ss:ID="s92">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#FF00FF"/>
   <NumberFormat ss:Format="#,##0;[Red]#,##0"/>
  </Style>
  <Style ss:ID="s94">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s95">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="Short Date"/>
  </Style>
  <Style ss:ID="s96" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s960" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s97" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#FF0000"/>
   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s970" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#FF0000" ss:Bold="1"/>
   <Interior ss:Color="#FFFFFF" ss:Pattern="Solid"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s98" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="#,##0;[Red]#,##0"/>
  </Style>
  <Style ss:ID="s99" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <Interior/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s100">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <Interior/>
  </Style>
  <Style ss:ID="s101">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <Interior/>
   <NumberFormat ss:Format="Short Date"/>
  </Style>
  <Style ss:ID="s102">
   <Alignment ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <Interior/>
  </Style>
  <Style ss:ID="s103">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s104">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s111">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"
    ss:Bold="1"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="s117">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s119">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat/>
  </Style>
  <Style ss:ID="s120" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="_(* #,##0.00_);_(* \(#,##0.00\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s121" ss:Parent="s43">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#FF0000" ss:Bold="1"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s123" ss:Parent="s43">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s124" ss:Parent="s43">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s1240" ss:Parent="s43">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s125" ss:Parent="s43">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s126" ss:Parent="s43">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#FF00FF"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s127" ss:Parent="s43">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s168">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="[$-F400]h:mm:ss\ AM/PM"/>
  </Style>
  <Style ss:ID="s169">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="13"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s170">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000" ss:Bold="1"/>
  </Style>
  <Style ss:ID="s171">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="[$-F400]h:mm:ss\ AM/PM"/>
  </Style>
  <Style ss:ID="s173">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="12"
    ss:Color="#000000" ss:Bold="1"/>
   <NumberFormat ss:Format="[$-F400]h:mm:ss\ AM/PM"/>
  </Style>
  <Style ss:ID="s174">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="Short Date"/>
  </Style>
  <Style ss:ID="s175">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="s176">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s177">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <Interior/>
   <NumberFormat ss:Format="Short Date"/>
  </Style>
  <Style ss:ID="s178">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s179">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Color="#000000"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="s180">
   <Alignment ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="_(* #,##0_);_(* \(#,##0\);_(* &quot;-&quot;??_);_(@_)"/>
  </Style>
  <Style ss:ID="s181">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="s182">
   <Alignment ss:Horizontal="Right" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="8"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
  <Style ss:ID="s183">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <Font ss:FontName="Times New Roman" x:Family="Roman" ss:Size="9"
    ss:Color="#000000"/>
   <NumberFormat ss:Format="#,##0"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="Sheet1">
  <Table ss:ExpandedColumnCount="15" ss:ExpandedRowCount="34" x:FullColumns="1"
   x:FullRows="1" ss:StyleID="s65" ss:DefaultRowHeight="15">
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="23.25"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="99"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="32.25"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="51.75"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="56.25"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="54.75"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="30.75"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="30"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="84.75"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="60.75"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="50.25"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="45"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="55.5"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="73.5"/>
   <Column ss:StyleID="s65" ss:AutoFitWidth="0" ss:Width="108"/>
   <Row ss:Height="15.75" ss:StyleID="s70">
    <Cell ss:MergeAcross="5"><Data ss:Type="String">TẬP ĐOÀN </Data></Cell>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"/>
    <Cell ss:MergeAcross="5" ss:StyleID="s168"><Data ss:Type="String">CỘNG HOÀ XÃ HỘI CHỦ NGHĨA VIỆT NAM</Data></Cell>
   </Row>
   <Row ss:Height="15.75" ss:StyleID="s70">
    <Cell ss:MergeAcross="5"><Data ss:Type="String">BƯU CHÍNH VIỄN THÔNG VIỆT NAM</Data></Cell>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"/>
    <Cell ss:MergeAcross="5" ss:StyleID="s173"><Data ss:Type="String">Độc Lập – Tự Do – Hạnh Phúc</Data></Cell>
   </Row>
   <Row ss:Height="15.75" ss:StyleID="s70">
    <Cell ss:MergeAcross="5" ss:StyleID="s170"><Data ss:Type="String"><xsl:value-of select="/root/header/tendoitac"/></Data></Cell>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"/>
    <Cell ss:MergeAcross="5" ss:StyleID="s171"><Data ss:Type="String" x:Ticked="1">&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;&#45;-</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="15.75">
    <Cell ss:StyleID="s67"/>
    <Cell ss:StyleID="s68"/>
    <Cell ss:StyleID="s68"/>
    <Cell ss:StyleID="s68"/>
    <Cell ss:StyleID="s68"/>
    <Cell ss:StyleID="s66"/>
    <Cell ss:StyleID="s66"/>
    <Cell ss:StyleID="s66"/>
    <Cell ss:StyleID="s66"/>
    <Cell ss:MergeAcross="5" ss:StyleID="s168"><Data ss:Type="String">................., ngày ...... tháng ...... năm ......</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="29.25">
    <Cell ss:MergeAcross="14" ss:StyleID="s169"><Data ss:Type="String">BẢNG ĐỐI SOÁT CƯỚC THUÊ KÊNH  THÁNG <xsl:value-of select="/root/header/thang"/> NĂM <xsl:value-of select="/root/header/nam"/>. GIỮA <xsl:value-of select="/root/header/tendoitac"/> VÀ TRUNG TÂM THÔNG TIN DI ĐỘNG KHU VỰC VI</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="28.125" ss:StyleID="s73">
    <Cell ss:MergeDown="1" ss:StyleID="m69915376"><Data ss:Type="String">STT</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m69915396"><Data ss:Type="String">Hợp đồng</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m69915416"><Data ss:Type="String">PLHĐ</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m69915436"><Data ss:Type="String">Ngày có hiệu lực PLHĐ</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m69915456"><Data ss:Type="String">Giá trị HĐ/PLHĐ</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m69915476"><Data ss:Type="String">Thời gian đối soát</Data></Cell>
    <Cell ss:MergeAcross="1" ss:StyleID="s76"><Data ss:Type="String">Thời gian tính cước</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m69915232"><Data ss:Type="String">Số kênh</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m69915172"><Data ss:Type="String">Thành tiền</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m69915192"><Data ss:Type="String">cước ĐNHM</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m69915092"><Data ss:Type="String">Giảm trừ MLL từ <xsl:value-of select="/root/header/matlienlactu"/> đến <xsl:value-of select="/root/header/matlienlacden"/></Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m69915112"><Data ss:Type="String">ĐÃ TT</Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m69915132"><Data ss:Type="String">CÒN TT ĐẾN THÁNG <xsl:value-of select="/root/header/thang"/>/<xsl:value-of select="/root/header/nam"/></Data></Cell>
    <Cell ss:MergeDown="1" ss:StyleID="m69915152"><Data ss:Type="String">Ghi chú</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="27" ss:StyleID="s73">
    <Cell ss:Index="7" ss:StyleID="s76"><Data ss:Type="String">Tháng</Data></Cell>
    <Cell ss:StyleID="s76"><Data ss:Type="String">Ngày</Data></Cell>
   </Row>
   <xsl:apply-templates select="/root/data/row"/>
   <Row ss:AutoFitHeight="0" ss:Height="36">
    <Cell ss:MergeAcross="7" ss:StyleID="m69914968"><Data ss:Type="String">Tổng </Data></Cell>
    <Cell ss:StyleID="s102"><Data ss:Type="String" x:Ticked="1"><xsl:value-of disable-output-escaping="yes" select="/root/summary/tongsokenh"/></Data></Cell>
    <Cell ss:StyleID="s103"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tongthanhtien"/></Data></Cell>
    <Cell ss:StyleID="s103"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tongdaunoihoamang"/></Data></Cell>
    <Cell ss:StyleID="s103"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tonggiamtru"/></Data></Cell>
    <Cell ss:StyleID="s103"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tongdathanhtoan"/></Data></Cell>
    <Cell ss:StyleID="s87"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tongconthanhtoan"/></Data></Cell>
    <Cell ss:StyleID="s104"/>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="22.5">
    <Cell ss:MergeAcross="12" ss:StyleID="m69914928"><Data ss:Type="String">Thuế VAT 10%</Data></Cell>
    <Cell ss:StyleID="s120"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tongvat"/></Data></Cell>
    <Cell ss:StyleID="s79"/>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="18">
    <Cell ss:MergeAcross="12" ss:StyleID="m69914948"><Data ss:Type="String">Cộng cước thanh toán</Data></Cell>
    <Cell ss:StyleID="s121"><Data ss:Type="Number"><xsl:value-of select="/root/summary/tongcong"/></Data></Cell>
    <Cell ss:StyleID="s79"/>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="14.4375">
    <Cell ss:MergeAcross="13" ss:StyleID="s88"><Data ss:Type="String">Bằng chữ: <xsl:value-of select="/root/summary/bangchu"/></Data></Cell>
    <Cell ss:StyleID="s88"/>
   </Row>
   <Row>
    <Cell ss:Index="10" ss:StyleID="s74"/>
    <Cell ss:Index="14" ss:StyleID="s75"/>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="14.4375">
    <Cell ss:MergeAcross="5" ss:StyleID="s73"><Data ss:Type="String">XÁC NHẬN CỦA <xsl:value-of select="/root/header/tendoitac"/></Data></Cell>
    <Cell ss:Index="8" ss:MergeAcross="7" ss:StyleID="s73"><Data ss:Type="String">XÁC NHẬN CỦA TRUNG TÂM TTDĐ KV VI</Data></Cell>
   </Row>
   <Row>
    <Cell ss:MergeAcross="5" ss:StyleID="s73"><Data ss:Type="String">TRƯỞNG PHÒNG KẾ TOÁN TKTC</Data></Cell>
    <Cell ss:Index="14" ss:StyleID="s71"/>
   </Row>
   <Row>
    <Cell ss:Index="2" ss:StyleID="s72"/>
    <Cell ss:StyleID="s72"/>
    <Cell ss:StyleID="s72"/>
    <Cell ss:StyleID="s72"/>
    <Cell ss:StyleID="s72"/>
    <Cell ss:StyleID="s72"/>
   </Row>
   <Row>
    <Cell ss:Index="10" ss:StyleID="s74"/>
    <Cell ss:Index="13" ss:StyleID="s72"/>
    <Cell ss:StyleID="s72"/>
   </Row>
   <Row>
    <Cell ss:Index="10" ss:StyleID="s74"/>
   </Row>
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <PageSetup>
    <Layout x:Orientation="Landscape"/>
    <Header x:Margin="0.24"/>
    <Footer x:Margin="0.24"/>
    <PageMargins x:Bottom="0.24" x:Left="0.17" x:Right="0.17" x:Top="0.24"/>
   </PageSetup>
   <Print>
    <ValidPrinterInfo/>
    <HorizontalResolution>600</HorizontalResolution>
    <VerticalResolution>600</VerticalResolution>
   </Print>
   <Selected/>
   <TopRowVisible>15</TopRowVisible>
   <Panes>
    <Pane>
     <Number>3</Number>
     <ActiveRow>8</ActiveRow>
     <ActiveCol>13</ActiveCol>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
</Workbook>
</xsl:template>
<xsl:template match="row">
	<xsl:variable name="mergeDown" select="./num_child"/>
	<Row ss:Hidden="1" >
		<Cell ss:MergeDown="{$mergeDown}" ss:StyleID="s103"><Data ss:Type="Number"><xsl:value-of select='./stt'/></Data></Cell>
		<Cell ss:MergeDown="{$mergeDown}" ss:StyleID="s103"><Data ss:Type="String"><xsl:value-of select='./sohopdong'/></Data></Cell>
   </Row>
   <xsl:apply-templates select="./childs/child"/>
</xsl:template>
<xsl:template match="child">
	<xsl:variable name="plthaythe" select="./plthaythe"/>
	<Row ss:AutoFitHeight="0" ss:Height="37.5">
		<xsl:choose>
			<xsl:when test="$plthaythe='1'">
				<Cell ss:Index="3" ss:StyleID="s860"><Data ss:Type="String"><xsl:value-of select='./tenphuluc'/></Data></Cell>
				<Cell ss:StyleID="s860"><Data ss:Type="String" x:Ticked="1"><xsl:value-of select='./ngaycohieuluc'/></Data></Cell>
				<Cell ss:StyleID="s1240"><Data ss:Type="Number"><xsl:value-of select='./giatriphuluc'/></Data></Cell>
				<Cell ss:StyleID="s860"><Data ss:Type="String"><xsl:value-of select='./tungay'/> - <xsl:value-of select='./denngay'/></Data></Cell>
				<Cell ss:StyleID="s860"><Data ss:Type="Number"><xsl:value-of select='./sothang'/></Data></Cell>
				<Cell ss:StyleID="s860"><Data ss:Type="Number"><xsl:value-of select='./songay'/></Data></Cell>
				<Cell ss:StyleID="s960"><Data ss:Type="String"><xsl:value-of select='./soluongkenh'/></Data></Cell>
				<Cell ss:StyleID="s960"><Data ss:Type="Number"><xsl:value-of select='./thanhtien'/></Data></Cell>
				<Cell ss:StyleID="s960"><Data ss:Type="Number"><xsl:value-of select='./cuocdaunoi'/></Data></Cell>
				<Cell ss:StyleID="s960"><Data ss:Type="Number"><xsl:value-of select='./giamtrumll'/></Data></Cell>
				<Cell ss:StyleID="s960"><Data ss:Type="Number"><xsl:value-of select='./dathanhtoan'/></Data></Cell>
				<Cell ss:StyleID="s970"><Data ss:Type="Number"><xsl:value-of select='./conthanhtoan'/></Data></Cell>
				<Cell ss:StyleID="s860"><Data ss:Type="String"><xsl:value-of select='./ghichu'/></Data></Cell>
			</xsl:when>
			<xsl:otherwise>
				<Cell ss:Index="3" ss:StyleID="s86"><Data ss:Type="String"><xsl:value-of select='./tenphuluc'/></Data></Cell>
				<Cell ss:StyleID="s95"><Data ss:Type="String" x:Ticked="1"><xsl:value-of select='./ngaycohieuluc'/></Data></Cell>
				<Cell ss:StyleID="s124"><Data ss:Type="Number"><xsl:value-of select='./giatriphuluc'/></Data></Cell>
				<Cell ss:StyleID="s86"><Data ss:Type="String"><xsl:value-of select='./tungay'/> - <xsl:value-of select='./denngay'/></Data></Cell>
				<Cell ss:StyleID="s98"><Data ss:Type="Number"><xsl:value-of select='./sothang'/></Data></Cell>
				<Cell ss:StyleID="s91"><Data ss:Type="Number"><xsl:value-of select='./songay'/></Data></Cell>
				<Cell ss:StyleID="s96"><Data ss:Type="String"><xsl:value-of select='./soluongkenh'/></Data></Cell>
				<Cell ss:StyleID="s96"><Data ss:Type="Number"><xsl:value-of select='./thanhtien'/></Data></Cell>
				<Cell ss:StyleID="s96"><Data ss:Type="Number"><xsl:value-of select='./cuocdaunoi'/></Data></Cell>
				<Cell ss:StyleID="s99"><Data ss:Type="Number"><xsl:value-of select='./giamtrumll'/></Data></Cell>
				<Cell ss:StyleID="s96"><Data ss:Type="Number"><xsl:value-of select='./dathanhtoan'/></Data></Cell>
				<Cell ss:StyleID="s97"><Data ss:Type="Number"><xsl:value-of select='./conthanhtoan'/></Data></Cell>
				<Cell ss:StyleID="s86"><Data ss:Type="String"><xsl:value-of select='./ghichu'/></Data></Cell>
			</xsl:otherwise>
		</xsl:choose>
	</Row>
</xsl:template>
</xsl:stylesheet>