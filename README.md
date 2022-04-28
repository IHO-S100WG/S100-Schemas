# S-100 Edition 5.0.0 schemas
S-100 5.0.0 schemas and samples have been added in the <em>schemas</em> and <em>samples</em> folders. A zip archive of the distribution is available in the <em>archive</em> folder.

There is now a schema server where the 5.0.0 schemas and samples can be accessed directly. The URL is https://schemas.s100dev.net/ 

See the README_5_0_0.docx file for information about the 5.0.0 distribution. Note that folder and file names on the server are case-sensitive. The server index at https://schemas.s100dev.net/index.html provides the folder and file names in their actual case.

<b>Contributors are requested not to update the schemas and sample files in this repository so as to avoid conflicts with the files on the schema server.</b> Instead, any discrepancies or change requests should be reported using the comment form so updates to the server and repository can be synchronized. The comment form is preferred to GitHub issues at least while the 5.0.0 distribution is being finalized. A due date for comments on this distribution will be announced by the S-100 WG Chair.

# S100-Schemas (4.0.0)
S100 Edition 4.0.0 Schemas uploaded as ZIP file.  See accompanying README docx file for folder organization.

The May 2019 update adds the ID attribute to the generic exchange catalogue schema. It also adds exchange catalogue schemas for S-98, S-101, S-102, S-111, and S-127.

The S-100 Edition 4.0.0 Schemas <em>folder</em> in this branch is now obsolete and awaiting deletion. (Update 12 August 2020 - this obsolete folder has been removed.)

2020-04-17: The S-100 4.0.0 schemas zip file has been updated to work around broken links in schemaLocation(s) in ISO schemas.

## Updated Portrayal schemas
<b>The Updated Portrayal schemas mentioned below are obsoleted by the Edition 5.0.0 distribution</b>

The zip file S100_5_0_0_S100XSLTPR_20200507.zip contains the draft of portrayal schemas with updates approved as of S-100 WG5. The S-100 revision number for this zip has been incremented to 5.0.0 because the proposed changes are intended for the 5.0.0 release of S-100. However, note that as of the upload date, these files are drafts and may be further updated before Edition 5.0.0 is published.

The previous draft zip from November 2019 (S100_4_10_S100XSLTPR_20191115.zip) has been removed. Note also that the build folder inside the new draft zip file has changed from 20191115 in the November zip file to 20200507 in this zip file.

## Interoperability schemas
<b>The Interoperability schemas mentioned below are obsoleted by the Edition 5.0.0 distribution</b>

The zip file InteroperabilitySchemasAndSample.zip contains the XML schemas and sample(s) for interoperability as described in the drafts of S-100 Part 16 and S-98. 

The exchange catalog file CATALOG.XML in the sample requires ISO schemas in order to validate, which are not included in this zip. They can be obtained from the S-100 4.0.0 schema distribution zip file on this site.

## XML Catalog
<b>There is a sample XML Catalog in the 5.0.0 distribution</b>

The XMLCatalog.xml file is an "XML Catalog" conforming to the OASIS standard for XML catalogs (URL: https://www.oasis-open.org/standards#xmlcatalogsv1.1), for mapping broken links in the ISO TC211 schemas on standards.iso.org to working links. It can be used with validation tools that implement the XML Catalogs standard. This file works with OxygenXML. The file "CustomCatalog.xml" is an "XML Catalog" for use with Altova XMLSpy. The differences in the two catalog files are minor, and are due to differences in tool behavior.
