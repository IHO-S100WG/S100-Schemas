<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process" schemaVersion="0.4-20200131">
<!-- ================================================================================ -->
<!-- Schematron validation for S-100 interoperabilty catalogue. 			     	  -->
<!-- ================================================================================ -->
    
<!--
© Copyright 2016-2020 ... (Draft - Copyright statement tbd)
Prepared under contract for NOAA (Original & 2019 update)

License (Draft)
Certain parts of this document refer to or are based on the standards, documents, schemas,
or other material of the International Organization for Standardization (ISO), Open Geospatial
Consortium (OGC), International Hydrographic Organization / Organisation Hydrographique
Internationale (IHO/OHI).
The ISO material can be obtained from any ISO member and from the Web site of the ISO Central
Secretariat at www.iso.org.
The OGC material can be obtained from the OGC Web site at www.opengeospatial.org.
The IHO material can be obtained from the IHO Web site at www.iho.int or from the International
Hydrographic Bureau.

Permission to copy and distribute this document is hereby granted provided that this notice is
retained on all copies, and that IHO, NOAA, C-Map are credited when the material is redistributed
or used in part or whole in derivative works.
Redistributions in binary form must reproduce this notice in the documentation and/or other
materials provided with the distribution.

Disclaimer
This work is provided by the copyright holders and contributors "as is" and any express or implied
warranties, including, but not limited to, the implied warranties of merchantability and fitness
for a particular purpose are disclaimed. In no event shall the copyright owner or contributors be
liable for any direct, indirect, incidental, special, exemplary, or consequential damages (including,
but not limited to, procurement of substitute goods or services; loss of use, data, or profits; or
business interruption) however caused and on any theory of liability, whether in contract, strict
liability, or tort (including negligence or otherwise) arising in any way out of the use of this
software, even if advised of the possibility of such damage.

Document history
Version 0.4 First S-98 specific version following TSM7 decision to split interoperability into S-100 Part 16 and S-98
-->
    <!-- Note that the S-98 rules are in addition to the S-100 rules and this file includes only the additional S-98 rules.
        This means that an instance XML document must include both the S-100 Schematron file and this file in order to
        validate an interoperability catalogue properly.
     -->

    <sch:ns uri="http://www.iho.int/S100/IC" prefix="S100IC"/>

    <sch:title>IHO S-98 Schematron validation rules for S-98 Interoperability Catalogues</sch:title>

    <xsl:key name="RULE_IDENTIFIER" match="/S100IC:S100_IC_InteroperabilityCatalogue/hybridizationRules/*" use="ruleIdentifier"/>
    
    <sch:pattern fpi="Level_Rule_Check_1">
        <sch:title>Level 3 PDCs can reference only simple or thematic rules</sch:title>
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue/predefinedProductCombinations/S100_IC_PredefinedCombination/derivedFeatures/S100_IC_HybridFeature">
            <sch:let name="level" value="../../interoperabilityLevel"/>
            <sch:let name="crRuleType" value="local-name(key('RULE_IDENTIFIER', creationRule))"/>
            <sch:assert test="($level = 3 and ($crRuleType = 'S100_IC_ThematicRule' or $crRuleType = 'S100_IC_SimpleRule')) or ($level = 4)">
                Rule '<sch:value-of select="creationRule"/>' referenced in <sch:name/> <sch:value-of select="@id"/> (PDC <sch:value-of select="../../name"/>): <sch:value-of select="$crRuleType"/> is not compatible with level <sch:value-of select="$level"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern fpi="Level_Rule_Check_2">
        <sch:title>Level 2 PDCs cannot contain suppressed instance or hybrid feature rules</sch:title>
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue/predefinedProductCombinations/S100_IC_PredefinedCombination[interoperabilityLevel = 2]">
            <sch:assert test="empty(derivedFeatures/*)">
                Content of PDC <sch:value-of select="name"/> is incompatible with level 2
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern fpi="Feature_Geometry_Check_1">
        <sch:title>Arc by center point and circle by center point geometries are not used in spatial queries</sch:title>
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue/displayPlanes/S100_IC_DisplayPlane/features/S100_IC_Feature/geometryType">
            <sch:let name="gv" value="text()"></sch:let>
            <sch:report test="($gv = 'arcByCenterPoint') or ($gv = 'circleByCenterPoint')" >
                Warning: Content of feature class geometry is <sch:value-of select="$gv"/> in <sch:name/>, feature ID <sch:value-of select="../identifier"/>, display plane ID <sch:value-of select="../../../identifier"/>
            </sch:report>
        </sch:rule>
    </sch:pattern>

    <sch:pattern fpi="DI_Geometry_Check_1">
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue/displayPlanes/S100_IC_DisplayPlane/drawingInstructions/S100_IC_DrawingInstruction/geometryType" role="warn">
            <sch:let name="gv" value="text()"></sch:let>
            <sch:report test="($gv = 'arcByCenterPoint') or ($gv = 'circleByCenterPoint')">
               Warning: Content of drawing instruction geometry is <sch:value-of select="$gv"/> in <sch:name/>, drawing instruction ID <sch:value-of select="../identifier"/>, display plane ID <sch:value-of select="../../../identifier"/>
            </sch:report>
        </sch:rule>
    </sch:pattern>

    <!-- Check that the specifications listed in a predefined product combination are distinct -->
    <sch:pattern fpi="S98.pdcproducts">
        <sch:title>Check listed data products for duplication</sch:title>
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue/predefinedProductCombinations/S100_IC_PredefinedCombination/includedProduct">
            <sch:let name="PRODNAME" value="string(@codeListValue)"/>
            <sch:assert test="count(../includedProduct[@codeListValue = $PRODNAME]) &lt; 2">
                Duplicate product in predefined combination element: <sch:value-of select="$PRODNAME"/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern fpi="S98.interoplevel.1">
        <sch:title>Check for existence of interop level in root element</sch:title>
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue">
            <sch:assert test="interoperabilityLevel">
                Interoperability level missing in <sch:name/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern fpi="S98.interoplevel.2">
        <sch:title>Check for existence of interop level in PDC element</sch:title>
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue/predefinedProductCombinations/S100_IC_PredefinedCombination">
            <sch:assert test="interoperabilityLevel">
                Interoperability level missing in <sch:name/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern fpi="S98.interoplevel.3">
        <sch:title>Check for existence of interop level in display plane element</sch:title>
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue/displayPlanes/S100_IC_DisplayPlane">
            <sch:assert test="interoperabilityLevel">
                Interoperability level missing in <sch:name/>
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern fpi="S98.interoplevel.4">
        <sch:title>Check for existence of interop level in hybridization rules</sch:title>
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue/hybridizationRules">
            <sch:assert test="*/interoperabilityLevel">
                Interoperability level missing in <sch:name/> rule
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern fpi="S98.interoplevel.5">
        <sch:title>Interop level in any sub element must be no more than the interop level in the root element</sch:title>
        <sch:let name="TOPILEVEL" value="xs:integer(S100IC:S100_IC_InteroperabilityCatalogue/interoperabilityLevel)"/>
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue/*//interoperabilityLevel">
            <sch:assert test="$TOPILEVEL &gt;= number(.)">Interop level <sch:value-of select="."/> in <sch:name path=".."/> cannot be greater than interop level <sch:value-of select="$TOPILEVEL"/> of root element.</sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern fpi="S98.interoplevel.6">
        <sch:title>S-98 allows only interoperability levels 1-4</sch:title>
        <sch:rule context="//interoperabilityLevel">
            <sch:let name="ILVL" value="xs:integer(.)"/>
            <sch:assert test="($ILVL &gt;= 1) and ($ILVL &lt;= 4)">
                Interoperability level in <sch:name path=".."/> must be in the range [1, 4]
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern fpi="S98.interoplevel.7">
        <sch:title>Interop level in simple and thematic rule must be 3 or 4</sch:title>
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue/hybridizationRules/S100_IC_SimpleRule|/S100IC:S100_IC_InteroperabilityCatalogue/hybridizationRules/S100_IC_ThematicRule">
            <sch:assert test="(interoperabilityLevel = '3') or (interoperabilityLevel = '4')">
                Interop. level in <sch:name/> must be 3 or 4
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern fpi="S98.interoplevel.8">
        <sch:title>Interop level in complete rule must be 4</sch:title>
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue/hybridizationRules/S100_IC_CompleteRule">
            <sch:assert test="(interoperabilityLevel = '4')">
                Interop. level in <sch:name/> must be 4
            </sch:assert>
        </sch:rule>
    </sch:pattern>

    <sch:pattern fpi="S98.L1.1">
        <sch:title>L1 catalogues cannot have PDCs, hybridization rules, hybrid PC, hybrid FC, hybrid feature, suppressed feature layers/instances</sch:title>
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue[interoperabilityLevel = 1]">
            <sch:report test="predefinedProductCombinations|hybridizationRules|hybridFC|hybridPC">
                Level 1 catalogues cannot have PDCs, hybridization rules, hybrid FC/PC, suppressed feature layers/instances, or HybridFeature elements 
            </sch:report>
        </sch:rule>
    </sch:pattern>

    <sch:pattern fpi="S98.L2.1">
        <sch:title>L2 catalogues cannot have hybridization rules, hybrid PC, hybrid FC, hybrid feature, suppressed feature instances</sch:title>
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue[interoperabilityLevel = 2]">
            <sch:report test="predefinedProductCombinations/S100_IC_PredefinedCombination/derivedFeatures|hybridizationRules|hybridFC|hybridPC">
                Level 2 catalogues cannot have hybridization rules, hybrid FC/PC, suppressed feature instances, or HybridFeature elements 
            </sch:report>
        </sch:rule>
    </sch:pattern>

    <sch:pattern fpi="S98.L3.1">
        <sch:title>L3 catalogues cannot have CompleteRules</sch:title>
        <sch:rule context="/S100IC:S100_IC_InteroperabilityCatalogue[interoperabilityLevel = 3]">
            <sch:report test="hybridizationRules/S100_IC_CompleteRule">
                Level 3 catalogues cannot have CompleteRule elements 
            </sch:report>
        </sch:rule>
    </sch:pattern>

</sch:schema>