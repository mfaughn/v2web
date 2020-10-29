<h2>
13 Appendix B: Conformance Statement Definition Language
</h2>
<p class='p_v2web'>
<p>Certain conformance-statement patterns have emerged and can be documented in a &ldquo;pseudo&rdquo; language. The pseudo language provides the mechanisms to construct conformance statements in a manner that provides the readability of a natural language while being machine computable. The outcome is a set of conformance-statement patterns and building blocks that provides a mechanism for specifiers to create and use a set of conformance statements. Using the conformance statements language provides consistency within and across HL7 v2 implementation guides. The pseudo language is not comprehensive (nor formal) and is intended for use in HL7 v2 for convenience. Constraints that cannot be represented within the pseudo language are written in &ldquo;free-text&rdquo;. Free-text conformance statements are not conducive to automated machine computability. Computability greatly enhances processing of the constraints used, for example, in validation tools. The HL7 v2 Pseudo Constraint Language is the preferred constraint language for HL7 v2 message profiles but is not required.</p><p>The HL7 v2 Pseudo Constraint Language is composed of building blocks that are linked together to create conformance statements. The building blocks include:</p><p></p><p>Element Location</p><p>Propositions</p><p>Context</p><p>Conformance Verbs</p><p>Declarative Statements</p><p>Occurrence Declarative Statement (ODS)</p><p>Content Declarative Statement (CDS)</p><p>Comparison Content Declarative Statement (CCDS)</p><p>Connectors</p><p></p><p>An example template for the conformance-statement builder is given below:</p>
</p>

<div class='box_v2web gray-box'>
<p class='p_v2web'>
<p><span style="color:#000000"><strong>C</strong></span><span style="color:#000000"><strong>onformance Statement </strong></span><span style="color:#000000"><strong>Example</strong></span><span style="color:#000000"><strong> using a template pattern</strong></span><span style="color:#000000"><strong>:</strong></span><span style="color:#000000"> </span></p><p><span style="font-family:Arial,Helvetica,sans-serif">IF </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">LOCATION (DESCRIPTION) </span><span style="font-family:Arial,Helvetica,sans-serif">contains the value </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">&#39;VALUE&#39;</span><span style="font-family:Arial,Helvetica,sans-serif">, THEN</span><span style="font-family:Arial,Helvetica,sans-serif"> </span><span style="font-family:Arial,Helvetica,sans-serif">at least one occurrence of</span><span style="font-family:Arial,Helvetica,sans-serif"> </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">LOCATION (DESCRIPTION)</span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif"> </span><span style="font-family:Arial,Helvetica,sans-serif">of the </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">SEGMENT</span><span style="font-family:Arial,Helvetica,sans-serif"> segment</span><span style="font-family:Arial,Helvetica,sans-serif"> </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">VERB</span><span style="font-family:Arial,Helvetica,sans-serif"> </span><span style="font-family:Arial,Helvetica,sans-serif">contain the value </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">‘VALUE&rsquo;</span><span style="font-family:Arial,Helvetica,sans-serif">.</span></p><p></p><p><strong>Instance </strong><strong>Example:</strong></p><p><span style="font-family:Arial,Helvetica,sans-serif">IF </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">MSA-1 (Acknowledgment Code) </span><span style="font-family:Arial,Helvetica,sans-serif">contains the value </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">&#39;AR&#39;</span><span style="font-family:Arial,Helvetica,sans-serif">, THEN</span><span style="font-family:Arial,Helvetica,sans-serif"> </span><span style="font-family:Arial,Helvetica,sans-serif">at least one occurrence of</span><span style="font-family:Arial,Helvetica,sans-serif"> </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">ERR-4 (Severity)</span><span style="font-family:Arial,Helvetica,sans-serif"> </span><span style="font-family:Arial,Helvetica,sans-serif">of the </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">ERR</span><span style="font-family:Arial,Helvetica,sans-serif"> segment</span><span style="font-family:Arial,Helvetica,sans-serif"> </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">SHALL</span><span style="font-family:Arial,Helvetica,sans-serif"> </span><span style="font-family:Arial,Helvetica,sans-serif">contain the value </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">‘E&rsquo;</span><span style="font-family:Arial,Helvetica,sans-serif">.</span></p>
</p>

</div>

<p class='p_v2web'>
<p></p><p><span style="font-size:16px">Table 13.1</span> shows the template pattern broken up into its building-block parts. Additionally, a usage is given for each building block. Some building blocks are a part of all conformance statements (required), and others may be part of the conformance statement (optional).</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 13.1: Conformance Statement Template</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Pattern</strong><strong> Part</strong>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Template Example</strong>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Example</strong>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Usage</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Proposition
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
IF <span style="color:#c00000">LOCATION (DESCRIPTION) </span>contains the value <span style="color:#c00000">&#39;VALUE&#39;</span>, THEN
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
IF MSA-1 (Acknowledgment Code) contains the value &#39;AR&#39;, THEN
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Optional
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
ODS
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
at least one occurrence of
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
at least one occurrence of
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
Optional
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Location
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#c00000">LOCATION (DESCRIPTION)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
ERR-4 (Severity)
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Required
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
Context
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
of the <span style="color:#c00000">SEGMENT</span> segment
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
of the ERR segment
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
Optional
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Verb
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#c00000">VERB</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
SHALL
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Required
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
CDS or CCDS
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
contain the value <span style="color:#c00000">‘VALUE&rsquo;</span>.
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
contain the value ‘E&rsquo;.
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
Required
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>An example of a conformance statement with the minimal required building blocks is:</p>
</p>

<div class='box_v2web gray-box'>
<p class='p_v2web'>
<p><strong>Example:</strong></p><p><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">OBX-11 (Observation Result Status)&nbsp;SHALL </span><span style="font-family:Arial,Helvetica,sans-serif">contain the value</span><span style="font-family:Arial,Helvetica,sans-serif"> </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">‘F&rsquo;</span><span style="font-family:Arial,Helvetica,sans-serif">.</span></p>
</p>

</div>

<p class='p_v2web'>
<p></p>
</p>
<h3>
13.1 Element Location
</h3>
<p class='p_v2web'>
<p>The Element Location indicates the location in the message that is being addressed. The location can reference a group, segment, field, component, or sub-component and includes a description. For details of how an element location is represented, see <span style="font-size:16px">Section 1.2.3</span>.</p>
</p>
<h3>
13.2 Propositions
</h3>
<p class='p_v2web'>
<p>A conformance statement may be predicated on a condition, which is a building block called a proposition. <span style="font-size:16px">Table 13.2</span> shows the list of pre-defined proposition patterns and their meanings.</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 13.2: Conformance Statement Propositions</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Propositions (Predicates)</strong>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Description</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
IF <span style="color:#c00000">LOCATION (DESCRIPTION) </span>is valued, THEN
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
&quot;is valued&quot; predicate
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
IF <span style="color:#c00000">LOCATION (DESCRIPTION) </span>is not valued, THEN
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">&quot;is not valued&quot; predicate</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
IF <span style="color:#c00000">LOCATION (DESCRIPTION) </span>contains the value <span style="color:#c00000">&#39;VALUE&#39;</span>, THEN
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">&quot;dependent value&quot; predicate</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
IF <span style="color:#c00000">LOCATION (DESCRIPTION) </span>contains the value <span style="color:#c00000">&#39;VALUE&#39;</span> <span style="color:#c00000">(DESCRIPTION)</span>, THEN
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">&quot;dependent value with description&quot; predicate</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
IF <span style="color:#c00000">LOCATION (DESCRIPTION) </span>does not contain the value <span style="color:#c00000">&#39;VALUE&#39;</span>, THEN
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">&quot;</span><span style="color:#000000">not </span><span style="color:#000000">dependent value&quot; predicate</span>
</p>


</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
IF <span style="color:#c00000">LOCATION (DESCRIPTION) </span>does not contain the value <span style="color:#c00000">&#39;VALUE&#39; (DESCRIPTION)</span>, THEN
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">&quot;not dependent value with description&quot; predicate</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
IF <span style="color:#c00000">LOCATION (DESCRIPTION) </span>contains one of the values in the list <span style="color:#c00000">{ </span><span style="color:#c00000">&#39;VALUE 1&#39;, &#39;VALUE 2&#39;, &#39;VALUE N&#39; }</span>, THEN
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">&quot;dependent value in list&quot; </span><span style="color:#000000">predicate</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
IF <span style="color:#c00000">LOCATION (DESCRIPTION</span>) contains one of the values in the list <span style="color:#c00000">{ &#39;VALUE 1&#39; (DESCRIPTION) , &#39;VALUE 2&#39; (DESCRIPTION), &#39;VALUE N&#39; (DESCRIPTION)  }</span>, THEN
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">&quot;dependent value in list with description&quot; predicate</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
IF <span style="color:#c00000">LOCATION (DESCRIPTION) </span>does not contain one of the values in the list <span style="color:#c00000">{ &#39;VALUE 1&#39;, &#39;VALUE 2&#39;, &#39;VALUE N&#39; }</span>, THEN
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">&quot;not dependent value in list&quot; predicate</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
IF <span style="color:#c00000">LOCATION (DESCRIPTION) </span>does not contain one of the values in the list <span style="color:#c00000">{ &#39;VALUE 1&#39; (DESCRIPTION) , &#39;VALUE 2&#39; (DESCRIPTION) , &#39;VALUE N&#39; (DESCRIPTION)  }</span>, THEN
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">&quot;not dependent value in list with description&quot; predicate</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>The key phrases in the proposition are &ldquo;is valued&rdquo; and &ldquo;contains the value&rdquo;; a brief definition follows:</p><p><strong>is-valued:</strong> Any non-empty value satisfies the predicate proposition.</p><p><strong>contains the value:</strong> A value that is an exact match of value satisfies the predicate proposition. An indication of whether the exact match is case sensitive can be noted.</p>
</p>
<h3>
13.3 Occurrence-Declarative Statement
</h3>
<p class='p_v2web'>
<p>A conformance statement may refer to a specific instance of an element or to a group of element instances. Identifying an instance or instances is accomplished with the occurrence-declarative statement. <span style="font-size:16px">Table 13.3</span> shows the list of pre-defined occurrence-declarative statement patterns and their meanings. </p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 13.3: Occurrence Declarative Statement</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Occurrence Declarative Statement</strong>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Description</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
At least one occurrence of
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">One or more occurrence(s) of a repeating element </span><span style="color:#000000">can</span><span style="color:#000000"> satisfy </span><span style="color:#000000">the predicate.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
The <span style="color:#c00000">&#39;INSTANCE&#39;</span> occurrence of
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">The occurrence indicated by the INSTANCE of a repeating element </span><span style="color:#000000">must </span><span style="color:#000000">satisf</span><span style="color:#000000">y</span><span style="color:#000000"> the predicate. Other instances may also satisfy the predicate.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
No occurrence of
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">No occurrence of a repeating element </span><span style="color:#000000">can </span><span style="color:#000000">satisf</span><span style="color:#000000">y</span><span style="color:#000000"> the predicate.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
Exactly one occurrence of
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">One and only one occurrence of a repeating element </span><span style="color:#000000">can </span><span style="color:#000000">satisf</span><span style="color:#000000">y</span><span style="color:#000000"> the predicate.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#c00000">&#39;COUNT&#39; </span>occurrences of
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">Exactly COUNT occurrences of a repeating element </span><span style="color:#000000">can </span><span style="color:#000000">satisf</span><span style="color:#000000">y</span><span style="color:#000000"> the predicate.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
All occurrences of
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">All occurrences of a repeating element </span><span style="color:#000000">must </span><span style="color:#000000">satisfy the predicate.</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>An example of a conformance statement using an occurrence-declarative statement is:</p>
</p>

<div class='box_v2web gray-box'>
<p class='p_v2web'>
<p><strong>Example:</strong></p><p><span style="font-family:Arial,Helvetica,sans-serif">Exactly one occurrence of</span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif"> MSH-21.1 (Entity Identifier) SHALL </span><span style="font-family:Arial,Helvetica,sans-serif">contain the value</span><span style="font-family:Arial,Helvetica,sans-serif"> </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">‘</span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">Z22r1.0</span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">&rsquo;</span><span style="font-family:Arial,Helvetica,sans-serif">.</span></p>
</p>

</div>

<p class='p_v2web'>
<p></p>
</p>
<h3>
13.4 Context
</h3>
<p class='p_v2web'>
<p>The meaning of a conformance statement can be different depending on the context or scope to which it applies. <span style="font-size:16px">Table 13.</span><span style="font-size:16px">4</span> shows the list of pre-defined context patterns and their meanings. Note that the context of &ldquo;LOCATION&rdquo; indicates the location at any level. To indicate a specific context, the conformance statement may be enhanced with the contexts provided in <span style="font-size:16px">Table 13.4</span>.</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 13.4: Conformance Statement Context</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Context (Scope/Location)
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
&nbsp;Description
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
of the <span style="color:#c00000">SEGMENT</span> segment
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
&quot;segment&quot;, e.g., &ldquo;ERR segment&rdquo;
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
in the same <span style="color:#c00000">GROUP</span> group
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
&quot;same group&quot;, e.g., &ldquo;in the same ORDER group&rdquo;
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>
<h3>
13.5 Verbs
</h3>
<p class='p_v2web'>
<p>Conformance statements indicate the strength of the constraint with the use of the conformance verbs (See <span style="font-size:16px">Table 13.5</span>). The &ldquo;SHALL&rdquo; and &ldquo;SHALL NOT&rdquo; verbs indicate that the constraint must be implemented. The other verbs indicate constraints that may be applied. The &ldquo;SHOULD&rdquo; and &ldquo;SHOULD NOT&rdquo; verbs indicate constraints that are recommended but are not mandated.</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 13.5: Conformance Statement Verbs</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Verbs
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
&nbsp;Description
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
SHALL
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
&nbsp;Requirement to implement the constraint statement.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
SHALL NOT
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
&nbsp;Requirement not to implement the constraint statement.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
SHOULD
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
&nbsp;Recommendation to implement the constraint statement.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
SHOULD NOT
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
&nbsp;Recommendation not to implement the constraint statement.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
MAY
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
&nbsp;An indication that the constraint statement can be implemented.
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>
<h3>
13.6 Content-Declarative Statement
</h3>
<p class='p_v2web'>
<p>Content-declarative statements ask whether an element contains certain content. The values can be arbitrary values, coded values, or restricted values based on a format. The values may or may not contain an associated description.</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 13.6: Content-Declarative Statement</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Declarative Statement
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
&nbsp;Description
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
contain the value <span style="color:#c00000">‘VALUE&rsquo;</span>.
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Simple Value
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
contain the value <span style="color:#c00000">‘VALUE&rsquo; (DESCRIPTION)</span>.
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
Simple Value with Description
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
contain the value <span style="color:#c00000">‘VALUE&rsquo; </span>drawn from the code system <span style="color:#c00000">&#39;CODE SYSTEM&#39;</span>.
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Code Value from Code System
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
contain the value <span style="color:#c00000">‘VALUE&rsquo; (DESCRIPTION) </span>drawn from the code system <span style="color:#c00000">&#39;CODE SYSTEM&#39;</span>.
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
Code Value with Description from Code System
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
contain one of the values in the list: <span style="color:#c00000">{ ‘VALUE 1&rsquo;, &#39;VALUE 2&#39;, &#39;VALUE N&#39; }</span>.
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Simple Value in List
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
contain one of the values in the list: <span style="color:#c00000">{ ‘VALUE 1&rsquo;</span><span style="color:#c00000"> (DESCRIPTION)</span><span style="color:#c00000">, &#39;VALUE 2&#39;</span><span style="color:#c00000"> (DESCRIPTION)</span><span style="color:#c00000">, &#39;VALUE N&#39;</span><span style="color:#c00000"> (DESCRIPTION)</span><span style="color:#c00000"> }</span>.
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
Simple Value with Description in List
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
contain one of the values in the list: <span style="color:#c00000">{ ‘VALUE 1&rsquo;, &#39;VALUE 2&#39;, &#39;VALUE N&#39; }</span> drawn from the code system <span style="color:#c00000">&#39;CODE SYSTEM&#39;</span>.
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Code Value in List from Code System
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
contain one of the values in the list: <span style="color:#c00000">{ ‘VALUE 1&rsquo;</span><span style="color:#c00000"> (DESCRIPTION)</span><span style="color:#c00000">, &#39;VALUE 2</span><span style="color:#c00000"> (DESCRIPTION)</span><span style="color:#c00000">&#39;, &#39;VALUE N&#39;</span><span style="color:#c00000"> (DESCRIPTION)</span><span style="color:#c00000"> }</span> drawn from the code system <span style="color:#c00000">&#39;CODE SYSTEM&#39;</span>.
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
Code Value with Description in List from Code System
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
match the regular expression <span style="color:#c00000">‘REGULAR EXPRESSION&rsquo;</span>.
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">Content is required to match the regular expression. Regular expressions of &ldquo;MR\d{5}&rdquo; indicates that the content must start with &ldquo;MR&rdquo; and be followed with 5 digits. Example is &ldquo;MR83452&rdquo;.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
contain a positive integer.
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">Content is required to be a positive integer. This is a specific instance of a regular expression and provided for convenience.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
be valued sequentially starting with the value ‘1&#39;.
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">Content of the first occurrence of an element must be ‘1&rsquo;, subsequent occurrences are required to increase by 1. Used for identifying instances of segments using the Set ID field.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
be valued with an ISO-compliant OID.
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">Content is required to be a regular expression that represents the format of an ISO-compliant OID. This is a specific instance of a regular expression and provided for convenience.</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>
<h3>
13.7 Comparison-Content Declarative Statement
</h3>
<p class='p_v2web'>
<p>Comparison-content declarative statements ask whether the content of one element matches that of another element based on a comparator. <span style="font-size:16px">Table </span><span style="font-size:16px">13.7</span> lists each of the statements along with a description and examples.</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 13.7: Comparison-Content Declarative Statement</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Comparative Statement </strong>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>&nbsp;Description</strong>
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Examples</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
be identical to <span style="color:#c00000">LOCATION 2 (DESCRIPTION)</span>.
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">Content is the same in meaning and representation (a literal </span><span style="color:#000000">identical to). Applies to general, coded values, and dat</span><span style="color:#000000">e</span><span style="color:#000000">/time content. This concept can also be applied at the complex element level (e.g., compare ORC-12 and OBX-16).</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">General: 3 is identical to 3.</span>
</p>

<p class='p_v2web'>
<span style="color:#000000">Coded Value: The LOINC code of 30963-3 is identical to 30963-3</span>
</p>

<p class='p_v2web'>
<span style="color:#000000">Date/Time: 201103041023-0400 is identical to 201803041023-0400 (unlikely to be used for time)</span>
</p>

<p class='p_v2web'>
<span style="color:#000000">Complex element: Each constitute part of the complex element are compared for identical content.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
be earlier than <span style="color:#c00000">LOCATION 2 (DESCRIPTION)</span>.
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">Applies to date/time content only and indicates a dat</span><span style="color:#000000">a</span><span style="color:#000000">/time that occurs before the date/time of the element it is compared to. The comparison is a &ldquo;meaning&rdquo; comparison.</span>
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">Date/Time: 201803041021-0400 is earlier than 201803040823-0600</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">be earlier than or equivalent to </span><span style="color:#c00000">LOCATION 2 (DESCRIPTION)</span>.
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">Applies to date/time content only and indicates a date/time that occurs before or at the date/time of the element it is compared to. The comparison is a &ldquo;meaning&rdquo; comparison.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">Date/Time: 201803041021-0400 is earlier than 201803040823-0600</span>
</p>

<p class='p_v2web'>
<span style="color:#000000">Date/Time: 201803041023-0400 is equivalent to 201803040823-0600</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">be truncated earlier than </span><span style="color:#c00000">LOCATION 2 (DESCRIPTION)</span>.
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">Applies to date/time content only and indicates a date/time that occurs before the date/time of the element it is compared to. The comparison is a &ldquo;meaning&rdquo; comparison and is at the coarsest level (i.e., the more detailed element is truncated to the resolution of the less detailed element).</span>
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
Date/Time: 20180302 is earlier than 201803040823-0600
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">be truncated earlier than or truncated equivalent to</span><span style="color:#c00000"> LOCATION 2 (DESCRIPTION).</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">Applies to date/time content only and indicates a date/time that occurs before or at the date/time of the element it is compared to. The comparison is a &ldquo;meaning&rdquo; comparison and is at the coarsest level (i.e., the more detailed element is truncated to the resolution of the less detailed element).</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Date/Time: 20180304 is equivalent to 201803040823-0600 
</p>


<p class='p_v2web'>
Date/Time: 20180302 is earlier than 201803040823-0600
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
be equivalent to <span style="color:#c00000">LOCATION 2 (DESCRIPTION)</span>.
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">Content is the same in meaning but not representation. Applies </span><span style="color:#000000">to general, coded values, and data/time content. This concept can also be applied at the complex element level (e.g., compare ORC-12 and OBX-16).</span>
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">General: 3.00 is equivalent to 3.</span>
</p>

<p class='p_v2web'>
<span style="color:#000000">Coded Value: C38288 (NCIT) is </span><span style="color:#000000">equivalent to PO (HL70162). Oral-administered by mouth. Note: A concept map must be specified.</span>
</p>

<p class='p_v2web'>
<span style="color:#000000">Date/Time: 201803041023-0400 is equivalent to 201803040823-0600</span>
</p>

<p class='p_v2web'>
<span style="color:#000000">Complex element: Each constitute part of the complex element are compared for identical content.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
be truncated equivalent to <span style="color:#c00000">LOCATION 2 (DESCRIPTION)</span>.
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">Content is the same in meaning but not represented in the same manner and/or having the same resolution. Applies to general and dat</span><span style="color:#000000">e</span><span style="color:#000000">/time content. The comparison is at the coarsest level (i.e., the more detailed element is truncated to the resolution of the less detailed element).</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">General: 3.56 is truncated equivalent to 3.</span>
</p>

<p class='p_v2web'>
<span style="color:#000000">Date/Time: 201</span><span style="color:#000000">8</span><span style="color:#000000">0304 is equivalent to 201803040823-0600</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">be equivalent to or later than </span><span style="color:#c00000">LOCATION 2 (DESCRIPTION)</span>.
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
Applies to date/time content only and indicates a date/time that occurs after or at the date/time of the element it is compared to. The comparison is a &ldquo;meaning&rdquo; comparison.&nbsp;
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
Date/Time: 201803041023-0400 is equivalent to 201803040823-0600&nbsp;
</p>

<p class='p_v2web'>
&nbsp;
</p>

<p class='p_v2web'>
Date/Time: 201803041025-0400 is&nbsp;later&nbsp;than 201803040823-0600&nbsp;
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
be later than <span style="color:#c00000">LOCATION 2 (DESCRIPTION)</span>.
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">Applies to date/time content only and indicates a date/time that occurs after the date/time of the element it is compared to. The comparison is a &ldquo;meaning&rdquo; comparison.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">Date/Time: 201803041025-0400 is later than 201803040823-0600</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">be truncated equivalent to or truncated later than </span><span style="color:#c00000">LOCATION 2 (DESCRIPTION)</span><span style="color:#000000">.</span>
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
Applies to date/time content only and indicates a date/time that occurs after or at the date/time of the element it is compared to. The comparison is a &ldquo;meaning&rdquo; comparison and is at the coarsest level (i.e., the more detailed element is truncated to the resolution of the less detailed element).
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
Date/Time: 20180304 is equivalent to 201803040823-0600 
</p>


<p class='p_v2web'>
 
</p>


<p class='p_v2web'>
Date/Time: 20180305 is later than 201803040823-0600
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">be truncated later than </span><span style="color:#c00000">LOCATION 2 (DESCRIPTION)</span><span style="color:#000000">.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Applies to date/time content only and indicates a date/time that occurs after the date/time of the element it is compared to. The comparison is a &ldquo;meaning&rdquo; comparison and is at the coarsest level (i.e., the more detailed element is truncated to the resolution of the less detailed element).
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Date/Time: 20180305 is later than 201803040823-0600
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>
<h3>
13.8 Complex Conformance Statements
</h3>
<p class='p_v2web'>
<p>Conformance statements can be combined to make complex conformance statements with a set of connectors (See <span style="font-size:16px">Table </span><span style="font-size:16px">13.8</span>). Multiple connectors can be used, and connectors can be used in propositions and/or content-declarative statements and comparison-declarative statements.</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 13.8: Conformance Statement Connectors</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Connectors
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
&nbsp;Description
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
AND
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
&nbsp;Both predicates must be satisfied
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
OR
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
&nbsp;One predicate must be satisfied; both may be satisfied
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
XOR
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
&nbsp;Exclusive OR—one predicate must be satisfied; both must not be satisfied
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>An example of a complex conformance statement is:</p>
</p>

<div class='box_v2web gray-box'>
<p class='p_v2web'>
<p><strong>Example:</strong></p><p><span style="font-family:Arial,Helvetica,sans-serif">IF </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">RXA-20 (Completion Status) </span><span style="font-family:Arial,Helvetica,sans-serif">contains one of the values in the list { </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">&#39;CP&#39;, &#39;PA&#39; </span><span style="font-family:Arial,Helvetica,sans-serif">} AND </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">RXA-9.1 (Administration Notes) </span><span style="font-family:Arial,Helvetica,sans-serif">contains the value </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">&#39;00&#39;</span><span style="font-family:Arial,Helvetica,sans-serif"> THEN exactly one occurrence of </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">OBX-3.1 (Entity Identifier)</span><span style="font-family:Arial,Helvetica,sans-serif"> in the same </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">O</span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">RDER</span><span style="font-family:Arial,Helvetica,sans-serif"> Group </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">SHALL</span><span style="font-family:Arial,Helvetica,sans-serif"> contain the value </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">&quot;30963-3&quot; (Funding Source) </span><span style="font-family:Arial,Helvetica,sans-serif">drawn from the </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">L</span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">N</span><span style="font-family:Arial,Helvetica,sans-serif"> code system.</span></p>
</p>

</div>

<p class='p_v2web'>
<p></p>
</p>
<h3>
13.9 Free-Text Conformance Statements
</h3>
<p class='p_v2web'>
<p>The pseudo language presented is not intended to cover all possible constraints a specifier may wish to provide. In situations in which the language does not support a constraint, the specifier may use a free-text expression. The expression is not conducive to automatic translation into a machine-processable assertion.</p>
</p>
