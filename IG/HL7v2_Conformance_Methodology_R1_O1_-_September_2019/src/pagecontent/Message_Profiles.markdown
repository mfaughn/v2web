<h2>
4 Message Profiles
</h2>
<p class='p_v2web'>
<p>A message profile is based on a message structure defined in the HL7 v2 standard and specifies refined requirements according to its intended context of use. The message profile identifies the message code (e.g., ADT), trigger event (e.g., A04), and message structure (e.g., ADT_A01) and other meta data as shown in <span style="font-size:16px">Table 10.2</span>. Constraints are placed at various levels and objects in the message template. <span style="font-size:16px">Table </span><span style="font-size:16px">4.1</span> summaries the types of constraints and the message objects for which they apply. In the sub-sections to follow, the constraint types that apply at each level of profiling are explained. In <span style="font-size:16px">Section </span><span style="font-size:16px">5</span> (Constraints), each constraint type is described in detail.</p><p></p>
</p>

<table class='center striped-rows table_v2web1'>
<tbody>
<caption>Table 4.1: Summary of Constraint Types and Where They Apply</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='2'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Constraint</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">M</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">SG</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">S</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='3'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">F</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='3'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">C</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">SC</span>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-header table_v2web1' colspan='2'>

</td>

<td class='emphasis-header table_v2web1' colspan='1'>

</td>

<td class='emphasis-header table_v2web1' colspan='1'>

</td>

<td class='emphasis-header table_v2web1' colspan='1'>

</td>

<td class='emphasis-header table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Cx</span>
</p>

</td>

<td class='emphasis-header table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">P</span>
</p>

</td>

<td class='emphasis-header table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Cx</span>
</p>

</td>

<td class='emphasis-header table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">P</span>
</p>

</td>

<td class='emphasis-header table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">P</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Usage</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px; font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px; font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-size:16px; font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px; font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-size:16px; font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px; font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px; font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Cardinality</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='2'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Data Type Specialization</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;*</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;*</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;*</strong></span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Vocabulary</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Length</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='2'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='2'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Conformance Length</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='2'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='2'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Content</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='2'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='2'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Conformance Statement</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Co-constraints</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='2'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='2'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Slicing</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='2'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Semantic Refinement</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px; font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px; font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px; font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='2'>
<p class='p_v2web'>
<span style="font-size:16px; font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px; font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px; font-family:Arial,Helvetica,sans-serif"><strong>&check;</strong></span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='12'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Key</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">M: Message</span>
</p>

</td>

<td class='table_v2web1' colspan='4'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">SG: Segment Group</span>
</p>

</td>

<td class='table_v2web1' colspan='3'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">S: Segment</span>
</p>

</td>

<td class='table_v2web1' colspan='3'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">F: Field</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">C: Component</span>
</p>

</td>

<td class='table_v2web1' colspan='4'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">SC: Sub-component</span>
</p>

</td>

<td class='table_v2web1' colspan='3'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Cx: Complex</span>
</p>

</td>

<td class='table_v2web1' colspan='3'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">P: Primitive </span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='12'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">*</span><span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">Typically (and in most cases) a data type specialization is not made for primitive elements (</span><span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">f</span><span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">ields, </span><span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">c</span><span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">omponents, sub-components). </span><span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">However,</span><span style="font-size:13px; font-family:Arial,Helvetica,sans-serif"> data types like DTM that have specialization &quot;encoding&quot; of the date/time format YYYYMMDDHHSS.SSSS+-ZZZZ.</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>Although all elements allow for semantic refinement, caution should be used in certain circumstances. For example, components within a data type generally have very specific meaning and rarely should be a candidate for semantic refinement.</p><p>Components and sub-components are not directly constrained, rather, they are constrained within the context of a data type flavor. Vocabulary bindings to elements within a data type can be assigned in the context of use. Vocabulary constraints only apply to elements that have data types that have coded data types. Fields and components can be complex or primitive elements. Sub-components are always primitive elements. As shown in <span style="font-size:16px">Table </span><span style="font-size:16px">4.1</span>, some of the concepts are the same depending on the context. For example, fields and components in some circumstances are primitive elements.</p><p>Segments are profiled at the message level. Fields are profiled at the segment level. For data types, components and sub-components are profiled in the context of data type flavors. </p><p></p>
</p>
<h3>
4.1 Message Profile Identification
</h3>
<p class='p_v2web'>
<p>To simplify profile references and claims of conformance, an identification mechanism for HL7 v2 is provided by the message profile identifier. The message profile identifier is referenced in two places that provide the bridge between the message profile and the message instance:</p><p>In the message profile meta data, indicated by the MessageProfileIdentifier element</p><p>In the message instance, indicated by the MSH-21 field (Message Profile Identifier)</p><p>The MessageProfileIdentifer element provides the identifier for the message profile that can be referenced in a message instance. This reference in the message instance is a claim by the sending system of conformance to the message profile it references. The receiver, via the conformance claim, is made aware of the expectant message content (as defined in the message profile). The receiver may validate the message content based on the requirements given in the message profile and make processing decisions based on the outcome of that validation. Additionally, validation tools conduct conformance testing based on the message instance and the conformance claim indicated by the message profile identifier. A receiver can publish its claim of conformance to the message profile in its interface documentation or other capability statement.</p><p></p>
</p>

<figure class='center'>
<img src = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAABUoAAAKECAIAAABemJeJAAAAAXNSR0IArs4c
6QAA/8pJREFUeF7svQnYZEV1/x8SRVQcUVRwGIZhUXFDVByFACIoiKKCIgJm
ATQY/BsjCYIL0URJFOWnRhNR3DAJIDgKUZRFHRGQZVREVERlGYZxBDeGARVw
4f8ZvnhyrHv79u1+u/vt7vd7n/d5n+7bdatOfaruvXXqnDq1zl133fUnPkzA
BEzABEzABEzABEzABEzABEzABCaZwJ9OsvCW3QRMwARMwARMwARMwARMwARM
wARMYC0Bq/fuByZgAiZgAiZgAiZgAiZgAiZgAiYw8QSs3k98E7oCJmACJmAC
JmACJmACJmACJmACJmD13n3ABEzABEzABEzABEzABEzABEzABCaewDq1ofXW
WWedia+ZK2ACJmACJmACJmACJmACJmACJmACU0qgqsvbej+lTe1qmYAJmIAJ
mIAJmIAJmIAJmIAJzCUCVu/nUmu7riZgAiZgAiZgAiZgAiZgAiZgAlNKoItz
/po1a6a04q6WCZiACZiACZiACZiACZiACZiACUwYgXnz5kliO+dPWMtZXBMw
ARMwARMwARMwARMwARMwARNoQ8DO+W0oOY0JmIAJmIAJmIAJmIAJmIAJmIAJ
jDUBq/dj3TwWzgRMwARMwARMwARMwARMwARMwATaELB634aS05iACZiACZiA
CZiACZiACZiACZjAWBOwej/WzWPhTMAETMAETMAETMAETMAETMAETKANAav3
bSg5jQmYgAmYgAmYgAmYgAmYgAmYgAmMNQGr92PdPBbOBEzABEzABEzABEzA
BEzABEzABNoQsHrfhpLTmIAJmIAJmIAJmIAJmIAJmIAJmMBYE7B6P9bNY+FM
wARMwARMwARMwARMwATGn8CSJUvm3X285z3vqZWW80pw8cUX5wQ6qYNM4qd9
9tmHM0VWXNtQhBIvX7485/kP//APtfIo/1zi+EO2hF0JWL3visgJTMAETMAE
TMAETMAETMAETKCJwMqVK/Xzxz72sdp0b3rTm3T+Rz/6UdbDd9tttzV/OA45
5BCU8xmC3mabbc455xxl+dGPfvTDH/5woeFrouFLX/rSDAvy5WNIwOr9GDaK
RTIBEzABEzABEzABEzABE5g8Ai9/+cuvu+66qklcZ/g1V+mMM87g67vf/e44
iUK+aNGiGVabTLbffntlsu+++zJ9gIYfeWL/Z6LhLW95C1MAMyzIl48hAav3
Y9goFskETMAETMAETMAETMAETGDyCLz4xS9G6JNOOqkQnTOo2TvssEM+v2LF
ihHUcPPNN6eUcApA80f/f81rXjOCol3E6AlYvR89c5doAiZgAiZgAiZgAiZg
AiYwnQQw0eP3nn3s+cyZl770pUWFpe0ffvjhIwAxc6eAEQjpImZOwOr9zBk6
BxMwARMwARMwARMwARMwARNYS0AGfDne69Bn/OQLQPKcR/Mfaog7PPMpxW0z
RwhYvZ8jDe1qmoAJmIAJmIAJmIAJmIAJDJ0A3u/4w+cAe6x1L1bdhxCnn346
y+D5SlC9WiU/x8Dn8x577NFTBRRU78gjj+zpKieeXAJW7ye37Sy5CZiACZiA
CZiACZiACZjA2BE4+OCDCbCnDfAUVE8m/dqDZfAKcS8lvwjLF0H19aGneHgI
gOmemYWItDd2pCzQoAlYvR80UednAiZgAiZgAiZgAiZgAiYwhwnsvffe1P6T
n/wk/wmqhzG/q4KNo/4VV1yh9O3JZdv+E57whHwhC/4x9VP0u971rvYZOuWk
E7B6P+ktaPlNwARMwARMwARMwARMwATGiABx7LQdnYLqYcxvIxxXoY1fe+21
bRIrTbbtf+tb38oXbrPNNnwtTrbP2SknlIDV+wltOIttAiZgAiZgAiZgAiZg
AiYwpgQUJ186dvtd6HDpH0gYPFny5Q7gY04RsHo/p5rblTUBEzABEzABEzAB
EzABExg6AZztteF8p6B6/IQS/p73vCdE2Wefffj86le/eobCkQ/TBKzS92Z4
MyQ5iZdbvZ/EVrPMJmACJmACJmACJmACJmACY01APvkNQfXwnCeofqyfxy0f
Z/sZ6uSE02M5AOWy8D6vzNfcAQcJdF5B+BWxn2OsUVq41gTWueuuu6qJ11ln
HZ2kh7XOyglNwARMwARMwARMwARMwARMwARMwASGSCCmY6q6vK33Q+TurE3A
BEzABEzABEzABEzABEzABExgNASs3o+Gs0sxARMwARMwARMwARMwARMwARMw
gSESsHo/RLjO2gRMwARMwARMwARMwARMwARMwARGQ8Dq/Wg4uxQTMAETMAET
MAETMAETMAETqCfw29/+1mhMYOYErN7PnKFzMAETMAETMAETMAETMAETMIE+
CZx55pnbbbfdSSedZCW/T4K+7A8ErN67L5iACZiACZiACZiACZiACZjArBF4
+9vfzq54hx122Dvf+c5ZE8IFTwUBq/dT0YyuhAmYgAmYgAmYgAmYgAmYwAQS
OOWUU6644goE32KLLZ773OdOYA0s8hgRsHo/Ro1hUUzABEzABEzABEzABEzA
BOYOgdtvv/2MM85QfffZZ59tttlm7tTdNR0GAav3w6DqPE3ABEzABEzABEzA
BEzABEygC4H//d//Peuss0i0+eab77333uZlAjMkYPV+hgB9uQmYgAmYgAmY
gAmYgAmYgAn0TODOO+88/fTTdRmm+yc84Qk9Z+ELTOCPCVi9d48wARMwARMw
ARMwARMwARMwgVETwC3/85//PKUuWrTIpvtR05/S8qzeT2nDulomYAImYAIm
YAImYAImYAJjTOC9732vpHvOc56z7bbbjrGkFm1iCFi9n5imsqAmYAImYAIm
YAImYAImYAJTQ+D973//Xnvttd566x1++OFTUylXZHYJrHPXXXdVJVhnnXV0
cs2aNbMrn0s3ARMwARMwARMwARMwARMwgWklcNNNN2200UbTWjvXaxgE5s2b
p2yruryt98MA7jxNwARMwARMwARMwARMwARMoJ7Atddey5Z4+s26vXvJAAlY
vR8gTGdlAiZgAiZgAiZgAiZgAiZgAl0I/NVf/dXjH/94nPNDyTcyExgIgQE4
568+68yBiOJMTMAETMAETMAEaglssOdeIyDjF/oIILsIEzABE/jU+Rcc/p/H
w2HRxhsdf/hrHrtoMzMxgUyg60vfzvnuMCZgAiZgAiZgAiZgAiZgAiYwywTu
+M1vzrz4Egnx3Kc9zbr9LLfH1BVv5/ypa1JXyARMwARMwARMwARMwARMYCwJ
fO7iS7502TcRbbONNnru0xaPpYwWaoIJDNI5/8dfOneCSVh0EzABEzABExgz
Ag/fbXdJ1NVPbyCCh3O+X+hdef79579wycofkexVT93uL5/wuK7pncAETMAE
IHDn7373hi+ed8H1N/D5r7d9/CsXP9lYTCAItH/p2znf3cYETMAETMAETGCq
CHzhmuuO/tJXTv/e9zvV6qknnBh/L/rEpwZY+f/+1nfQ7S899CD+rNsPEKyz
MoGpJ/Cla5dLt99k3gN23WLR1NfXFRw9ATvnj565SzQBEzABEzABE5gRgXdc
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
htgHTFtgk+c/zvNsVdjrvvQ0Gcq5ohiy8L7Q/wNXNWY+MwuE9MPzX/4X/H/F
dk/kwye/+0fwZ9KavtYEJo4Auv3v71prvEe373Q3TVylLPAEEbB6P0GNZVFN
wARMwARMYMAEnv3sZ5Pj8ccfX823dkX98x/1CFZfaxX3sRdejLM9e9G/cecd
dDkKHqbgmYxosQbzN8NK7vWorcghe4ljzCcgXK1gaOMECESz5Q/3dUrHBi4B
IIBBmxrpVyzbUrk7nZd+/t7n7K70bOxHbiEGv7LunZP6VaHv+CCpyDP/SjK+
djWDa2Jlx4ULyITQd1jR+fq6L3x5hgBrO0N45utXzSxgrs9rK/RZ0fV9mMAc
JHDe8hVaB/Tg+953180XzUECrvKsE7B6P+tNYAFMwARMwARMYNYI7L777mx6
j38+IfSzENjn0Wx1Jq+oR39j1T37qGkJN4Zfgq4X29E3VEZh2xvs0uSMjp1z
wBYd1nUcv9uQUuD3CLCnoHpsGl+9FmGw6qOQ6yfc19GrSSwJf/LLtRH4HvPQ
h+hXLNtast7pPL/m/eqITUDib/74Jl2uQb9OcmgOIhT4t5x3IQp//MoH5iM+
etkVzfX9yvK1ayW0JSEHrYO+TY16NeC3oUqaje5//0ip8IQKzheHdsvDpN8y
QyczgSkjQFC93/3+91QK031xd0xZTV2dsSVg9X5sm8aCmcCcJnCfDTd8zFFH
b/e+Dy7+4Mee9K73LXj+PrU4OE8C/h73T2+Z07xceROYAYH/+I//2GCDDQ45
5JC9Xn/08Z/57Ds+cSoGbezzBz1xG+W66+abYcF+WFLt0Of7M9Ffv/oWDNrh
zF+VmpzXX3fd0P9RFw878+xb7rhDMeH+etvHt6yoAuwpH+nV1KJ6rbZ5j/3h
SKAt36W7SrHHil7MR3Q6XytbSx97dHItfIhjwbx5XTfNpo44U2T7uYrLjdWS
WHMyljygtLMWg30Tco3uf3cE/jiW/WgVn588f+OBFOpMTGCyCKDY83Bgyf2f
/emf7v/4/4shOlm1sLSTTsDq/aS3oOU3gekk8KjXvHb9Lbb803XXmoDudf/1
H/yUp/Jhm7e+HU0enT+0/fsu2FT1V0ofJmACfRB4/OMff/7557/85S+//qab
3nbSKf997hfRGNGlcfZWbmi/2MMHEt9eduYwaNdKi9v/SVd8Vz8tX70aT+/D
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
ijcRAfJYTZ8Zn7Vfxj88CM7ZBOYaAXRIIuGjDbK6/mH3vx/VR5NnOX2vEdow
uWPrZik7Gu9z/+dUzPJHnbv0fZd+/Yzv/eDrq37ch8abG2LdP/szwtFjgnvS
/I3Rchm1/82Tt63+MY7HXpf/Xrn4yTnZS7d5HNfqD0M3dSTbDe933xk2OoZ3
jOenfufKd154yd997lzmMrDws7Yf8z7rCO783e/a5E8UA1Rx/PZZCsFuhZ96
yYtCn2c2gTbKjvco8JxhbYVyxtrPOnwi7evrf1z6DWZt/n3PZ9GUKPzkTJjA
j19+RRsxhpHmlu98W9mGD9eNXzi7oaAICIcbPHZmpSQ4C671ONKH+Z3PLKrX
qwpfgIjDr1JIRgJdzsslprxDhgg6gz85SjL5R84hGye1aBzvdHwB9LbiQzGB
3lLggbNtJkBxd/5i7Wo7DoL4UBf+tESiTd17kjYIMLci7wm1FwsiVOKIETG9
KPlR8jdYb72e6uLEJjA8At73fnhsnfP4Esh7scY8+paHHLrhU7fPQseutrXp
eeFp/pgpdgLzyAOQNw2h3R742Mfhgq74tyQjLA3eAdIqY0dWbWPLa/6+D5//
i69dqst5P+GSJxkkWOxVq+18tW98bDMbJ7VcEEkYEHTi3lLg2surW+bWJqsF
pZQZL0aMlf/7KQY6pH/47nvKBRHDS0wxdNrNvqDBVdWUcQYzyE+/egExk7V2
gOHXvEc/lgjAYB/frmnJTOCPCbTfAncg5Aa7730hEg7h2NJ7ss+Tw+9+//tr
bl6N5vndn/wM3ZJl7TOpKTr2w9df/2Hr33/t//vfD637Aeuu++D73fc+dyv2
M8m55bVMT9x2x50///Wv7/zt71bddtstaxft/xIs2Op/8stfsYa/ZT7VZMxN
MDHxuI0eysp5/rOVXa9ZYXjH/I4pPtqIJQMEBYgzuF2wNyE7HeK9j6qP8R/1
nnX7T3z4RsxiYOFXDgRN6LXoXtPXvmvyC5QM8971tel5KbDqvlPR2rmdX+PV
WaTEbR7Terxxil/jjbbd+z7YaTd7LtFLvJBcWa215K++mbHEilNPirdYG4Fr
a9Sw730GlevbkkB+EUfRurZN3Wvf48onyIcknfa0D5It27TX/labnmU1BM5g
KvBvnrQt/weSpzMxgfYvfe97795iAt0J/OSC83IiXnjNy8LRyZUe7TQC86Bm
s+iucBsjoO5Wf3OY1oHHlq0RipbEcXno9uFkGIv9WOmnqD+h24e06z74no1z
kSRWm/Nalf0hAsW3F7g7rN5TgDfqwjQKFSnC7/982T08e8/7j67AXBNhkKCt
gvgDcu2eujMszpebgAm0JNDe9x6VnqB0rJNn8fluHz+FMfRxX730rB9e0163
l66LXRqjOmb24/d69qf2f+FFL/+rz//FSz6y93Pf9sxdXv207fZ//GNYLsu4
fNEGDxyNbg8oZhMoi4UJlIttHzv/EX/+1Hfsvut/v+j55/zV/he87C9P3W+f
9z13dxwEkBz5qQWGwTaEsd5jw8eSjz2fiAP8ybCPEtLmctIQ+wDVPc+/sLUB
Cnycyevwr797nkW7+n3ga5fJ2/+M732/ZVnDSMYrO4y35H/Ld7/TXAqz6rEN
XjVl7GxXmwlvGQLONeT/k/OW6tdb6mL7xdtQaQrJdZJJAYYHvPEf/do36j0+
E4EHDjwT6OQl0abuPQmGO0OnJvvVDdePGNGp376SEnlSnX31H20L0lONnNgE
hkGg1TtjGAU7TxMYNwIeGQy1RcCLLb1TEbywB7WMv7mgYlA11Co7cxMwgfYE
fv2b37ChOuZflNIX3h3NnlDzGO053zWTB913vSds/LDnPnKrV2z3RNzOP/7C
5531ly9BYebzy5+8LVo0ujSxr1rqyV2LG14CZiWYa8AS/oKtH4nkyE8tzv7L
tVMSb95lp4OfuM0zt1iEwr/eve7VVQY8Agjaz7p9JkeI1feW8y5kxb4C43c6
mH/JQfXWKktr1kRQfb7mdfi4VHBmh003YWO/T+3/Ihz+idtHZH7W9neVbeYJ
WMmlh3nxSI9ZbKbI83b3sfKriDKD+R37OQvmI5+IGhs727E1DG+ouBAvOVZ+
EWxPBgBM69iWY8E8yUjMIvwI6YcRmyX0eUU96eNtGII1TEYwcb/gBS8StDYC
1+L9P/l/cc90z69X3qCUBcP4Gnv+NRMgB1DkqARU9ufLLuF8y7q3l0QE4Bnz
OEhL81F62GP6RtRTtySMiPa6v/+63uu+J3JOPAoCds4fBWWXMW4EWES3xV+/
jKlxXgyxXSpChlsXL8Lv/us/R0B40mN+J0F2IFelcPljDRhT7PK+IwEvNl4z
oazidLfpC/dbb6ONtAiNX2+/6ce8LJW5nO1ZrhYO6rffdFN48qsIvNEetO2T
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
X/rnf/7nNrr9LMjtIk3gDwS22267Cy644GMf+9hDHvKQTGX16tWo/dtvvz36
v2mZwJAIoNIr56222sq6/ZAgO9sREBik9d7T/CNoMBdhAiZgAiYwpwi0mc6/
5ZZb/u7v/u6MM84oyDzwgQ9Eq3/Zy17WEzFb73vC5cTDIIA+/9rXvpYgEUXm
WO//9m//9m1ve9v6668/jHKd55wlcOONNz760Y8+6KCDjjrqqI033njOcnDF
Z5FAm9d9iGfr/Sy2lIs2ARMwARMwgSESOO2001784hcXuv29733vQw45hJO9
6vZDFNRZm0BrAnjjf+hDH/rkJz/5nOc8J1/E5o7/8R//sddee33iE59onZkT
mkB3AkQbZVLpPe95D4/T7qmdwgTGmID3vR/jxrFoJmACJmACJtCZAOHxWZCM
0/Ill9wT6llpd9ppp//8z/9knPrkJz/Z/Exgcgnsu+++H/3oR9kD4hGPeESu
xVe+8pVXvvKVb3jDG7gFJrd2lnx8CPAIXbJkieTBPWR8BLMkJtAHAav3fUDz
JSZgAiZgAiYwywTOOeccFPt3v/vdt956a4hyv/vd7+///u/f//7377///rMs
n4s3gUEQ2GijjV7/+tej5OONkvO7+eabcdE/7LDDzjzzzEGU4zzmNAH8RFau
XAmC5z//+bbez+muMBWVt3o/Fc3oSpiACZiACcwlAu9973v/8i//8txzz82V
3mSTTf7nf/7nrW9962abbTaXYLiu009gxx13/MhHPnL66acXIfc+97nP7bPP
PscddxxO+9NPwTUcDoFLL700TPfo9uuuu+5wynGuJjAiAlbvRwTaxZiACZiA
CZjAzAn86Ec/eu5zn3v00UdHkGflyWpkwuM/85nPnHkRzsEExpPA3nvv/b3v
fY+unsVDsScI3zOe8Yzly5ePp9iWaswJYLpfsWIFQj7vec9jPciYS2vxTKAr
Aav3XRE5gQmYgAmYgAmMBQGi6L30pS9l57AsDcuSCQr18Y9/fMMNNxwLKS2E
CQyNANZ7DK2sSXnUox6VC2Fua88998Sr5c477xxa4c54CgksW7Ysm+69e+gU
tvHcq5LV+7nX5q6xCZiACZjABBJ417veRcynyy67LMvOnvaYnliBTKj8CayT
RTaBngnc5z73ec1rXnP22Wc/7WlPyxdfddVVBJ54yUteQvzznjP1BXOVAM/P
66+/ntpvu+22rHiaqxhc76kiYPV+qprTlTEBEzABE5g+Aj9c+aPXnfBhdrDP
C4wf+tCHEnKM7cG22GKL6auya2QCzQQWLVr02c9+lkgT8+fPzynZDPJFL3rR
Zz7zGQM0gTYE3vjGN/JoZSNGdiFpk95pTGD8Caxz1113VaVcZ511dHLNmjVd
67D6rHtilm663wFdEzuBCZiACZiACZhAewJf/H/v+Jvj3rX8xpvyJUTR+6//
+i9M9+3zaZ/Sr/X2rJxy1glcfvnlBxxwAKb7LAku1scff/xBBx006+JZgIkg
gMcHGv5EiGohp5jADaedotptsOcfRRiprfK8efN0vqrL23o/xZ3EVTMBEzAB
E5hsAkTC3/voNxe6PVHEWGk8JN1+snlZ+rlHAJ/qb37zm7jr56oTePLggw/+
m7/5myIC5dzD4xp3JIBKf/XVV9+jTVm3d0+ZIgKzpt6/4x3vwEcAr8IMkzPP
fvazR4D3la98JWXpYJDUpsStttqKxBL72rsPzrS50GlMwARMwARMoFcCq1at
OvLII1/2spf98vbb49oHPOABr3vd60488cTpi6LHeIBXc0+USM9LubhEr2kd
xU9z4cXNkGY046hqS0G+2hw9NWhOTOMWQ8TqmUiPrZ5gex/84Acf/ehH50w+
/OEPH3jggeeff37fYoznhXOhJ4+A/L//+7/TYZgGCiW/faHVxwtKAe3SPgen
bCZgnjPpIaNW7+n6cUvssccejFFCep7jnJlJZXq69pRTTsGZgfjDbXy39CQl
PYMt/jcvdCRlyymDngR2YhMwARMwgTlC4MYbb2T98Dvf+c4cBvyBD3wg4fHf
8IY3POhBD5p1DpryzmNcvd85QktHz9QZaX1KEL/y0udrocLlesV8eqfKormd
cMIJ+VeKOOqoo6655hre1IwoGrTNPMtfiN3MtnYaIuqurFQpqp9rF2ODXHQn
CUk8QxMC45CqBtKpalldVF1mqKhQryw/Gca4KCZfBCej62l2gHxyEXx+zGMe
8+lPf/rBD35wrubpp5/+9Kc/ndGm+ls+4vKi+ZSmJQFauTrkq514ylJlYWY+
HZPlD7FzEXGyuAcRKZJlmHHnSrYqH1U5enK+Vh0vN2XtjFs0RDwQIlkGEs+Z
6lxP7lS1kgTwLH/kw+WKZkLf+NCHPqTEIVXIX4ux6+O36D/kpqdBviWpGmfA
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
S4skEd+OD7GyoGs70lj0+RzdoJPkmrUJdbRrziNIoDblFiucI/ormg5Jp61W
UH1GeUKgGktCs2PS7rKiKPHaz7X1J3b7qxCeO73wTai9vPog1cNQN1d47EMm
/BGoptZhcRQPUojFzZ7XNOXVTFzF5fFk44bVehb+K5aEVoUUvv3t616bkmcm
HjF5CrVljWpfDTMUZoCXW70fIMzuWXFHxcwT3XQYs1DdheiWgptNE6J5d4rm
5S6RUjXKF2YnOn4qVj/G15g55kMsaordPuKDcg5h+KD4LnniWY8kToafTEMg
Ir0V9KSb1tbp1uD+3QRMwASGQkB+3fzHeNVg4Zfrsl4QPe16FbZKLbeWIqex
Ziy2l8alRenkr7E7Z1BlIw2/Rug4xq/ZrsV5Ru16VXGVakEmYamLd5wKystZ
GdHqQok3QMRSO4sMZYtWicXChK5Fa0ferr6pXfPJCRT4umFSQ6waXG1zbqhM
qCWqHePvTsuGKU4xugvscnuW7sH/WGfbtUaxbiKnlAOF+m00BEqLJIz9iblE
6/8ldrVvazlGnk7qKk+nBNnDnzQyRDe4eCifWGLAjEmBtFZyMCJwpwANfQuf
LwxcnTpG3PWM2egV2oaZq5rdKFrKxi1Am1YryI0PIrUjbKuWXs0rKQEHwpMs
Hh3jM9qPJT9dgVQfpMBRwPz8hFFwxOLGlOk+P0ghFoEGKToA5oiVen4GNIDr
easwjbrd4lndVf42CRQdIO/kreLa1Kj21dCm0BGl0VRTcUTZbfbYabODTm0p
c+ektrKgvndvQrG2d/JZm1KMIYTYRiLvJ6FNNZC2uk0IG9rpHcav/FdlOaOq
6bNmlPkQW1DwQcMdhXXRc1lpYgY08skflFIZSirlE1fJCUonhZqfYkpb2+9F
DnwmfWwpNH2tM4YdzCKZgAn0RKCnnXLavLW7phn2a51ncpv9hOI9EriqZ3oi
6cTjTKDrFlbjLHzfssn5ue/LR39hHj6NoPSxHSoXdeeZFkEKB7J73wjYVouY
rAds9YlRrdHEPVV6et2Htl6tuK33w51GkQFZs0EqqeqNlm3dSsMUV5yM0Lsx
kRkTYPKQyft/yDevCDQSs4kRPSUS6ExM3zZMouO4IkcvPjAzTZ45EFHEfWE2
q5jUVMXx0lHm4ZxTLCaUp1MbD3km1Yp1d5qljm02WBVGAgUsUZzP2J1IeBGe
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
10quPutMpdl0vwO6Jh7/BIyDsafJKMQIHu3IBqLxbzVLaAJjQoAZMVTlWdnH
cYAEqIX0cGYfUPXbhAUdYOnOqiBww2n3LK7ZYM+9RgNnyl7ro4HmUkzABEzA
BExgJgR6et3PmzdPZVV1+TlkvW+JG6tXGPP7jh7fsqzZShb7w4WBro9NpMMY
GJlU7ZnFyupswJytus9KucU6ajg07yxQK2TeWizMqkVKA5+V9p2+QsN6j4ND
sZ5i+irrGpmACZiACZiACZjA1BCw9X5qmtIVMQETMAETmEICPU3nD6T+tt4P
BKMzMQETMAETMIH2BHp63dt63x6sU5qACZiACZiACZiACZiACZiACZjA5BGw
c/7ktZklNgETMAETMAETMAETMAETMAETMIGCgNV7dwkTMAETMAETMAETMAET
MAETMAETmHgCVu+H2IQKPtewgRZlE9Oua5ohiuisTcAETMAETMAETMAETMAE
TMAEpoKA1fvhNmPsp92pGHZvZsPq4Qrh3E3ABEzABEzABEzABEzABEzABKad
gNX7aW9h188ETMAETMAETMAETMAETMAETGAOELB6Pwca2VU0ARMwARMwARMw
ARMwARMwAROYdgJW76e9hV0/EzABEzABEzABEzABEzABEzCBOUDA6v0caGRX
0QRMwARMwARMwARMwARMwARMYNoJWL2f9hZ2/UzABEzABEzABEzABEzABEzA
BOYAAav3o2jka6+9lt3v+H/hhRfygSLZLW+rrbYaRdkuwwRMwARMwATGmABv
Q96PfQjIm5QNaPOF1TN9ZDs1l1TB9neGHXwZvWQsbc5MDUY6pwdsU9OarogJ
zAUCVu9H0cpbbLHFXXfdxf8dd9yRDxS5//77X3311aMo22WYgAmYgAmYwBAI
vOMd72DCOo4oAV0onw/VXTPdOri2ViJNgusInSpfyHl0+Ja1QQslcXG5JtkL
ZTULrCmDLEmUSIZKGdMKOXPVtMCSNUPlmack+JzlKRIoc4maqSJGll/JipmO
loiGkSyLnfMPMln+qFfRJUQmphWq5HMDFa2ZmefmGKWWLvFyX21owYG3QtGv
lL9OFlNpSJg5R2cr+li1OqQkTYFUTZ+bUrWOCuqW1G0SPTbuvjCD5fuxesMq
N84XQnJS1Wn/iBg4eWdoAuNAwOr9cFthp512an7K8Gw6/vjjhyuEczcBEzAB
EzCBgRJgaH7UUUddcMEFzFlzbLnllnkUzledl1LBfwbunDzssMN0funSpZ0s
9nHt7rvvnlVWXcjB/HhPVdEMu45jjz0WGYrLzz777Eiwxx577LzzziQ46KCD
VDv+H3DAAZxBw9l1112Vkhe35D/uuOOuueYa5SxpjzzyyFwctYjiGBIUpZMP
Z/I4AQEi80LOoC3NKn5dsmQJmYz/WIJGFxnMG6oy/4855hjOwJDuFDXSpAw9
QWdqyetCDuqeZ1vIHJUyuxtEr+P8yBS/k08+mXJPPPHE3IidWrCn/twmcbVf
cZVO0ltyDkjISaSNk6ADFBjzHVqtDr9WUasrnnDCCbkIunSn6Tw9H7h31Ae4
m2QGU7PqPEe1yrQjCc4555ziMaLqFNjbEHMaE5gmAlbvh9ia73//+3kqNQ9E
NKrodbAyRKGdtQmYgAmYgAl0I4CqwKidsbgSomvxv0F3YuBOgiOOOELpefeh
dTcXgprdn9N+p2zRW9AheTU3JEBjqb6RpWdSWVR3PkgqyU9u+rDDDjtUnfIo
LqqMGnPKKacsWrQoSpeKcuCBBx599NFxkkxipqCTnNBDsQkNFm2KUmiOkemu
3XpH/e+IrR+Y8lixYgUfQC3aq1atCmWer8ynROJO5CNB7ieol4ceeihTM+qQ
xQHbBQsWcJK2CIWTz9meHG4jsgNzqOvqiJNhtSafWq8EbhD6BiUW6xqUT27B
7IagxFoOIGN72NtrT4Y82WZe26/iZNa9paIjZ55RQpMHIBhzxavVqUWtrlhM
o5AbN0KneznOcx813JtFU6LAc+MUsxVRnara31+P9VUmMKEErN5PaMNZbBMw
ARMwAROYHQJSQjBlR/HSmqSzcWCIk2bC+Ftq2Lnnnov+1lWlz/VhBJ+LUIYz
8a9GzUDBbkCGTohWowQIjLGdEvkfertcxKkIFSzyQSnKhnp+RetD5VaVIYbu
UUwcSEXRFElWAplEyNp7rcDkvHLlyriQUqjdpBgt0RWZDVG95LydIWsepKh1
A/ncT1Av9913XzhnBY/i1HnIMyakaqmSUs4FNBZTDPLLiJS0EWXJnkxXCZcB
dNfwSlA7SpfmA90pG8ZzoWpBCqLuKgjbPp+l7nKGaQt5hYSaXT1JTVV0dn+o
7VecJMOis0lFp7isJwOBbMEY/iC11amiltm/2hV5OJB/nizIHFDpARizGA23
Z/wEItqXunD75NkKqqN7sOqk0CZbpzGBqSFg9X5qmtIVMQETMAETMIGxICAH
e/mZ9ypQTA2g28tariM0qF4zVHqUbYb+oWDH4t7Qq6UzRInLli2TlsX/UOTC
jZ8KZlM5mTAdUNgeUTzCLI/uXfzKJaiRUreqSiD6ba39uVp3tEdpaIVO2x+l
wV4V9uci3AAqa6jZQJB2SovApHYeBKk6kVcrqNX4LPWSz1nBC+d8QFVXa+cq
I5i+0voxNRP+FxdddBE9RD0H5T/MznEVHUxzLrQ7micfspJcy5aCEE8yw4RC
cWTgMx1MfZV5kCio9qTmR/JChmq/Ut9WhrmzoVcjISdDT+Y20cQEIoU/SLU6
tajpsfTz2q5YOAhkFFo7QwegCp1ap/CP0BIAEeN/dmMR9qhOpwANg+3nzs0E
xo3AOrVrWjTHybFmzZquEq8+60yl2XS/tYvTfEwTgWWvOHiaqjMddVn8wY9N
R0VcixETGNnt7C462Ja94bR7LJkb7LnXYHPulFvX13ospA+VleE+Cg9KKSqE
DOxyS8YaifKD9sXAHQWDQXzVgE96dOOwcqMhyHwqIznn9bk6XKHQ888/P6vN
xRkKJTdEkiS1A56AgAqK53y436OqhdEeCTF+ZsNvkThEjdyQhEvkuZCXkSsB
ilN2Po+rkFPV5wyFoonJMqyvWQbGaRh7ESkGbMpEtPU5g53JGTCi4OXqN5/p
1F7IgJ7GCvzauquxcADJi/C5RJ2qtpnaNCslLl++XJ0k8Obm4zNmbYqQu37M
FOTmU2fIWYU8+arIqvbOqm1BpgNyHxbY+fPnR/dDZtRmiEG1elLzJqodPaFT
D0fIgmrzvTDA50zUWk1Pzrola2FShXhE5DYq5CHP7D6Dqg8BdYacUjfIAOvi
rExg2AR6et3PmzdP8tTczpoOL46QHvW+67Hi1JP1V5uVT2YCeWmZpiojzkpO
pp8KdIwGcmLNFseZ4tdBYb/00LWxhXh08n4lT8kfE+Gc0QRqVdpBCVCbTw5N
lIVpKDQm13WtJG8Wm4prYFG0IKh7rZ3eQwoSEz6HetfKJa/hID0X8l81pUWU
WKNJfa7tML0KWZterc9/1To7TEYsHH6qCiDOuccKgmrRqefXyhDD+viVM9EK
gsP/iMGjZNVuWdwyPfGpLSX3hKqQ5B+9DmH66DY9SdgmMZ2nqAhSxdNe7Rgd
tcgwbodcKSXu1EUbmkAFdZK54ac21SzS5Dul0+VqvpwSGvF8KO6CPmSY4SXx
ku36Oh5UgjavdXWeHCosiPGh+lldKJ7YfIgnWCZPsriWNErfqcPEgzEIF2cQ
Ml5etW/buFBFhEiSNr6qpvT2HEpQOeupWG1ialG8PpRGsf06dYlcfckQmefH
JvXSIyWnlzD5vVbt/P2dqQ4wms90ai+uKuqeu0HxyshvilrynGwz9sjA+Sxu
8UGiqqXyeyT3hxgtqEWKtstXxWCptn1rWzAXFPnnV2q8f2tPUmIeWnTqV3Ej
KEGnzjnDJ1XXWmsMGbRjPKALC7xRtSLbonfFVcWdFU+PYVTKeZrAkAj09LqP
8VtVGDvnB5whfsj7f8RwAYtEOFD1VzYPypbOe/3lH1dFKCC9XbKzJZ81XJhh
ET1dHpYBXhII0CaYEHPGeqkr3mFPxfWdmGl4eZrJ90w2AebpNSJ5+9vfzv+W
K1G1rnW2DiwJUXQMznKknNpaADyvOcSbLpTJPnq+hgUczO5Xu/3ChQurcIrg
yTjKZm22D5hRijxOqYW8SSOrEDLOxKQDZzq5HUZgp6pIiqXUh6jNl0RFqELM
O9Ta06r5RFRw6fly7OSo7aKdmkB3xMDrFRkq2FWv+QdqPsjFNB/5Lug156lM
T4eh82h1Ogefa3d7xf7MC4LbBDMaA/FYBc1rpevTD6foHPEr3Ol7bVxKR4YQ
tbht1TosDA4fab4irbRHFcpnztDbIxPqJZOy3O8LV3+9lWYYNFeu2rnzROmg
0w0bnvlKRomiPYZdDqlw34gOoNsNJ+qAzAu9k621ljzvICob5BuiMEahXCJu
im7AtdjDs8EguEE4OoB2Uohe0Xc/JIdqC1KQJmXIVovwe2o77hEtXKcfVl9A
yip75usMvXdWwjTUDlk5KaRUP6a0GiCEZ340ChXnjuMVL898HXzuY2VQT/Cd
2ATGloDV++E2jYKaUkZtOFCG+3oNx+qgqgKgcDK1Q3we0EVQVh7i8eKJSLCx
Zokzyi1KiZ+6jpZi7K41frGljd4TAbEoPdbdKX+tENPQKosq77K8RIo0JMgh
YWvbafHixZzHl4/8tf+qQEW5gi+nUA5+VZWL3EKwThxix924MEuLqKpORo0M
KlR10a+c5H2jEYlqpxFJsaMvyVSF3B9yvOVOvTakEtLqKCTOqOhoha46ZHUg
zrhTSwR1VHNAQcovV4YgoTJFz+eqaKzmWzHyRy2s1SSrGj7FxfwCtCPqVfU2
CS00tuTtJEwupToOa8CoOMkUHZ1E/VBdAq9mri0EC+dkUv7Lv/xLZE5dNCNQ
Ddcct0xe6Vpbl9oJkfZPQ2SjQbM6xLXVLtqpCdQ59SSJWnSSuXhM1V4SdxDZ
vvSlL0U2DXlVIzQ39fwGBUAp1c95rurZUhxd1dH2AKcjZd5PLk8PATBUfc0H
SW2LLa9iurPKgTRxraaB+J93tmu4tpobUqHx5nJl5aiqkbyji9d03t9Ok7NZ
jHCA19LxOJQzhdZOdvATFzaEB8/VJ7EIq165oMiBDzk8Aclqazfi/lY7f1e0
gvjkk9XZkJgIriVfGKw63Z65HfOsoi5X3HgVTcoMMy7MrVntFfmqyKoWeG0L
qrdEXVQLmX+UCYh0c3U6GRXp1OWqzYHMLedzZ95z8my+ahq01Y1z9fONWe3b
EqZ6B1GE2ihfrq41c/mdgwlMIgGr98NqNSlamGqLsUhMVOeCGQTrAU0koWyL
Zlyr5zLrEtENqrIy65lnQ+MViOIREX20co85UVQIFaRJAQ4WpKlcbUGch8hS
wvVq4WGaH5qM6TXvS+3ytDeXy7TLnLeizqC3yJWRHKhXeC4oNxUtCzyJkU2m
TrmNkYBMdDlnaof+Cn2kALzwAQVVoyCp0LoQqXiN8aGTcYmcUZwkSe3eLWRI
5kjCERod08xyMCPbkE08OQMf3kzhPxnDDp2U9T5ak1bWW1+mLWEXOo1Nxb8Y
w9V2XAiImN6aMWLQQgDkFGE5VCMVGq/ScCFi5PkUOgDpKVfbPhXjUVkD+DWM
SLVjBfpDzATVWkjgiU6IAPyKAMUUj2Y3NGTpNBYBy907K609CiacifkFRRJW
guptwq90P5HnquqNUJQiHxDZvdWZm4VUuZoQydZvqkxW8uckh0IwvoY35pvf
/GZykHbKfSdrUhGumV8jqjO/Up08zyVdt4orIkX1ZPFTDOQYnHXqop2aILeU
THCQzHbaSFB9TKni+RL1Md1BwDzppJPCXTbyUbeX2HmSS1iam6/TXVB7D/qk
CZiACZiACZiACcwiAav3o4af1/KpbPkNasTJsJWxe8iEuqhxPAP9Wr9iTVjm
cbk0k+yjJR9aPEs5KRVIwV2JARseawzxUZWzKSb0liogRJIdksvDaY1k4XeX
I7igBsskLotrzBpQI1UZHb62DaS6y5MNPoXZTcS4Vj6TykG1k/e7NOocG6lT
S2vqJCTJFmldoq2eKIVDYAWc0rmKa2PKPBqr0yR6rQzMrag6igqjuLsU1MlN
saHLMj0U2+qQrGoYl82WfkWlQBodj7ogRp5EjzmCojj1mZYrMtCoNROUtesi
Q01bgA6pCvPOzM0Lml+gpsW8fnGbUC5TPKCTvtryRuhPvDDRF4GOhKV6/wYu
3GRwSuSrdi3iQ8yY8BO3M7dM6Oqk4YymIeKo7TnhnN++v+neLxbhd+qWnZog
0ocLQOEPogTVx5Qqrhs8LtFX7TJVlUSBryMAdWaSJ9oa7iz/NFQCmtvqowhu
hGLmsXqmj2yn5pIq2P7O8Kwrng9tzkwNRlfEBEzABCaLgNX7YbWXFBWUFnSh
rq7vMcLupFM1SIniFAb8sGK1XL4VC4Mpt9ZoWVtuzBHwa2EyzRnKFMlAHDUG
pUVAUAul8KN5yogd0dpQxcOfNrKN2ZBClYqAOm1s2l3bOAf7aa/kRIylnpT5
ZhVLDdFV4E4JZBmGJHiZg2DmQpqM0mMn15QE58UtxyWCcNV6Xy0oHDQ67WGb
L5GjKZIU2nUn+Wut933T4ELNL8TWvsqq4TbR5E6tG8tMxNC16N7MstE0EVio
yLP5/mX1KWsLQVTrB6Gsck+miavW+5nXghzkrtLy1qttgp7EKB5T1WuZOtSs
E927we05Lqxa73uSx4lNwARMwARMwARMYGwJWL0fbtPIHBoD4trCGPHLGF79
FX1MxnzFpKm9XOpo/CobiEzfzQeGXLSFnKal0ZJLmI9A8S7UDHRF7XqiQ8uM
5XvMV1QXqXlF9JfwVghPfmnLsva3qUhRTaCFtR89NlZcd6KhrYMaWMnireUM
mjdRkC3sit0Yt/qdJuvUuA3XU69QsPmQq0l1VCOt1g7nDrkJ0CFFWL7f2fWj
jfVeIqHa1bpSVwXGsMyETg7Q0FCpgVvvNb8QW/tG0cVtQufkDPM1ig7Q/kZo
1cB3J0Il5q5Ruerb+WbpJFjOX9cylxerDGLpATcypmlpufmSNtb79lVQSj2L
8h4KzTl0aoKW5VYfU9ULuRMjRHkbI7Ct9y3hO5kJmIAJmIAJmMDEEbB6P4om
aw6lw3g04qZiVspr77kQPY2TjOkbTHaxzB71TOnjTEP1SIxOGIasrkGnclbS
grJnPl/Dy508sX9SLxQYPqNyIA/Fhac99cJdVp7hoVrnIMxa9a01/JKwTXh8
SUjmWt+uVbVdrXnocuGjXhsaDcklG7VWK6jJ5GvQ4J1B+git19AQSBgRGSRz
m4Orws2bD6qmYgRqSwXN+8jnX1MquO5HQTLAotBGIN+uPiaFVLGSuVlaRVZv
aentWnFVGZkFts1ycWYWighw1duEbkaHlIt+rxyaZY5OQjJ5oHAviHk4faCu
K7ReVTB6mtpU/Z+6KOSBCqVe6oHcyFo8QqPEHd0GDpmHP3+nwP5FBRWtMG7M
rjH8JHbRBF0bOmrR5jHF1EbIo1uYXpdD63UtrkigmyhCYPZ6udObgAmYgAmY
gAmYwGwRWKd25WHoGGyi21Wy1WedqTSb7le/iLprDk4wtgSWveLgxR/82AjE
QxXRniioKOhXihk2gnInroiZtAiaT6iU3OMmPHGtj5KPt4umcvLnlhWZSedp
WQTJRlNKlocpBqZINOvBJAUTKO2X2LSv1yymvOG0taFGOTbYc6/RiOHX+mg4
uxQTMAETMAETCAI9ve7nzZunC6vjeVvv3anGggDD8bDeo9u3d/0dC+knRAiM
qGEUNeEJabQ/EhPFNe/rO7wqRD/pz7tneILV5gyTvJv0lOn2I4Y5fcXh8lO4
ZVXPTF+tXSMTMAETMIE5S8Dq/Zxt+rGreF7wPJPwcmNXsbERKG/Ya8Jj0yw9
CFJsINx14UkPWf9x0mJ1Ol/brGnvu7gZXphDNgyPyQyFnMrLFYyzWDmFA0Wh
TitkZpFMcR8zFi29yatjcpDLuDzPPcWaMq1hidy4sP16LkqMPLVEJZ/hp1wd
1SXWpETKvLZFwhRVVsoQOJZWKWXmoCIyhyLoaV53U4QjjXyEN1IqnG38mqvA
yU6JuTzXPZpDlVUVIs9OiXNdikviWkop+kyUldux2rWqfSaqU9xxRZWjlYtl
iYiRm7INmYhgqiarzo3WrpNSBQshVZ3mFU8kKBZSqXtEKbWQizQqt82tqs5c
pRQnhxTAdSofmK6UCYyMgNX7kaF2QSZgAiZgAiYwJQQY1rNUpNixVZtQohJk
lYZ4DQRf0B6ZcRCTRZsmxhl2uOBMEfBVQROJg0B4hdAxFCKUn3JIUSTpO3BG
bDmhABl5JpR4FrkU/ERyHBziy2gujFqrLvwn9AlnWGuWt32lXlyovS3j0LUU
kRU24So4xPY6CpgivLGoLfLJGiOXxK46uVAkJP8iDGenxHEhbardcDgI49I8
e6LqxCwhHnkNTRPzAtFnYg8RcohuU9u1avtMtWvVVrnaIpKEpszabDMZLokd
ahQtVbWmczbsOaq6kKDAqOoUTRNNoKmcqucdiLhKUVE6HdU07W9V5Mz9tpjH
ocTY3ETBX6bkAedqmMAkE/Da+0luveHLzjLa4RfiEnojMJpoCL3J5NSTQGBk
t7O76GC7Q0+L8QZSdPu19yhyxBANbyBpcex3gDoRu5ky4kfhQXHipJZOKHIE
qyq4NgKCaBMTZg0iw5x5XE5uqPeomugn2tqTDPkVVRZ1Wj/lC0mGfp63Ly3O
IPPy5cs7+X1EcZSCbASUXbFiRTU9P7FpSxFDNK5FI0I8RVGVwFl4fs0canFl
ngiMJgneaqHiQHPoJzRYfc11VHwKtMEQuFPiEKyQUH0sV4GvkaY4r+amRKnN
QSA6apVqVDB35tquVe0ztV2rWuVqi9S2b1cyUbXivuN8brLi19q6qBsXt0D1
di5yjs5ce19ES+kWyJ255a0ad1Ys7hVM5ph0rxWdkF+Z/RlUMN2BPM2ciQlM
EIGeXvcNa+//b3o1e2MGCELrdT1WnHqy/qr+nD5jAiZgAiZgAiYwEwLxku36
Oh5UgvavdSx7sSshddSOA9IEwsYu2ziWvTCScxVWaKXXB/7L2pnNnpE5v0aG
8YEMw0CqfMhfRWSpEEMqZRzFGfKJMU+ui2TOZnN9zhWJPMlBFYlDG+LoK1Ip
5xBMe6zGr0Emqp9LyUzESjkHvSiUfGRK1YeQIXKLukcmDYkjTW2VVYV8SKpC
Ws5EZXOtMzrOFz9pt5fmrtWpzxRdq1OVixZRp83StiGjNuXCsGCrXlUIuW9E
w0Vnzs3afG3xK+XmFi/kV6HVNOo8bW5ViZr7bUzQ6PLoclFWdOZcZX82ARNo
Q6Cn1308fqs5j8g5X8t+Cu+s6mqrTvMrzA62X0fXdZIGMbq68FEcafifF0Hl
tVKxFk5OaMXSOK5iblj/i1VSeTGhXNFI1lUeksnlqVhB17WyOQGzvJQeUYXy
mj1Vs5CWxDqT4YterBss1stFcdWK9yRqy8Qt0eXcCq/R5oLyCsyWPVDti2BR
UCdftaJ3SRKuKha5tUERHKJdMBN1apquVVZvjJsuIMR59e0MJK8jjXKrC/aq
RQeEntolFje2gdN3mjZtocpGyhAsIOiO060UkuTHRdx6bdor330t61XbzVpe
WyTrtG62ZW7F80dX5YWmeuS2eT63LNHJRkyA5pMLN+WGI3rEg2S3Qnkdcy9E
FAnifcqpGCOz9lvF1MxmjfEY1JaH2lclAkBog09ZsHMdee5RRK+P0HDFlzt9
vhzrd+wyi3idLPzcxWhQRUxHstK2r2SIVHJwIJO8SEFPDM5HzvwqDoFrJo1I
obRIflYfd9xxMCdPSZufS9XEbYqOYaWmYHo9kA3VkZblyM7q9BByBr741Hat
ap+p7VrVKte2CE+e2Pi2cJtvJqOwQdoGuLbv5bFWMBf/vF6DG0FNk2+BeKfU
LuAnMQsftPssvjDFgo5oi2qalrdq5BD9NmD22tBObwImMEoCI1LvqRKPy/zo
qa7eGXa1+1gRtGDBgpAKgXNwKd7BeqtpxR2P43jJ8byODeHnz59frZemlpmC
1bo43uvtHZlIOcPYUbkWYZdgFNLp5VEMR2hE3iWMZjTzTRU6XTjsBm2PLms4
OThZGwk1L66Vn23Sa1BCG/VaUJvMizTRpaMLLVu2TALTQNkZtY/MdQmDFW1S
yIE/auSDV2eRZ9ipYjTJJe3jsbXHpZE0mXMfadjaRg9vSaA/3TJr5mKFJ2Se
s6tyCPuGtBGGeu3bSytgW9Zo5sliKmcg5QYKTRZU15Hi1z1zmZ3DrBDgPRj6
djyU4taO/pN7e7zRuDA8/POjI+y3WXmW2TCWu+fK8nBojkzWQIYieI6tWrVK
aaQCqVy6q4zAdFoeidy2MXGv+e7iJc6FSK7enm+cjIif9LggN71GyYepDc1o
yHxdO6180UUXxcQin3ONeJXvsMMO+Qwacn555fFG9albJI58uCs1VdHmYOBE
LXJKXkxFjIb4laEUiaXE8qEI0BAL1Gu7VrXP1HatapVrWyQPrnLOErUTmagI
l1RjK+jXHPuTr6jx9CVVmaaPgTGf6Vox46Pl7jGw7LQhSNwsDS+RapqWt2rU
TjMO9FKEbB6vMs1RHR606TZOYwImMEACo1PveZ5mA11Mu1KZbCPla2j+Dcai
wnxHzhG9U3SyfSys7uFBgKKiHLqazeM5VczcxyAmB92h3DwrLEkaNBz9FBoF
cgaK0JklZ4xXQlOVwVa/agSQLajNcxlVOyG1WLlyZW3H0mNdP2lmOteIX5u3
oVLtQk61hQZGMgIjjCoYyVRW6GzhCFDlE+iiP3Amz5TzGTgMbngnkSbbUYsJ
dZUYMhRz8FSZwRYnkVM9TT1HwkcT8EGvbclcTHwUZvBMW/lUA/ZGzhmjilYT
SxIdqinjA6GLVo5bQ/2ElDrT6yC4mFfKk19Fz9FPEkPM1e4hUtyerL/VtYGr
ei/n50OWmY4no4qG3eEyEwUVwGUZLm6oaEEBgZ4GWJIKS4XSd7UHFrc5E3x5
NoSsamf6VIpWEQtOrZAhduQpCfMdFJ0nmjt6adE6RacVfFUzdzMVQW7cO/Qr
iRdkQiSVW9vKRbnxVVk1TBZYw++EzuczAUYRYVqP8+ge6ISFetmSGzcUD5N4
o5G5DOnRXaVryVNdYwD6P3dldiLQixg1tf3uJGSouX6pwaHRcb5Qd3XX84xS
xRGPz/F00uOxeCPzFWlJ1gZCp8SqS4yXeEw1uLNpliSe1YjHAyRIFmLQUpqs
0TS6HDf0MFdKzjS8a9pUaiBpOpHRm1dFMAPS5tlFsryOg1pTWY68hIS5oU6m
+IFUp49M6I1FXMlqJtCgvdrbq/oQw5eYgAm0ITA69V6vIrnh8fjmBbx48WKJ
GK5xPD54OvAYle2LsXXt7ty8UPU+4BGpVwhf0cM5w2tMbyCF2OEMT0y5TnGS
/3ruMGDVu0TvvDwglkLFy4yUSKL05CmnqepBVlERfmXCVQv5uBZ1iCFs1diu
LZqRsLqFtcLwhmGfmsp2Ee4AWQCe/oKgN31Y1IEgw6aG7KHPIIxGIYVDo4Do
DRrz6FwVI6RwVKN24kClYsTftZ/J/Cu/R/qArC56eVOu/CD4wCApt2BttgWf
SKPBAW2NZ0HMlFOiogrBUMbSrIMpMIzGaqEaSQbO0PeyABr26XJ6rzoSwKGh
jiSXzljjV53yIAdlzkEtsroY+dCOWn9I26k/c8T4VRij0xZdmquoqZbYZTtw
bVaK9NvGDYQqk2FWFLlK90VRxzBHVC1CdCS1uwz7Gu2pdlW1ubiXs/sA7Uvp
/397b9Ny13Gu+eMvIDIWihFxPoMGInaDBnYCmTQYE/v0wD1R4wwyEnYPDIeA
Jw4eZeDQnrQHfewcI+iJIZYHGtiN4K/PEAehCI2DvkD+v5wrXH131Xqp/frs
Zz/XRoj9rF2r6q5fvay6X6oWn6qBU5z2EKo6dCS+q4P1wLlRjS6fOeOaqYY/
6SFUkxy8R7F2LfWHxnwmHVWo+wFFr9aY5SdNAo3+L3sTn3oKtwpthKQiGul8
egeaR5CqzEeNSzUZtv0yq++0Wpsqf9I3szGSa9tw7VRVJE2PmjpqK1fzGdVk
iC3MP6o4RdOH9VmdVZLgwgnouWlv86oJbO8Cq5/0eubkcfELpdvgpYeCUirb
5a5IJ6f6HsuaE/Ts0FN+zsTWCEPPl2vUkflKwOPM+xT8aJaQmn71dFNMAR+t
rPqa3rt3bxz+XGJytm951XhBYiYiSaXN25WklyW///3vFZkv8RSfzzIDGQyw
3/UwXpf9ppwkQ9sp2oIPT5PVuUsrn/r01KH3jsyXzOQjtb9WQZMqxakz2Noy
WU1D3tfA9BaAvjh3DD2q9os9uYVACGxB4KjqPROWtt5ZS5TEXjfbwMw0Kpv0
5FzJ1KbnGQ8Ar3e1kK1OMz0zmCL72U0auF2yLGG1utWnKZTbmbMm7ZGKE64L
d+9xWmgMGW4RDPkb2aTLYS/QQ9pGkEkOWsTwnPCKRCo6eeKK55ZaqUldzisG
lgh63lTXgaPpWLXLy4peqilenjcEoBUWrPiCINp4L2k1VcTBAhShcvlJz87e
7VlJNnzqTzLBqC20XAPvXCvwmPSqghp5SSQZCG50u+i5VZd99kLQ90yD3BzS
OVkoIZReBYIdL42TUZbCKeX04Au0/bz0M77ptAsdrP40mdWcrWoyT+l72li4
UKg9D2TenDfhdudAXQ6dBlTtWn2ezVgWE1lPlBh5GEST6xs36yRwFlLqIW4v
hefoKOxektof1Of9mYul16KKmi6v8xycLytDLboRkrHsEKG+4TyCPKakYwB5
UsK+09JDqmOtn417LLC1JNwrdE0r13hUoPUWkMEOnGQnS6B5bi7EqW1dhT5G
WsPfZdHJNdCqVVHPvlVFy1JpR5U+zpnb58a4o7ibTq70DZY5T2YTvULR5NbU
V2n4v3maNwF0Fr6OshqRrnwW7LlziZt476agpgpN4krV2mwzi/7mN79pZgb+
hFhNdrGu4BEyxlIJ02STk14fQi+bdS3Ij7k+EKM+g5a7Vt+ltxuGzeYai+TB
Ujv8+Baz7YTJXSEQAoMEjqreIxMrV7RB7d+2iHY7S4GpD925aqwusm3PbtTv
yQx7731NhiZmzyTXZSPnixbldYb1ITEj9GWoXtYJR/JxGjKUwZsrPFp6732f
m5X55ZWQ7DLyDDQLC+wCffTgRmLvJXE1wdglu91JP4082uZdl31bC+ysRpae
9cTg5e0Pq/LsJStWKs1pQ3PlVnPJqmyrCehvGn2M6BrLAxPadzl8cRU4gZQy
o/D/aizDpPe+l5/GdYTFau1IYPV4JPFqGoxostkxFWw3MOdm49WimwS9937T
HJI+BEIgBEIgBEIgBEJgUwLHVu8JR1dQd2Ppl9sZD6EqwBKTtXtzPJXrxkJ/
2WPMQpwipJWNmH6XvffVcI4M0vTQIZG2UQnwLfdbAeeaBCFZiC/syOVGaiE3
73IUlopQUC4f2YxHvPfj3QXVjuawy87uWdyeh3Da1LprQ8fyhw5TlRm5ZJsz
h2oO0oJkpiGWpDlAYa20f/5O6+jwGzXlshKOJjmniwJQotKr5aBG/u10s17y
HbNCSXPfw7gzsgcSJv3hDj18XVkdLwhgR7eMUO57uLUXCloAbmFwXHsP5Gqj
D3rvyYeU3iW0mi0NvXwQEcwdo7S6gdZnK8oZ2Jfed9q+hzSzcZ9JZettCE2y
eO9Xmz4JjkOA8dg4Ffsrx5EkpYRACIRACITAEQgcW71X+HGzpudPuZ31DJbq
TkqH6POndzfxK4td/zl5PJge3t56pP1LLLhXdysNEtd+YEe2+6A4ib2aiSor
b+Sybqwt7nLIK0R54YOO6iqPmANW5awJ8DGieTrmgj9VFirrqttzo4KcWAfV
LgeEK7G0a1GlP2DQkUvW6rSiDxx2wS1g95bFrauAGUUFaW/hcjWRoTZQ3ZTh
zeRom4pal03KrTmX80iXHsxqrgj6s8Ly+WDcWejejnCByXIkNvC1n5/P6i5Z
SvSmBrWgXpXEh+6hghCsnuSkuiwAd2XZCeIdnhrF9PC6sX+7rstdmrsWbnel
3NwLTeCeM3kWSb2RfT3e1uGx47IYHX2n1VFkQsq80czGZG6brAuqbBU5vAUo
7yNtxuYWWeWWEAiBEAiBENKNFroAAL1sSURBVAiBEAgBEXgJJ0/PwuvCFy9e
rJL625++VpofvzX05rDVDHdPwMIRl6/UTswBaE0HUkF3F3WPOeCXk30EFQh9
IJug9sg2WV0UAcYvESI+4RIxRuJxBqVFpfehdwwf7IYHCkUZlGf3ZOjnuNal
b6PMY7/YTvfeXZLksEcCf/3qS+X2o1/8co/ZLmR1go/141Q8pYRACIRACITA
RRHY6HF/7do1ydnr8sf23h+HFx4/n9qKi+8q6PaAtYsPT+a+QrtH2qvZk4xt
aDk2eyTPpDkCgeZ0BsU+HKHcjYpAO62n8u5Rt0cMglB8SIfPZdxIvFNLTPSB
I5vmjiY9NZkjTwiEQAiEQAiEQAiEwL4InKf3fl90kk8IhEAIhEAIXCyBjcz5
exE13vu9YEwmIRACIRACITBOYKPH/ZXz3o9zTMoQCIEQCIEQCIEQCIEQCIEQ
CIEQOAMC5xmcfwYNkyqEQAiEQAiEQAiEQAiEQAiEQAiEwDiBqPfjrLZJyS70
ekb6NlnknhAIgRAIgRAIgRAIgRAIgRAIgRBYI3Ak9Z5DvHY8tYsToTn6S6+4
48OR1/6+XEe0axLzv89740+9BUpv4OOjw+H8MjkncIk+hMzv3JY8+pADwlBB
/ncCXaTQy34W91oXyu8hEAIhEAIhEAIhEAIhEAIhEAIXT+BI6r0ruouezxnX
q2/JniNqHVsqPa8Q4DXdHDEtJZwz53kRd72X15iTho9e9E1K0uvFAyj2eu+9
EvDucdsFrl+/XjN59OgRR3PLdnDxTR0JQiAEQiAEQiAEQiAEQiAEQiAEzpfA
UdV7VGv05D/84Q+ouwpZrw5w/sTXba+4X7dmHztvruJd7o3T3n711ZexKQFv
jEPl5gsK/xtvvEFuKPDLr4gnDSllIODeJ0+eNA55XjTtHlJ/+uyzz27dusUV
rAB5Xdz5DqLULARCIARCIARCIARCIARCIAQunsBR1XteYf3ll1/i7kbdRekl
jl0ucVzlDt1HeZZLHF+9fvrwww/NCe99deBjAsBeIC86HngyaV7lzRUK+uab
b8hB//O5ceOGvvDTs2fPJhvh1VdfdeA9PvkHDx74XhkmqIgS3Lx5k3phI/j0
00/JkP+VsonMR8Jvv/32NF8tfvHdMBKEQAiEQAiEQAiEQAiEQAiEQAjsRuCo
6n0jKjozOjwaL7o0qq9+vXfvHv+jMytaHrUZE4BvRJGuDvzHjx9jCNCv77zz
Doo3CaTt62NleyNKGAIceC8DAaVImUdUZfXdd9/h0kdIovQnD8/74osvFCbQ
fHLS3kZtkcQhEAIhEAIhEAIhEAIhEAIhEAIjBC5SvUc+6+HL4fG1JkTXL+zA
7733PQV77NG07cmfhCWTAT9hJpCoOO3v3LmDZ57rWAHef/99rkyeGojBAluD
s8U0QHwBOTiIYKR5kiYEQiAEQiAEQiAEQiAEQiAEQiAERghcpHqP69776kdk
VRqddadoeZRzdvLrOt5yFO9V7z1pMBCQHv2cTJTb3Ed51l/ZC/Dmm29iILA9
4unTp/3Z+IrM1406RADFftyEMU4jKUMgBEIgBEIgBEIgBEIgBEIgBEIAAsdW
71G/fbQe/m20ZQW9b/TaPO/GRzknPF45oEXjS19tVNKgZpMe4wIb+0kvhz8x
9nx0xL0P/HOevsItKPPUAu1dF7mr3wJQI/N1tN6qYEkQAiEQAiEQAiEQAiEQ
AiEQAiEQAlsT+IdXub9ZWi6fFy9erGb9tz99rTQ/fusf75nLBwIo//HVpyeE
QAiEQAjsTuCvX32pTH70i1/unttIDnmsj1BKmhAIgRAIgRDYI4GNHvfXrl1T
0b0uf2zv/R4RnGxWNTL/ZIWMYCEQAiEQAiEQAiEQAiEQAiEQAudEIOr9/luT
LQM5P2//WJNjCIRACIRACIRACIRACIRACITAPIGo9+kdIRACIRACIRACIRAC
IRACIRACIXDpCUS9v/RNmAqEQAiEQAiEQAiEQAiEQAiEQAiEQNT79IEQCIEQ
CIEQCIGLIfC7//isls2BtbzLZjkZB9/8/Oc/X83qdBIgLTJXeforpyPtaUpC
5+E0aLrHpWv9PfI8kbozQv1OaNfuRGTbI+1Ns4KA3/C16b1HSD8ytS6LwQvI
Nnr92X4rZfl3r8iqYHrV2qV4ykS9X23N7RPQ3ekH9IaFLOglq2m2lyB3hkAI
hEAIhMABCPjtsHXlqiea9HAtaq26D65xnYx7G9W3qcTqMqtm5Xv1XJZCWDWQ
KirXnawuW11lX5Ru2a/dJ2VTnsuVauoonnxcImxdorOytHXd6WRehFjaueWp
i3OCueYARQVYpZpc81RQC9hN3mnIbXkx/dlnn/3www95V9HCEF/udRstQQeN
cQeYby4mS0aW+zPft1NieVX2l19+ydnmvCd762ow3OpAaCYT2kWy1ZHYzGn8
2s9gvTz9JFAHo2eV3o4zWLXJ08c1P9iAq2mnGfj1oqo5Z/BFNrWasUg25aDv
WxtS33vvPR2v5rnRKJriBoEcKFnU+wOB/We233///a9+9auFMugl9JXDCpHc
QyAEQiAEQmDfBF555RXWrHoljxaXH374If9/8skn/P/uu+/y//vvv69iWeO+
8cYbfLl///6CIK+++irPTfJkQcz3yZRaV5FguUIfffSRxOMhK/FY83377be6
yJpMF1mTkbI+iLVqVLI//OEP0qJJ/Prrr/siWZHsgw8+0JWPP/5Yuc3JpvQQ
G28Esrpz545LlFSwRZsVH8TmSpUWLVfSUilh5H81Cp+HDx8qN5L1SrgMMU6g
P/vm0MJaRfsDGSkwFPf22283y25EMig4a9XeY1duACfNsl+kFg2NXbSm8ea4
vClpF458npOfX5eXqZe34vuV/NP/+GyRJ8Phxo0bW9zoW6QSM2zryGI6bYah
02sU82Hc2cDKsL17966ua6bqRZqcBGoyCvUUsUuNmnsx0jHq66OBqbKpr58g
3MuQR4y5gc+Nk12aUaC67+XDA05zLK0wPl/tpeiRTKLej1BKmhAIgRAIgRAI
gRUCrJ9YpaGhoeuid1UNnIush1gdspKby4UVJwmkimh9NrkGHVyl+RU2r732
mpbF3333nRfECIOqz0UMEM3Lblg1eh2PPM+ePSMZie/duyfJqSNZNbXQWnNO
NpTeTV+pQ1Yyjkh45Y9g+vL06VN9qdLC/Pr166qUMCK8nUsWAG2c2xv5Uf5t
CEAN4M/J5tDCuqorEk/tRaGsyx8/flwzf/ToEeYPXXnnnXcePHgwiZ2LrJJh
SxpL4nwU+O04BRUqX1zjpazuwRoZ3gcvkJsv9s5PmSHszFzwFlaXqQRWEG8N
EunzmfT+2TvqfBBMTtfqJOxDM5rWrH/W6GXX1wqJ9jUo/XJgCPeiLvJROECN
yKjqjduoH7w9ll5s0pCz/cxKIL+oIVTgNVZokpKdwHK/yy3Mp7rlyb8Gqqgz
8D+zFiNXTa/IBRVtsd0rXOvGw09BdHjMZBLDfViKdH9XXzWSodkyXzEqZTnV
B9vfpJ2uIkX/pL3UIZnKbGxlGpm0+PSTwEK/mvuJOtZu5p4/l14DltlVovpT
6wsWZmCZjPWprdDkPOeZ9+YRN4ozcX9Tr1BKST4Xb8Vkq3KZ+k7QQBb1fouu
m1tCIARCIARC4KoTYH0jfcDxihCRDsyymNWkFz1aM926dYv1GXfNLZikSPuz
ka97oTE+//xzlsJatDnZiD+N9CzNEZu7vJjj+82bN/kfRRf7hQiwLF7w7LGI
X401mJRf60s4uHSv/muJVhJYzdujJcHQk3uzAq1z+/btpsQa3/7yyy/z62Bz
PH/+vGbVR+0+efLECWR9mPvQUuj2Ujz6TgIELDWKlZCeI18c/1tvmcuZHogY
cjzSGezSxNikizCBrYwXfOi90iWgpysutC8CYRS8YL8oFdGfmJOk7/X58JO8
fyKPhBaGsowRwRRy4pBjKqvMa2jGAtX6kyBM3kj+Cgzho8AZhZzoCvJTLoLx
4U/Znnox3EYAqcqYGrTHMik2ap6q7LgbksHBrBw3RHHYqvi1hznZ3MqWutAH
bKEj5zfffFOGOX3UGRjRCNDE1dNDKF2dUzozV+hOzAm6V9ddL8oiDcDrMCQZ
9Cbv6qumujOXIiRfKjFq3RvCagINJepCZTUHLn/6SaBJz3yoicUjaDJDBQqB
DuOIQpAgOXeLjBdgBFRFV+uLYx9tf0380d/dKGovpln3THjqMUHXQip19cl8
FV+29SaFUVm3TRf1fltyuS8EQiAEQiAErjABrURZk9VFp5U9OWn1YfGkdbBU
Zdy5R8Om9eKq+jcpj9TyhdhvFs3UizRUdi4+E02A9eJ27h3rhKBW/tY/WXra
9YQeItWCi15D6wrk7WBUHakUGprWrL23dl/tYpfdshpQiwMU2oUEYynPor8R
BgjCiG2iif9fFZuWopeqvmiPtjg4moN2dNdFZjg7fsR3zZWC0QE1xh2A7m0t
yFsV7By2ixK1B/XAVowaWkJ3tUEHvUg9kPSOuZBIc7tXFmjI+gbkaq7iCjy5
AmHlrCuI1KjoTc69GG4j6JFhbaZJLJOiusrYehRiw8cBICKmom356mEuN7dV
R4WoiPCqn1mSuHOaD9qsghr4UG4fGlOr6SCg/q7JqtEbtXWoV4CBbKPP6hDY
PQHFaVahZanvnJWWgmTrZLangTT3Mkaqmc/C0ENkvOAKnY35yj/V+lIcTbZ7
FSZzUHiFmo+qaR5wT54rVDSYQFaNHQcSeznbqPcXgj2FhkAIhEAIhMA5EJD7
yFqc9CU5q3VRPnApPHLIL8TnVyIONd8aEwvQuaj4GrU+mT9qsHW8JgHrVJx1
UufQwKXJUNBkPlWrIRnryC02arK+b3QGLYgbLRfFo1lDK1q+Kq7cYmOH3ZWN
h8qR/1s0Byo6kRE2TDSGFSSZC8pABjsPuWu7fc4LXUVuZ30WMocPuoQT1NMH
lhf6KHu2pNBeLktu2z4feb+lHmzUw9FCVZdGRd8ok8nElpkvqycabCFGj2U7
me3ilsBk0sNcbm6rjnIde7JShstxQzYNWC/VjGd648bE/q7Jqrk3arap0Jh+
52YekkkDp7LMV1gTNqI9OQkoB9Frons2ytyJZa/Un1StCTWiaaig9uysdsjt
BNBdjltBmIWDKvoikJnQjMEn2i4Sbnpv1PtNiSV9CIRACIRACITAPwlIgdT6
hnUYajxrVhY9XJSjUgcmef3EsnsuPh9vD7c78JUcdlnSYVxQdKWbChefY1kd
sT/ZkPjEWBBXJZDlrDe+Krid5a9di02Aes3TMcxSG1YP3PW92g+sPylIAfP1
THv+hA/MbS9gBa+NA04mr6xC4rmI8j93BABBznZl05p42wabQ65gyYDAfG/W
x2RllzXalKKpD/ehsvYbu0bIMLgERzzaqIonetWvOCk8vUUhAPSNJoha6Sfz
oTnoFTQTErpz0vQ6h3Luo86wfErlRoQVc94YnuhLfa2r/agXwz2BrJrxO4el
l1Ox8Vyf7C3qb5Ou4wpztbnlK64qumYb9WFL1bvipdwymnweJxPLavfoq9nf
tVC1udbUcSfNrnUnxqikqAdmoRphVOeWmnM/CUyWW3ctbdTNNk0sWwb2C+I4
Nr13Nb3NE7TmpkMJAp5jMeCeYIh+1PvVDrCHBNosx/+KziJHJr4T7A17qGqy
CIEQCIEQuGIEcBprwY1+4phGrXfxgbPOrgt9xVj2oddc1G52xUmypLPy3ODU
k5QEigiYC/9myevTAfQIZo1bj+ySk02nQLHK95lhPKAVfapwTS3j0Bwc7qvg
9pqbfLPSDUZkG+kggHLIKIS10kUlcES0lBCu6/QvPgBUpRS6r3AJbchHMHC5
Cv0KBO0U57nuYpVPtpPNofUMgomtNpbrwHxdb3RjSYgGopxpUxlNeuwjTEbS
IDbFKc7c+42RgUpJBj4LOykUYUEaIaKtlZWL9kLOV2pQNx2DD3e5LPXPPh93
RQRTnIglZMgsHMQohy35T/pjub4QNb0AkKZxR1Ld1ZdUEY0COa5VxKQYaEra
D9KP30kswGnef0Ypbj73lkZs+piHho+sc9dtYM41N8AZEVbRqayqRs62raBV
ah5owmQYX9xrnbOCGuc/eVdftdU+72h/p3TfYzp1KIEijPQTNppJH3U/CZCn
jsrji/u5Z5VV2SYT1Gl5NQemPorbyKNe8/SM13QzWlA0NLd7tq8jfUE2+hgf
weTeTY9NXa317gleqobt2jP0/cWLF6tl/O1PXyvNj9+ajkxbzeFcE/DY8yEx
C3UkGVbb7TbmnSu61CsEQiAEQkAE/vrVP98A96Nf/PI4TI75WNfCcTWclSUm
a/1lZz4qB97aE1xpzbUaK050pLpy7a8cp8VTyjgBTANosKfZzdBCFd09Xh1G
FtXZWn0aL2gyJQtgYgTq8Acv2xz2vjVjRznP+PaRqXW5+lenyY5Q040e99eu
XVPT9EM+3vvDjtnVXXY8yyeDuA4rVnIPgRAIgRAIgRAIgRDYkMAW7zjcsITt
k6Mt99ETc9k5DOGidHudOrlq2tseR+4MgX0TQGXr4032Xcge8ov3fg8Qk0UI
hEAIhEAIHIjARub8vchwTO/9XgROJiEQAiEQAiFw2Qls9LiP9/6yN3fkD4EQ
CIEQCIEQCIEQCIEQCIEQCIElAgnOT/8IgRAIgRAIgRAIgRAIgRAIgRAIgUtP
4Oqq9+z5uRTbJy59F0sFQiAEQiAEQiAEQiAEQiAEQiAEDk/g6qr3vJWH9yJA
2O8mad57cXj4KSEEQiAEQiAEzpwApw3r9WmX4qOXP829OO3IVej9EPFMHLkJ
jlzcabbv4NvCjszqUhTH1Hcik8mlwBUh90XgCqn3TJr1Ra+8Yod30fFKHl40
yhsFeA3j/fv394V1IR+MCBaDZUSG/RGYp4gQCIEQCIE9EuDJ1YS/8Vw7/uOs
eazrlewL1fQrqRfW3LzwzK/CVlbcVc0TzYObn/RuPyfWy5B1kf/rvZWbkjXS
Tl5cXlH4HdfmT4m6WNc8Oia9tlGTgMTbvS+91n3HHDbtouO9ri691E8uhUeH
zlYbke5UG9HdqfZ8v5y8ptSNTe/yldqB1XkW4NglVvs5kjg39wGndP7qhMud
nLtqlekSk133mM03KcDy4B3vme7zTVvr+mRzqDUbAlxprKhqlGZIIlgzdY/P
DHU2czsiRm39fuZxBdVLe1OvqnPkqWPTqebSpb8S6r26FK/D/fOf/6wWatYE
XOFtuno5h2cfD4BmrtSzXD1Y+dT+6seqHqKkdGK+6JWkmBI07bKM4PWe6daX
bthE4BAIgRC4ygRu3br14MEDry/5wnMNi/mJM8GUv+k7wHhSo+2PvL9WK40v
v/ySUvg8fPhwVQN54403qr7Nd65sxBD/hErkdWi8sE1LbbwXkoH1iRfTRCxS
Ed5wXvPfQglZEG8LvBtVtk/Mom6LXsd6D1H5f8fSD307rUkFG7MLPeTDDz9c
LlpdgiGpLsFK9YMPPlCXoA9occv/H3/8sZLxq5QrynrttdeWM0ckZcWHBe3t
27dJT0HkwxWKVmAs/ZBVt/NXnroiMXo1z2v1RoDJrnto+DX/SQGWB++mPXOy
rZGBmQdWjffxs88+ay5OTlMMdpIhvOsinQXZ6tS0xcxA27nzfPLJJ4xBNStM
1PesbVWM1GJyLlV1qpzHbNxzLev81Xset/LPo0u7FR2Zj0rPg7CawZiY1E3v
3LnDgNGjlz95dtL/9CChL2oW47X2jB++MwL1WL1586Zu9/yrWVUTKI8TvjAh
ckVZffrpp3xnyusNgefa51KvEAiBEAiBS02AZxkrOS86tW5TjSb9hPqp+q4d
sa9oZJvRtcRvnDy9Y3CVHqtYS2IVmovkz9qURzYKiR79dj1NHsfDI/6dd96h
dtXDOVm6IFjbZMmxqkCy3qiqGt9XNbdatNboKhGzBUuLx48f4zNgRaFk5M8K
R9+pMusNlt3VS0YCOPTVsd9V6BywUP3efRi58Cp9dWzY7aFfV1u8xkfwXQI3
eUpm/eo+Q4Nad63exepZkVbpFVe91/2EX6sXp2Eu/6cdMw0r9XOXrnudxjot
X4RFAru4quTQo+7evUsbuUFJSadS314dAqSkSzx//vzRo0coY0pPZ8Ywxxf+
l09LY5k0fN9IKaWaSNLby+R7p1uqZyIAYqh0r8MxIvTGL5ldbty40VRtsus2
aZpWIHPZttQQbuU6xj3n+GL13lXrw9zYWRi87reWU7Nc0x/c5SbbWko7TYbS
4Xykot+7dw+dwhf7aUr2Aoa81BOllO5Dp0In970bzQy6yxnSZBSx2hWVgFog
dmMWcXVGTKiDBSUZBM5fvZ9sZrqRn8EMAKncDGb6mVzrfBg5PCY19/H/s2fP
3KE11TIH0U01tfGFKYz03KXbyUfPJM2qmmeXbfmrlv502RAIgRAIgRA4BQIs
E73o5AtrUKRiPSrzNx+efU2Q7ZzYaBoyrPMkVYCbjebcQia6wgeT+njdnzx5
ItN8ozOzHmXRLC8Tj2Z+Vf7VB+BVLCsEnvLNCntSBtz1q57P5kaCILiipYKW
udevXx+vIKuOmli060LCmpL0BH5lZV8VSASAeaMrooTIbyFHBRnSOloOYT4g
Pf/zHYUQL8ictOoGwJcSov5gpWK5xefyhLCdJTWN1EL1H7mOaUp3QgqtnpVG
G6G/IaSyxdJRbR9cpJNU1VqFklLdlY7RswIX+ah0PqQnDdj1J9YW01aQBaJW
73ptPhi++eabLFZrpAwZ0ihVtZvDpQUtPYqB4DTqYM1qc9UONVkEYog2HxhC
kqUvFz2OpHIzZntfLh1sofPU4ua6bk3Tt4KaSf42er5b2eYtFvzuNiS2Mu/p
y1rxwtjhxsHBq+JEZlLaybaGElOKtAz3TKnoMsrIOiBNvpmmZC/g1+rnl+5D
p7IuvdHMYOYMIik742qL5EdshK8xRFSHnlCrM9efc30jAuev3ms+tYlUg6TZ
WaepX92dAeN5mR7M05Hr3M58PWKjcmCepv7VxpBxkQmR9NvNsKtFJEEIhEAI
hEAI7JcAy0SemyzvtMLT8666jvENkmCkUB67MrizzkMJ1KNQRnMyl/1ddnOt
ZUfyJA2eIgm2LAbxfXPGdzRDLZGbFfagACPJrG+jRlpZGrlxozSsMWR/qSt7
5aCVes0NZRKVzI4KWgErgBZItC9ZSdVH2Sa3OTG0ghc3rZ2I4nbbLbT4Qr1k
pplzlqA285M6kndZLqvBJLOThntZGeLIkQDybFPxXjWlt9g/1LPC9tGsMO0n
J0Na2cq2DQcYSnyLTVHyjWssNJHYUF0OJ1FkCo2I1n2ghaW0NXOgClKhGWu2
XyiMXz6zajeRUirCfexD0wEWuq5T9q3AT8ijItCQwaWuyGBXE6MXaH7gIxuW
vrtRNP/o17mxMzh4FSBjDaKXdrKtEYmUIuyCuGj3pPXkyWmKnq/hadMk7aJu
VnXpjWYGA5dlRDPzZNATKR06IdMJarzm0sZcRXUkp6vjwesQm6ZL5M8RAuev
3qsrywgt2zadzCZ2up1GtcKHsGs2VlLmLGvsq7MklsJmY9tyGzAqkGTQEDDS
nEkTAiEQAiEQAschIK3DbqLDFWqbe2MH55E9aEFYkE1b5Fj397EG/CQNgY/8
Y1pRPH36tM+Q69J76+fll19etkdI32ZFu1Fc9GR1yKEJbEaTUaWq8HIp+yO1
ttkI7XAJrU+kDygMnj9RjeQwXF0UHa5LNDkjD/qMNShptnK/H1qGhtW+ikML
shu89kPlr9jsyX7Ir1619k6mGipvUaFHR91IctRga8J0DGw96mMwR7Da59V5
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
45zHRf/NN98stOL7779Pmk8//XTHls7tIRACIRACIRAChyYgbdAfF4fy44vW
FaveqBsXVHruWlUyud2lKCsWc325kxCcrGoUkspXnJs9E6x6mxKduVaTvcpX
UZDA2q/KcvrmXn5ddocstKy3PW7R+p999tkPP/xAZOUW99ZbQLfRwnrH4i7w
9gXayxD6X+l47vMbmQ9ORB/W6Kj2HWpRxzgVrAn4aXmMa0zN1U7FTfa6Oi8p
gYrWpxaqMe5M5oahJNHHHbsvZaQfLgxtTWgjmWyaplb/QEVsKlJNP9c6m+ZJ
M6n70TeYxKRRXp25qMF1JPV+00ZK+hAIgRAIgRAIgZMlwLLpgw8++P7771lF
8XnllVfqwvGNN97gIr+iLmrJ9fHHH/OdlRxrL24kweSmPK3aP/roo+WKk8+r
r75Khir93XffVXpK0ZUFHZX8v/zySyXTVkE+rK1RbpFKf5L/t99+qzT8qSq8
/vrrupF6Ubol5Nef/OQnkwJrlWlEt2/fVjLKeu+99+7fv68/Kdff+fPhw4eu
0aYdwNseN72R9PCcq8hGubGqviKumgXayxD6X+mKuxtWNmqm/SamA9Ol6dgL
2dLPGfsj5TJIl4cAHZU5p5rnGLDvvPMOA5kiNOKQx2YyzUjNzEBYMWmcycIw
9Iyhjs3sR02VIbPBuDELR+acp1N+0BE4W6Rx9Q9XxBZSaaYlcNszOXPsqmF3
riDAgpdfnz9/7kyuzlzUYIl6v12HvJi7Hv+3/3rofxdTsZQaAiEQAiFwqQiw
Mq4quhTyyfDal19+mZ9YeLEcZyX3ySef8Oec+seqnQXojRs3lmF8/vnnLLit
i47rRUiI2NbqXQq6BOqB//zuu+/u3r2rP/kJfRu7A2tQ3chCnLrIM8l1Fvqr
2qx8s7JoyG957949qzoUYb2IDB88eKCCJl2OvijaTZRBjYy1g7GqH769iZ6Q
dUb+VXK2XuTocdJz0Z5Ms/KVJ0+e6KJDkXWvQhjqqt0yVHeuyJDeGSq6QZno
FgFvCKjEmidXyER38X8N9DAK5PFdqq+LaPqef+q3Hph2LYJ8+LOJx3YcR4PI
ZQkvf5KSnkYHk4RuiN7dXQsFS4WgvuE2VSYVnSNHaoCJ4PRxMYrWFoff/va3
bsrqQqcD06VXg0dQp0eUYSaBW7duLU8CjFDmAaVRZ2Z8PXr0CBufLqLtM5Tm
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
QuBMCfz/3qWVxb6FP/MAAAAASUVORK5CYII=
' alt = 'Figure 4.1: Message Profile Identifier Mechanism' />
<figcaption>Figure 4.1: Message Profile Identifier Mechanism</figcaption>
</figure>

<p class='p_v2web'>
<p></p><p>The left-hand side of <span style="font-size:16px">Figure </span><span style="font-size:16px">4.</span><span style="font-size:16px">1</span> shows the message profile identifier as meta data that models the Entity Identifier (EI) data type. The field definition for MSH-21 is contained in the body of the message profile; the definitions in the meta data and the field must be compatible. The right-hand side of <span style="font-size:16px">Figure </span><span style="font-size:16px">4.</span><span style="font-size:16px">1</span> shows a message instance in which MSH-21 is claiming conformance to the message profile definition on the left-hand side of <span style="font-size:16px">Figure </span><span style="font-size:16px">4.</span><span style="font-size:16px">1</span>.</p><p>The message profile identifier is not limited to just the message profile; it can reference any of the following profile building blocks:</p><p>message profile (including a pre-coordinated profile identifier)</p><p>profile component (including the core profile component and differential component)</p><p>composite profile</p><p>value set library</p><p>In principle, all of these items can be managed the same way. The message profile identifier can be a list of any of these profile building blocks. For example, the specifier may wish to separate the message profile and the value set library. The message profile identifier in this case will contain two occurrences. The totality of both occurrences indicates the claim of conformance. Likewise, a complete profile can be described as a collection of profile components. For example, three profile components can be indicated in which one of the components is the core profile component and the others are profile components. See <span style="font-size:16px">S</span><span style="font-size:16px">ection </span><span style="font-size:16px">7.1</span> for more details on how profiles can be constructed.</p><p>The EI data type consists of the four components. EI.1 indicates the identifier of the profile artifact. EI.2 or (EI.3 and EI.4) establish the assigning authority for the identifier given in EI.1. This scheme gives the identifier uniqueness. EI.2 describes the common name of what is defined by EI.3 and EI.4 (and vice-versa). EI.2 alone, or EI.3 and EI.4, or all three elements can be used to specify the assigning authority of the identifier. If all three are defined, then EI.2 and the combination of EI.3 and EI.4 should refer to an equivalent concept. Typically, EI.3 is an OID that defines the assigning authority of the identifier.</p><p>Below is an example that shows the message profile identifier definition for a profile that consists of a national level profile with a separate identifier for the value set library. Together the two identifiers indicate the national level requirements for a message. Additionally, the example shows that a state (local) entity further constrained the profile for their refined use case. Together, all three identifiers indicate the complete set of requirements. The example also shows how a system could value MSH-21 in the message instance to convey the content of the message.</p><p></p>
</p>

<div class='box_v2web gray-box'>
<p class='p_v2web'>
<p><strong>Profile Definition</strong><strong>:</strong></p><p><span style="font-family:Courier New,Courier,monospace">&lt;MessageProfile&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&lt;CoreProfileID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp;&nbsp;&lt;EntityIdentifier&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">Profile_National_Level</span><span style="font-family:Courier New,Courier,monospace">&lt;/EntityIdentifier&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp;&nbsp;&lt;NamespaceID&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">Domain_XYZ</span><span style="font-family:Courier New,Courier,monospace">&lt;/NamespaceID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp; &lt;UniversalID&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">1.2.3.4.5</span><span style="font-family:Courier New,Courier,monospace">&lt;/UniversalID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp; &lt;UniversalIDType&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">ISO</span><span style="font-family:Courier New,Courier,monospace">&lt;/UniversalIDType&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp; &lt;/CoreProfileID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;ValueSetLibraryID&gt;&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp; </span><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;EntityIdentifier&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">VS_Library</span><span style="font-family:Courier New,Courier,monospace">&lt;/EntityIdentifier&gt;&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;</span><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;NamespaceID&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">Domain_XYZ</span><span style="font-family:Courier New,Courier,monospace">&lt;/NamespaceID&gt;&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;</span><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;UniversalID&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">1.2.3.4.5</span><span style="font-family:Courier New,Courier,monospace">&lt;/UniversalID&gt;&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;</span><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;UniversalIDType&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">ISO</span><span style="font-family:Courier New,Courier,monospace">&lt;/UniversalIDType&gt;&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;/ValueSetLibraryID&gt;&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp; &lt;ProfileComponentID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp;&nbsp;&lt;EntityIdentifier&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">State_Profile&nbsp;_Component</span><span style="font-family:Courier New,Courier,monospace">&lt;/EntityIdentifier&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp;&nbsp;&lt;NamespaceID&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">Domain_ABC</span><span style="font-family:Courier New,Courier,monospace">&lt;/NamespaceID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp; &lt;UniversalID&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">1.2.3.4.6</span><span style="font-family:Courier New,Courier,monospace">&lt;/UniversalID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp; &lt;UniversalIDType&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">ISO</span><span style="font-family:Courier New,Courier,monospace">&lt;/UniversalIDType&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp; &lt;/ProfileComponentID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&lt;/MessageProfile&gt;&nbsp;</span></p><p><strong>Message Instance</strong><strong>:</strong></p><p><span style="font-family:Courier New,Courier,monospace">Profile_National_Level^Domain_XYZ^1.2.3.4.5^ISO~</span><span style="font-family:Courier New,Courier,monospace">VS_Library</span><span style="font-family:Courier New,Courier,monospace">^Domain_</span><span style="font-family:Courier New,Courier,monospace">XYZ</span><span style="font-family:Courier New,Courier,monospace">^1.2.3.4.</span><span style="font-family:Courier New,Courier,monospace">5</span><span style="font-family:Courier New,Courier,monospace">^ISO</span><span style="font-family:Courier New,Courier,monospace">~</span><span style="font-family:Courier New,Courier,monospace">State_Profile_Component^Domain_ABC^1.2.3.4.6^ISO</span></p>
</p>

</div>

<p class='p_v2web'>
<p>The above example illustrates the grouping of three profile building blocks with an implied AND connector. The message profile identifier mechanism also supports an implied OR connector with the PreCoordinatedProfile element. For example, the above illustration also could have defined a single pre-coordinated identifier that refers to these three profile building blocks. See the illustration below.</p><p></p>
</p>

<div class='box_v2web gray-box'>
<p class='p_v2web'>
<p><strong>Profile Definition</strong><strong>:</strong></p><p><span style="font-family:Courier New,Courier,monospace">&lt;MessageProfile&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;PreCoordinatedProfile&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp; &lt;PreCoordinatedProfileID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;EntityIdentifier&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">State_Profile</span><span style="font-family:Courier New,Courier,monospace">&lt;/EntityIdentifier&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;NamespaceID&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">Domain_ABC</span><span style="font-family:Courier New,Courier,monospace">&lt;/NamespaceID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;UniversalID&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">1.2.3.4.6</span><span style="font-family:Courier New,Courier,monospace">&lt;/UniversalID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;UniversalIDType&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">ISO</span><span style="font-family:Courier New,Courier,monospace">&lt;/UniversalIDType&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp;&nbsp;&lt;/PreCoordinatedProfileID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">    </span><span style="font-family:Courier New,Courier,monospace">&lt;CoreProfileID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;EntityIdentifier&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">Profile_National_Level</span><span style="font-family:Courier New,Courier,monospace">&lt;/EntityIdentifier&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;NamespaceID&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">Domain_XYZ</span><span style="font-family:Courier New,Courier,monospace">&lt;/NamespaceID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp; </span><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;UniversalID&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">1.2.3.4.5</span><span style="font-family:Courier New,Courier,monospace">&lt;/UniversalID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp; </span><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;UniversalIDType&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">ISO</span><span style="font-family:Courier New,Courier,monospace">&lt;/UniversalIDType&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp; </span><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;/CoreProfileID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">    </span><span style="font-family:Courier New,Courier,monospace">&lt;ValueSetLibraryID&gt;&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp; </span><span style="font-family:Courier New,Courier,monospace">    </span><span style="font-family:Courier New,Courier,monospace">&lt;EntityIdentifier&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">VS_Library</span><span style="font-family:Courier New,Courier,monospace">&lt;/EntityIdentifier&gt;&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;</span><span style="font-family:Courier New,Courier,monospace">    </span><span style="font-family:Courier New,Courier,monospace">&lt;NamespaceID&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">Domain_XYZ</span><span style="font-family:Courier New,Courier,monospace">&lt;/NamespaceID&gt;&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;</span><span style="font-family:Courier New,Courier,monospace">    </span><span style="font-family:Courier New,Courier,monospace">&lt;UniversalID&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">1.2.3.4.5</span><span style="font-family:Courier New,Courier,monospace">&lt;/UniversalID&gt;&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;</span><span style="font-family:Courier New,Courier,monospace">    </span><span style="font-family:Courier New,Courier,monospace">&lt;UniversalIDType&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">ISO</span><span style="font-family:Courier New,Courier,monospace">&lt;/UniversalIDType&gt;&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">    </span><span style="font-family:Courier New,Courier,monospace">&lt;/ValueSetLibraryID&gt;&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp; </span><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;ProfileComponentID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;EntityIdentifier&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">State_Profile&nbsp;_Component</span><span style="font-family:Courier New,Courier,monospace">&lt;/EntityIdentifier&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp;&nbsp;</span><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;NamespaceID&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">Domain_ABC</span><span style="font-family:Courier New,Courier,monospace">&lt;/NamespaceID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp; </span><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;UniversalID&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">1.2.3.4.6</span><span style="font-family:Courier New,Courier,monospace">&lt;/UniversalID&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp;&nbsp;&nbsp; </span><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;UniversalIDType&gt;</span><span style="color:#c00000; font-family:Courier New,Courier,monospace">ISO</span><span style="font-family:Courier New,Courier,monospace">&lt;/UniversalIDType&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&nbsp; </span><span style="font-family:Courier New,Courier,monospace">  </span><span style="font-family:Courier New,Courier,monospace">&lt;/ProfileComponentID&gt;</span></p><p><span style="font-size:13px">  </span><span style="font-family:Courier New,Courier,monospace">&lt;PreCoordinatedProfile&gt;</span><span style="font-family:Courier New,Courier,monospace">&nbsp;</span></p><p><span style="font-family:Courier New,Courier,monospace">&lt;/MessageProfile&gt;&nbsp;</span></p><p><strong>Message Instance</strong><strong>:</strong></p><p><span style="font-family:Courier New,Courier,monospace">State_Profile^Domain_ABC^1.2.3.4.6^ISO</span></p><p><span style="font-family:Courier New,Courier,monospace"><strong>OR</strong></span></p><p><span style="font-family:Courier New,Courier,monospace">Profile_National_Level^Domain_XYZ^1.2.3.4.5^ISO~</span><span style="font-family:Courier New,Courier,monospace">VS_Library</span><span style="font-family:Courier New,Courier,monospace">^Domain_</span><span style="font-family:Courier New,Courier,monospace">XYZ</span><span style="font-family:Courier New,Courier,monospace">^1.2.3.4.</span><span style="font-family:Courier New,Courier,monospace">5</span><span style="font-family:Courier New,Courier,monospace">^ISO</span><span style="font-family:Courier New,Courier,monospace">~</span><span style="font-family:Courier New,Courier,monospace">State_Profile_Component^Domain_ABC^1.2.3.4.6</span><span style="font-family:Courier New,Courier,monospace">^ISO</span></p>
</p>

</div>

<p class='p_v2web'>
<p></p><p>This example shows a definition of a pre-coordinated profile and its constituent parts. Systems can convey the message content in MSH-21 by either indicating the pre-coordinated identifier or the three identifiers for the parts of the profile. Combining profile parts can continue indefinitely to a practical limit. For example, a profile component can be added to the pre-coordinated profile in the previous example to address a different, but closely related, use case. The identifiers can be specified separately, or another pre-coordinated identifier could be created.</p>
</p>
<h3>
4.2 Message Level Profiling
</h3>
<p class='p_v2web'>
<p><span style="font-size:16px">Table 4.2</span> illustrates an abbreviated specification of a message definition as given in the base standard. <span style="font-size:16px">Table 4.3</span> shows an example of a profiled version of that message definition.</p><p></p>
</p>

<table class='center striped-rows table_v2web1'>
<tbody>
<caption>Table 4.2: Example of Base Standard Message Level Definition</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace"><strong>Segments</strong></span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace"><strong>Description</strong></span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace"><strong>Status</strong></span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace"><strong>Chapter</strong></span>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">MSH</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Message Header Segment</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">2</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">[{ SFT }]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Software</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">2</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">[  UAC  ]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">User Authentication Credential</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">2</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">PID</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Patient Identification Segment</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">3</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">[  PD1  ]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Additional Demographics</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">3</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">[{ NK1 }]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Next of Kin/Associated Parties</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">3</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Courier New,Courier,monospace"><strong>...</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">[{ </span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">--- ORDER begin</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">      ORC</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Common Order</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">4</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">    [{PRT}]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Participation (for ORC)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">7</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">   [{ </span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">--- TIMING begin</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">         TQ1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Timing/Quantity</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">4</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">      [{ TQ2 }]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Timing/Quantity Order Sequence</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">4</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">   }]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">--- TIMING end</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">      RXA</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Pharmacy Administration Segment</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">4A</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">   [  RXR  ]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Pharmacy Route</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">4A</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">   [{ </span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">--- OBSERVATION begin</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">         OBX</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Observation/Result</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">7</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">      [{ PRT </span><span style="font-size:12px; font-family:Courier New,Courier,monospace">}</span><span style="font-size:12px; font-family:Courier New,Courier,monospace">]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Participation (for Observation)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">7</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">      [{ NTE }]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Notes (Regarding Immunization)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">2</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">   }]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">--- OBSERVATION end</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">}</span><span style="font-size:12px; font-family:Courier New,Courier,monospace">]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">--- ORDER end</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p>The <strong>Segment column</strong> represents the abstract message definition as defined in the base standard, not the profiled definition. Specifiers may choose to represent the segment columns differently but must maintain the original list of segments. A second column may be added to include segment flavors. For example, if an optional segment in the abstract message definiton is constrained to required with a cardinality of 1…1, then the identifier of the segment flavor is given. The specfier may choose to mark segments that need to be supported in bold. A segment flavor indicates that the segment definition has been constrained. The segment-flavor identifier provides a convenient mechanism to manage and reference segments. If the segment was not constrained, then the base standard segment identifier is given.</p><p>The Usage column must be included and reflect the usage of the segment or segment group for this message-structured definition.</p><p>The Cardinality column must be included and reflect the minimum and maximum number of occurences allowed for the segment or segment group for the message-structured definition.</p><p><strong>Additional</strong> column headings, such as Referenced Chapter or Comments, may be specified. Conformance Statements and Condition Predicates (if any) also may be included as a column heading or be specified as separate tables immediately following the message-structured defintion table. <span style="font-size:16px">Table 4.</span><span style="font-size:16px">4</span> shows conformance statement defintions.</p>
</p>

<table class='center striped-rows table_v2web1'>
<tbody>
<caption>Table 4.3: Example of Profiled Message Level Definition</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Courier New,Courier,monospace"><strong>Segment</strong></span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Courier New,Courier,monospace">Segment Flavor</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Courier New,Courier,monospace">Description</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Courier New,Courier,monospace">Usage</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Courier New,Courier,monospace">Cardinality</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Courier New,Courier,monospace">Chapter</span>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">MSH</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace"><strong>M</strong></span><span style="font-size:12px; font-family:Courier New,Courier,monospace"><strong>S</strong></span><span style="font-size:12px; font-family:Courier New,Courier,monospace"><strong>H_IZ</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Message Header Segment</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[1..1]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">2</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">[{SFT}]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">SFT</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Software</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[0..0]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">2</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">[UAC]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">UAC</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">User Authentication Credential</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[0..</span><span style="font-family:Courier New,Courier,monospace">1</span><span style="font-family:Courier New,Courier,monospace">]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">2</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">PID</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace"><strong>PID_IZ</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Patient Identification Segment</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[1..1]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">3</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">[PD1]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace"><strong>PD1_IZ_01</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Additional Demographics</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">R</span><span style="font-size:13px">E</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[</span><span style="font-family:Courier New,Courier,monospace">0</span><span style="font-family:Courier New,Courier,monospace">..1]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">3</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">[{NK1}]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace"><strong>NK1_IZ</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Next of Kin/Associated Parties</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">RE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[0..</span><span style="font-family:Courier New,Courier,monospace">1</span><span style="font-family:Courier New,Courier,monospace">]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">3</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Courier New,Courier,monospace"><strong>...</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">[{ </span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">--- ORDER begin</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[</span><span style="font-family:Courier New,Courier,monospace">1</span><span style="font-family:Courier New,Courier,monospace">..</span><span style="font-family:Courier New,Courier,monospace">*</span><span style="font-family:Courier New,Courier,monospace">]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">7</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">  ORC</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace"><strong>ORC_IZ_01</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Common Order</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[</span><span style="font-family:Courier New,Courier,monospace">1..1</span><span style="font-family:Courier New,Courier,monospace">]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">2</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace"> </span><span style="font-size:12px; font-family:Courier New,Courier,monospace"> </span><span style="font-size:12px; font-family:Courier New,Courier,monospace">[{PRT}]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">PRT</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Participation (for ORC)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[0..1]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">3</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">  [{ </span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">--- TIMING begin</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[0..</span><span style="font-family:Courier New,Courier,monospace">1</span><span style="font-family:Courier New,Courier,monospace">]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">3</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">      TQ1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">TQ1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Timing/Quantity</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[</span><span style="font-family:Courier New,Courier,monospace">1</span><span style="font-family:Courier New,Courier,monospace">..1]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">7</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace"> </span><span style="font-size:12px; font-family:Courier New,Courier,monospace">   </span><span style="font-size:12px; font-family:Courier New,Courier,monospace">[{TQ2}]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">TQ2</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Timing/Quantity Order Seq</span><span style="font-size:12px; font-family:Courier New,Courier,monospace">uence</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[0..</span><span style="font-family:Courier New,Courier,monospace">*</span><span style="font-family:Courier New,Courier,monospace">]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">7</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">   }]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">--- TIMING end</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">  RXA</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace"><strong>RXA</strong></span><span style="font-size:12px; font-family:Courier New,Courier,monospace"><strong>_IZ_01</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Pharmacy Administration Segment</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[</span><span style="font-family:Courier New,Courier,monospace">1</span><span style="font-family:Courier New,Courier,monospace">..</span><span style="font-family:Courier New,Courier,monospace">1</span><span style="font-family:Courier New,Courier,monospace">]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">4</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">  </span><span style="font-size:12px; font-family:Courier New,Courier,monospace">[</span><span style="font-size:12px; font-family:Courier New,Courier,monospace">RXR]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace"><strong>RXR</strong></span><span style="font-size:12px; font-family:Courier New,Courier,monospace"><strong>_IZ</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Pharmacy Route</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">RE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[0..1]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">4</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">  [{ </span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">--- OBSERVATION begin</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">RE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[0..</span><span style="font-family:Courier New,Courier,monospace">*</span><span style="font-family:Courier New,Courier,monospace">]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">    OBX</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace"><strong>OBX</strong></span><span style="font-size:12px; font-family:Courier New,Courier,monospace"><strong>_IZ_02</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Observation/Result</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[</span><span style="font-family:Courier New,Courier,monospace">1..1</span><span style="font-family:Courier New,Courier,monospace">]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">7</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace"> </span><span style="font-size:12px; font-family:Courier New,Courier,monospace"> </span><span style="font-size:12px; font-family:Courier New,Courier,monospace">  </span><span style="font-size:12px; font-family:Courier New,Courier,monospace">[{PRT</span><span style="font-size:12px; font-family:Courier New,Courier,monospace">}</span><span style="font-size:12px; font-family:Courier New,Courier,monospace">]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">PRT</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Participation (for Observation)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[0..</span><span style="font-family:Courier New,Courier,monospace">*</span><span style="font-family:Courier New,Courier,monospace">]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">7</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace"> </span><span style="font-size:12px; font-family:Courier New,Courier,monospace">   </span><span style="font-size:12px; font-family:Courier New,Courier,monospace">[{NTE}]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">NTE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">Notes (Regarding Immunization)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">[0..</span><span style="font-family:Courier New,Courier,monospace">1</span><span style="font-family:Courier New,Courier,monospace">]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">3</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">  }]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">--- OBSERVATION end</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">}</span><span style="font-size:12px; font-family:Courier New,Courier,monospace">]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">--- ORDER end</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 4.4: Example of Profiled Conformance Statement &ndash; Message Level</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='2'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace"><strong>Message Level Conformance Statements</strong></span>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">IZ</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">-</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">205</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">If OBX-3.1 (Identifier) contains the value ‘59785-6&rsquo; (Indication for Immunization) then RXA-20 (Completion Status) in the same Order group SHALL contain one of the values in the list:</span><span style="font-size:13px; font-family:Courier New,Courier,monospace"> </span><span style="font-size:13px; font-family:Courier New,Courier,monospace">{CP,</span><span style="font-size:13px; font-family:Courier New,Courier,monospace"> </span><span style="font-size:13px; font-family:Courier New,Courier,monospace">PA}. </span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">IZ-206</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">If OBX-3.1 (Identifier) contains the value ‘30945-0&rsquo; (Vaccination contraindication/precaution) then RXA-20 (Completion Status) in the same Order group SHALL contain the value ‘NA&rsquo;. </span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>
<h4>
4.2.1 
</h4>
<h3>
4.3 Segment Level Profiling
</h3>
<p class='p_v2web'>
<p><span style="font-size:16px">Table 4.5</span> shows the RXA segment definition as it appears in the HL7 v2.8.2 standard. <span style="font-size:16px">Table 4.6</span> shows an example of how the profiled segment definition (RXA_IZ_01) can be displayed. The segment flavor (specialization) identifier (RXA_IZ_01) is used in the message definition to indicate that this specialization of the RXA segment is to be used.</p><p></p>
</p>

<table class='center striped-rows table_v2web1'>
<tbody>
<caption>Table 4.5: Example Base Segment Definition &ndash; RXA Segment</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">SEQ</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">LEN</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">C.LEN</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">DT</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">OPT</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">RP/#</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">TBL#</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">ITEM #</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">ELEMENT NAME</span>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">4=</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">NM</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">00342</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Give Sub-ID Counter</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">2</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">4=</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">NM</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">00344</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administration Sub-ID Counter</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">3</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">DTM</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">00345</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Date/Time Start of Administration</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">4</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">DTM</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">00346</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Date/Time End of Administration</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">5</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">0292</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">00347</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Code</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">6</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">NM</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">00348</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Amount</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">7</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">C</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">9999</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">00349</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Units</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">8</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">9999</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">00350</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Dosage Form</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">9</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Y</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">9999</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">00351</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administration Notes</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">10</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">XCN</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">B</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Y</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">00352</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administering Provider</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">11</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">W</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">00353</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered-at Location</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">12</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">20=</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">ST</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">C</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">00354</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Per (Time Unit)</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">13</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">NM</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">01134</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Strength</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">14</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">9999</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">01135</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Strength Units</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">15</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">20=</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">ST</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Y</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">01129</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Substance Lot Number</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">16</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">DTM</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Y</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">01130</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Substance Expiration Date</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">17</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Y</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">0227</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">01131</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Substance Manufacturer Name</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">18</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Y</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">9999</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">01136</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Substance/Treatment Refusal Reason</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">19</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Y</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">9999</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">01123</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Indication</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">20</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">2..2</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">ID</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">0322</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">01223</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Completion Status</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">21</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">1..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">ID</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0206</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">01224</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Action Code &ndash; RXA</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">22</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">DTM</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">01225</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">System Entry Date/Time</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">23</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">5=</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">NM</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">01696</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Drug Strength Volume</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">24</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">9999</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">01697</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Drug Strength Volume Units</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">25</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">9999</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">01698</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Barcode Identifier</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">26</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">1..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">ID</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">0480</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">01699</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Pharmacy Order Type</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">27</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">PL</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">02264</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administer-at</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">28</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">XAD</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">02265</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered-at Address</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>The specifier has chosen to present the segment flavor definition with a field sequence identifier, element name, data type (that includes any flavor), usage, cardinality, vocabulary binding (including concept domain, code system, or value set binding), minimum and maximum length, conformance length, and comments. If content constraints (e.g., fixed values) existed, a column for them could have been added.</p><p></p>
</p>
<h4>
4.3.1 
</h4>
<table class='center striped-rows table_v2web1'>
<tbody>
<caption>Table 4.6: Sample Profile Segment Definition &ndash; RXA Segment (RXA_IZ)</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">SEQ</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">ELEMENT NAME</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">D</span><span style="font-family:Courier New,Courier,monospace">ata Type</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Usage</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Card.</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Vocab</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">LEN</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">C.LEN</span>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Comments</span>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Give Sub-ID Counter</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">NM</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">1..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">2</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administration Sub-ID Counter</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">NM</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">1..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">3</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Date/Time Start of Administration</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">DTM</span><span style="font-family:Courier New,Courier,monospace">_IZ02</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">1..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">4</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Date/Time End of </span><span style="font-family:Courier New,Courier,monospace">Administration</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">DTM</span><span style="font-family:Courier New,Courier,monospace">_IZ02</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">1..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">5</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Code</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span><span style="font-family:Courier New,Courier,monospace">_IZ01</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">1..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">CVX</span><span style="font-size:12px; font-family:Courier New,Courier,monospace">_01</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">6</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Amount</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">NM</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">1..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">1..16</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">7</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Units</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span><span style="font-family:Courier New,Courier,monospace">_IZ01</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">C</span><span style="font-family:Courier New,Courier,monospace">(R/X)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">UCUM_01</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">8</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Dosage Form</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">9</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administration Notes</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span><span style="font-family:Courier New,Courier,monospace">_IZ01</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">C(R/O)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">NIP001_01</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">10</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administering Provider</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">XCN</span><span style="font-family:Courier New,Courier,monospace">_IZ01</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">C(RE/O)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">11</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered-at Location</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..0</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..0</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">12</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Per (Time Unit)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">ST</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">C</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">13</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Strength</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">NM</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">14</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Strength Units</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">9999</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">15</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Substance Lot Number</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">ST</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">C(R/O)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..*</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">20=</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">16</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Substance Expiration Date</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">DTM</span><span style="font-family:Courier New,Courier,monospace">_</span><span style="font-family:Courier New,Courier,monospace">IZ03</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">C(RE/O)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">17</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Substance Manufacturer Name</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span><span style="font-family:Courier New,Courier,monospace">_IZ01</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">C(R/O)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">MVX</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">18</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Substance/Treatment Refusal Reason</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span><span style="font-family:Courier New,Courier,monospace">_IZ01</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">C(R/X)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..*</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">9999</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">19</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Indication</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">9999</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">20</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Completion Status</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">ID</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">RE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">0322</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">2..2</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">21</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Action Code &ndash; RXA</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">ID</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">C(R/X)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0206</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">1..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">22</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">System Entry Date/Time</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">DTM</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">23</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Drug Strength Volume</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">NM</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">24</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Drug Strength Volume Units</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">9999</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">25</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Barcode Identifier</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">CWE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">9999</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">26</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Pharmacy Order Type</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">ID</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:12px; font-family:Courier New,Courier,monospace">0480</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">27</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administer-at</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">PL</span><span style="font-family:Courier New,Courier,monospace">_IZ01</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">C(RE/O)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">28</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered-at Address</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">XAD</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">29</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">Administered Tag Identifier</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">EI</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-family:Courier New,Courier,monospace">0..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

</tbody>
</table>

<table class='center striped-rows table_v2web1'>
<tbody>
<caption>Table 4.7: Example of Profiled Condition Predicate &ndash; Segment Level</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='3'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace"><strong>Condition Predicates</strong></span>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace"><strong>Location</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace"><strong>Usage</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace"><strong>Predicate</strong></span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">RXA-7</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">C(R/X)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">If RXA-6(Administered Amount) does not contain the value &#39;999&#39;.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">RXA-9</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">C(R/O)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">If RXA-20(Completion Status) contain</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">s</span><span style="font-size:13px; font-family:Courier New,Courier,monospace"> one of the values in the list:</span><span style="font-size:13px; font-family:Courier New,Courier,monospace"> </span><span style="font-size:13px; font-family:Courier New,Courier,monospace">{CP,PA}.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">RXA-10</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">C(RE/O)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">If RXA-9.1(Identifier) contain</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">s</span><span style="font-size:13px; font-family:Courier New,Courier,monospace"> the value &#39;00&#39; AND RXA-20(Completion Status) contain</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">s</span><span style="font-size:13px; font-family:Courier New,Courier,monospace"> one of the values in the list: {CP,PA}.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">RXA-15</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">C(R/O)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">If RXA-9.1(Identifier) contain</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">s</span><span style="font-size:13px; font-family:Courier New,Courier,monospace"> the value &#39;00&#39; AND RXA-20(Completion Status) contain</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">s</span><span style="font-size:13px; font-family:Courier New,Courier,monospace"> one of the values in the list:</span><span style="font-size:13px; font-family:Courier New,Courier,monospace"> </span><span style="font-size:13px; font-family:Courier New,Courier,monospace">{CP,PA}.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">RXA-16</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">C(RE/O)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">If RXA-9.1(Identifier) contain</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">s</span><span style="font-size:13px; font-family:Courier New,Courier,monospace"> the value &#39;00&#39; AND RXA-20(Completion Status) contain</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">s</span><span style="font-size:13px; font-family:Courier New,Courier,monospace"> one of the values in the list:</span><span style="font-size:13px; font-family:Courier New,Courier,monospace"> </span><span style="font-size:13px; font-family:Courier New,Courier,monospace">{CP,PA}.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">RXA-17</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">C(R/O)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">If RXA-9.1(Identifier) contain</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">s</span><span style="font-size:13px; font-family:Courier New,Courier,monospace"> the value &#39;00&#39; AND RXA-20(Completion Status) contain</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">s</span><span style="font-size:13px; font-family:Courier New,Courier,monospace"> one of the values in the list:</span><span style="font-size:13px; font-family:Courier New,Courier,monospace"> </span><span style="font-size:13px; font-family:Courier New,Courier,monospace">{CP,PA}.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">RXA-18</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">C(R/X)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">If RXA-20(Completion Status) contain</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">s</span><span style="font-size:13px; font-family:Courier New,Courier,monospace"> the value &#39;RE&#39;.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">RXA-21</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">C(R/X)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">If RXA-5.1(Identifier) does not contain the value &#39;998&#39;.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">RXA-27</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">C(RE/O)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">If RXA-9.1(Identifier) does contain the value &#39;00&#39; AND RXA-20(Completion Status) does contain one of the values in the list:</span><span style="font-size:13px; font-family:Courier New,Courier,monospace"> </span><span style="font-size:13px; font-family:Courier New,Courier,monospace">{CP,PA}.</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p><span style="font-size:16px">Table 4.8</span> shows the list of conformance statements associated with the segment. <span style="font-size:16px">Appendix B</span> provides an example (and recommended) conformance statement language.</p><p></p>
</p>

<table class='center striped-rows table_v2web1'>
<tbody>
<caption>Table 4.8: Example of Profiled Conformance Statement &ndash; Segment Level</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='2'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace"><strong>Conformance Statements</strong></span>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">IZ-207</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">If RXA-20 (Completion Status) contains the value &#39;RE&#39; then RXA-5.1 (Identifier) SHALL NOT contain the value &#39;998&#39;.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">IZ-30</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">RXA-4 (Date/Time End of Administration) SHALL be identical RXA-3(Date/Time Start of Administration).</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">IZ-32</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">If RXA-18 (Substance/Treatment Refusal Reason) is valued then RXA-20 (Completion Status) SHALL contain the value &#39;RE&#39;.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">IZ-48</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">If RXA-20 (Completion Status) contains the value &#39;RE&#39; then RXA-6 (Administered Amount) SHALL contain the value &#39;999&#39;.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">IZ-49</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">If RXA-5.1 (Identifier) contains the value &#39;998&#39; then RXA-6 (Administered Amount) SHALL contain the value &#39;999&#39;.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">RXA_IZ_01-1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">RXA-1(Give Sub-ID Counter) SHALL contain the value &#39;0&#39;.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">RXA_IZ_01-2</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">RXA-2(Administration Sub-ID Counter) SHALL contain the value &#39;1&#39;.</span>
</p>

</td>

</tr>

</tbody>
</table>

<div class='box_v2web gray-box'>
<p class='p_v2web'>
<p><span style="color:#000000"><strong>…</strong></span></p><p><span style="color:#000000"><strong>RXA-3: Date/Time Start of Administration (DTM_IZ02)</strong></span></p><p><span style="color:#000000">The date this vaccination occurred. In the case of a contraindication, refusal</span><span style="color:#000000">,</span><span style="color:#000000"> or deferral, this is the date the action occurred.</span></p><p><span style="color:#000000"><strong>RXA-4: Date/Time End of Administration (DTM_IZ02)</strong></span></p><p><span style="color:#000000">This field is specified as required in the HL7 base standard. An immunization is given at a point in time, and</span><span style="color:#000000">,</span><span style="color:#000000"> in the context of immunization, the End date/time is equivalent to the Start date/time. For this reason, this document has required this field to be equal to RXA-3.</span></p><p><span style="color:#000000"><strong>RXA-5: Administered Code (CWE_IZ01)</strong></span></p><p><span style="color:#000000">This field identifies the medical substance administered. If the substance administered is a vaccine, CVX and NDC codes </span><span style="color:#000000">typically </span><span style="color:#000000">are used for historical and new administrations respectively. The second set of three components may be used to represent the same vaccine using a different coding system.</span></p><p><span style="color:#000000"><strong>RXA-6: Administered Amount (NM)</strong></span></p><p><span style="color:#000000">This field records the amount of vaccine administered. The units are expressed in the next field, RXA-7. When the administered amount is unknown, this field should be populated with the value &quot;999&quot;.</span></p><p><span style="color:#000000"><strong>RXA-9: Administration Notes (CWE_IZ01)</strong></span></p><p><span style="color:#000000">This field is used to indicate whether this immunization record is based on a historical record or is being reported by the administering provider.</span></p><p><span style="font-family:Arial,Helvetica,sans-serif"><strong>…</strong></span></p>
</p>

</div>
<h3>
4.4 Data Type Profiling
</h3>
<p class='p_v2web'>
<p>Components and sub-components are constrained in the context of data type specializations; that is, a component or sub-component should not be constrained directly in their context of use. Rather, they are constrained in the context of a data type specialization, and that specialization is used in context, either at the field level or as a complex data type.</p><p>Data type profiling entails constraining the components of a data type. The two cases where this profiling applies are related to primitive components and complex components:</p><p></p><p>The data type specification is displayed in a table form. <span style="font-size:16px">Table 4.9</span> shows a data type definition (XON) as given in the base standard. <span style="font-size:16px">Table 4.10</span> shows an example of the data type specialization (XON_IZ01) of the XON data type.  </p><p></p>
</p>

<table class='center striped-rows table_v2web1'>
<tbody>
<caption>Table 4.9: XON Data Type Definition in Base Standard</caption>
<tr class='tr_v2web'>
<th class='table_v2web1 th_v2web' colspan='9'>
<p class='p_v2web'>
XON DATA TYPE
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
SEQ
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
LEN
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
C.LEN
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
DT
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
OPT
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
TBL#
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Name
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Comments
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
SEC.REF.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">50#</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">ST</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Organization Name</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">2.A.76</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">2</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">CWE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">0204</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Organization Name Type Code</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">2.A.</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">3</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">6</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">3</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">W</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">ID Number</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Withdrawn as of v2.7.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">4</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">W</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Identifier Check Digit</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Withdrawn as of v2.7.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">5</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">W</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Check Digit Scheme </span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Withdrawn as of v2.7.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">6</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">HD</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">0363</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Assigning Authority</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">2.A.</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">33</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">7</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">2..5</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">ID</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">0203</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Identifier Type Code</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">2.A.</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">35</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">8</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">HD</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Assigning Facility</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">2.A.</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">33</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">9</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">1..1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">ID</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">0465</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Name Representation Code</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">2.A.</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">35</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">10</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">ST</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Organization Identifier</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">2.A.</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">76</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>As shown, the specifier did not include all columns as given in the base standard. If constraints are unspecified in the profile, then the requirements, or associated information of the profile from which it was derived, apply (in this case, the base standard). </p><p></p>
</p>

<table class='center striped-rows table_v2web1'>
<tbody>
<caption>Table 4.10: XON Data Type Definition Constrained in Profile</caption>
<tr class='tr_v2web'>
<th class='table_v2web1 th_v2web' colspan='5'>
<p class='p_v2web'>
XON_IZ01 DATA TYPE
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
SEQ
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Name
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
DT
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Usage
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Vocab
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">1</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Organization Name</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">ST</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">RE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">2</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Organization Name Type Code</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">CWE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">3</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">ID Number</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">4</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Identifier Check Digit</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">5</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Check Digit Scheme </span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">6</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Assigning Authority</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">HD</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">_IZ01</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">C(R/X)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">7</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Identifier Type Code</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">ID</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">C(R/X)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">0203</span><span style="font-size:13px; font-family:Courier New,Courier,monospace">_02</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">8</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Assigning Facility</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">HD</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">9</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Name Representation Code</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">ID</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">O</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">10</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">Organization Identifier</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">ST</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace">C(R/RE)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p><span style="font-size:16px">Table 4.11</span> shows the list of condition predicates for the data type specialization. The implementation guide and the message profile can define multiple data type specializations for the same data type.</p><p> </p>
</p>

<table class='center striped-rows table_v2web1'>
<tbody>
<caption>Table 4.11: XON Data Type Definition Constrained in Profile</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='3'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace"><strong>Condition Predicates</strong></span>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace"><strong>Location</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace"><strong>Usage</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Courier New,Courier,monospace"><strong>Predicate</strong></span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">XON.6</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">C(R/X)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">If XON.10(Organization Identifier) is valued</span><span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">XON.7</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">C(R/X)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">If XON.10(Organization Identifier) is valued</span><span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">XON.10</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">C(R/RE)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">If XON.1(Organization Name) is not valued</span><span style="font-size:13px; color:#000000; font-family:Courier New,Courier,monospace">.</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>
<h3>
4.5 Primitive Element Profiling
</h3>
<p class='p_v2web'>
<p>Primitive elements are those elements that are leaf nodes (i.e., they carry the data). Primitive data elements that appear at a field, component, or sub-component level can apply the following constraints:</p>
</p>
<h3>
4.6 Differential Profiles
</h3>
<p class='p_v2web'>
<p>An alternative form of documenting a profile is to include only the differential between the constrained profile and a baseline (starting) profile. The baseline profile may be the HL7 v2 base standard or a message profile. For example, a local jurisdiction profile (e.g., state of Maryland) can be created from a national level profile (US Realm profile). The state of Maryland profile could be expressed as a differential to the US Realm profile. The same profiling mechanisms expressed in the earlier section can be used but would only express the elements that differ from the baseline profile. For example, if only two fields were modified in a segment definition, then only those two fields (rows) would be expressed in the segment table definition. A Differential Profile may be represented as a profile component. The complete, i.e., the Composite Profile, can be created by &ldquo;overlaying&rdquo; the differential profile &ldquo;on&rdquo; the baseline profile.</p>
</p>
<h3>
4.7 Extensions
</h3>
<p class='p_v2web'>
<p>Extensions provide a mechanism for specifying a concept (e.g., a data element) that is not expressed in the base standard but is needed for a particular use case. This mechanism allows for new concepts to be specified in an &ldquo;as needed&rdquo; manner to support particular implementations. HL7 v2 supports extensions via the &ldquo;Z&rdquo; mechanism in which Z messages, Z segments, Z fields, and Z data types can be created. Creation of locally defined vocabulary is supported by the base standard natively. The use of Z elements in message profile definitions must be specified using the constraint mechanisms defined in this document.</p><p>When using extensions, the data elements should be described and documented sufficiently in a profile such that trading partners can reach a common understanding. Extensions should not be used in cases where a concept already exists in the base standard. The base standard provides a common method for defining extensions, thus ensuring consistent application of the mechanism; these rules must be adhered to in the message profile.</p><p></p>
</p>
