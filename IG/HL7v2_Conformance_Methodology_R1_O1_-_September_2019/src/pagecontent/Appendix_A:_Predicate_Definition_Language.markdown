<h2>
12 Appendix A: Predicate Definition Language
</h2>
<p class='p_v2web'>
<p>Elements assigned with a declared conditional usage require an associated predicate that is computable and based on other elements in the message. The conformance methodology specification does not prescribe a language to define the predicate. A recommended pseudo language that provides the mechanisms to construct predicate statements is given in this section. The language is HL7 v2-specific and is grounded on predicate definitions that have emerged over time in the specification of HL7 v2 implementation guides. The goal is to provide specifiers with a simple language that affords consistency within and across HL7 v2 implementation guides, the readability of a natural language, and be machine computable. The language is not comprehensive (nor formal) and is intended for use in HL7 v2 for convenience.</p><p></p>
</p>

<div class='box_v2web gray-box'>
<p class='p_v2web'>
<p><span style="color:#000000"><strong>Examples of Condition Predicates</strong></span><span style="color:#000000"><strong>:</strong></span><span style="color:#000000"> </span></p><p></p><p><span style="font-family:Arial,Helvetica,sans-serif">IF </span><span style="font-family:Arial,Helvetica,sans-serif">CWE.1 (Identifier) is valued.</span></p><p></p><p><span style="font-family:Arial,Helvetica,sans-serif">I</span><span style="font-family:Arial,Helvetica,sans-serif">F</span><span style="font-family:Arial,Helvetica,sans-serif"> RXA-20 (Completion Status)</span><span style="font-family:Arial,Helvetica,sans-serif"> contains one of the values in the list</span><span style="font-family:Arial,Helvetica,sans-serif">: </span><span style="font-family:Arial,Helvetica,sans-serif">{</span><span style="font-family:Arial,Helvetica,sans-serif">&#39;CP&#39;,</span><span style="font-family:Arial,Helvetica,sans-serif"> </span><span style="font-family:Arial,Helvetica,sans-serif">&#39;PA&#39;</span><span style="font-family:Arial,Helvetica,sans-serif">}</span><span style="font-family:Arial,Helvetica,sans-serif">.</span></p>
</p>

</div>

<p class='p_v2web'>
<p></p><p>The pseudo language for describing predicate definition is composed of building blocks that are linked together to create the predicates. The building blocks include:</p><p></p><p>An example template for the condition predicate builder follows this general pattern:</p>
</p>

<div class='box_v2web gray-box'>
<p class='p_v2web'>
<p><span style="color:#000000"><strong>Condition Predicate Example</strong></span><span style="color:#000000"><strong> using a template pattern</strong></span><span style="color:#000000"><strong>:</strong></span><span style="color:#000000"> </span></p><p><span style="font-family:Arial,Helvetica,sans-serif">IF </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">LOCATION (DESCRIPTION) </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">VERB </span><span style="font-family:Arial,Helvetica,sans-serif">one of the value</span><span style="font-family:Arial,Helvetica,sans-serif">s</span><span style="font-family:Arial,Helvetica,sans-serif"> in the list</span><span style="font-family:Arial,Helvetica,sans-serif">: </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">{‘VALUE 1&rsquo;, ‘VALUE 2&rsquo;, ‘VALUE N&rsquo;}. </span></p><p></p><p><strong>Example:</strong></p><p><span style="font-family:Arial,Helvetica,sans-serif">IF </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">RXA-20 (Completion Status) contains </span><span style="font-family:Arial,Helvetica,sans-serif">one of the values in the list: </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">{&#39;CP&#39;, &#39;PA&#39;}.</span></p>
</p>

</div>

<p class='p_v2web'>
<p></p><p></p><p><span style="font-size:16px">Table 12.1</span> shows the template pattern broken up into its building-block parts. Additionally, a usage is given for each building block. Some building blocks are a part of all condition predicates (required), and others may be part of the condition predicates (optional). Subsequent sections explains the details for each of the building blocks.</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 12.1: Condition Predicate Template</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Example Template Pattern</strong>
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
IF
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
IF
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
IF
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
Occurrence Declarative Statement
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
N/A
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
N/A
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
RXA-20 (Completion Status)
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
N/A
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
N/A
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
VERB
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
contains
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
Content Declarative Statement OR Content Comparison Declarative Statement
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
contains the value one of the values in the list: {<span style="color:#c00000">‘VALUE</span><span style="color:#c00000"> 1</span><span style="color:#c00000">&rsquo;</span><span style="color:#c00000"> ‘VALUE 2&rsquo;, ‘VALUE N&rsquo;}</span>.
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
one of the values in the list: {&#39;CP&#39;, &#39;PA&#39;}.
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
<p></p>
</p>
<h3>
12.1 IF Statement
</h3>
<p class='p_v2web'>
<p>Every condition predicate starts with an &ldquo;IF&rdquo; statement.</p>
</p>
<h3>
12.2 Occurrence-Declarative Statement
</h3>
<p class='p_v2web'>
<p>A condition predicate may refer to a specific instance of an element or to a group of element instances. Identifying an instance or instances is accomplished with the occurrence-declarative statement. <span style="font-size:16px">Table 12.2</span> shows the list of pre-defined occurrence-declarative statement patterns and their meanings.</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 12.2: Occurrence-Declarative Statement</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Occurrence</strong><strong>-</strong><strong>Declarative Statement</strong>
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
at least one occurrence of
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">One or more occurrence(s) of a repeating element </span><span style="color:#000000">can</span><span style="color:#000000"> satisfy the predicate.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
the <span style="color:#c00000">&#39;INSTANCE&#39;</span> occurrence of
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
no occurrence of
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
exactly one occurrence of
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
<p></p>
</p>
<h3>
12.3 Element Location
</h3>
<p class='p_v2web'>
<p>The Element Location indicates the location in the message that is being addressed. The location can reference a group, segment, field, component, or sub-component and includes a description. For details of how an element location is represented, see <span style="font-size:16px">Section 1.2.3</span>.</p>
</p>
<h3>
12.4 Context
</h3>
<p class='p_v2web'>
<p>The meaning of a condition predicate can be different depending on the context or scope to which it applies. <span style="font-size:16px">Table 12.3</span> shows the list of pre-defined context patterns and their meanings. Note that the context of &ldquo;LOCATION&rdquo; indicates the location at any level. To indicate a specific context, the condition predicate may be enhanced with the context provided in <span style="font-size:16px">Table 12.3</span>.</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 12.3: Condition Predicate Context</caption>
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
12.5 Verbs
</h3>
<p class='p_v2web'>
<p><span style="font-size:16px">Table 12.4</span> indicates the set of verbs that can be used to construct predicate inquires. The verbs are paired with certain Proposition Content Declarative Statements or Content Comparison Declarative Statements.</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 12.4: Condition Predicate Verbs</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Verbs
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
is
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
is not
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
contains
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
does not contain
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
matches
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
does not match
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>
<h3>
12.6 Content-Declarative Statements
</h3>
<p class='p_v2web'>
<p>Proposition content-declarative statements ask whether an element contains certain content. The values can be arbitrary values, coded values, or restricted values based on a format. The values may or may not contain an associated description. <span style="font-size:16px">Table 12.5</span> lists each of the statements along with the verbs they can be paired with.</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 12.5: Content-Declarative Statement</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Declarative Statement
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
&nbsp;Verb Pairs
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
valued
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
is/not
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
the value <span style="color:#c00000">‘VALUE&rsquo;</span>.
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
contains/does not contain
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
the value <span style="color:#c00000">‘VALUE&rsquo; (DESCRIPTION)</span>.
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
contains/does not contain
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
the value <span style="color:#c00000">‘VALUE&rsquo; </span>drawn from the code system <span style="color:#c00000">&#39;CODE SYSTEM&#39;</span>.
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
contains/does not contain
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
the value <span style="color:#c00000">‘VALUE&rsquo; (DESCRIPTION) </span>drawn from the code system <span style="color:#c00000">&#39;CODE SYSTEM&#39;</span>.
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
contains/does not contain
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
one of the values in the list: <span style="color:#c00000">{ ‘VALUE 1&rsquo;, &#39;VALUE 2&#39;, &#39;VALUE N&#39; }</span>.
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
contains/does not contain
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
one of the values in the list: <span style="color:#c00000">{ ‘VALUE 1&rsquo;</span><span style="color:#c00000"> (DESCRIPTION)</span><span style="color:#c00000">, &#39;VALUE 2&#39;</span><span style="color:#c00000"> (DESCRIPTION)</span><span style="color:#c00000">, &#39;VALUE N&#39;</span><span style="color:#c00000"> (DESCRIPTION)</span><span style="color:#c00000"> }</span>.
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
contains/does not contain
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
one of the values in the list: <span style="color:#c00000">{ ‘VALUE 1&rsquo;, &#39;VALUE 2&#39;, &#39;VALUE N&#39; }</span> drawn from the code system <span style="color:#c00000">&#39;CODE SYSTEM&#39;</span>.
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
contains/does not contain
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
one of the values in the list: <span style="color:#c00000">{ ‘VALUE 1&rsquo;</span><span style="color:#c00000"> (DESCRIPTION)</span><span style="color:#c00000">, &#39;VALUE 2</span><span style="color:#c00000"> (DESCRIPTION)</span><span style="color:#c00000">&#39;, &#39;VALUE N&#39;</span><span style="color:#c00000"> (DESCRIPTION)</span><span style="color:#c00000"> }</span> drawn from the code system <span style="color:#c00000">&#39;CODE SYSTEM&#39;</span>.
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
contains/does not contain
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
the regular expression <span style="color:#c00000">‘REGULAR EXPRESSION&rsquo;</span>.
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">m</span><span style="color:#000000">atches/does not match</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p><span style="color:#000000">For </span><span style="color:#000000">‘REGULAR EXPRESSION&rsquo;</span><span style="color:#000000">, c</span><span style="color:#000000">ontent is required to match the regular expression. Regular expressions of &ldquo;MR\d{5}&rdquo; indicate that the content must start with &ldquo;MR&rdquo; and be followed with 5 digits. Example is &ldquo;MR83452&rdquo;.</span></p>
</p>
<h3>
12.7 Comparison-Content Declarative Statement
</h3>
<p class='p_v2web'>
<p>Proposition comparison-content declarative statements ask whether the content of one element matches that of another element based on a comparator. <span style="font-size:16px">Table 1</span><span style="font-size:16px">2.6</span> lists each of the statements along with a description and examples. All Content Comparison Declarative Statement are paired with the verbs is/is not.</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 12.6: Content Comparison Declarative Statement</caption>
<tr class='tr_v2web'>
<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Comparative Statement 
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
&nbsp;Description
</p>

</th>

<th class='emphasis-header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Examples
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
<span style="color:#000000">Content is the same in meaning and representation (a literal identical to). Applies to general, coded values, and data/time content. This concept can also be applied at the complex element level (e.g., compare ORC-12 and OBX-16).</span>
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
<span style="color:#000000">Complex element: Each constitute part of the complex </span><span style="color:#000000">element are compared for identical content.</span>
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
<span style="color:#000000">Applies to date/time content only and indicates a date/time that occurs before the date/time of the element it is compared to. The comparison is a &ldquo;meaning&rdquo; comparison.</span>
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
<span style="color:#000000">Content is the same in meaning but not representation. Applies to general, coded values, and data/time content. This concept can also be applied at the complex element level (e.g., compare ORC-12 and OBX-16).</span>
</p>

</td>

<td class='emphasis-column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">General: 3.00 is equivalent to 3.</span>
</p>

<p class='p_v2web'>
<span style="color:#000000">Coded Value: C38288 (NCIT) is equivalent to PO (HL70162). Oral-administered by mouth. Note: A concept map must be specified.</span>
</p>

<p class='p_v2web'>
<span style="color:#000000">Date/Time: 201803041023-0400 is equivalent to 201803040823-0600</span>
</p>

<p class='p_v2web'>
<span style="color:#000000">Complex element: Each constitute part of the complex element are compared for </span><span style="color:#000000">identical content.</span>
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
<span style="color:#000000">Content is the same in meaning but not represented in the same manner and/or having the same resolution. Applies to general and data/time content. The comparison is at the coarsest level (i.e., the more detailed element is truncated to the resolution of the less detailed element).</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">General: 3.56 is truncated equivalent to 3.</span>
</p>

<p class='p_v2web'>
<span style="color:#000000">Date/Time: 20110304 is equivalent to 201803040823-0600</span>
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

</td>

<td class='emphasis-column table_v2web1' colspan='1'>

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

</td>

<td class='emphasis-column table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">be truncated later than </span><span style="color:#c00000">LOCATION 2 (DESCRIPTION)</span><span style="color:#000000">.</span>
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
<p></p>
</p>
<h3>
12.8 Complex Condition Predicates
</h3>
<p class='p_v2web'>
<p>Condition predicate statements can be combined to make complex condition predicates with a set of connectors (See <span style="font-size:16px">Table 1</span><span style="font-size:16px">2.7</span>). Multiple connectors can be used.</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 12.7: Condition Predicate Connectors</caption>
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
<p></p><p>An example of a complex condition predicate is:</p>
</p>

<div class='box_v2web gray-box'>
<p class='p_v2web'>
<p><strong>Example:</strong></p><p><span style="font-family:Arial,Helvetica,sans-serif">If </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">RXA-9.1</span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif"> </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">(Identifier) contain</span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">s</span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif"> </span><span style="font-family:Arial,Helvetica,sans-serif">the value </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">&#39;00&#39;</span><span style="font-family:Arial,Helvetica,sans-serif"> AND </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">RXA-20</span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif"> </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">(Completion Status) contain</span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">s</span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif"> </span><span style="font-family:Arial,Helvetica,sans-serif">one of the values in the list: </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">{CP,</span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif"> </span><span style="color:#c00000; font-family:Arial,Helvetica,sans-serif">PA}</span><span style="font-family:Arial,Helvetica,sans-serif">.</span></p>
</p>

</div>

<p class='p_v2web'>
<p></p>
</p>
