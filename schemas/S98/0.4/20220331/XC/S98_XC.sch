<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================================================= -->
<!--
	© Copyright 2015-2017 (IHB) ... (Draft - Copyright statement tbd)
  © Copyright 2018
	Prepared under NOAA contract
	
	License
  Certain parts of the text of this document refer to or are based on the standards of the International
  Organization for Standardization (ISO). The ISO standards can be obtained from any ISO member and from the
  Web site of the ISO Central Secretariat at www.iso.org.
    
  Permission to copy and distribute this document is hereby granted provided that this notice is retained
  on all copies, and that IHO & NOAA are credited when the material is redistributed or used in part or
	whole in derivative works.
	
  Certain parts of this work are derived from or were originally prepared as works for the UK Location Programme
  (UKLP) and GEMINI project and are (C) Crown copyright (UK). These parts are included under and subject to the
  terms of the Open Government license.

	Disclaimer	(Draft)
	This work is provided without warranty, expressed or implied, that it is complete or accurate or that it
	is fit for any particular purpose.  All such warranties are expressly disclaimed and excluded.
	
	Document history
	Version 0.3	20180702	Raphael Malyankar for NOAA Initial version adapted from the Schematron file for S100 exchange catalogues.
    1.0.0 2019-03-31  Raphael Malyankar (RMM) for NOAA  removed superfluous namespaces
          2019-04-24  (RMM) removed obsolete rules; updated rules to work with exchange sets that mix ICs with other products
	-->
<!-- ============================================================================================= -->

<!-- Notes: (1) This rules file does not provide for extensions to IC catalogue metadata, since
      extensions to medatata for interoperability catalogues are not envisioned in Edition 1.0.0.
-->

<!-- ============================================================================================= -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" schemaVersion="1.0.0-20190422" queryBinding="xslt">
  <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/2.0"/>
  <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>
  <sch:ns prefix="gcx" uri="http://standards.iso.org/iso/19115/-3/gcx/1.0"/>
  <sch:ns prefix="gex" uri="http://standards.iso.org/iso/19115/-3/gex/1.0"/>
  <sch:ns prefix="lan" uri="http://standards.iso.org/iso/19115/-3/lan/1.0"/>
  <sch:ns prefix="mco" uri="http://standards.iso.org/iso/19115/-3/mco/1.0"/>
  <sch:ns prefix="mdb" uri="http://standards.iso.org/iso/19115/-3/mdb/1.0"/>
  <sch:ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
  <sch:ns uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/>
  <sch:ns uri="http://www.iho.int/s100/xc" prefix="S100XC"/>
  <sch:ns uri="http://www.iho.int/s98/xc" prefix="S98XC"/>

  <sch:title>IHO S-100 Schematron validation rules for S-98 Exchange Catalogues for Interoperability Catalogue datasets</sch:title>

  <!-- Rules to test validity of bounding box coordinates (if any). Assumes lat/lon in decimal degrees, ranges +/-90.0 and +/-180.0. -->
  <sch:pattern is-a="S100_ValidBBoxPattern" fpi="S100_XC_ValidBBox">
    <sch:title>Validity of bounding box corners</sch:title>
    <sch:param name="bbox" value="//S100XC:boundingBox | //*[@gco:isoType = 'gmd:EX_GeographicBoundingBox']"/>
  </sch:pattern>

  <sch:pattern id="S100_ValidBBoxPattern" abstract="true" fpi="S100_BBox_LLDD_MinMax">
    <sch:title>Check the values of the bounding box min/max. Assumes values are latitude and longitude in decimal degrees in +/-90 or +/-180 range respectively.</sch:title>
    <sch:rule context="$bbox">
      <sch:assert test="gex:westBoundLongitude and (string-length(gex:westBoundLongitude) > 0) and (gex:westBoundLongitude >= -180.0) and (gex:westBoundLongitude &lt;= 180.0)" flag="badWB">
          westBoundLongitude must be present and in the range [-180.0, 180.0].
      </sch:assert>
      <sch:assert test="gex:eastBoundLongitude and (string-length(gex:eastBoundLongitude) > 0) and (gex:eastBoundLongitude >= -180.0) and (gex:eastBoundLongitude &lt;= 180.0)" flag="badEB">
          eastBoundLongitude must be present and in the range [-180.0, 180.0].
      </sch:assert>
      <sch:assert test="gex:southBoundLatitude and (string-length(gex:southBoundLatitude) > 0) and (gex:southBoundLatitude >= -90.0) and (gex:southBoundLatitude &lt;= 90.0)" flag="badSB">
          southBoundLatitude must be present and in the range [-90.0, 90.0].
      </sch:assert>
      <sch:assert test="gex:northBoundLatitude and (string-length(gex:northBoundLatitude) > 0) and (gex:northBoundLatitude >= -90.0) and (gex:northBoundLatitude &lt;= 90.0)" flag="badNB">
          northBoundLatitude must be present and in the range [-90.0, 90.0].
      </sch:assert>
      <sch:assert test="not(badEB or badWB) and (number(gex:westBoundLongitude) &lt; number(gex:eastBoundLongitude))">
        westBoundLongitude (<sch:value-of select="gex:westBoundLongitude"/>) must be less than eastBoundLongitude (<sch:value-of select="gex:eastBoundLongitude"/>)
      </sch:assert>
      <sch:assert test="not(badNB or badSB) and (number(gex:southBoundLatitude) &lt; number(gex:northBoundLatitude))">
        northBoundLatitude (<sch:value-of select="gex:northBoundLatitude"/>) must be greater than southBoundLatitude (<sch:value-of select="gex:southBoundLatitude"/>)
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Test for availability or nilling of reference to ISO 19115 metadata file -->
  <sch:pattern fpi="S100_XC_ISO19115Filename">
    <sch:rule context="//S98XC:S100_IC_CatalogueMetadata/S100XC:S100_19115DatasetMetadata">
      <sch:assert test="@gco:nilReason or gcx:FileName[string-length(normalize-space(@src)) > 0]">
        Reference to ISO 19115 metadata file must be nilled or have the gcx:FileName@src attribute populated.
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Tests that mandatory elements with string types are non-empty / non-blank.    -->
  <!-- Test for identifier sub-element of exchange catalogue. -->
  <sch:pattern fpi="S100_XC_cString_generic_exchangecatalog">
    <sch:title>Rule to check for presence of mandatory elements of type string</sch:title>
    <sch:rule context="
        /*/S100XC:identifier/S100XC:identifier
        | /*/S100XC:identifier/S100XC:editionNumber
        | /*/S100XC:exchangeCatalogueName
        | /*/S100XC:exchangeCatalogueDescription | /*/S100XC:metadataLanguage">
      <sch:assert test="string-length(normalize-space())"><sch:name/> must contain a string value that is not all whitespace</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Tests for sub-elements of dataset discovery -->
  <!-- Check that the exchange catalogue uses at least one S-98 discovery metadata tag  -->
  <sch:pattern fpi="S98_XC_DatasetDiscoveryElement">
    <sch:title>Rule to check that the exchange catalog for interoperability datasets uses at least one dataset discovery definition from S-98</sch:title>
    <sch:rule context="//S100XC:datasetDiscoveryMetadata">
      <sch:assert test="S98XC:S100_IC_CatalogueMetadata"><sch:name/> There must be at least one Dataset Discovery Metadata element from the S-98 exchange catalogue namespace</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Check that the specifications listed in interoperability catalogue products element are distinct from one another -->
  <sch:pattern fpi="S98_DSD.icproducts">
    <sch:title>Check listed interoperability catalogue products for duplication</sch:title>
    <sch:rule context="//S100XC:datasetDiscoveryMetadata/S98XC:S100_IC_CatalogueMetadata/S98XC:interoperabilityCatalogueProducts/S100XC:S100_ProductSpecification">
      <sch:let name="PRODNAME" value="string(S100XC:name)"/>
      <sch:assert test="count(../S100XC:S100_ProductSpecification[string(S100XC:name) = $PRODNAME]) + count(../S100XC:S100_ProductSpecification[substring-after(S100XC:name, 'other: ') = $PRODNAME]) &lt; 2">
          Duplicate product in interoperabilityCatalogueProducts element: <sch:value-of select="$PRODNAME"/>
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Check that dataset discovery metadata data type is "undefined" -->
  <sch:pattern fpi="S98_datasetDiscoveryMetadata.dataType.1">
    <sch:title>Check dataType in dataset discovery metadata</sch:title>
    <sch:rule context="//S100XC:datasetDiscoveryMetadata/S98XC:S100_IC_CatalogueMetadata">
      <sch:assert test="count(S100XC:dataType) > 0 and (S100XC:dataType/text() = 'undefined')">
        Content of element 'datatype' in <sch:name/> (<sch:value-of select="S100XC:dataType"/>) must be the value 'undefined'
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Check that the optional S-100 metadata elements of dataset discovery metadata not used in S-98 metadata are not included (warning)
      updateNumber, updateApplicationDate, optimum/maximum/minimumDisplayScale, epoch, verticalDatum, soundingDatum,
      dataCoverage.{optimum/maximum/minimumDisplayScale}
 -->
  <sch:pattern fpi="S98_datasetDiscoveryMetadata.omissions.1">
    <sch:title>Check for S-100 metadata elements in discovery metadata not used in S-98</sch:title>
    <sch:rule context="//S100XC:datasetDiscoveryMetadata/S98XC:S100_IC_CatalogueMetadata" role="warn">
      <sch:report test="count(S100XC:updateNumber | S100XC:updateApplicationDate) > 0">
        Warning: S-98 Exchange Catalogue element <sch:name/> uses S-100 metadata element updateNumber or updateApplicationDate which is omitted for S-98
      </sch:report>
      <sch:report test="count(S100XC:optimumDisplayScale | S100XC:maximumDisplayScale | S100XC:minimumDisplayScale) > 0">
        Warning: S-98 Exchange Catalogue element <sch:name/> uses S-100 metadata element optimumDisplayScale, maximumDisplayScale, or minimumDisplayScale which is omitted for S-98
      </sch:report>
      <sch:report test="count(S100XC:verticalDatum | S100XC:soundingDatum) > 0">
        Warning: S-98 Exchange Catalogue element <sch:name/> uses S-100 metadata element verticalDatum or soundingDatum which is omitted for S-98
      </sch:report>
      <sch:report test="S100XC:epoch">
        Warning: S-98 Exchange Catalogue element <sch:name/> includes epoch which is not used for S-98
      </sch:report>
      <sch:report test="S100XC:horizontalDatumReference[count(@xsi:nil) = 0 and count(@gco:nilReason) = 0]">
        Warning: S-98 Exchange Catalogue element <sch:name/> includes a horizontal datum reference which is not nilled
      </sch:report>
      <sch:report test="S100XC:horizontalDatumvalue[count(@xsi:nil) = 0 and count(@gco:nilReason) = 0]">
        Warning: S-98 Exchange Catalogue element <sch:name/> includes a horizontal datum value which is not nilled
      </sch:report>
      <sch:report test="S100XC:S100_SupportFileDiscoveryMetadata">
        Warning: S-98 Exchange Catalogue element <sch:name/> contains a support file discovery metadata block (deprecated - use references to support file metadata blocks instead)
      </sch:report>
      <sch:report test="count(S100XC:dataCoverage/S100XC:optimumDisplayScale | S100XC:dataCoverage/S100XC:maximumDisplayScale | S100XC:dataCoverage/S100XC:minimumDisplayScale) > 0">
        Warning: S-98 Exchange Catalogue element <sch:name/>/dataCoverage uses optimumDisplayScale, maximumDisplayScale, or minimumDisplayScale which is omitted for S-98
      </sch:report>
    </sch:rule>

  </sch:pattern>

  <!-- Check that the support file dataType is limited to XML/XSLT/LUA/other -->
  <sch:pattern fpi="S98_supportFileDiscoveryMetadata.dataType.1">
    <sch:title>Check dataType in support file discovery metadata</sch:title>
    <sch:rule context="//S100XC:datasetDiscoveryMetadata/S98XC:S100_IC_CatalogueMetadata/S100XC:supportFileDiscoveryMetadataReference" role="warn">
      <sch:let name="SUPP_FILE" value="text()"/>
      <sch:report test="count(/*/S100XC:supportFileDiscoveryMetadata[fileName = $SUPP_FILE]) = 0">Support file metadata for <sch:value-of select="$SUPP_FILE"/> not found</sch:report>
      <sch:report test="count(/*/S100XC:supportFileDiscoveryMetadata[fileName = $SUPP_FILE]/S100XC:dataType) > 0 and not(contains('XML|XSLT|LUA|other', S100XC:dataType/text()))">
        Warning: Data type for IC support file <sch:value-of select="$SUPP_FILE"/> (<sch:value-of select="S100XC:dataType"/>) must be one of XML, XSLT, LUA, other
      </sch:report>
    </sch:rule>
  </sch:pattern>


  <!-- check (information) root element (must be S100_Exchange Catalogue unless the IC is part of a mixed exchange set -->
  <sch:pattern fpi="S98_CatalogueMetadata.1">
    <sch:title>Check S98 S100_CatalogueMetadata elements</sch:title>
    <sch:rule context="/S100XC:S100_ExchangeCatalogue" role="information">
      <sch:report test="count(S100XC:S100_CatalogueMetadata) = 0">Information: No S100_CatalogueMetadata element with S-100 namespace - is this exchange catalogue for a mixed exchange set?</sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- check (warning) if there is no catalogue metadata element with scope = interoperability -->
  <sch:pattern fpi="S98_CatalogueMetadata.2">
    <sch:title>If S100_CatalogueMetadata elements are present there should be at least one for the interoperability catalogue</sch:title>
    <sch:rule context="/*" role="warn">
      <sch:report test="count(S100XC:S100_CatalogueMetadata[S100XC:scope = 'interoperabilityCatalogue']) = 0">Warning: No S100_CatalogueMetadata element with scope interoperabilityCatalogue</sch:report>
    </sch:rule>
  </sch:pattern>


  <!-- Test for sub-elements of product specification sub-element of dataset discovery -->
  <sch:pattern fpi="S100_XC_cString_generic_productSpecification">
    <sch:title>Rule to check for presence of mandatory elements of type string</sch:title>
    <sch:rule context="//S98XC:datasetDiscoveryMetadata/S100XC:productSpecification/S100XC:name
        | //S98XC:datasetDiscoveryMetadata/S100XC:productSpecification/S100XC:version">
      <sch:assert test="string-length(normalize-space())"><sch:name/> must contain a string value that is not all whitespace</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Test that the product specification name for interop catalogues is S-98 (warning) -->

  <!-- rule to check that role is either nilled or not empty -->
  <sch:pattern fpi="S100_XC_DSMD_role_Nillable">
    <sch:rule context="//S98XC:datasetDiscoveryMetadata//cit:role">
      <sch:assert test="
          (count(*) > 0) or (@gco:nilReason = 'inapplicable' or
          @gco:nilReason = 'missing' or
          @gco:nilReason = 'template' or
          @gco:nilReason = 'unknown' or
          @gco:nilReason = 'withheld' or
          starts-with(@gco:nilReason, 'other:'))" flag="isNilled">
      The <sch:name/> element shall have a value or a valid Nil Reason.
    </sch:assert>
      <sch:assert test="isNilled or (cit:CI_RoleCode and (string-length(cit:CI_RoleCode/@codeListValue) > 0))">
        The codeListValue attribute does not have a value.
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- 
    Rule to require support file name to be populated in S100_SupportFileDiscoveryMetadata.
  -->
  <sch:pattern fpi="S100_XC_productSpecification">
    <sch:rule context="//S100XC:supportFileDiscoveryMetadata/S100XC:supportFileSpecification">
      <sch:assert test="string-length(normalize-space(S100XC:name)) > 0">
        The name element of support file discovery metadata must be populated.
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule to warn if support file specification date and version are not populated in S100_SupportFileDiscoveryMetadata when dataType is not ASCII -->
  <sch:pattern fpi="S100_XC_productSpecification">
    <sch:rule context="//S100XC:supportFileDiscoveryMetadata" role="warn">
      <sch:assert test="(S100XC:dataType = 'ASCII') or ((string-length(normalize-space(S100XC:supportFileSpecification/S100XC:date)) > 0) and (string-length(normalize-space(S100XC:supportFileSpecification/S100XC:version)) > 0))">
        Warning: Support file discovery metadata element for non-text support files should contain a supportFileSpecification element with date and version populated
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rule to check nillable elements -->
  <sch:pattern is-a="TypeNillablePattern_S100Ext">
    <sch:param name="context" value="//S100XC:horizontalDatumReference|//S100XC:horizontalDatumValue"/>
  </sch:pattern>

  <!-- rule to check that codelist values are populated -->
  <sch:pattern is-a="IsoCodeListPattern">
    <sch:param name="context" value="//lan:LanguageCode|//lan:MD_CharacterSetCode|//mco:MD_ClassificationCode|//cit:CI_RoleCode"/>
  </sch:pattern>

  <!-- ========================================================================================== -->
  <!-- The following patterns are extracts from the Schematron Schema for the UK GEMINI Standard  -->
  <!-- Version 2.1 and are incuded subject to the terms applicable to that schema, reproduced     -->
  <!-- below.                                                                                     -->
  <!-- Note that some of the comments below refer to tests which are not applicable to S-100 and  -->
  <!-- which are therefore not included below.                                                    -->
  <!-- ========================================================================================== -->

  <!-- 
     James Rapaport                                
     SeaZone Solutions Limited                                                  
     2010-07-13
     
     This Schematron schema has been developed for the UK Location Programme (UKLP) by
     SeaZone Solutions Limited (SeaZone), with funding from Defra and CLG.
     
     It is designed to validate the constraints introduced in the GEMINI2.1 draft standard.
     Constraints have been taken from:
     
     UK GEMINI Standard, Version 2.1, August 2010.
     
     The schema has been developed for XSLT Version 1.0 and tested with the ISO 19757-3 Schematron
     XML Stylesheets issued on 2009-03-18 at http://www.schematron.com/tmp/iso-schematron-xslt1.zip 
     
     The schema tests constraints on ISO / TS 19139 encoded metadata. The rules expressed in this 
     schema apply in addition to validation by the ISO / TS 19139 XML schemas.
     
     The schema is designed to test ISO 19139 encoded metadata incorporating ISO 19136 (GML Version
     3.2.1) elements where necessary. Note that GML elements must be mapped to the Version 3.2.1 
     GML namespace - http://www.opengis.net/gml/3.2
     
     (C) Crown copyright, 2011
     
     You may use and re-use the information in this publication (not including logos) free of charge
     in any format or medium, under the terms of the Open Government Licence.
   
   
     Document History:
     
     2010-10-14 - Version 1.0
     Baselined version for beta release.  No technical changes against v0.11.
     
     2011-01-18 - Version 1.1
     - Metadata Point of Contact (Metadata Item 35) - test now ensures that at least one 
     metadata contact has a role of pointOfContact.
     - Temporal element (Metadata Item 7) - test changed so that it is nolonger the case 
     that only one gmd:temporalElement can be encoded for any gmd:extent element.
     
     2011-04-19 - Version 1.2a
     Changes to allow round trip interoperability with INSPIRE metadata.
     - Temporal extent (Metadata Item 7) - remove rule constraining temporal extent to 
     one only.
     - Geographic bounding box (Metadata Item 11, 12, 13, 14) - allow one or more geographic bounding box
     - Spatial reference system (Metadata Item 17) - remove rule constraining spatial reference
     system to only one.
     - Frequency of update (Metadata Item 24) - remove rule constraining frequency of update to single
     - Unique resource identifier (Metadata Item 36) - amend rule to allow 1 or more Unique resource identifier
     - Equivalent scale (Metadata Item 43) - remove rule constraining Equivalent scale to zero or 1
     
     2011-04-20 - Version 1.2b
     - Unique resource identifier (Metadata item 36) - change sense of failure message to 'one or more'
     - Spatial resolution (Metadata item 18) - remove rule that tests for units of measure
     
     2011-04-21 - Version 1.2c
     - Temporal extent (Metadata item 7) - temporal extent can be implemented as a gml:TimePeriod or 
     gml:TimeInstant. If gml:TimePeriod is used, the child elements are allowed to be gml:begin or gml:beginPosition, and
     gml:end or gml:endPosition.
     
     2011-05-09 - Version 1.2
     - Vertical extent (Metadata item 16) - remove rule restricting number of vertical extent elements
     to 0 or 1.
	 
	2012-12-20 - Version 1.3a
	 - Metadata language - ensure that metadata contains one metadata language element. Gemini2-mi33 edited and rule added.
	2013-02-01 - Version 1.3
	 - as above, but tested by data.gov.uk & EDINA, so accepted for publication
-->

  <!-- ========================================================================================== -->
  <!-- Abstract Patterns                                                                          -->
  <!-- ========================================================================================== -->

  <!-- Test that an element has a value or has a valid nilReason value -->
  <!-- Provisionally extended to account for child elements - RMM -->
  <sch:pattern abstract="true" id="TypeNillablePattern_S100Ext">
    <sch:rule context="$context">
      <sch:assert test="
          (string-length(.) &gt; 0) or (count(*) > 0) or
          (@gco:nilReason = 'inapplicable' or
          @gco:nilReason = 'missing' or
          @gco:nilReason = 'template' or
          @gco:nilReason = 'unknown' or
          @gco:nilReason = 'withheld' or
          starts-with(@gco:nilReason, 'other:'))">
        The <sch:name/> element must have a value, element content, or a valid Nil Reason (inapplicable, missing, template, unknown, withheld, other: ...).
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Test that an element has a value - the value is not nillable -->
  <sch:pattern abstract="true" id="TypeNotNillablePattern">
    <sch:rule context="$context">
      <sch:assert test="string-length(.) &gt; 0 and count(./@gco:nilReason) = 0">
        The <sch:name/> element is not nillable and must have a value.
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Test ISO code lists -->
  <sch:pattern abstract="true" id="IsoCodeListPattern">
    <sch:rule context="$context">
      <sch:assert test="string-length(@codeListValue) &gt; 0">
        The codeListValue attribute of <sch:name/> does not have a value.
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- End of patterns included from GEMINI 2.1 Schematron Schema -->


</sch:schema>