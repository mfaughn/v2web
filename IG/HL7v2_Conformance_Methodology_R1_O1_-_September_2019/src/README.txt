# edited version of text originally authored by Brian Rheinhold
How to use Lloyd's Framework IG 

The Frameworks directory is not touched (except for a single hardcoded error that may be fixed in the future).
You may want to rename the *.bat files appropriate for your IG, this example has 'Phd' all over the place.
The source-generated directory is built by the _<name>UpdatePublisher.bat file. It must be generated before being used in the continuous integration build
One can safely delete the source-generated directory and run _<name>UpdatePublisher.bat to rebuild it.
You will need to modify the ig.json file to point to your ImplementationGuide.xml file which is in the src directory
In this example the name of the ImplementationGuide is 'v2ig.xml'.
So in the end all your work is in the src directory.
The resources are placed in the src/resources directory
The Value Sets can be placed in src/vocabulary directory (have not tried this) but putting them in the resources directory is also okay 
The pages are placed in the src/pagecontent directory
The menu items that occur across the header in the published guide is in the src/includes directory in the menu.xml file.
These directory names are fixed. (There might be a special directory name for Code Systems but I do not know.)
You need a 'jurisdiction' element or it will not build. Not sure how it is used or why it is required. It is not required by FHIR.
Resources:
The names of the files must follow a certain structure. There are certain options. Here is one that works
    1. For structure definitions *.structuredefinition.xml where '*' is your choice (no spaces). Make sure the 'id' and 'name' values are the same as '*'
       For example I have PhdNumericObservation.structuredefinition.xml with <id value="PhdNumericObservation" /> and <name value="PhdNumericObservation" /> 
    2. For value sets *.valueset.xml where '*' is your choice (no spaces). Make sure the 'id' and 'name' values are the same as '*'
    3. For code systems *.codesystem.xml where '*' is your choice (no spaces). Make sure the 'id' and 'name' values are the same as '*'
    4. These resources will not be listed by the Artifacts page unless one specifies a 'grouping' under the 'definition' element and then references
       it in each resource with groupingId.
Pages:
For md (markdown) pages (the only pages I know how to do)
    1. No spaces in the name
    2. No YAML headers to cause the publisher to convert them to html
    3. No Jekyll liquid syntax to link to other pages.
    4. All references to your pages are 'pageName.html' even though they are written in md.
    5. Don't put a title in your md file as it is taken from the 'title' tag in the <page> entry of this file, for example
        <title value="Technical Implementation Guidance"/>. If you do you will have two titles.
In your structure definition the first page SHALL be toc.html. This page is auto generated, you do not need to create it
    Under this page every page you want included in the table of contents will appear as a sub page.
The next primary page is 'artifacts.html'. This is auto-generated. You need no sub-pages. This topic will cause a list of all your resources to appear
when you click on the 'Artifacts Index' header in the published guide. Be sure to include that name in the 'menu.xml' file in the includes directory
along with the 'Table of Contents' entry. 
The other entries are up to you BUT there is a catch. When putting in your pages in the ImplementationGuide the <nameUrl value="pageName.html"/>
even though the file names are 'pageName.md'. But the <generation value="markdown" />.
Make sure the version in the src/properties.txt file is the same as the versions in you value sets and code systems

The 'menu.xml' file in src/includes contains the headers or sections displayed across the top.

In this example there are only xml structure definitions, value sets, code systems, and markdown pages that are all text. -->