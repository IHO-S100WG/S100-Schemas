<?xml version="1.0" encoding="UTF-8"?>
<!-- ============================================================================================= -->
<!--
	© Copyright 2015-2017 (IHB) ... (Draft - Copyright statement tbd)
  © Copyright 2018, 2022 (IHO)
	Prepared under NOAA and IHO contracts
	
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
	Version 1.0	2015-08-18	Raphael Malyankar (Jeppesen) for NOAA / IIC Technologies / IHO
            1.1 2015-09-16  Raphael Malyankar (Jeppesen) corrected element datasetDiscoveryMetadata to S100_DatasetDiscoveryMetadata
  3.0.0-20170430  Raphael Malyankar updated for S-100 3.0.0; vertical and sounding datum in dataset discovery metadata no
                  longer checked (some product specifications do not need them); schema version number convention
                  now <S-100 version>-<file build date (YYYYMMDD)>
  4.0.0-20180502  Updated for Edition 4.0.0 and ISO 19115-3
        20180619  Build number updated to match exchange catalogue schema
        20180702  Build number updated to match exchange catalogue schema
        20181015  Build number updated to match exchange catalogue schema
  5.0.0-20220331  Updated for S-100 Edition 5.0.0
        Rules updated, removed, and added to implement constraints in new Part 17; unneeded namespaces removed
	-->
<!-- ============================================================================================= -->
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" schemaVersion="5.0.0-20220331">
  <!--<sch:ns prefix="fn" uri="http://www.w3.org/2005/xpath-functions"/>-->
  <!--<sch:ns prefix="cat" uri="http://standards.iso.org/iso/19115/-3/cat/1.0"/>-->
  <sch:ns prefix="cit" uri="http://standards.iso.org/iso/19115/-3/cit/2.0"/>
  <sch:ns prefix="gco" uri="http://standards.iso.org/iso/19115/-3/gco/1.0"/>
  <sch:ns prefix="gcx" uri="http://standards.iso.org/iso/19115/-3/gcx/1.0"/>
  <sch:ns prefix="gex" uri="http://standards.iso.org/iso/19115/-3/gex/1.0"/>
  <!--<sch:ns prefix="gmw" uri="http://standards.iso.org/iso/19115/-3/gmw/1.0"/>-->
  <sch:ns prefix="lan" uri="http://standards.iso.org/iso/19115/-3/lan/1.0"/>
<!--
  <sch:ns prefix="mac" uri="http://standards.iso.org/iso/19115/-3/mac/1.0"/>
  <sch:ns prefix="mas" uri="http://standards.iso.org/iso/19115/-3/mas/1.0"/>
  <sch:ns prefix="mcc" uri="http://standards.iso.org/iso/19115/-3/mcc/1.0"/>
-->
  <sch:ns prefix="mco" uri="http://standards.iso.org/iso/19115/-3/mco/1.0"/>
  <!--<sch:ns prefix="mdb" uri="http://standards.iso.org/iso/19115/-3/mdb/1.0"/>-->
  <!--<sch:ns prefix="mex" uri="http://standards.iso.org/iso/19115/-3/mex/1.0"/>-->
  <sch:ns prefix="mmi" uri="http://standards.iso.org/iso/19115/-3/mmi/1.0"/>
  <!--<sch:ns prefix="mpc" uri="http://standards.iso.org/iso/19115/-3/mpc/1.0"/>-->
  <!--<sch:ns prefix="mrc" uri="http://standards.iso.org/iso/19115/-3/mrc/2.0"/>-->
  <!--<sch:ns prefix="mrd" uri="http://standards.iso.org/iso/19115/-3/mrd/1.0"/>-->
  <sch:ns prefix="mri" uri="http://standards.iso.org/iso/19115/-3/mri/1.0"/>
  <sch:ns prefix="mrl" uri="http://standards.iso.org/iso/19115/-3/mrl/2.0"/>
  <!--<sch:ns prefix="mrs" uri="http://standards.iso.org/iso/19115/-3/mrs/1.0"/>-->
  <!--<sch:ns prefix="msr" uri="http://standards.iso.org/iso/19115/-3/msr/2.0"/>-->
  <!--<sch:ns prefix="srv" uri="http://standards.iso.org/iso/19115/-3/srv/2.0"/>-->
  
  <!--<sch:ns prefix="mds" uri="http://standards.iso.org/iso/19115/-3/mds/1.0"/>-->
  <!--<sch:ns prefix="md1" uri="http://standards.iso.org/iso/19115/-3/md1/1.0"/>-->
  <!--<sch:ns prefix="mda" uri="http://standards.iso.org/iso/19115/-3/mda/1.0"/>-->
  <sch:ns prefix="mdt" uri="http://standards.iso.org/iso/19115/-3/mdt/1.0"/>
  <!--<sch:ns prefix="md2" uri="http://standards.iso.org/iso/19115/-3/md2/1.0"/>-->
  
<!--
  <sch:ns prefix="gmd" uri="http://www.isotc211.org/2005/gmd"/>
  <sch:ns prefix="gmx" uri="http://www.isotc211.org/2005/gmx"/>
-->
  <sch:ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
  <!--<sch:ns uri="http://www.isotc211.org/2005/gmi" prefix="gmi"/>-->
  <sch:ns uri="http://www.iho.int/s100/xc/5.0" prefix="S100XC"/>
  <sch:ns uri="http://www.iho.int/s100/se/5.0" prefix="S100SE"/>
    
  <sch:title>IHO S-100 Schematron validation rules for S-100 Exchange Catalogues</sch:title>

<!-- Modified because Ed. 5.0.0 removed maximum and minimum display scales from dataset discovery metadata -->

  <sch:pattern fpi="S100_17.DataCoverage">
    <sch:title>Comparative validity of maximum and minimum display scales</sch:title>
    <sch:rule context="//S100XC:dataCoverage/S100XC:minimumDisplayScale" role="warning">
      <sch:assert test="not(../S100XC:maximumDisplayScale) or (number(../S100XC:maximumDisplayScale) &lt; number())">
        <sch:value-of select="../../S100XC:fileName"/> maximumDisplayScale (<sch:value-of select="../S100XC:maximumDisplayScale"/>) must be less than minimumDisplayScale (<sch:value-of select="."/>)
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Rules to test validity of bounding box coordinates (if any). Assumes lat/lon in decimal degrees, ranges +/-90.0 and +/-180.0. -->
  <sch:pattern is-a="S100_ValidBBoxPattern" fpi="S100_XC_ValidBBox">
    <sch:title>Validity of bounding box corners</sch:title>
      <sch:param name="bbox" value="//S100XC:boundingBox | //*[@gco:isoType = 'gmd:EX_GeographicBoundingBox']"/>
  </sch:pattern>

  <sch:pattern id="S100_ValidBBoxPattern" abstract="true" fpi="S100_BBox_LLDD_MinMax">
    <sch:title>Check the values of the bounding box min/max. Assumes values are latitude and longitude in decimal degrees in +/-90 or +/-180 range respectively. Also that datasets do not cross the anti-meridian.</sch:title>
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
      <sch:assert test="not(badEB or badWB) and (gex:westBoundLongitude &lt; gex:eastBoundLongitude)" role="warning">
        westBoundLongitude (<sch:value-of select="gex:westBoundLongitude"/>) must be less than eastBoundLongitude (<sch:value-of select="gex:eastBoundLongitude"/>) (unless dataset crosses 180 deg.?)
      </sch:assert>
      <sch:assert test="not(badNB or badSB) and (gex:southBoundLatitude &lt; gex:northBoundLatitude)">
        northBoundLatitude (<sch:value-of select="gex:northBoundLatitude"/>) must be greater than southBoundLatitude (<sch:value-of select="gex:southBoundLatitude"/>)
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- Test for sub-elements of dataset discovery -->
<!--
  <sch:pattern fpi="S100_XC_cString_generic_DSDMD" >
    <sch:title>Rule to check for presence of mandatory elements of type string in S100_DatasetDiscoveryMetadata</sch:title>
    <sch:p>Note: filePath CAN be empty, but not blank</sch:p>
    <sch:rule context="//S100XC:S100_DatasetDiscoveryMetadata | //S100XC:S100_SupportFileDiscoveryMetadata | //S100XC:S100_CatalogueDiscoveryMetadata" role="warning">
      <sch:assert test="string-length(normalize-space(S100XC:fileName)) > 0"><sch:value-of select="local-name()"/>.filename should generally not be blank or empty</sch:assert>
          </sch:rule>
  </sch:pattern>-->


  <!-- Test for sub-elements of product specification sub-element of dataset discovery -->
  <sch:pattern fpi="S100_XC_cString_generic_productSpecification">
    <sch:title>Check for empty or blank optional name and version of product specification</sch:title>
    <sch:rule context="//S100XC:datasetDiscoveryMetadata/S100XC:S100_DatasetDiscoveryMetadata/S100XC:productSpecification/S100XC:name |
      //S100XC:datasetDiscoveryMetadata/S100XC:S100_DatasetDiscoveryMetadata/S100XC:productSpecification/S100XC:version |
      //S100XC:catalogueDiscoveryMetadata/S100XC:S100_CatalogueDiscoveryMetadata/S100XC:productSpecification/S100XC:name |
      //S100XC:catalogueDiscoveryMetadata/S100XC:S100_CatalogueDiscoveryMetadata/S100XC:productSpecification/S100XC:version" role="warning">
      <sch:assert test="string-length(normalize-space())">Optional element <sch:name path=".."/>/<sch:name/> is blank or empty</sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- rule to check that role is either nilled or not empty -->
  <sch:pattern fpi="S100_XC_DSMD_role_Nillable">
    <sch:rule context="/S100XC:S100_ExchangeCatalogue/S100XC:datasetDiscoveryMetadata//cit:role" role="warning">
    <sch:assert test="(count(*) > 0) or (@gco:nilReason = 'inapplicable' or
      @gco:nilReason = 'missing' or 
      @gco:nilReason = 'template' or
      @gco:nilReason = 'unknown' or
      @gco:nilReason = 'withheld' or
      starts-with(@gco:nilReason, 'other:'))" flag="isNilled">
      The <sch:name/> element shall have a value or a valid Nil Reason.
    </sch:assert>
      <sch:assert test="isNilled or (cit:CI_RoleCode and (string-length(cit:CI_RoleCode/@codeListValue) > 0))">
        The codeListValue of cit:role attribute does not have a value.
      </sch:assert>
    </sch:rule>
  </sch:pattern>



  <!-- 
    Rule to warn if fileName is not populated in dataset, support file, or catalogue metadata blocks.
  -->
  <sch:pattern fpi="S100_XC_fileName">
    <sch:title>Warn if fileName in any discovery block is empty</sch:title>
    <sch:rule context="/S100XC:S100_ExchangeCatalogue/*/*/S100XC:fileName">
      <sch:assert test="string-length(normalize-space(.)) > 0" role="warning">
        Empty or blank fileName attribute found in <sch:value-of select="local-name(..)"/>.filename
      </sch:assert>
    </sch:rule>
  </sch:pattern>


  <!-- 
    Rule to require support file specification name to be populated in S100_SupportFileDiscoveryMetadata.
  -->
  <sch:pattern fpi="S100_XC_productSpecification">
    <sch:rule context="//S100XC:S100_SupportFileDiscoveryMetadata/S100XC:supportFileSpecification">
      <sch:assert test="string-length(normalize-space(S100XC:name)) > 0">
        The name element of the specification in support file discovery metadata must be populated.
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <sch:pattern fpi="S100_15-8.7">
    <sch:rule context="//S100SE:*/digitalSignatureReference" role="warning">
      <sch:report test="not(text() = 'DSA')">
        <sch:name/> (<sch:value-of select="local-name(..)"/>) <sch:value-of select="."/>, must be DSA in S-100 5.0 catalogs
      </sch:report>
    </sch:rule>
  </sch:pattern>

  <!-- Validate temporal extent by presence of at least one sub-attribute. In 5.0, S100_TemporalExtent is used only in dataset discovery metadata -->
  <sch:pattern fpi="S100_TemporalExtent">
    <sch:title>If temporal extent of a dataset is present, at least one of the begin/end times must be populated</sch:title>
    <sch:rule context="/S100XC:S100_ExchangeCatalogue/S100XC:datasetDiscoveryMetadata/S100XC:S100_DatasetDiscoveryMetadata/S100XC:temporalExtent">
      <sch:assert test="count(S100XC:timeInstantBegin|S100XC:timeInstantEnd) > 0">
        <sch:name/>: At least one of timeInstantBegin/timeInstantEnd must be populated if temporalExtent is present
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- S100_CatalogueDiscoveryMetadata.purpose: The values must be one of the following: 2  new edition 5  cancellation Default is new edition -->
  <sch:pattern fpi="S100_CatalogueDiscoveryMetadata.purpose">
    <sch:title>Validation of purpose in catalogue discovery metadata</sch:title>
    <sch:rule context="/S100XC:S100_ExchangeCatalogue/S100XC:catalogueDiscoveryMetadata/S100XC:S100_CatalogueDiscoveryMetadata">
      <sch:assert test="(count(S100XC:purpose) = 0) or (S100XC:purpose = 'newEdition') or (S100XC:purpose = 'cancellation')" role="warning">
        The values of S100_CatalogueDiscoveryMetadata.purpose must be either newEdition or cancellation
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- ========================================================================================== -->
  <!-- The following patterns are extracts from the Schematron Schema for the UK GEMINI Standard  -->
  <!-- Version 2.1 and are incuded subject to the terms applicable to that schema, reproduced     -->
  <!-- below.                                                                                     -->
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
      <sch:assert test="(string-length(.) &gt; 0) or (count(*) > 0) or
        (@gco:nilReason = 'inapplicable' or
        @gco:nilReason = 'missing' or 
        @gco:nilReason = 'template' or
        @gco:nilReason = 'unknown' or
        @gco:nilReason = 'withheld' or
        starts-with(@gco:nilReason, 'other:'))">
        The <sch:name/> element shall have a value, element content, or a valid Nil Reason.
      </sch:assert>
    </sch:rule>
  </sch:pattern>
  
  <!-- Test that an element has a value - the value is not nillable -->
  <sch:pattern abstract="true" id="TypeNotNillablePattern">
    <sch:rule context="$context">
      <sch:assert test="string-length(.) &gt; 0 and count(./@gco:nilReason) = 0">
        The <sch:name/> element is not nillable and shall have a value.
      </sch:assert>
    </sch:rule>
  </sch:pattern>
  
  <!-- Test ISO code lists -->
  <sch:pattern abstract="true" id="IsoCodeListPattern">
    <sch:rule context="$context">
      <sch:assert test="string-length(@codeListValue) &gt; 0">
        The codeListValue attribute does not have a value.
      </sch:assert>
    </sch:rule>
  </sch:pattern>

  <!-- End of patterns included from GEMINI 2.1 Schematron Schema -->


</sch:schema>