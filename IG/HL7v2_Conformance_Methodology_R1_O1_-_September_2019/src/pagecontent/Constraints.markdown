<h2>
5 Constraints
</h2>
<p class='p_v2web'>
<p>This section presents the constraints that can be applied during the profiling process. The types of constraints that can be applied to the various parts of a profile were given in the previous section. For each of these constraints, this section provides a description and definition, and, additionally, the compliance and compatibility rules are presented.</p><p>For each of the conformance constructs described, the standard defines a set of &ldquo;allowable constraints&rdquo; (i.e., the rules for profile compliance) that can be applied. Allowable constraints are a means of restricting requirements in the base standard (or another profile) to make those requirements more specific. As such, elements that are &ldquo;Required&rdquo; cannot be relaxed, e.g., changed to &ldquo;Optional&rdquo;.</p>
</p>
<h3>
5.1 Usage
</h3>
<p class='p_v2web'>
<p>Usage rules govern the expected behavior of the sending application and the receiving application with respect to an element. The usage indicators expand/clarify the optionality indicators defined in the HL7 base standard.  Usage determines, from an implementation perspective, whether an element must be supported. Additionally, from an operational perspective, usage determines whether the element must be present, can be present, or must not be present in a message instance for the sender. For the receiver, usage influences the processing of the element. </p><p></p>
</p>

<div class='box_v2web pink_box'>
<p class='p_v2web'>
<p><span style="color:#000000"><strong>Optionality and Usage:</strong></span><span style="color:#000000"> </span>Optionality and Usage often refer to the same concept. Optionality is a term that has been used historically in the HL7 v2 base standard. Usage is the term that is used in the HL7 v2 conformance specification.</p>
</p>

</div>

<p class='p_v2web'>
<p></p><p><span style="font-size:16px">Table </span><span style="font-size:16px">5.</span><span style="font-size:16px">1</span> provides an overview of the allowable usage indicators in message profiles (i.e., for constrainable and implementable profiles). While the base standard allows for all optionality indicators in some capacity, message-profile usage indicators have restricted use for a profile level.</p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.1: Conformance Usage Indicators and Definitions</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Indicator</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Name</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Description</strong></span>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>R</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Required</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The element is required and must be present in the message instance.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>RE</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Require, but may be Empty</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The element is required to be supported and may be present in the message instance.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>C</strong></span>
</p>


</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Undeclared Conditional</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The usage of the element is conditional and is based on the outcome of a predicate that may not be defined initially. The usage indicator does not define an exact usage for the true and false outcomes and does not define an explicit predicate. Although the definition may be informative, the definition is incomplete and must be further defined. The undeclared conditional usage is the predominate form of conditional usage in the base standard. At this level, the specific context may </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">not </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">be known completely, therefore, precise constraints can&rsquo;t be specified. In constrainable message profiles, a &ldquo;C&rdquo; usage may be used and is interpreted as a &ldquo;passthrough&rdquo; from the base standard (i.e., the specifier </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">is indifferent). The &ldquo;C&rdquo; usage indicat</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">es</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> implementation requirements are yet to be determined and, in this sense, behaves much like the &ldquo;O&rdquo; usage indicator</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">,</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> except the condition associated with the element is known. For an implementation profile</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">,</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> all elements designated as undeclared conditional usage must be constrained to R, RE, C(a/b)</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">,</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> or X.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>C(a/b)</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Declared Conditional</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The usage of the element is conditional and is based on the outcome of a predicate. The usage indicator defines exactly the usage for the true and false outcomes and defines an explicit predicate that determines the true and false outcomes. The declared conditional defines explicit implementation requirements.</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> The declared conditional usage construct must not be nested.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>O</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Optional</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The usage requirements for the element have not been defined at this stage of specification. For an implementation profile</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">,</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> all elements designated as optional usage must be constrained to R, RE, C(a/b)</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">,</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> or X.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>X</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Not-supported</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The element is not</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">supported and must not be present in the message instance.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>B</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Backward Compatible</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The element has been designated for removal from a future version of the standard</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">,</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> and current use is discouraged.</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>Conditional usage in the base standard often is under-specified in terms of explicitly defining a predicate and the true and false outcomes. Additionally, in many cases such a complete declaration is not possible, since the specific use requirements are unknown at the base standard level; only at the profile level can they be fully determined. Observing this reality, the conformance methodology specification henceforth recognizes this unadorned conditional usage designation as an undeclared conditional usage that can be used in constrainable message profiles. Undeclared conditional usage is distinguished from a declared conditional usage that is fully defined. The introduction of the undeclared conditional usage along with the declared conditional usage allows for multiple types of conditional usage to co-exist in message profiles without ambiguity. Undeclared conditional usage asserts no implementation requirements, but declared conditional usage does.</p><p></p>
</p>

<div class='box_v2web pink_box'>
<p class='p_v2web'>
<p><span style="color:#000000"><strong>C(a/b) usage in the base standard</strong></span><span style="color:#000000"><strong>:</strong></span><span style="color:#000000"> </span>C(a/b) usage replaced C usage in the base standard in version 2.8 and beyond. However, the construct is rarely used as intended, and, in many cases, it is not possible for it to be used at the base standard level, because the complete set of requirements are unknown. In nearly all cases, the unadorned C usage indicator is used for specifying conditional elements and not C(a/b). This specification considers elements specified as conditional in the base standard in essence as undeclared conditional elements and may be constrained as an undeclared conditional (C) or a declared conditional C(a/b) in message profiles.</p>
</p>

</div>

<p class='p_v2web'>
<p></p>
</p>
<h4>
5.1.1 Usage Requirements for Sending Applications
</h4>
<p class='p_v2web'>
<p><span style="font-size:16px">Table 5.2</span> shows the usage rules requirements for a sending application. These requirements are expressed from the perspective of implementation and operational requirements. Usage implementation requirements indicate what the application must support for the element. Usage operational requirements indicate what the application must provide in a message instance. What is provided is sometimes dependent on conditions and data availability. <span style="font-size:16px">Table </span><span style="font-size:16px">5.</span><span style="font-size:16px">2</span> indicates what must be supported by the implementation and what must be provided in the message instance, not how it is accomplished.</p><p></p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.2: Usage Requirements Sending Applications</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Indicator</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Description</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Implementation Requirement</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Operational Requirement</strong></span>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>R</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Required</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The application </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> support an element with an &ldquo;R&rdquo; usage designation.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The application </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> value an element with an &ldquo;R&rdquo; usage designation.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>RE</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Required, but may be empty</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The application </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> support an element with an &ldquo;RE&rdquo; usage designation.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The application </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> value an element with an &ldquo;RE&rdquo; designation if data is known for that element.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>C</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Undeclared Conditional</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">There are no impl</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">ementation requirements. The &ldquo;C</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">&rdquo; usage designation is a placeholder indicating that the usage for this element ha</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">s</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> not yet been</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">specified.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Not Applicable.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>C(</strong></span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>a</strong></span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>/</strong></span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>b</strong></span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>)</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Declared </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Conditional</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The application must support the implementation requirements as indicated by the true (&ldquo;a&rdquo;) outcome and by the false (&ldquo;b&rdquo;) outcome usage indicators in the declared conditional definition.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">operational </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">usage designation for the element is determined based on the out</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">come of an associated </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">predicate</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> at runtime</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">.</span>
</p>

<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">If the </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">predicate associated with the element is true, follow the </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">usage rule requirements</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> for &ldquo;</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>a</strong></span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">&rdquo;</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">,</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> which </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> be one of &ldquo;R&rdquo;, &ldquo;RE&rdquo;, &ldquo;O&rdquo;</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">,</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> or X&rdquo;:</span>
</p>

<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">If the </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">predicate associated with the el</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">ement is false, follow the usage rule requirements</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> for &ldquo;</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>b</strong></span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">&rdquo;</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">,</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> which </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> be one of &ldquo;R&rdquo;, &ldquo;RE&rdquo;, &ldquo;O&rdquo;</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">,</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> or X&rdquo;.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>X</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Not supported</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The application (as configured) </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> not support an element with an &ldquo;X&rdquo; usage designation.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The application </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> not value an element with an &ldquo;X&rdquo; usage designation.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>O</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Optional</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">There are no implementation requirements. The &ldquo;O&rdquo; usage designation is a placeholder indicating that the usage for this element has not yet been specified.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Not Applicable. </span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>B</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Backwards Compatible</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">There are no implementation requirements. The &ldquo;</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">B</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">&rdquo; usage </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">indicates that the element is retained for backwards compatibility of the </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">element.</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> Another usage indicator may be assigned in a derived profile.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Not Applicable.</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>The use of the RE usage code is qualified with the &ldquo;if data is known&rdquo; clause. The sender must interpret the clause as &ldquo;the capability must always be supported, and data must always be sent if known&rdquo;. To clarify, the sender does not determine whether the data should be sent; to be conformant to the rule, the data must be sent. There is a misconception where the RE usage is interpreted as &ldquo;the capability must always be supported, and data may or may not be sent even when known based on a condition external to the profile specification&rdquo;. If there are valid external conditions, then the profile does not describe the use case accurately, and the profile needs to be modified accordingly, or possibly another profile needs to be created. This is not to say that the sender doesn&rsquo;t control what data they send in production systems, but it is an indication that the sender is not conformant to the profile to which they are claiming conformance. The consequence of non-conformity created by not sending known data for an RE element is out of scope for this specification. See <span style="font-size:16px">S</span><span style="font-size:16px">ection </span><span style="font-size:16px">1.5.1</span> for insight on how installed systems can handle non-conformities.</p>
</p>
<h4>
5.1.2 Usage Requirements for Receiving Applications
</h4>
<p class='p_v2web'>
<p><span style="font-size:16px">Table </span><span style="font-size:16px">5.</span><span style="font-size:16px">3</span> shows the usage rules requirements for a receiving application. These requirements are expressed from the perspective of implementation and operational requirements. Usage implementation requirements indicate what the application must support for the element. Usage operational requirements indicate what the application must process in a message instance. The concept of &ldquo;must process in a meaningful way&rdquo; is intentionally vague at the interface level specification. Exactly what this means can be further defined in the profile definition in the context of a use case or in a functional requirements specification. The phrase &ldquo;process in a meaningful way&rdquo; can mean many things, as illustrated in the simple examples given below:</p><p><span style="font-size:16px">Table </span><span style="font-size:16px">5.</span><span style="font-size:16px">3</span> indicates what must be supported by the implementation and what must be processed by the implementation, but not how the processing is to be accomplished.</p><p></p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.3: Usage Rules Requirements for a Receiving Application</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Indicator</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Description</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Implementation Requirement</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Operational Requirement</strong></span>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>R</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Required</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The application </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> support an element with an &ldquo;R&rdquo; usage designation.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The rece</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">iving application must process in a meaningful way</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> the information conveyed by an element with an &ldquo;R&rdquo; usage designation.</span>
</p>

<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">A receiving application </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> raise an exception due to the absence of a required element. A receiving application </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> not raise an exception due to the presence of a required element</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>RE</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Required, but may be empty</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The application </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> support an element with an &ldquo;RE&rdquo; usage designation.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The receiving application </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> process </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">in a meaningful way</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> the information conveyed by an element with an &ldquo;RE&rdquo; usage designation. </span>
</p>

<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The receiving application </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> process the message if the element is omitted (that is, an exception </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> not be raised because the element is missing).</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">A receiving application </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> not raise an exception due to the presence of a required element</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>C</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Undeclared Conditional</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">There are no impl</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">ementation requirements. The &ldquo;C</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">&rdquo; usage designation is a placeholder indicating that the usage for this element has not yet been</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">specified.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Not Applicable.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>C(</strong></span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>a</strong></span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>/</strong></span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>b</strong></span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>)</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Declared </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Conditional</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The application must support the implementation requirements as indicated by the true (&ldquo;a&rdquo;) outcome and by the false (&ldquo;b&rdquo;) outcome usage indicators in the declared conditional definition.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">operational </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">usage designation for the element is determined based on the out</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">come of an associated </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">predicate</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> at runtime</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">.</span>
</p>

<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">If the </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">predicate associated with the element is true, follow the </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">usage rule requirements</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> for &ldquo;</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>a</strong></span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">&rdquo;</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">,</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> which </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> be one of &ldquo;R&rdquo;, &ldquo;RE&rdquo;, &ldquo;O&rdquo;</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">,</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> or X&rdquo;:</span>
</p>

<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">If the </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">predicate associated with the el</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">ement is false, follow the usage rule requirements</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> for &ldquo;</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>b</strong></span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">&rdquo;</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">,</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> which </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> be one of &ldquo;R&rdquo;, &ldquo;RE&rdquo;, &ldquo;O&rdquo;</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">,</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> or X&rdquo;.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>X</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Not supported</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The application (as configured) </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> not support an element with an &ldquo;X&rdquo; usage designation.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">None if the element is not present</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">.</span>
</p>

<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">If the element is present</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">, the receiving application may process the message </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">but must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> ignore the element</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> content</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> and may raise an exception. The receiving application </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> not proc</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">ess the information </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">conveyed </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">in </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">an element with an &ldquo;X&rdquo; usage designation</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>O</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Optional</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">There are no implementation requirements. The &ldquo;O&rdquo; usage designation is a placeholder indicating that the usage for this element has not yet been specified.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">None if the element is not present</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">.</span>
</p>

<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">If the element is present</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">, the receiving application may process the message </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">but must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> ignore the element</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> content</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> and may raise an exception. The receiving application </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">must</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> not </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">process</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> the information conveyed </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">in </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">an element with an &ldquo;O&rdquo; usage designation</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>B</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Backwards Compatible</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">There are no implementation requirements. The &ldquo;</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">B</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">&rdquo; usage </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">indicates that the element is retained for backwards compatibility of the </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">element.</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> Another usage indicator may be assigned in a derived profile.</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Not Applicable.</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>
<h4>
5.1.3 Conditional Usage
</h4>
<p class='p_v2web'>
<p>Conditional usage has several facets that necessitate further explanation, including formal definitions of undeclared and declared conditional usage, factoring conditional usage to a non-conditional usage, and predicate definition.</p>
</p>
<h5>
5.1.3.1 Undeclared Conditional Usage
</h5>
<p class='p_v2web'>
<p>Undeclared conditional usage is a designation that the element is conditional on another element or elements, however, the specific requirement can&rsquo;t be determined at the current level of use case knowledge. Additionally, the conditional usage may be out of scope for the use case, but the specifier chooses to be silent on the element requirements; that is, the specifier neither fully defines the conditional usage nor eliminates its potential use in a derived profile. The undeclared conditional usage can be thought of as a &ldquo;passthrough&rdquo; in a message profile; and it is analogous to an optional element in the base standard, remaining as an optional element in a constrainable profile. </p><p>Although an undeclared conditional usage isn&rsquo;t fully or formally defined, that fact does not imply that any requirements specified are not obligatory in a derived profile if &ldquo;activated&rdquo;. A requirement defined in the undeclared conditional usage must be preserved in any subsequent definition if the underlying condition hasn&rsquo;t changed. </p>
</p>
<h5>
5.1.3.2 Declared Conditional Usage
</h5>
<p class='p_v2web'>
<p>The Declared Conditional usage is a fully-specified declaration of the true and false outcome usages based on an explicitly defined predicate. The formal definition is:</p><p><strong>C(</strong><strong>a</strong><strong>/</strong><strong>b</strong><strong>)</strong> with an associated predicate where &ldquo;<strong>a</strong>&rdquo; and &ldquo;<strong>b</strong>&rdquo; in the expression are placeholders for usage codes representing the true (&ldquo;<strong>a</strong>&rdquo;) predicate outcome and the false (&ldquo;<strong>b</strong>&rdquo;) predicate outcome of the condition. The condition is expressed by a conditional predicate associated with the element. &ldquo;<strong>a</strong>&rdquo; and &ldquo;<strong>b</strong>&rdquo; must be one of &ldquo;R&rdquo;, &ldquo;RE&rdquo;, &ldquo;O&rdquo;, and/or &ldquo;X&rdquo;. As such, the conditional usage construct cannot be nested. The values of &ldquo;a&rdquo; and &ldquo;b&rdquo; cannot be the same; logically, if this is the case, the usage indicator resolves to a single non-conditional usage.</p>
</p>
<h5>
5.1.3.3 Factoring Conditional Usage to Non-conditional Usage
</h5>
<div class='box_v2web pink_box'>
<p class='p_v2web'>
<p><span style="color:#000000"><strong>C and CE Conformance Usage</strong></span><span style="color:#000000"><strong>:</strong></span><span style="color:#000000"> </span>Conditional (C) and Conditional, but maybe Empty (CE) usage indicators were introduced in the conformance specification in version 2.5 and deprecated in version 2.7.1. In version 2.7.1, C(a/b) was introduced, which subsumed C and CE. C equates to C(R/X) and CE equates to C(RE/X). Note, that the definition of &ldquo;C&rdquo; optionality in the base standard does not match the definition of &ldquo;C&rdquo; usage in various versions of conformance section/chapter.</p>
</p>

</div>

<p class='p_v2web'>
<p></p><p><span style="font-size:16px">Table </span><span style="font-size:16px">5.4</span> describes various use cases for profiling conditional usage. The examples employ an excerpt of the CWE data type (as of version 2.7). CWE.1 (Code) is the code identifier, CWE.2 (Text) is the text that describes the code concept, CWE.3 (Code System) is the name of the code system of which the code (CWE.1) is a member, and CWE.14 (Code System OID) is the OID of the code system of which the code (CWE.1) is a member. The BASE column indicates the specification as given in the base standard, in which the Code and Text are optional and the Code System and Code System OID are conditional. The conditions and relationships for the CWE definition are that if a code is provided, then either the code system or the code system OID must also be provided.</p><p></p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.4: Examples of Conditional Usage</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Element</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Name</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Base</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>DTF1</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>DTF2</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>DTF3</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>DTF4</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>DTF4 Predicate</strong></span>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>CWE.1</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Code</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>O</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>R</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>X</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>R</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>RE</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>CWE.2</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Text</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>O</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>RE</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>R</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>RE</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>C(R/RE)</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">If CWE.1 is not valued. </span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>CWE.3</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Code System</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>C</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>R</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>X</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>X</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>C(R/X)</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">If CWE.1 is valued.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>CWE.14</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Code System OID</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>C</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>C</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>X</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>R</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>C(O/X)</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">If CWE.1 is valued.</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>Four profiling examples of the CWE data types that represent a data type flavor (DTF1, DTF2, DTF3, DTF4) are explained below, with references to information in <span style="font-size:16px">Table 5.4</span>:</p><p><strong>DTF1</strong><strong>:</strong> The specifier is requiring a code and the associated code system. Additionally, the specifier is making no statement on the requirement for CWE.14. This requirement designation is left to be specified in a derived profile. The usage of &ldquo;C&rdquo; is used instead of &ldquo;O&rdquo; because of the dependency of the element. Since the original condition has been satisfied by requiring CWE.3, CWE.14 can be profiled to one of R, RE, or X in a derived profile. There is no need to specify an explicit predicate since the condition is an undeclared conditional usage.</p><p><strong>DTF2</strong><strong>:</strong> The specifier is indicating that a code is not to be supported, therefore, CWE.3 and CWE.14 must also not be supported. The text component in this case is required. Since the original predicate will always resolve to false, the specification of a predicate is not necessary, and a non-conditional usage indicator can be specified (&ldquo;X&rdquo; in this example).</p><p><strong>DTF3</strong><strong>:</strong> The specifier is indicating that a code and the associated code system OID are required. The code system name is not to be supported. Since the original condition is satisfied by requiring CWE.14, the specifier has the option to constrain CWE.3 to R, RE, X or leave it to be determined in a derived profile (usage = C). In this case the specifier decided not to support (X).</p><p><strong>DTF4</strong><strong>:</strong> The specifier is constraining the data type flavor such that a code must be supported, and, if available, it must be valued (CWE.1). If the code is not available, then text describing the concept must be valued (CWE.2). If a code is provided, then the code system name (CWE.3) must be provided as well. The specifier is leaving it up to the specifier of a derived profile as to whether the code system OID (CWE.14) must be supported. Since a declared conditional usage is specified, an explicit condition predicate is given (Column DTF4 Predicate).</p>
</p>
<h5>
5.1.3.4 Predicate Definition
</h5>
<div class='box_v2web pink_box'>
<p class='p_v2web'>
<p><span style="color:#000000"><strong>Conditional Usage on the Event Type (MSH-9.2)</strong></span><span style="color:#000000"><strong>:</strong></span><span style="color:#000000"><strong> </strong></span><span style="color:#000000">Although not explicitly prohibited</span><span style="color:#000000">, the use of the event type as the basis of the conditional usage is not recommended. Specification of individual profiles is the preferred approach.</span></p>
</p>

</div>

<p class='p_v2web'>
<p>The predicate may be expressed in a computable language or in plain text. This specification does not prescribe a specific method for expressing a predicate. However, a pseudo language (See <span style="font-size:16px">Appendix A</span>) has been developed to concisely and consistently express conditional usage predicates. The language is specifically designed for HL7 v2 in terms of relatability and ease of use. When possible, use of this language is recommended.</p>
</p>
<h4>
5.1.4 Usage Compliance
</h4>
<p class='p_v2web'>
<p><span style="font-size:16px">Table 5.5</span> presents the allowable transitions for each Usage code at each possible profile-level transition. The &ldquo;Usage Code&rdquo; column indicates the usage code for the &ldquo;starting&rdquo; profile level. The columns to the right of the Usage Code column indicate the possible usage code for the &ldquo;ending&rdquo; profile level. The &ldquo;starting&rdquo; profile level is indicated by the top line in the column heading, and the &ldquo;ending&rdquo; profile level is indicated by the bottom line in the column heading. For example, in the<span style="color:#ff0000"> </span>first row of the Usage Code column, the usage code is R, which is the usage of the<span style="color:#ff0000"> </span>element as defined in the Base standard. This usage code can only transition to R in a constrainable profile, as indicated by the Usage Code = R and Base-to-Constrainable coordinates.</p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.5: Usage Compliance</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif"><strong>Usage Code</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif"><strong>Base-to-Constrainable</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif"><strong>Constrainable-to-Constrainable</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif"><strong>Base-to-Implementation</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif"><strong>Constrainable-to-Implementation</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif"><strong>Implementation-to-Implementation</strong></span>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif"><strong>R</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif"><strong>RE</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif"><strong>O</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE, C(a,b), O, X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE, C(a,b), O, X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE, C(a,b), X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE, C(a,b), X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">N/A</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif"><strong>C</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE, C, C(a,b), X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE, C, C(a,b), X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE, C(a,b), X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE, C(a,b), X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">N/A</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif"><strong>C(a/b)</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE, C(a,b), C(a&rsquo;/b&rsquo;), X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE, C(a,b), C(a&rsquo;/b&rsquo;), X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE, C(a,b), C(a&rsquo;/b&rsquo;), X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE, C(a,b), C(a&rsquo;/b&rsquo;), X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, C(a,b), C(a&rsquo;/b&rsquo;)</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif"><strong>X</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">X</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif"><strong>B</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE, C(a,b), O, X</span><span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">, B</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE, C(a,b), O, X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE, C(a,b), X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">R, RE, C(a,b), X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">N/A</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif"><strong>W</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">N/A</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">X</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">N/A</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:13px; font-family:Arial,Helvetica,sans-serif">N/A</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>In an implementable profile, ultimately only two possibilities are allowed: either a specific element is supported (&quot;R or RE&quot;) or it is not (&quot;X&quot;). For a conditional usage, the true and false outcomes must also be defined only as R, RE, or X.</p><p>An element with a usage of withdrawn is not to be used. The usage code &ldquo;W&rdquo; can only be profiled to &ldquo;X&rdquo;, and use of &ldquo;X&rdquo; is required in the profiles. The usage code &ldquo;B&rdquo; in a constrainable profile can be profiled to another usage indicator; however, this approach is not recommended (unless it is being profiled to &quot;X&quot;), since the intent of the authors of the standard is that this element not be used in the future. </p>
</p>
<h5>
5.1.4.1 Conditional Usage Compliance
</h5>
<p class='p_v2web'>
<p><span style="font-size:16px">Table </span><span style="font-size:16px">5.6</span> indicates the circumstances in which an undeclared conditional usage remains an undeclared conditional usage and the implications of that transition; and the circumstances in which an undeclared conditional is constrained to a declared conditional usage and the implications of that transition. Note, the conditional usage in the base standard is not referred to as an undeclared conditional usage. </p><p></p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.6: Use of Undeclared Conditional Usage</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Indicator</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Transition</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Resulting Indicator</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Comments</strong></span>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>C</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Base-to-Constrainable</span>
</p>

<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Constrainable-to-Constrainable</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>C</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The message profile does not further specify the element definition beyond what is defined in the base standard. Since the message profile does not declare an explicit definition of the conditional usage and condition predicate, there are no implementation requirements. The specifier does not make an explicit declaration on the inclusion of the element. Therefore, the &ldquo;C&rdquo; usage is treated the same as the &ldquo;O&rdquo; usage indicator in terms of implementation requirements (i.e., the implementation requirements are determined in a derived profile).</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>C</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Base-to-Constrainable</span>
</p>

<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Constrainable-to-Constrainable</span>
</p>

<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Base-to-Implementable</span>
</p>

<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Constrainable-to-Implementable</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>C(a/b) with predicate</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">The message profile explicitly defines the true (a) and false (b) usage outcomes for the conditional usage based on the predicate statement. A predicate statement is required. This declaration defines explicit requirements for implementation.</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>Elements with a conditional usage indicator require a separate examination, because a specialization allows for different combinations depending on the characteristics of the constraint.</p><p></p><p>Compliance assessment for elements with conditional usage (i.e., C(a/b)) is dependent on the respective true and false usage code specification. For example, if conditional usage for an element is specified as C(RE/O), the true usage code &ldquo;RE&rdquo; can be profiled to &ldquo;RE&rdquo; or &ldquo;R&rdquo; in a derived profile. The false usage code of &ldquo;O&rdquo; can be profiled to &ldquo;R&rdquo;, &ldquo;RE&rdquo;, &ldquo;O&rdquo;, or &ldquo;X&rdquo;. The conditional usage codes may collapse to a single non-conditional code if the usage codes are profiled to the same code. For example, if the &ldquo;RE&rdquo; and &ldquo;O&rdquo; usage are both profiled to &ldquo;R&rdquo;, then the usage code can be specified simply as &ldquo;R&rdquo; and not C(R/R). <span style="font-size:16px">Table 5.7</span> summarizes the possible constraints applicable to conditional usage.</p><p></p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.7: Summary of Compliance Rules for Constraining Conditional Usage</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Base Profile
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Derived Profile
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Comment
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
C(a/b)
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
C(a/b)
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
The derivation remains unchanged.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
C(a/b)
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
C(a&rsquo; / b&rsquo; )
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
a&rsquo; is a valid specialization (constraint) of a, and b&rsquo; is a valid specialization of b; a and b can be constrained individually, the condition remains unchanged.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
a
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
If b&rsquo; is a valid specialization of b, and this is equal to a. For example, the usage is C(R/O), and because of the specific use case being profiled the specifier wants to further constrain the false outcome to R. Therefore, the conditional is C(R/R), which resolves to R. 
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
b
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
If a&rsquo; is a valid specialization of a, and this is equal to b. For example, the usage is C(O/X), and because of the specific use case being profiled the specifier wants to constrain the true outcome to never allow that element. Therefore, the conditional is C(X/X), which resolves to X.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
C(a/b)
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
a
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
If the condition is always met in a specific use case.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
C(a/b)
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
b
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
If the condition is never met in a specific use case.
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p></p>
</p>

<div class='box_v2web pink_box'>
<p class='p_v2web'>
<p><strong>A reasonable question is: should the condition predicate itself be allowed to change? </strong></p><p>The authors are unaware of any standard that provides guidance on this question. An example situation could be changing the condition from &ldquo;if the patient is male&rdquo; to &ldquo;if the patient is male and older than 18 years&rdquo;. Any change to a condition changes the result set as well. In the modified version of the condition in this example, some patients would be excluded because they are too young. In principle, such a change causes the application to evaluate the data in a different way, but it does not change the related usage of this element and, therefore, does not change the handling of this element. It is unclear whether this kind of change should be an allowable &ldquo;constraint&rdquo;. When changing a condition, careful consideration should be given to the potential impact on implementations.</p>
</p>

</div>

<p class='p_v2web'>
<p></p>
</p>
<h4>
5.1.5 Usage Compatibility
</h4>
<p class='p_v2web'>
<p><span style="font-size:16px">Table 5.8</span> provides a compatibility analysis of an element&rsquo;s usage in a sender profile to an element&rsquo;s usage in a receiver profile. For a pair of profiles to be compatible, all element pairs in the profiles must adhere to the profile compatibility rules. For example, if the sender profile specifies an element as required and the receiver profile also specifies the corresponding element as required, then the profiles are compatible for that element. If, however, the sender profile specifies an element as not-supported and the receiver profile specifies the corresponding element as required, then the profiles are not compatible for that element, since the receiver is expecting data that the sender will never provide.</p><p><span style="font-size:16px">Table 5.8</span> addresses implementable profiles where each element must be profiled; that is, no elements can be optional. <span style="font-size:16px">Table 5.9</span> addresses additional optionality choices available for constrainable profiles. <span style="font-size:16px">Tables 5.8</span> and <span style="font-size:16px">5.9</span> do not take conditional usage into account; an analogous analysis can be performed for each true and false outcome of the conditional usage.</p><p>Optional elements apply only to constrainable profiles. Often specifiers develop constrainable-level profiles for national specifications. Their goal is to specify elements that are needed to meet their use case requirements. Beyond that, they allow trading partners to negotiate among themselves regarding local customization of the remaining un-profiled (or optional) elements.</p><p>Defining compatibility among systems requires a comparison of the capabilities of the sending side to the requirements on the receiving side through the means of profiles. For assessing compatibility, use case requirements are defined in higher-level constrainable profiles and are thus not considered. For example, the assignment of &ldquo;R&rdquo; usage for an element on the sending side expresses the fact (or the intent) that this element is always valued in every message instance that is sent. &ldquo;RE&rdquo; usage expresses the intent that data will be present in messages if the data are entered into the system or are made available in some other way. In other words, these usage requirements identify what a receiver can expect in messages being sent to them. Statements for a receiver are clear expressions of their requirements. Therefore, a required element (&ldquo;R&rdquo; usage) indicates that the receiver must get this information in order to be able to process the message or a specific part of the message. Having said this, the pairing &ldquo;R  X&rdquo; is deemed compatible, since the receiver can ignore a data element for which the sender always provides data, although this behavior may not fulfill a certain use case or meet external expectations. Use case requirements must, therefore, be introduced as higher-level requirements (&ldquo;R&rdquo;) in the form of a constrainable profile that must be fulfilled by both sender and receiver, i.e., the implementable profiles must be compliant to this higher-level constrainable profile. Providing such a use case requirement would mean that the applications are compatible, although the receiver is not compliant (i.e., the receiver&rsquo;s implementable profile is not compliant with the constrainable profile). The receiver is conformant to its implementable profile, because this profile does not support the element; however, the fact that the receiver is not compliant prevents interoperability. In summary, specific aspects of compliance, compatibility, and conformance need to be met to enable interoperability.</p><p></p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.8: Sender/Receiver Pair Profile Compatibility Rules</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Sender
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Receiver
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Compatible
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Comment
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
R
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
R
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Sender and Receiver have the same expectations.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
R
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
RE
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver supports this element but is not always expecting it.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
R
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
X
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver doesn&rsquo;t support this element.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
RE
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
R
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
No
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver is not guaranteed to get required data.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
RE
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
RE
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Sender and Receiver have the same expectations.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
RE
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
X
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver doesn&rsquo;t support this element.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
X
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
R
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
No
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver will not get required data.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
X
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
RE
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
No
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver will not get the data it needs for certain use cases.
</p>

<p class='p_v2web'>
Note: a data value must be needed in at least one instance; otherwise, the element should not be profiled to RE. On the other hand, RE is the only construct that expresses the capability of the receiving system to handle the data.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
The element is not necessary for operation. 
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
X
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
X
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Sender and Receiver have the same expectations.
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>The analysis of optional elements for profile compatibility provides guidance for pairing potential implementable profiles derived from constrainable profiles. A definitive assessment of profile compatibility can&rsquo;t be made until implementation profiles are developed; however, the guidance provided here will aid in the specification of constrainable profiles. As is to be expected, profile compatibility of constrainable profiles is directly linked to the requirements of the compatibility rules of Implementable profiles.</p><p></p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.9: Compatibility Analysis for Optional Elements</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Sender
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Receiver
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Compatible
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Comment
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
R
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
O
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver does not express any expectations or requirements for the data and may support this element in the future. Compatible receiver profiling in the implementable profile includes R, RE, or X.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
RE
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
O
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Only RE, X
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver does not expect data and may support this element in the future. Compatible receiver profiling includes RE or X.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
X
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
O
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Only X
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver does not expect data and may support this element in the future. However, compatibility can only be achieved if usage for the element is constrained to X.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
O
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
R
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Only R
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver requires the data. Compatible sender profiling option is R.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
O
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
RE
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Only R, RE
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver expects data in certain instances. Compatible sender profiling options are R or RE.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
O
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
X
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Compatible sender profiling options are R, RE, or X.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
O
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
O
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Possible
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Compatibility can be achieved by following the rules for Implementation profiles as given above.
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>
<h4>
5.1.6 Usage and Conformance
</h4>
<p class='p_v2web'>
<p>The base standard allows broad flexibility for the message structures that HL7-conformant applications must be able to receive without failing; but, while the base standard allows messages to be missing data elements or to contain extra data elements, no inference should be made from these declarations that such messages are conformant in the context of a message profile.  In fact, the usage codes specified in a message profile impose strict conformance requirements on the behavior of the application. For example, the presence of unexpected content for an unspecified element in the message profile is a conformance violation. A case in point would be where data are present for a fourth component of a data type, but the message profile only defines three components for the data type. The determination of conformance and a receiver&rsquo;s business processing rules are separate matters. </p>
</p>
<h3>
5.2 Cardinality
</h3>
<p class='p_v2web'>
<p>A data element often must occur more than once in the instance of a message. Cardinality is the conformance construct that is used to indicate this requirement. Cardinality controls the number of occurrences of an element an implementation must support and the number of instances of an element that can appear in a message. Some elements shall always be present (e.g., cardinality [1..1], [1..n]). Others shall never be present (i.e., cardinality [0..0]). Still other elements may or may not appear in the message instance, with zero or more occurrences (e.g., cardinality [0..n]). Cardinality identifies both the minimum and maximum number of occurrences that a message element must have in a conformant message and is expressed as an interval of a minimum-maximum pair of non-negative integers. A conformant message must always contain at least the minimum number of occurrences and shall not contain more than the maximum number of occurrences. As an example, a cardinality of &ldquo;[0..5]&rdquo; would indicate that the element need not occur in the instance at all or it may occur up to five times; an implementation must support up to five occurrences of an element.</p><p>Cardinality boundaries apply both to primitive data of a simple data type and a collection of data contained in a complex data type. An explicit cardinality range is required for segment groups, segments, and field elements.  Component and sub-component elements do not explicitly include a cardinality range, but a cardinality range is implicitly associated with each component and sub-component element.  The associated cardinality depends on the element&#39;s usage code.  For components and sub-components with a usage code of R, the associated cardinality range is [1..1]; for all elements with a usage code of RE or O, the associated cardinality is [0..1]; for all elements with a usage code of C(a/b), the associated cardinality is determined by the resultant usage based on the evaluation of the condition predicate; and for all elements with an X usage code, the associated cardinality is [0..0].</p><p></p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.10: Cardinality</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Cardinality</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Interpretation</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Valid Usage</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>[0..0]</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Element is never present
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
X
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>[0..1]</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Element may be omitted, and it can have at most one occurrence
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
RE, C(a/b), O
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>[1..1]</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Element must have exactly one occurrence
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
R
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>[0..n]</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Element may be omitted or may have up to <strong>n</strong> occurrences
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
RE, C(a/b), O
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>[1..n]</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Element must appear at least once and may have up to <strong>n</strong> occurrences
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
R
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>[0..*]</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Element may be omitted or may have an unlimited number of occurrences
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
RE, C(a/b), O
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>[1..*]</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Element must appear at least once and may have an unlimited number of occurrences
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
R
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>[m..n]</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Element must have at least <strong>m</strong> occurrences and may have at most <strong>n</strong> occurrences. Except in the case where the usage code is RE, the element may also be omitted (&ldquo;zero occurrences&rdquo;).
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
R, RE
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>[m..*]</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Element must have at least &quot;m&quot; occurrences and may have an unlimited number of occurrences. Except in the case where the usage code is RE, the element may also be omitted (&ldquo;zero occurrences&rdquo;).
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
R, RE
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>
<h4>
5.2.1 Relationship between usage and cardinality
</h4>
<ul>
<li>
<p class='p_v2web'>
If the usage of an element is Required (R), the minimum cardinality for the element shall  be equal to or greater than 1.
</p>

</li>

<li>
<p class='p_v2web'>
If the usage of an element is not Required (R) (i.e., any code other than &#39;R&#39;), the minimum cardinality shall be 0 except in the following condition:
</p>

</li>

<li>
<p class='p_v2web'>
If the profile author wishes to express a circumstance where an element will not always be present, but when it is present it must have a minimum number of occurrences greater than one, they may document this rule by specifying the RE usage code with the minimum cardinality representing the minimum number of occurrences when the element is present. This expression would be in the form [m..n], indicating that permitted occurrences are either zero or the range of m through n.
</p>

</li>

<li>

</li>

</ul>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.11: Example Cardinality-Usage Combinations</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">Cardinality</span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">Usage</span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">Interpretation</span>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">[1..1]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">There will always be exactly 1 </span><span style="font-size:16px">occurrence</span><span style="font-size:16px">.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">[1..5]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">R</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">There will be 1 </span><span style="font-size:16px">to</span><span style="font-size:16px"> 5 </span><span style="font-size:16px">occurrences</span><span style="font-size:16px"> </span><span style="font-size:16px">inclusive</span><span style="font-size:16px">.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">[0..1]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">RE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">The element must be supported, but may not always be present.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">[0..5]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">C(R/X)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">If the condition predicate is true, there will be</span><span style="font-size:16px"> </span><span style="font-size:16px">1 </span><span style="font-size:16px">to</span><span style="font-size:16px"> 5 </span><span style="font-size:16px">occurrence</span><span style="font-size:16px">s</span><span style="font-size:16px"> inclusive</span><span style="font-size:16px">. If the condition predicate is false, there will be 0 </span><span style="font-size:16px">occurrence</span><span style="font-size:16px">s.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">[3..5]</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">RE</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:16px">If any values for the element are </span><span style="font-size:16px">valued</span><span style="font-size:16px">, there must be at least 3 and no more than 5 </span><span style="font-size:16px">occurrence</span><span style="font-size:16px">s. However, the element may be absent (0 </span><span style="font-size:16px">occurrence</span><span style="font-size:16px">s).</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>
<h4>
5.2.2 Repetition, Occurrence, and Cardinality
</h4>
<p class='p_v2web'>
<p>Historically, the base standard has used the term &ldquo;repetition&rdquo; to indicate the upper limit and not the actual number of times an element may repeat (in contrast to its well-established dictionary definition). The terms &ldquo;maximum occurrences&rdquo; or &ldquo;maximum cardinality&rdquo; are the preferred terms when describing the number of times an element may appear in a message. It is important to note that if the upper boundary for repetition is n it means n occurrences and not n repetitions (i.e., n+1 occurrences). This document uses the terms occurrences and cardinality.</p>
</p>
<h4>
5.2.3 Cardinality Compliance
</h4>
<p class='p_v2web'>
<p><span style="font-size:16px">Table 5.12</span> lists the rules for constraining cardinality. The left-most column indicates the cardinality for an element as defined in the base standard. The combination of the information in the &ldquo;Derived Profile&rdquo; column (always m..n) and the &ldquo;Valid Compliance Rule&rdquo; column indicates possible modifications of the cardinality constraint. The associated &ldquo;Example(s)&rdquo; column provides valid instances. Likewise, the information in the &ldquo;Derived Profile&rdquo; column (always m..n) and the &ldquo;Invalid Compliance Rule&rdquo; column indicate possible modifications (invalid in this case) of the cardinality constraint. The associated &ldquo;Example(s)&rdquo; column provides non-valid instances.</p><p>For instance, a cardinality defined in the base standard as [0..0] and then constrained to [0..0] (m=0 and n= 0) is a valid constraint (row 1 &ndash; valid column); however, if the cardinality is constrained to [1..4], it is invalid (row 1 &ndash; invalid column). In <span style="font-size:16px">Table 5.12</span> it is assumed that &ldquo;m&rdquo; is always less than or equal to &ldquo;n&rdquo;. Generally speaking, the cardinality range must be constrained by increasing the lower boundary and decreasing the upper boundary. The minimum cardinality has to be less than or equal to the maximum cardinality. Additionally, for some of the examples listed in <span style="font-size:16px">Table 5.12</span> a specific value for a variable is used to facilitate the explanation.</p><p></p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.12: Compliance Assessment for Constraining Cardinality</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Parent Profile
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Derived Profile
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='2'>
<p class='p_v2web'>
Valid Compliance
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='2'>
<p class='p_v2web'>
Invalid Compliance
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_header table_v2web1' colspan='1'>

</td>

<td class='emphasis_header table_v2web1' colspan='1'>

</td>

<td class='emphasis_header table_v2web1' colspan='1'>
<p class='p_v2web'>
Rule
</p>

</td>

<td class='emphasis_header table_v2web1' colspan='1'>
<p class='p_v2web'>
Example(s)
</p>

</td>

<td class='emphasis_header table_v2web1' colspan='1'>
<p class='p_v2web'>
Rule
</p>

</td>

<td class='emphasis_header table_v2web1' colspan='1'>
<p class='p_v2web'>
Example(s)
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..0]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[m..n]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m=0 and n=0
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..0]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m≠0 or n≠0
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..1], [1..4]
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..1]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[m..n]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m≤1 and n≤1
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..0], [1..1]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m&gt;1 or n&gt;1
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..3], [1..2]
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..x]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[m..n]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
n≤x
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
x=3, [0..0], [0..3]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m&gt;x or n&gt;x
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
x=3, [4..6], [0..4]
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..*]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[m..n]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m≤n
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..200], [2..40]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m&gt;n
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[1..0], [5..1]
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[1..1]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[m..n]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m=1 and n=1
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[1..1]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m≠1 or n≠1
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..1], [1..2]
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[1..x]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[m..n]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m≥1 and n≤x
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
x=3, [1..3], [2..2]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m&lt;1 or n&gt;x
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
x=3, [0..3], [1..5]
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[1..*]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[m..n]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m≥1 and n≥1
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[1..1], [2..200]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m&lt;1 or n&lt;1
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..0], [0..200]
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[x..x]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[m..n]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m=x and n=x
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
x=3, [3..3]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m≠x or n≠x
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
x=3, [0..3], [3..4]
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[x..y]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[m..n]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m≥x and n≤y
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
x=3, y=5, [4..5]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m&lt;x or y&lt;n
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
x=3, y=5, [3..6]
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[x..*]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[m..n]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m≥x and n≥x
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
x=3, [3..3], [4..5]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m&lt;x or n&lt;x
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
x=3, [2..2], [2..6]  
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>It is important to note that this analysis does not account for the dependencies that an associated usage constraint places on cardinality constraints. In <span style="font-size:16px">Table 5.12</span>, the usage reference point is O-optional. For a cardinality of [0..1], a valid constraint is [0..0] as indicated in row 2 &ndash; Valid Compliance column; additionally, [1..1] is also a valid constraint. In the context of a related usage, such constraints may not be valid. For example, for a cardinality of [0..1] and an associated usage of &ldquo;RE-required, but may be empty&rdquo;, the maximum cardinality must be 1 (allowing for appearance of the element). Likewise, if the usage is &ldquo;X-not-supported&rdquo;, then a cardinality setting of [0..0] is the only valid constraint of [0..1]. See <span style="font-size:16px">Section </span><span style="font-size:16px">5.2.1</span> for additional information on the dependencies between usage and cardinality. </p><p>Note that the set of constraints given in <span style="font-size:16px">Table 5.12</span> can be applied to any profile level in the hierarchy (i.e., the constraint table can be applied recursively). Additionally, once a constraint has been applied, only further (or the same) constraints can be specified in the (another) derived profile. For example, if the base profile &ldquo;A&rdquo; has a cardinality of [0..1] that is constrained to [1..1] in a derived profile &ldquo;B&rdquo;, then in derived profile &ldquo;C&rdquo; the cardinality constraint must remain as [1..1] (as indicated in row 5 of the Table). On the other hand, if the base profile &ldquo;A&rdquo; cardinality of [0..*] is constrained to [1..5] in a derived profile &ldquo;B&rdquo;, then in derived profile &ldquo;C&rdquo; the cardinality can be further constrained to [2..4]. In this example, the constraints transitioned from [0..*] (see row 4 of the Table) to [1..x] (see row 6 of the Table), and finally to [x..y] (see row 9 of the Table).</p>
</p>
<h4>
5.2.4 Cardinality Compatibility
</h4>
<p class='p_v2web'>
<p>Compatibility is a measure that indicates whether two specifications (or systems that implement the same specification) have harmonized requirements. Compatibility is determined from the perspective of a receiver. <span style="font-size:16px">Table 5.13</span> presents an analysis of compatibility for a set of sender/receiver cardinality pairs. The analysis is a direct assessment of the sender/receiver pairs indicated and does not consider what pairs might actually be enacted for an element in a particular use case. For example, in the case of a sender cardinality of [1..1] and a receiver cardinality of [0..0], the receiver doesn&rsquo;t need the data element to be valued in order to operate. If the sender has an expectation that the receiver must process the data element, however, then this requirement is indicated in the use case, and, as such, the receiver must set the cardinality for the element to [1..1], which would be part of the profile/interface negotiations.</p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.13: Compatibility Analysis for Cardinality</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Sender
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Receiver
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Compatible
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
Comment
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..0]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..0]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Sender and Receiver have the same expectations.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..0]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..m]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver can process data but can also handle absence of data.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..0]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[n..m]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
No
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver will not get required data if n&gt;0.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..1]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..0]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver has no expectations.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..1]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..1]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Sender and Receiver have the same expectations.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..1]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..m]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver supports more than the sender.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..1]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[n..m]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
No
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver will not get required data if n&gt;0.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[1..1]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..0]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver has no expectations.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[1..1]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[0..1]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver processes the data.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[1..1]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[1..1]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Sender and Receiver have the same expectations.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[1..1]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[1..m]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver supports more than the sender.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[1..1]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[n..m]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
No
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Receiver will not get required data if n&gt;1.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[x..y]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[n..m]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
If m&lt;x.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[x..y]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
[n..m]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
No
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
If n&gt;y.
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>
<h3>
5.3 Data Type Specialization (Flavor)
</h3>
<p class='p_v2web'>
<p>Data types and specializations of data types are core aspects of the HL7 v2.x standard and implementation guides. The HL7 v2.x standard provides a set of data types (referred to as the &ldquo;base&rdquo; data types). Typically, the base data types are not used &ldquo;as-is&rdquo; in implementation guides; instead they are constrained for a particular need in the profiling process. The specialization of the data type is referred to as a data type &ldquo;flavor&rdquo;. Each element in the data type can be constrained following the rules defined by the conformance constructs. The data type flavor is assigned a new identifier that can be referenced by other elements as part of the profiling process. </p><p>An example of data type specialization was given in <span style="font-size:16px">Section 4.4</span>. Additionally, a detailed discussion on data type specializations and on the HL7 v2 standardized data type library can be found in the HL7 Version 2 Specification: Data Type Specializations, Release 1 (currently in ballot resolution) and on the web site https:/v2.hl7.org/datatypeflavors (forthcoming). The goal of standardized data type flavors is to promote consistency and reuse of commonly used data type specializations.</p>
</p>
<h4>
5.3.1 Root Data Type Substitution
</h4>
<p class='p_v2web'>
<p>Under certain circumstances, a use case may require a data type substitution at the root level.  One example would be when an IS data type is replaced with a CWE data type. Root data type substitutions are promotions, that is, more functionality is specified. The following compliance and compatibility rules apply:</p><p>When a substitution is made, a data type in which all constituent parts and attributes are compatible must be specified. Many substitutions are possible, and specifiers should exercise caution when changing the root data type, as detecting non-compliance can be challenging. <span style="font-size:16px">Table 5.14</span> provides a few examples of root data type substitutions and an analysis of the substitution.</p><p></p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.14: Root Data Type Substitution</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Replaced</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Replaced By</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Analysis</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Comments</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>IS</strong>
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>CWE</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Valid
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
1st component of CWE is compatible with &ldquo;IS&rdquo; data type
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>CWE</strong>
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>IS</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Invalid
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Data type demotion; fewer capabilities
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>TX</strong>
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>FT</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Valid
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Primitive data types; expands capabilities of text
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>CWE</strong>
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>CNE</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Valid
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Same structure, added usage constraint; in essence CNE is a data type flavor of CWE.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>ST</strong>
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>TX</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Valid
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Contains the same sort of data. Allowable content differs.
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>
<h4>
5.3.2 Data Type Compatibility
</h4>
<p class='p_v2web'>
<p>Data Type Flavors can be replaced in derived profiles; however, requirements can only be strengthened. In general, the compatibility rules apply for each element in the data type flavor. For example, if a data type flavor specifies an element with R usage, the replacing data type flavor must also specify that element with R usage.</p>
</p>
<h3>
5.4 Content
</h3>
<p class='p_v2web'>
<p>Content constraints limit the allowed values of an element. Content constraints include coded values, fixed values, pattern restricted, arbitrary data values, and element relationships.</p>
</p>
<h4>
5.4.1 Coded Values
</h4>
<p class='p_v2web'>
<p>Content is restricted based on a vocabulary definition that is bound to an element. The vocabulary definition may include a set of codes that can be used to populate an element in a message instance. The code set is associated with a specific element (which is known as &ldquo;binding&rdquo;), and the bound code set should only contain codes that are meaningful for that element in a given context (use case). The base standard does not and cannot provide the necessary granularity or depth of specification, because it is designed to have broad utility. Therefore, the base standard provides a starting point, which includes normative (HL7) tables or informative (User) tables or may merely include a placeholder (i.e., a concept domain). The process of profiling elements that are bound to code values includes providing the value set definition, the binding to the element, and the strength of that binding.</p><p></p>
</p>

<div class='box_v2web pink_box'>
<p class='p_v2web'>
<p>Appropriate code set constraints should define and bind a code set containing only the values suitable for a particular data element; often, however, this rule is not followed. A common issue found in specifications is a single code set (e.g., an HL7 table) being applied to multiple elements for the sake of convenience, even though not all values in the value set are meaningful (suitable) for every element. The implementer is left to figure out which values in the given value set are appropriate for the data element in their particular use case.</p>
</p>

</div>

<p class='p_v2web'>
<p></p><p>Vocabulary constraints are described in detail in <span style="font-size:16px">Section 6</span>.</p><p><strong>Fixed Value:</strong> A fixed value constrains the content to a single value, e.g., &ldquo;A08&rdquo; that indicates an update event type in ADT messages. The more detailed and specific a certain data exchange specification is, especially in the case of specific use cases, the fewer possible options are valid for a data element. In some cases, the options for an element are reduced to a single value, thus providing a fixed (constant) value. A Fixed Value is represented in the message profile by the fixed value constraint attribute or can be specified by a conformance statement (See <span style="font-size:16px">Section </span><span style="font-size:16px">5.7</span>).</p><p><strong>Pattern Restricted</strong><strong> Value</strong><strong>:</strong> A pattern-restricted value constrains the content of the element based on the specified pattern matching algorithm (e.g., a Medical Record Number format). A pattern-restricted value is specified using the conformance statement mechanism (See <span style="font-size:16px">Section 5.7</span>).</p><p><strong>Element Relationships:</strong> Elements may have relationship constraints that must be maintained. This includes dependency of data values. Element relationships are supported by the co-constraint construct (see <span style="font-size:16px">Section </span><span style="font-size:16px">5.8</span>) and conformance statements (<span style="font-size:16px">See Section </span><span style="font-size:16px">5.7</span>).</p>
</p>
<h3>
5.5 Length
</h3>
<p class='p_v2web'>
<p>Length is defined as a constraint on the number of characters that may be present in the data value of one occurrence of a data element (object). The definition is system-independent; the number of characters is what is important at the application level. The application must be designed to ensure that storage space is adequate to suit the defined length, even if more bytes are necessary to physically store the data. </p><p>The definition and requirements for length in the base standard have changed over various versions. Although specific requirements were not always clear in the base standard, specifiers have the opportunity in message profiles to be definitive in specifying length requirements. Specification of length requirements are optional in message profiles. Additionally, length requirements can be specified selectively for certain elements where length requirements are of concern. Those length requirements that are specified using the methods in this document are deemed to be normative. Length requirements are only applicable to primitive data elements. Length constraints include Minimum and Maximum Length, Conformance Length, and Truncation Indicators.</p>
</p>
<h4>
5.5.1 Minimum and Maximum Length
</h4>
<p class='p_v2web'>
<p>Length is expressed as either a minimum and maximum pair (e.g. 1..20) and indicates the number of characters an element may have. A constraint on length restricts the range and thus reduces the capabilities, e.g., [1..2048] to [1..1024]. In some sense the length constraint is a bit counterintuitive when compared to usage. Usage requires that an application add capabilities, whereas a constraint on length may mean reducing an application&rsquo;s current capability (as configured). The specific needs of a use case will dictate whether length constraints must be applied.</p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.15: Minimum and Maximum Length</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Length</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Interpretation</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>0..0</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Not supported element; minimum and maximum set to 0.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>1..1</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Element must have exactly one character
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>1..n</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Element may have up to n characters
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>n..n</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Element must have exactly &ldquo;n&rdquo; characters
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>1..*</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Element may have any length.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>m</strong><strong>..*</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Element may have any length which is greater than or equal to &ldquo;m&rdquo;, where &ldquo;m&rdquo; is greater than or equal to 1.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<strong>m..n</strong>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Element must have a minimum length of &ldquo;m&rdquo; and a maximum length of &ldquo;n&rdquo; where &ldquo;m&rdquo; is less than or equal to &ldquo;n&rdquo; and &ldquo;m&rdquo; is greater than or equal to 1.
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p>Length compatibility (<span style="font-size:16px">Table 5.16</span>) is based on a single criterion, that the receiver&rsquo;s capabilities are greater than the sender&rsquo;s capabilities.</p><p></p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.16: Testing Possible Combinations of Implemented Length</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Sender</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Receiver</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Compatible</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
Implemented Minimum Length
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
&lt;
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
n
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
No
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
=
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
n
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
&gt;
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
n
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
Implemented Maximum Length
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
&lt;
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
n
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
=
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
n
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Yes
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
m
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
&gt;
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
n
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
No
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>
<h4>
5.5.2 Conformance Length
</h4>
<h4>
5.5.3 Truncation
</h4>
<p class='p_v2web'>
<p>The conformance length can be indicated with truncation behavior requirements. In the base standard, &ldquo;=&rdquo; denotes that the content of the element must not be truncated, and the &ldquo;#&rdquo; denotes that the content of the element may be truncated, and, if truncated, the rules for indicating data truncation must be followed. </p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.17: Truncation Flag Setting Allowable Transitions</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Indicator</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Transition</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Allowed?</strong></span>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>Comments</strong></span>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>#</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">#</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Yes</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Same requirement</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>#</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">=</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Yes</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Requirement Strengthen</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>=</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">#</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">No</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Requirement Relaxed</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"><strong>=</strong></span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">=</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Yes</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">Same Requirement</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>
<h4>
5.5.4 General length Conformance Rules
</h4>
<p class='p_v2web'>
<p>The following list provides a general sets of length rules and observations that need to be considered when applying length constraints in message profiles:</p><p></p><p>Length constraint specification is optional in message profiles, either entirely or at specific data elements. If not specified, base standard requirements apply.</p><p>If specified, the following length rules apply:</p><p>Length constraints can only be applied to primitive data elements.</p><p>The Minimum Length and Maximum Length must be both be specified.</p><p>The Minimum Length and Maximum Length must be specified as a range of two non-negative integers in which the Maximum Length must be equal to or greater than the Minimum Length; an exception to these rules apply:</p><p>In a constrainable profile, the Maximum Length may be unknown and therefore may not be specified; in this case, the Maximum Length must be represented as ‘*&rdquo;, e.g., 1..*.</p><p>Minimum Length must be 1 or greater (expect for elements with X usage).</p><p>0..0 would be the length if specified (best practice is to not specify a length).</p><p>In a derived profile, the Minimum Length must remain the same or can increase (given that the increased value is not greater that the Maximum Length).</p><p>Whereas the base standard (versions 2.3 to 2.6 inclusive) specifies the Maximum Length as normative, it is not considered as a constraint in a message profile. There are contradicting requirements. The specifier, at their discretion can specify any length constraint that satisfies their use case requirements.</p><p>Whereas earlier versions of the base standard specifies the Maximum Length for composite data elements, a message profile must not.</p><p>The Conformance Length constraint is not applicable in an implementation profile and must not be specified.</p><p>For conformance testing of a message that claims conformance to a constrainable profile, the Conformance Length will be treated as a Maximum Length constraint.</p><p>Whereas Conformance Length is informative in the base standard, Conformance Length is normative in a constrainable profile when explicitly specified in a message profile.</p><p>Whereas the base standard is not prescriptive on the strength of the truncation indicator, the conformance methodology (this specification) is, and asserts it as normative.</p><p></p>
</p>
<h3>
5.6 Slicing
</h3>
<figure class='center'>
<img src = 'data:image/png;base64,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
dj16Js7YtA0y/9nTFktRoG3rCx1EKEPJUxo1clc4aX7GGdnIz2Hdc888c/Ct
fRjWByaVecXCgOOnz0Dt/r16+ppbsfYtXXni+XmJmhz/7jtff/m5fsuWO0eP
+XlRLwgxh8qbqOAI2F9SSY5V2j8rwKubml9XfODqY0xBLi2aN//rqhXBByC3
JTEimFSvz32ufdu2kvz10aMLV6xk0nI+csjgcSVDg7eY2MfgdRNLYgLzSoDm
lpbPzEZO/uqC1eU9e8N6L86Y3u3aa9SQIB0/YvjwgQN8TcNcXGnbujVvO28V
FUvaXy6OnTqN9xAcun7RAng2f93Jk2T7swJ5Arb2iR0z9D6U3l9ZWVCqn9q4
MXP1ucmT0GranLkny8MtKEyqUwasHi4dxt1RUx53tAXf8RpL5DvMeca69w3d
b+zUkcJvvn3iv3ml7imvopfLZ2LwQqxPvrCgVsBSx5Q0xza/A8pbnfiaAn8c
E8NqzBzCbQr3YDX4okK4P77qWCIhNL75hu6YV1TE4nPVU+imGJxKulCUq0g0
ygXppHM4rSQcWHzV+clF2VCKiM17ZRkXQU9IcisxIqYC3JLC4OZzHoFa11MA
OOiWm+EjuEwDUfLweI7lj8aOvk0c16tb147tr+IEAz8gCBDrxAdGZlQlxIhb
leoQMMrL2bOx6q11yCIe5CQyUXHltu3cyUU8o3Zt2jAxOt9e7OYGk/C24SN4
4XOXHRdp+65PXHXuXt+334atWyEs7nZq357qeF4Bp5avY/2KenBl285dup5a
NwrTokpKN/cTyiAadeToUXcRr/nuMePC4di7e3e6v3Hru97q/ORipw7tuaiI
2Nvvf0DHY0HJNm1ESehAF1wtrFcVAEMUA3BwAz3vgtKuvXspjxOaWlXxEeE5
op8xO657dxclcBUZAgUxLjr/fChMg+7rRYpWEEhdCuzevz8cblYrNAJGeaGh
i1XEFtAOEYycOAlLSu6tNqwMph+hPSJoeEbEsHwzfPafllDslafKucs+p2wS
u+oyqe4Z9xARn1XPPD119CjdnTZ2DFwwadZTIZRu1vR0alXs2BFEN0jWuXLS
zf08UFlJ3Grdwhd0ce2C+cxevL9wLrO8wsWrVnt7VL5gIT8xuNxFeIpWKlav
BEOalp/+6MwnHfuz5gAyXAcltAIxcKOMzDRtF7ZqxZEhSI0efKR1DOIA4P9Q
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
/LdPrVrtZbSj337L7jAdN/f5Wx75A8eMUM6oMK2jw02jx0klTviZkYQQhR+Y
XMYzPaF8lq8u/0a6ZcfO3OLEd4sJwHXuJt6ipO569y79B9DKgS++CKEeVbZu
24ZMKcORc+ZhalEq7N37lJTOmP9CUoXDaZVRrbT/wZI+ZiQwh4UTx0vaCuTj
333H8eixYzls8WSJijrlwSaDyqb81/aPLmnZ8heXXvLN8eOTF/0pBaOd0/R0
hkrHPG3Xj/gtOsCz6HNO06Yf7dvHz7Fz5uapOYkdNqCY47Q5c32zbtKsp76p
qho5ZPCpjRt7FYA1lq9ZwxXurnprXaJumh6XtW7duUMHdk4+3Llz7stL2/Xo
mUisabs275Vlvx58Jy22a9MGaTTKedHd96ZmPYohWQqwt2jefP2WLeOnz7i8
Z+9lb8aUD77lxMxxmkgZWufovdigXr3gKuW2pG+8nFYN6tfPbUMnXVqk/6wA
9tSld97NGLwxZXLrc87RYCx6a93mHTvLR5TqJ3YWx89eXFxjQ4Wl+Yc7Bna+
rK3TZ/Szczj/y4wnzg5GteH+rADmD3QAN61b+IKahv4gmlMaNfpg5XIf5UEZ
d44eAxXCkt4qDiXsKfjl9bnPtW97oiOw5MIVK2mCMlQcVzI0OKToVnX8eP9e
Pc8980xqIapb8cD9lZWDb+0zdfSo6uTo335/XfGBK4CN+djMcpH1izOmd7v2
moA6CAqIYGn5zIBVUhcT2uNHDB8+cEBOBGYpJHG8vAJz3v0stU1d3f6sQLX4
7Ik7WRhTju/4eXvXLo7v8jow1Ql/e8YfHd9JH5U8fORIXvWBUDA6sMWcBTQ1
TrVwio/vuFi+YCHHof1vV5Ug7ipCmN7PTZ5ERYgySBXXXypCkeI7NkQNvOVm
Tg5UZuYmI2FO2SSIkrqjpjyeVzxNeGEiEHXHllHZtmdv8OUIbEDsPo7e4Vy1
eYs39MZP793EWGG4R6H+T/8tXMWAteCRsgd/R2EibphREB9mGnbNzTf4/wYX
bAXN9e7enSq943cx3wK2gjRkZlQlheTGDRsGbNdbbMzQ+zBdMRLX/uUdd53+
YukogPXzol7ekB9XMPEoCSAqQElVBArgoryuExELHY+jRSRw9PVI1/UewsFX
fI3dRd9QJrFRuubrTgigUlThCUEx4rPqOCfuTYkyXoicEF0HLl2RBAcdEnxh
VgUTuMiJijnYs+lLpCnvigv+nWAZUTOWLz47/GUQHKvicVwdtRFlGzZ9JhE3
rEV2TvjJqq7uTlnyIrHCA4cOD+vdc/Tt/9G4fn0CczQXpC0ngROfKRq8ekYl
cfQUKSOENzG+lDH+BwffK0cEd2OnjhyxDTkuzyQ01q+oB1W27dyVkW7ewhDN
E8/P48pdfX8TQghMLR7ftXevqkMf+OlHjh7F02SPdXz6jLvHjNNdrsgwxKRV
AXWBOdz59mKmeqcO7VUGlxlyDMd6nTu0R+b8V5b5eqQr7S5qwxHvniPEd33f
fhu2bnUBShr1hjWJlt42fMT+zz8ngIBi8DvdyQlfSDcFFpB5bhwQWuH9AYDi
a0IZtMjrwWfIP7vkJe5e3a4dR24RUUXCkaoqxQ15ifLz1pJSt7ikNZPtuz4h
aKtiyAwx3L4qkaY8sJj9n/dDQ/DUtcPvh7wcVQVEFgtuwZq3kEA0cMGYUezb
n3sGdpNFhrQnl69kYWTVxMce7HvbfUU9Xp08ocfVHVgt8VmCvuawIllX0bot
Eoq7d51ROiygSlkWmzomFhpjnYGHmEf5ovPPTxQoguvY/iqOuIrE8nwWU2od
msUjkhU7dmSkKlOaGcWOmQDRNGnUiGCcCxRmJIrCZzdrpumkigcqK5FGEBMP
mn3tgvla69Ck5UqfX/2SkxZnnaUCYsyDh7/s1L49gU58fy5ynDY2lsax9M9v
ZKoP5YGaRkHSy5gYa1zBoHZOvUYHeqVdAot/XbVCdDx++okgI9UVYKUXRANQ
jH4hge6kXbQZO3UazOj26rJSYF5IbdOSxUQJFHNY9czT6OD4Wvhs3Pquw0Hr
XdTSrQcmlfFmdb2gIxWrV2qNy+cxUAtY1FlvWDYEwqoSdcojirdp+h/hFLCA
vEhAwQQL7ue+sultKk68c7CLBjZp2AB2088V78T8ppG/6cNFN0KD4kP+5vs/
xtQTB69s8RKMQXa4GD795vi3//P1/xt6jDOqyNSS48nW9ZqrE+syo7Ru4AJ8
xb17xXr0dgyK4JuWU4NvH/zt41i8f/oMJjx1mTzORgsuxFfSZV1ACt6lDLoG
u1H40FdfpRDO7GXOewOdF7RqSflMI4yuidL4UoaXMYWqDGq3adHGtYufzi0Y
TfaRqo+69x6vYjKHX9uwMTVWMA5y3I4hmbQ8DwmIeV+HOufBUHm9IRYsX+Gq
i/7Ed7xIaIIRRHOnJDLRmbs+O5diL5fPTIwmhx70qFMewMFHE4cMxjqT44kJ
Fpz1Ptq7DwnnnRkzGRK37Xtid9dVVMhk0y4erPLk+iVW/NvcZ1kjZsd4LLqm
w+rNW277w4Sdn34aepiDV4TR9DhSRcsXvk0z6obrrnPXZe5hQWSU76YsjeDb
oFtu5iXPvmfDOtZAYD3ozwWGgsvxljy3+Yn1EF2k7zIk2fEKA8pkAtN31Qpn
37mGiuJLVV5bjHPGQgi7TSaq22IEHQdz9/79HD/csZMjXOn64hRLm1jHCrtA
1r5v4/oUIDDcGKGuFW9JrG+tazl3W2wrKqz4OGbgYyD7iExvHcebEkhaUg75
DoFGeSdGCuLD8XzxkXHyc19/90ebPMWof3r4MHe9C77ewsjhJ8ajTDbt/ORi
o2DpTkiGjjFCCTg++PSzASdhNsVKHh5P9cVPTJNn53OFtKxBASws96yTl8e0
hIO8jkwKHfAHuSszKsSmSNwrT5VTF4vPuwQRXNpnBw9S2HEHQgiQExGTIcnu
m3hJJYMGnEumIWEsZ4EG1yGxZGw5qHt3kBTIaMU5nU07571gQjRCxvVFpjEX
w632JO0Ro08wjoiha8VXTEvqK9bGnnZ5tTxRCkRUHjrE8dILL8gGq9B1jfL+
CTooZmivIi6RmhcEU/iRYtUtfRDF4+4rf3hEJpt3zygPptc1sbefCDSvW8y6
iUeOeDTLHx1PW1q9dY1CanJIvdOJc11cHOwrERW7qXOnbPriHPAQ7q0jbq0Y
YKbdM+4hAuQYj5iQMnCcd59CyVkLF0ElwEVUS7WwkrLpFHX73nQjR9lE8mpl
GaXevDYpETEK++w1qYcbnk5SoPtwMYMOhREAdSahr6YsVoV99S4UCbI1ahCL
87hAaqAmc1fIKM+P5bH4OlHA7yvanteKwtt+WPjzyTrnjKZcOfaPf2Q5Xv/z
9ddxlWLS8re5ZdCHSktoBdbT6i0T2zWqqeh90J2zyfXERbpEbeU4c93nrIXo
l+Z58zPOyLQuAXL6xYxVBEo8ToAsiD3lbUum0+Ojf590kSdTrVQe5w6TGZtI
/rKzjLzStG7rNkrKJpUNxSoqx2PHf/xKMpwmKWotefU17hJ6S5HL7da18G31
khMJsl1+8UUct8WtUe8mg12Unb8t0pRXMn0mq7ReG401VjmenX74ZiA19Ld2
/AUFHl/ykhOiL2QVd7vhilj2/7SXlvrWQ2ilOsOQuj6VEDX2udjXZv26ds7f
c4BkPkuIBchGDHeLg1q9dWnDTC0tuiU+6PLIKJzCt8W2Irui3/0jKeZtJUin
8Dp9LjbmJ/M8Mc6VWhpdIIFDX4DIjGWT0eFNmmGW+haU9SmYL8DHqjEXFUHT
lmUsT0K0Ajvk96MZDqU9+jZGxH20B6oMnKvFidY6yp6e7Qut8rLJKP07BZJN
Gsc67rWvk64FlxT3pxhLybzkIDL3XLm1aW8oFsyVHK5a+dv+NX+iC1/yKQ3q
Q3DseKDE8iAmOY/EzkjZC6J/0dUdnln9mnJcSJ2jCqsfHC+Pmw/cfXfXLuTz
2SwyG9arhwm5evNWIoB4u0m/HmtUr55UwqY794ymTiU07NspK08wdXeYD6Iz
5dlp4xnVJ2WkFJAi4F10S5TGTEPCzPkvsM7g7pL00OSHj3NdUlWIr6zwOomX
scvfhI/kSif9MsSnm8tHI+1OcS66OXvCYy7BBXtTeWSUvP7KKwjzYb5pAcdt
bpZCvgqcAQieGuwJiUNS8CZLjegZ5LFJXaZXt65gLlW9w+FqQR8UiH2w3KaN
oEBbfSXNhq26uaKCu8TapBhWIQ4mbwi8XW+yS2hV8bUVKwQr4qGb3ntfS16+
VXgZ8hp3H5HNnzqFbDuEwJX0wg2NbO3QigWpGGkrj5WBJ0eUKn8YquJI0ty8
UQ9y3WFHtE4BO21QkjvqCrl4LPXCUEhgRxoyHWOqCfxf0uu0dnFJq5Y0UR2l
8nkZ5VGDP3AglRA4+a4hJPR5M12CDG1GZeAmykMEvkg5n5SJDngJv7p+A2Wq
Cy3xpOqTBi3SKVLuTXqArSBQ0q9CfFW6ftEC6jLVlT+BecXcIIKWenqItlzK
BbqhA6lzJHn5UlJIK1PmGtOYFU9I+eGEREhmqTIQYRmYEcl0hJIoAwGRGt22
dWvk+LiyulGQaZl0g17F7F7LyFuyZ7euxBa0vsR1oAAfL5fxJiAuCZWgmNYu
0C11GmPqlQ0Zua4MbwukoZ6Ij1v8ZAXW1x2eJVmsicY4fURn3aUXPCd0GZ29
X0z7Gs3oeU5RONJ/ViBXIBaanHB/VqDQehFlffD4YBMowMfphfbHCApzjOzP
ChTmuJhWhkByBIjBybPOfoXHIE5EINKOrT0QhkABIqAvrjJdPi7AjhSmSkZ5
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
rkJggg==
' alt = 'Figure 5.1: Overview of Slicing Concept' />
<figcaption>Figure 5.1: Overview of Slicing Concept</figcaption>
</figure>
<h4>
5.6.1 Slicing Using a Discriminator
</h4>
<p class='p_v2web'>
<p>The slicing type &ldquo;discriminator&rdquo; assigns a data type flavor to the field slice (occurrence) based on an evaluation of a discriminator value. The discriminator must be a primitive component within the field. For example, when PID-11.7 (address type) = ‘H&rsquo; then the data type flavor XAD_1 is assigned to the field slice (PID-11). PID-11.7 (address type) is the discriminator and ‘H&rsquo; is the discriminator value. The discriminator value can have three evaluation types:</p>
</p>
<h5>
5.6.1.1 FIXED VALUE DISCRIMINATOR SPECIFICATION AND EXAMPLES
</h5>
<p class='p_v2web'>
<p><span style="font-size:16px">Table 5.18</span> and <span style="font-size:16px">Table 5.19</span> show an example of slicing for the Patient Address field using the Fixed Value discriminator method. <span style="font-size:16px">Table 5.18</span> shows the field definition for PID-11 (Patient Address). The cardinality is defined as 0..*. The base data type is XAD and the default slice data type is set to the XAD_0 data type flavor. The discriminator is 7 (Address Type), which indicates a component position within the field.</p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 5.18: Field Definition of Patient Address (PID-11): Slice Type = Discriminator Fixed</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Field</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Min Cardinality</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Max Cardinality</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Base Datatype</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Default Datatype</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Discriminator</strong>
</p>

<p class='p_v2web'>
<strong>(Position)</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">PID-11 </span>
</p>

<p class='p_v2web'>
<span style="color:#000000">(Patient Address)</span>
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">1</span>
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">*</span>
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">XAD</span>
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">XAD_0</span>
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">7 (Address Type)</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p><span style="font-size:16px">Table 5.19</span> shows the definition for each slice. The discriminator indicates the actual value that triggers and defines a &ldquo;slice&rdquo;.  The first row in the table indicates that when (if) the discriminator contains the value of &ldquo;H&rdquo; then the field must conform to the requirements defined by the XAD_1 data type flavor. The field slice with these characteristics must appear in the message instance and only can appear once in the message instance. The requirements that dictate whether the field slice must appear are specified by the slice minimum and slice maximum parameters. Likewise, if the discriminator value contains &ldquo;M&rdquo; then the field instance follows the requirement indicated by the XAD_2 data type flavor. The field slice with this definition need not appear in the message (Slice Min = 0) or can appear more than once (Slice Max = *). Other discriminator values can also apply, but, since they are not explicitly listed, the default data type flavor defines the requirement for such field instances; in this case, XAD_0 is the data type flavor (see <span style="font-size:16px">Table 5.19</span>).</p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.19: Slice Definitions</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Discriminator Value</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Slice Datatype</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Slice Min</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Slice Max</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Comment</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">&ldquo;H&rdquo; (Home)</span>
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">XAD_1</span>
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">1</span>
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">1</span>
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">If PID-11.7 = &ldquo;H&rdquo;, then the requirements for this field slice are defined by XAD_1 data type flavor.</span>
</p>

<p class='p_v2web'>
<span style="color:#000000">A field of this definition must appear once and only once.</span>
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">&ldquo;M&rdquo; (Mailing)</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">XAD_2</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">0</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">*</span>
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
<span style="color:#000000">If PID-11.7 = &ldquo;M&rdquo;, then the requirements for this field are defined by the XAD_2 data type flavor.</span>
</p>

<p class='p_v2web'>
<span style="color:#000000">The field slice need not appear or may appear an unlimited number of times.</span>
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>The profile XML representation for this example is illustrated in <span style="font-size:16px">Figure 5.2</span>. The &ldquo;slicing&rdquo; element is a child element of the PID-11 (Patient Address) field in the profile.</p><p></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Slicing SliceType=&quot;</span><span style="color:#000000; font-family:Courier New,Courier,monospace">discriminatorFixed</span><span style="color:#000000; font-family:Courier New,Courier,monospace">&quot; DefaultDataType=&ldquo;XAD_0&quot;&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Slice Datatype=&ldquo;XAD_1&quot; Min=&ldquo;1&quot; Max=&ldquo;1&quot; &gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Discriminator Position=&ldquo;7&quot; Value=&ldquo;H&quot; /&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;/Slice&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Slice Datatype=&ldquo;XAD_2&quot; Min=&ldquo;0&quot; Max=&ldquo;*&quot; &gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Discriminator Position=&ldquo;7&quot; Value=&ldquo;M&quot; /&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;/Slice&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;/Slicing&gt;</span></p><p>Slicing is used most often for a field that has multiple occurrences. However, the discriminator method can be used for a field with a maximum cardinality of one. In this case, the field instance requirements vary based on the discriminator value, even though there can be only one instance of the field. For example, the discriminator could be the address type as in the previous example. If the address type is &ldquo;H&rdquo;, then the field instance would follow the requirements specified in the XAD_1 data type flavor. Likewise, if the address type is &ldquo;M&rdquo;, then the field instance would follow the requirements specified in the XAD_2 data type flavor. So, the field would follow one or the other definition based on the address type value (discriminator value) and in aggregate can only appear once, since the cardinality of the field is 1..1. Note, for this example, the default data type is not defined by specifier choice. <span style="font-size:16px">Table 5.20</span> and <span style="font-size:16px">Table 5.21</span> show the specification of this example.</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 5.20: Field Definition of Patient Address (PID-11): Slice Type = Discriminator Fixed</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Field</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Min Cardinality</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Max Cardinality</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Base Datatype</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Default Datatype</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Discriminator (Position)</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
PID-11
</p>

<p class='p_v2web'>
(Patient Address)
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
1
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
1
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
XAD
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
NA
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
7 (Address Type)
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.21: Slice Definitions</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Discriminator Value</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Slice Datatype</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Slice Min</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Slice Max</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Comment</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
&ldquo;H&rdquo; (Home)
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
XAD_1
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
0
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
1
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
If PID-11.7 = &ldquo;H&rdquo;, then the requirements for this field slice are defined by XAD_1 data type flavor.
</p>

<p class='p_v2web'>
A field of this definition need not appear and at most will appear once.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
&ldquo;M&rdquo; (Mailing)
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
XAD_2
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
0
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
1
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
If PID-11.7 = &ldquo;M&rdquo;, then the requirements for this field are defined by the XAD_2 data type flavor.
</p>

<p class='p_v2web'>
A field of this definition need not appear and at most will appear once.
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p>
</p>
<h6>
5.6.1.1.1 EXISTS DISCRIMINATOR SPECIFICATION AND EXAMPLES
</h6>
<p class='p_v2web'>
<p>The &ldquo;Exists&rdquo; discriminator methods work much like the &ldquo;Fixed Value&rdquo; discriminator method except that the discriminator value can be either &ldquo;valued&rdquo; or &ldquo;not-valued&rdquo;. Only those two possibilities exist. <span style="font-size:16px">Table 5.22</span> and <span style="font-size:16px">Table 5.23</span> provide examples. The field definition defines the minimum and maximum cardinality for the field and the discriminator. However, there is no default data type flavor since the slicing definition (<span style="font-size:16px">Table 5.23</span>) covers all possibilities.</p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 5.22: Field Definition of Patient Address (PID-11): Slice Type = Discriminator Exists</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Field</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Min Cardinality</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Max Cardinality</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Base Datatype</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Default Datatype</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Discriminator (Position)</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
PID-11 (Patient Address)
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
1
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
*
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
XAD
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
NA
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
7 (Address Type)
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>If only one of the discriminator values is specified, then a default data type flavor is necessary (in essence, the default is specifying the requirements for the slice in which the discriminator value was indicated).</p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.23: Slice Definitions</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Discriminator Value</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Slice Datatype</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Slice Min</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Slice Max</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Comment</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
True
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
XAD_1
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
0
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
*
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
If PID-11.7 is valued, then the requirements for this field slice are defined by XAD_1 data type flavor.
</p>

<p class='p_v2web'>
The field slice need not appear or may appear an unlimited number of times.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
False
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
XAD_2
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
0
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
*
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
If PID-11.7 is not valued, then the requirements for this field are defined by the XAD_2 data type flavor.
</p>

<p class='p_v2web'>
A field of this definition need not appear and at most will appear once.
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p>The profile XML representation for the example presented in <span style="font-size:16px">Table 5.22</span> and <span style="font-size:16px">Table 5.23</span> is illustrated in <span style="font-size:16px">Figure 5.3</span>.</p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Slicing SlicingType=&rdquo;discriminatorExists&rdquo;&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Slice Datatype=&ldquo;XAD_1&quot; Min=&ldquo;0&quot; Max=&ldquo;*&quot; &gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Discriminator Position=&ldquo;7&quot; Value=&ldquo;true&quot;/&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;/Slice&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Slice Datatype=&ldquo;XAD_2&quot; Min=&ldquo;0&quot; Max=&ldquo;*&quot; &gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Discriminator Position=&ldquo;7&quot; Value=&ldquo;false&quot;/&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;/Slice&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;/Slicing&gt;</span></p>
</p>
<h6>
5.6.1.1.2 PATTERN DISCRIMINATOR SPECIFICATION AND EXAMPLES
</h6>
<p class='p_v2web'>
<p>The &ldquo;Pattern&rdquo; discriminator method uses a pattern to determine the slice that is triggered. <span style="font-size:16px">Table 5.24</span> and <span style="font-size:16px">Table 5.25</span> illustrate an example. The use case in this scenario is that if a postal code is valid for the United States or Canada, then specific constraints are specified for the field instance. If the postal code is neither, then a default set of constraints are applied. Note that for the United States, two types of postal codes are acceptable, hence there are two separate slices that refer to the same data type flavor (XAD_1). The discriminator values are represented as a pattern, and the discriminator (position) is PID-11.5 (ZIP or Postal Code).</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 5.24: Field Definition of Patient Address (PID-11): Slice Type = Discriminator Pattern</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Field</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Min Cardinality</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Max Cardinality</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Base Datatype</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Default Datatype</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Discriminator (Position)</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
PID-11 (Patient Address)
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
1
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
*
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
XAD
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
XAD_0
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
5 (ZIP or Postal Code)
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>The above example shows how an application can handle different requirements of XAD based on the postal code. In most cases, a message is likely to contain only one type or the other, but both could be supported in the same message for a patient. This specification supports either configuration. Note that a similar result could be accomplished using conditional usage.</p><p></p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.25: Slice Definitions</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Discriminator Value</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Slice Datatype</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Slice Min</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Slice Max</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Comment</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
[0-9]{5}
</p>


</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
XAD_1
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
0
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
*
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
If PID-11.5 matches the five-digit pattern for United States zip code, then the requirements for this field slice are defined by XAD_1 data type flavor.
</p>

<p class='p_v2web'>
The field slice need not appear or may appear an unlimited number of times.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
[0-9]{5}-[0-9]{4}
</p>


</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
XAD_1
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
0
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
*
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
If PID-11.5 matches the nine-digit pattern for United States zip code, then the requirements for this field slice are defined by XAD_1 data type flavor.
</p>

<p class='p_v2web'>
The field slice need not appear or may appear an unlimited number of times.
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
(?!.*[DFIOQU])[A-VXY][0-9][A-Z] ?[0-9][A-Z][0-9]
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
XAD_2
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
0
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
*
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
If PID-11.5 matches the pattern for Canada postal code, then the requirements for this field are defined by the XAD_2 data type flavor.
</p>

<p class='p_v2web'>
The field slice need not appear or may appear an unlimited number of times.
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>The profile XML representation for the example presented in <span style="font-size:16px">Table 5.24</span> and <span style="font-size:16px">Table 5.25</span> is illustrated in <span style="font-size:16px">Figure 5.4</span>.</p><p></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Slicing SlicingType=&ldquo;discriminatorPattern&quot; DefaultDataType=&ldquo;XAD_0&quot;&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Slice Datatype=&ldquo;XAD_1&quot; Min=&ldquo;0&quot; Max=&ldquo;*&quot; &gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Discriminator Position=&ldquo;5&quot; Value=&ldquo;[0-9]{5}&quot;/&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;/Slice&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Slice Datatype=&ldquo;XAD_1&quot; Min=&ldquo;0&quot; Max=&ldquo;*&quot; &gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Discriminator Position=&ldquo;5&quot; Value=&ldquo;[0-9]{5}-[0-9]{4}&quot;/&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;/Slice&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Slice Datatype=&ldquo;XAD_2&quot; Min=&ldquo;0&quot; Max=&ldquo;*&quot; &gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Discriminator Position=&ldquo;5&quot; Value=&ldquo;</span><span style="font-family:Courier New,Courier,monospace">(?!.*[DFIOQU])[A-VXY][0-9][A-Z] ?[0-9][A-Z][0-9]</span><span style="color:#000000; font-family:Courier New,Courier,monospace">&quot;/&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;/Slice&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;/Slicing&gt;</span></p><p></p>
</p>
<h5>
5.6.1.2 Slicing Using Ordering
</h5>
<p class='p_v2web'>
<p>Ordered slicing defines specific requirements based on the order sequence in which the given field instance appears. That is, the order sequence in which the field instance appears is significant for the use case. <span style="font-size:16px">Table 5.26</span> illustrates a field definition for Patient Name (PID-5). <span style="font-size:16px">Table 5.27</span> defines the requirements (data type flavor) for the associated slice occurrence. For the first occurrence of PID-5 the data type definition is XPN_1, for the second occurrence of PID-5 the data type definition is XPN_2, and for any other occurrence of PID-5 the data type definition is XPN_0 (the default data type flavor assigned).</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 5.26: Field Definition of Patient Name (PID-5): Slice Type = Ordered</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Field</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Min Cardinality</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Max Cardinality</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Base Datatype</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Default Datatype</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
PID-5 (Patient Name)
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
1
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
*
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
XPN
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
XPN_0
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>This strategy can be combined with the data type flavors and constant values to specify particular occurrences of the type of patient name. For example, if it were necessary to constrain the Patient Name field tightly such that the first occurrence of the field is the legal name (PID-5.7 = ‘L&rsquo;), then the data type flavor, XPN_1 in this example, can set the XPN.7 (Name Type Code) to ‘L&rsquo; as a constant value. </p><p></p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.27: PID-5 Ordered Slicing Definition</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Occurrence</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Slice Datatype</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
1
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
XPN_1
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
2
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
XPN_2
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>The profile XML representation for this example is illustrated in <span style="font-size:16px">Figure 5.5</span>. </p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Slicing SlicingType=&quot;ordered&quot; DefaultDataType=&ldquo;XPN_0&quot;&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Slice Datatype=&ldquo;XPN_1&quot; Occurrence=&ldquo;1&ldquo;/&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Slice Datatype=&ldquo;XPN_2&quot; Occurrence=&ldquo;2&ldquo;/&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;/Slicing&gt;</span></p><p>The occurrence value is not required to be specified for each field instance nor is an order sequence required. For example, if a specifier only wanted to assign a specific data type flavor to the second occurrence, then only the second occurrence would be specified. All other occurrences, including occurrence one, would follow the requirements defined by the default data type flavor for Patient Name.</p>
</p>
<h5>
5.6.1.3 Non-Selective Slicing
</h5>
<p class='p_v2web'>
<p>The &ldquo;Non-selective&rdquo; slicing method can be employed in cases where the specifier wishes the field instances to follow the constraints of one of a number of constraint sets (data type flavors).  <span style="font-size:16px">Table 5.28</span> and <span style="font-size:16px">Table 5.29</span> illustrate the use case.</p><p></p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 5.28: Field Definition of Patient Address (PID-11): Slice Type = Non-selective</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Field</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Min Cardinality</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Max Cardinality</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Base Datatype</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
PID-11
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
0
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
*
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
XAD
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>In this specification, the PID-11 can occur an unlimited number of times. A field occurrence must follow the constraints of any one of the three data type flavors (XAD_1, XAD_2, XAD_3)</p>
</p>

<table class='center table_v2web1'>
<tbody>
<caption>Table 5.29: PID-5 Ordered Slicing Definition</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Slice Datatype List</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Comment</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
XAD_1, XAD_2, XAD_3
</p>

</td>

<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
The field instance must adhere to the constraints specified in one of the specified data type flavors (XAD_1, XAD_2 or XAD_3).
</p>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>The profile XML representation for this example is illustrated in <span style="font-size:16px">Figure 5.6</span>.</p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Slicing SliceType=&quot;non-selective&quot;&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Slice Datatype=&ldquo;XAD_1&quot;/&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Slice Datatype=&ldquo;XAD_2&quot;/&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;Slice Datatype=&ldquo;XAD_3&quot;/&gt;</span></p><p><span style="color:#000000; font-family:Courier New,Courier,monospace">&lt;/Slicing&gt;</span></p><p></p>
</p>
<h3>
5.7 Conformance Statement
</h3>
<p class='p_v2web'>
<p>A conformance statement is a mechanism to express a constraint using a natural or computable language.  An example is: </p><p><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">&ldquo;I</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">F</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> RXA-18 (Substance/Treatment Refusal Reason) is valued </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">THEN</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> RXA-20 (Completion Status) SHALL </span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif">contain the value</span><span style="font-size:14px; font-family:Arial,Helvetica,sans-serif"> &#39;RE&#39; (Refused)&rdquo;. </span></p><p>Conformance statements provide a catch-all mechanism for expressing a constraint that can&rsquo;t be defined by the constraint types provided by the other conformance constructs (e.g., usage). Conformance statements should not be used in place of the conformance constructs, i.e., do not use a conformance statement to constrain the usage of an element (e.g., &ldquo;PID-8 (Administrative Sex) is Required.&rdquo;).</p><p>The forms in which a conformance statement can be expressed vary and can appear as a text description or a computable expression. In both forms a specific syntax should be used to ensure that the requirement details are complete and to improve readability for the implementer. This specification does not require a specific method or language. However, a pseudo language specifically for HL7 v2 has been developed and is recommended method for expressing conformance statements (See <span style="font-size:16px">Appendix </span><span style="font-size:16px">B</span>).</p>
</p>
<h3>
5.8 Co-Constraints
</h3>
<p class='p_v2web'>
<p>The co-constraint construct is a related constraint concept that is used to express dependencies among a set of data values. An HL7 v2 message in which observations are conveyed is one example of how co-constraints are used. Such constraints typically follow the form of &ldquo;if OBX-3.1 = LOINC code XXXXX-X then OBX-2 SHALL BE &ldquo;CE&rdquo; and OBX-5.1 SHALL contain a value from the value set YYY&rdquo; or a similar form. A co-constraint is not limited to use with observations, but it appears most frequently with observations. A convenient way to illustrate a set of co-constraints is to present them in a table format. <span style="font-size:16px">Table 5.30</span> illustrates an example for a set of immunization observations.</p><p></p>
</p>

<table class='center striped_rows table_v2web1'>
<tbody>
<caption>Table 5.30: Excerpt of Co-Constraints of Immunization Observations</caption>
<tr class='tr_v2web'>
<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>LOINC</strong><strong>(OBX-3)</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Description</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Data Type</strong><strong>(OBX-2)</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Data Type Flavor (OBX-2)</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Value Set</strong><strong>(OBX-5)</strong>
</p>

</th>

<th class='emphasis_header table_v2web1 th_v2web' colspan='1'>
<p class='p_v2web'>
<strong>Units (OBX-6)</strong>
</p>

</th>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
30973-2
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Dose number in series
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
NM
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
NM
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Not applicable
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
&ldquo;NA&rdquo; from HL70353
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
59782-3
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Number of doses in series
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
NM
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
NM
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Not applicable
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
&ldquo;NA&rdquo; from HL70353
</p>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
59783-1
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Status in Immunization series
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
CE
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
CE_01
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Local Value Set
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
30956-7
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Vaccine Type
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
CE
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
CE_01
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
CVX - Vaccine Group
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
30980-7
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Date next dose is due
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
DT
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
DT_D
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Not applicable
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
59779-9
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Immunization Schedule
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
CE
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
CE_01
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
ScheduleIdentifier
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

<tr class='tr_v2web'>
<td class='emphasis_column table_v2web1' colspan='1'>
<p class='p_v2web'>
30963-3
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
Vaccine funding source
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
CE
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
CE_01
</p>

</td>

<td class='table_v2web1' colspan='1'>
<p class='p_v2web'>
FundingSource
</p>

</td>

<td class='table_v2web1' colspan='1'>

</td>

</tr>

</tbody>
</table>

<p class='p_v2web'>
<p></p><p>Usually the OBX-3 (Observation Identifier) is the key upon which data dependencies are based. For example, when OBX-3 contains the LOINC code 30980-7 (for Vaccine Type), the data type in OBX-2 must be &ldquo;CE&rdquo; (for coded element), and OBX-5 (the Observation Value) must contain a code from the CVX value set (specifically from the Vaccine Group). The data type representation for OBX-5 is given by the data type flavor CE_01 definition. This example shows how co-constraints are typically expressed in HL7 v2. Other mechanisms can also be used. Additionally, co-constraints can be grouped or predicated on a condition. For example, a group of OBX segments with interdependences may be required predicated on a certain value in the segment group (e.g., OBR-4). </p>
</p>
<h3>
5.9 Semantic Refinement
</h3>
<p class='p_v2web'>
<p>Every element has associated data semantics that define the sort of data the element is carrying and how those data should be interpreted. That is, the data element is bound to a concept (logical meaning). The base standard provides these element definitions. In some instances, the definitions are broad, because the context of a given use case is unknown. Profiles, therefore, can refine the semantics of a data element based on the use case. This refinement is in prose, and hence not conducive to computerized understanding, that is, implementers will have to read and adjust implementation accordingly. Best practice is to provide only refined element semantics in profiles, and not to repeat existing element definitions from the base standard. HL7 v2 profiles have an Annotation mechanism that supports documentation of semantic refinements in a structured way.</p>
</p>
<h4>
5.9.1 Annotations
</h4>
<p class='p_v2web'>
<p>An annotation is descriptive text that accompanies a standard element definition or concept and provides additional information pertaining to the use of the element (i.e., it is an elaboration of the concept as it relates to the use case to which it is being applied). An annotation may be associated at any defined element level in a message profile (e.g., a field). HL7 v2 supports a number of predefined annotation types:</p><p></p><p> Annotations do not introduce new requirements in the form of constraints or extensions; they are informative and can be used to supplement the understanding of the element. </p><p></p>
</p>
