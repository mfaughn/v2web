project "v2web", :version => "4.0.1", :original_filename => "v2web_4.0.1.mdj", :generated_by => "Star UML plugin: ruby-dsl-generator.js v0.0.0", :generated_at => "Mon Nov 06 2023 10:31:39 GMT-0700 (Mountain Standard Time)", :additional_info => { :selected_model => { :name => "Application", :id => "AAAAAAFF+qBWK6M3Z8Y=", :pluralize_role_names => true, :snakecase_role_names => true }}, :id => "AAAAAAFF+h6SjaM2Hec=" do
  model "Application", :imports => ["HL7", "FHIR", "V2Web", "Gui_Builder_Profile"], :id => "AAAAAAFF+qBWK6M3Z8Y=" do
    applied_stereotype :instance_of => "Gui_Builder_Profile::change_tracked"
  end # model Application
  package "HL7", :id => "AAAAAAGJjcjsRfjoWRM=" do
     # Association # HL7::WorkGroup::owners <-> HL7::Vocab::CodeSystem::<unspecified>
    association :properties => ["HL7::Vocab::CodeSystem::owners", "AAAAAAGJiZ2i17KbaHs="], :id => "AAAAAAGJiZ2i17KZvO8="
     # Association # Gui_Builder_Profile::Person::co_chairs <-> HL7::WorkGroup::co_chairs
    association :properties => ["HL7::WorkGroup::co_chairs", "Gui_Builder_Profile::Person::co_chairs"], :id => "AAAAAAGJjvb3P0u5rAo="
     # Association # Gui_Builder_Profile::Person::members <-> HL7::WorkGroup::work_groups
    association :properties => ["HL7::WorkGroup::members", "Gui_Builder_Profile::Person::work_groups"], :id => "AAAAAAGJjvZF8kiRVQ4="
    klass "WorkGroup", :id => "AAAAAAGJiZ1Le563iZw=" do
      property "name", :type => "String", :id => "AAAAAAGJiZ1tbaJl9oU="
      property nil, :type => "HL7::Vocab::CodeSystem", :upper => Float::INFINITY, :id => "AAAAAAGJiZ2i17KbaHs="
      property "co_chairs", :type => "Gui_Builder_Profile::Person", :upper => Float::INFINITY, :aggregation => :shared, :id => "AAAAAAGJjvb3P0u6zIA="
      property "members", :type => "Gui_Builder_Profile::Person", :upper => Float::INFINITY, :aggregation => :shared, :id => "AAAAAAGJjvZF8kiS7ek="
    end
    enumeration "WorkGroupName", :id => "AAAAAAGJjcok/vrUDx0=" do
      property "value", :type => "UML::String"
    end
    package "V2", :id => "AAAAAAGJdVwMVCdiIS8=" do
       # Association # HL7::V2::Message::<unspecified> <-> HL7::V2::Event::trigger_for
      association :properties => ["AAAAAAGJdWFbdyoFjtU=", "HL7::V2::Message::trigger_for"], :id => "AAAAAAGJdWFbdioEaLY="
       # Association # HL7::V2::Message::ack_to <-> HL7::V2::Message::ack
      association :properties => ["HL7::V2::Message::ack_to", "HL7::V2::Message::ack"], :id => "AAAAAAGJdWJKHDS2yI8="
       # Association # HL7::V2::EventText::<unspecified> <-> HL7::V2::Event::<unspecified>
      association :properties => ["AAAAAAGJdXEMjx/WIzs=", "AAAAAAGJdXEMjx/XFI0="], :id => "AAAAAAGJdXEMjx/VXXI="
       # Association # HL7::V2::Message::response_for <-> HL7::V2::Message::responses
      association :properties => ["HL7::V2::Message::response_for", "HL7::V2::Message::responses"], :id => "AAAAAAGJ3H5s5OVjQwo="
       # Association # HL7::V2::Message::<unspecified> <-> HL7::V2::MessageStructure::structure
      association :properties => ["AAAAAAGJdWVi0z17Zck=", "HL7::V2::Message::structure"], :id => "AAAAAAGJdWVi0z16wbk="
       # Association # HL7::V2::AcknowledgmentChoreography::<unspecified> <-> HL7::V2::Message::for
      association :properties => ["AAAAAAGJrSgAUmvJezs=", "HL7::V2::AcknowledgmentChoreography::for"], :id => "AAAAAAGJrSgAUmvIz+M="
       # Association # HL7::V2::AcknowledgmentChoreography::as_oa <-> HL7::V2::Message::original_acks
      association :properties => ["HL7::V2::Message::as_oa", "HL7::V2::AcknowledgmentChoreography::original_acks"], :id => "AAAAAAGJrSjU73FMwoM="
       # Association # HL7::V2::AcknowledgmentChoreography::as_msh15 <-> HL7::V2::Message::msh15_acks
      association :properties => ["HL7::V2::Message::as_msh15", "HL7::V2::AcknowledgmentChoreography::msh15_acks"], :id => "AAAAAAGJrSl5Vna7bhQ="
       # Association # HL7::V2::AcknowledgmentChoreography::as_msh16 <-> HL7::V2::Message::msh16_acks
      association :properties => ["HL7::V2::Message::as_msh16", "HL7::V2::AcknowledgmentChoreography::msh16_acks"], :id => "AAAAAAGJrSod5n0LVOQ="
       # Association # HL7::V2::AbstractSegment::segments <-> HL7::V2::MessageStructure::structure
      association :properties => ["HL7::V2::MessageStructure::segments", "HL7::V2::AbstractSegment::structure"], :id => "AAAAAAGJdWXZCUnnffQ="
       # Association # HL7::V2::AbstractSegment::segments <-> HL7::V2::SegmentSequence::<unspecified>
      association :properties => ["HL7::V2::SegmentSequence::segments", "AAAAAAGJdWaXllowhZw="], :id => "AAAAAAGJdWaXllouiOg="
       # Association # HL7::V2::AbstractSegment::segments <-> HL7::V2::SegmentGroup::<unspecified>
      association :properties => ["HL7::V2::SegmentGroup::segments", "AAAAAAGLY0UYOcM7hcA="], :id => "AAAAAAGLY0UYOcM5JDQ="
       # Association # HL7::V2::SegmentChoice::<unspecified> <-> HL7::V2::SegmentGroup::groups
      association :properties => ["AAAAAAGJdWdb7HTo79Q=", "HL7::V2::SegmentChoice::groups"], :id => "AAAAAAGJdWdb7HTnuJw="
       # Association # HL7::V2::Segment::<unspecified> <-> HL7::V2::SegmentDefinition::type
      association :properties => ["AAAAAAGJdW1pKtt7A94=", "HL7::V2::Segment::type"], :id => "AAAAAAGJdW1pKtt6tKU="
       # Association # HL7::V2::Field::<unspecified> <-> HL7::V2::DataElement::<unspecified>
      association :properties => ["AAAAAAGJdXyczjR4imI=", "AAAAAAGJdXyczjR5e6M="], :id => "AAAAAAGJdXyczTR343U="
       # Association # HL7::V2::Field::<unspecified> <-> HL7::V2::SegmentDefinition::<unspecified>
      association :properties => ["AAAAAAGJiYPs9mueANQ=", "AAAAAAGJiYPs9mufibI="], :id => "AAAAAAGJiYPs9mudNFw="
       # Association # HL7::V2::Field::<unspecified> <-> HL7::V2::DefinitionText::<unspecified>
      association :properties => ["AAAAAAGJiaDjXJO9560=", "AAAAAAGJiaDjXJO+vis="], :id => "AAAAAAGJiaDjXJO8OKs="
       # Association # HL7::V2::DataElement::<unspecified> <-> HL7::V2::DataType::<unspecified>
      association :properties => ["AAAAAAGJdXw0siwrgSk=", "AAAAAAGJdXw0siwsyHI="], :id => "AAAAAAGJdXw0siwqF/c="
       # Association # HL7::V2::DataElement::<unspecified> <-> HL7::V2::DefinitionText::definitions
      association :properties => ["AAAAAAGJiZ+vkzwK09Y=", "HL7::V2::DataElement::definitions"], :id => "AAAAAAGJiZ+vkzwJtas="
       # Association # HL7::V2::Component::type_for <-> HL7::V2::DataType::type
      association :properties => ["HL7::V2::DataType::type_for", "HL7::V2::Component::type"], :id => "AAAAAAGJdX603VDu0pc="
       # Association # HL7::V2::Component::<unspecified> <-> HL7::V2::DataType::owner
      association :properties => ["AAAAAAGJ5XTm0Z3EtRc=", "HL7::V2::Component::owner"], :id => "AAAAAAGJ5XTm0Z3Dtms="
       # Association # HL7::V2::BoundToVocab::<unspecified> <-> HL7::Vocab::ConceptDomain::<unspecified>
      association :properties => ["AAAAAAGJjwDV/m4ih0Q=", "AAAAAAGJjwDV/m4j1xg="], :id => "AAAAAAGJjwDV/m4hG9Q="
       # Association # HL7::V2::BoundToVocab::users <-> HL7::Vocab::ValueSetDefinition::vocab
      association :properties => ["HL7::Vocab::ValueSetDefinition::users", "HL7::V2::BoundToVocab::vocab"], :id => "AAAAAAGJ3ImNnXmOGU0="
       # Association # HL7::V2::MessageType::<unspecified> <-> HL7::V2::Message::<unspecified>
      association :properties => ["AAAAAAGLAFsw+cIOoko=", "AAAAAAGLAFsw+cIPNM8="], :id => "AAAAAAGLAFsw+cINO2s="
      klass "Event", :implements => ["HL7::V2::Origin", "HL7::V2::Referenceable"], :id => "AAAAAAGJdV8uiyiDfgw=" do
        property "name", :type => "String", :id => "AAAAAAGJeg+iTXlBkx0="
        property "code", :type => "String", :id => "AAAAAAGJeg/B/XuIeCQ="
        property "withdrawn", :type => "String", :id => "AAAAAAGJeg/d9H0be1A="
        property "deprecated", :type => "String", :id => "AAAAAAGJehAp5H6updY="
        property nil, :type => "HL7::V2::Message", :lower => 1, :is_navigable => true, :id => "AAAAAAGJdWFbdyoFjtU="
        property nil, :type => "HL7::V2::EventText", :upper => Float::INFINITY, :is_ordered => true, :id => "AAAAAAGJdXEMjx/WIzs="
      end
      klass "EventText", :id => "AAAAAAGJdXC83xYB9b8=" do
        property "content", :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJdXH4yTXl0Us="
        property nil, :type => "HL7::V2::Event", :upper => Float::INFINITY, :id => "AAAAAAGJdXEMjx/XFI0="
      end
      klass "Message", :implements => ["HL7::V2::Origin", "HL7::V2::Referenceable"], :id => "AAAAAAGJdV9lAiitakA=" do
        property "description", :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJehHoxw5HOvA="
        property "source", :type => "Gui_Builder_Profile::Code", :id => "AAAAAAGJehKFcCwhQnc="
        property "notes", :type => "String", :id => "AAAAAAGJehKxYC5o87I="
        property "status", :type => "HL7::V2::MessageStatus", :id => "AAAAAAGJehLHoC/7CeA="
        property "trigger_for", :type => "HL7::V2::Event", :id => "AAAAAAGJdWFbdyoGyq0="
        property "ack_to", :type => "HL7::V2::Message", :upper => Float::INFINITY, :id => "AAAAAAGJdWJKHTS3nzM="
        property "ack", :type => "HL7::V2::Message", :is_navigable => true, :id => "AAAAAAGJdWJKHTS49tg="
        property "response_for", :type => "HL7::V2::Message", :upper => Float::INFINITY, :id => "AAAAAAGJ3H5s5OVklhM="
        property "responses", :type => "HL7::V2::Message", :upper => Float::INFINITY, :is_navigable => true, :id => "AAAAAAGJ3H5s5OVlckY="
        property "structure", :type => "HL7::V2::MessageStructure", :lower => 1, :id => "AAAAAAGJdWVi0z18VPw="
        property nil, :type => "HL7::V2::AcknowledgmentChoreography", :lower => 1, :id => "AAAAAAGJrSgAUmvJezs="
        property "as_oa", :type => "HL7::V2::AcknowledgmentChoreography", :upper => Float::INFINITY, :id => "AAAAAAGJrSjU73FNhFg="
        property "as_msh15", :type => "HL7::V2::AcknowledgmentChoreography", :upper => Float::INFINITY, :id => "AAAAAAGJrSl5Vna8qYs="
        property "as_msh16", :type => "HL7::V2::AcknowledgmentChoreography", :upper => Float::INFINITY, :id => "AAAAAAGJrSod5n0M0S4="
        property nil, :type => "HL7::V2::MessageType", :lower => 1, :id => "AAAAAAGLAFsw+cIOoko="
      end
      klass "AcknowledgmentChoreography", :id => "AAAAAAGJrSUs0Gr4YxY=" do
        property "ack_immediate", :type => "Boolean", :default_value => "false", :id => "AAAAAAGJrSW+N2sjEFw="
        property "msh15", :type => "HL7::V2::AckType", :id => "AAAAAAGJrSX1tWsqwV0="
        property "msh16", :type => "HL7::V2::AckType", :id => "AAAAAAGJrSa1kGtv7nM="
        property "imm_ack_name", :type => "String", :id => "AAAAAAGJrSbxb2t2C2I="
        property "app_ack_name", :type => "String", :id => "AAAAAAGJrScZ9Gt9ovc="
        property "notes", :type => "String", :id => "AAAAAAGJrSdFAWuEvGc="
        property "for", :type => "HL7::V2::Message", :lower => 1, :id => "AAAAAAGJrSgAUmvKxEs="
        property "original_acks", :type => "HL7::V2::Message", :upper => Float::INFINITY, :is_navigable => true, :id => "AAAAAAGJrSjU73FOUvE="
        property "msh15_acks", :type => "HL7::V2::Message", :upper => Float::INFINITY, :is_navigable => true, :id => "AAAAAAGJrSl5Vna9U+Q="
        property "msh16_acks", :type => "HL7::V2::Message", :upper => Float::INFINITY, :is_navigable => true, :id => "AAAAAAGJrSod5n0NSp8="
      end
      klass "MessageStructure", :implements => ["HL7::V2::Origin", "HL7::V2::Referenceable"], :id => "AAAAAAGJdV+AUCjX2W4=" do
        property "code", :type => "String", :id => "AAAAAAGJehMWFzknRoE="
        property nil, :type => "HL7::V2::Message", :upper => Float::INFINITY, :id => "AAAAAAGJdWVi0z17Zck="
        property "segments", :type => "HL7::V2::AbstractSegment", :upper => Float::INFINITY, :is_ordered => true, :aggregation => :composite, :id => "AAAAAAGJdWXZCUnoSKQ="
      end
      klass "AbstractSegment", :is_abstract => true, :id => "AAAAAAGJdV/djykBmLc=" do
        property "repeat", :type => "Boolean", :default_value => "false", :id => "AAAAAAGJehNjFEb4CXs="
        property "optional", :type => "Boolean", :default_value => "false", :id => "AAAAAAGJehOPeEk/NJk="
        property "status", :type => "String", :id => "AAAAAAGJehOsnErSNro="
        property "structure", :type => "HL7::V2::MessageStructure", :id => "AAAAAAGJdWXZCUnpFAs="
        property nil, :type => "HL7::V2::SegmentSequence", :id => "AAAAAAGJdWaXllowhZw="
        property nil, :type => "HL7::V2::SegmentGroup", :id => "AAAAAAGLY0UYOcM7hcA="
      end
      klass "SegmentSequence", :parents => ["HL7::V2::AbstractSegment"], :id => "AAAAAAGJdWAj+Cks+H8=" do
        property "name", :type => "String", :id => "AAAAAAGJdWw31bPPsmM="
        property "segments", :type => "HL7::V2::AbstractSegment", :lower => 1, :upper => Float::INFINITY, :is_ordered => true, :aggregation => :composite, :id => "AAAAAAGJdWaXllovXpo="
      end
      klass "SegmentChoice", :parents => ["HL7::V2::AbstractSegment"], :id => "AAAAAAGJdWBHKSlWTQE=" do
        property "name", :type => "String", :id => "AAAAAAGJdWwAoLDpYi0="
        property "groups", :type => "HL7::V2::SegmentGroup", :lower => 1, :upper => Float::INFINITY, :is_ordered => true, :aggregation => :composite, :id => "AAAAAAGJdWdb7HTpQTo="
      end
      klass "ExampleSegment", :parents => ["HL7::V2::AbstractSegment"], :id => "AAAAAAGJdWBizimA21Y=" do
        property "description", :type => "String", :id => "AAAAAAGJdWiKFacvn7s="
        property "name", :type => "String", :id => "AAAAAAGJdWtxbK2FMzg="
      end
      klass "Segment", :parents => ["HL7::V2::AbstractSegment"], :id => "AAAAAAGJdWCwBSnUCCU=" do
        property "description", :type => "String", :id => "AAAAAAGJdWzhosaeJvU="
        property "type", :type => "HL7::V2::SegmentDefinition", :lower => 1, :is_navigable => true, :id => "AAAAAAGJdW1pKtt8dtQ="
      end
      klass "SegmentDefinition", :implements => ["HL7::V2::Origin", "HL7::V2::Referenceable"], :id => "AAAAAAGJdWB/aSmq9QY=" do
        property "name", :type => "String", :id => "AAAAAAGJdXm1aQDD2+Q="
        property "withdrawn", :type => "Boolean", :id => "AAAAAAGJdXnaIgJ67ts="
        property "code", :type => "String", :id => "AAAAAAGJdXn6QgOqbBU="
        property "description", :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJdXojsATaSyY="
        property "source", :type => "Gui_Builder_Profile::Code", :id => "AAAAAAGJdXpFewYKOTM="
        property nil, :type => "HL7::V2::Segment", :upper => Float::INFINITY, :id => "AAAAAAGJdW1pKtt7A94="
        property nil, :type => "HL7::V2::Field", :upper => Float::INFINITY, :is_ordered => true, :aggregation => :composite, :id => "AAAAAAGJiYPs9mueANQ="
      end
      klass "Field", :id => "AAAAAAGJdXquwAeL1iM=" do
        property "sequence_number", :type => "Integer", :id => "AAAAAAGJiYR6/H9WmzA="
        property "must_support", :type => "Boolean", :id => "AAAAAAGJiYS114Ibidw="
        property "min_cardinality", :type => "Integer", :id => "AAAAAAGJiYTYVIPPAUQ="
        property "max_cardinality", :type => "Integer", :id => "AAAAAAGJiYUNNYWD+Lc="
        property "optionality", :type => "HL7::V2::Optionality", :id => "AAAAAAGJiYU2RIc34Eg="
        property "flags", :type => "String", :id => "AAAAAAGJiYVTrYjr+DU="
        property "repetition", :type => "String", :id => "AAAAAAGJiYVrxoqf/m0="
        property "addendum_type", :type => "Boolean", :id => "AAAAAAGJiYWjg4xTsLw="
        property "description", :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJiYYgs5H+OqM="
        property nil, :type => "HL7::V2::DataElement", :lower => 1, :is_navigable => true, :id => "AAAAAAGJdXyczjR5e6M="
        property nil, :type => "HL7::V2::SegmentDefinition", :id => "AAAAAAGJiYPs9mufibI="
        property nil, :type => "HL7::V2::DefinitionText", :lower => 1, :id => "AAAAAAGJiaDjXJO+vis="
      end
      klass "DataElement", :implements => ["HL7::V2::BoundToVocab", "HL7::V2::Referenceable", "HL7::V2::BoundToVocab"], :id => "AAAAAAGJdV7BhCgxf5Q=" do
        property "name", :type => "String", :id => "AAAAAAGJiYZ4DKKhQTs="
        property "item_number", :type => "Integer", :id => "AAAAAAGJiYaYIaUYqaw="
        property "min_length", :type => "Integer", :id => "AAAAAAGJiYbEWabM60s="
        property "max_length", :type => "Integer", :id => "AAAAAAGJiYcOsqiASqk="
        property "c_length", :type => "String", :id => "AAAAAAGJiYcsBqo0f3A="
        property "may_truncate", :type => "HL7::V2::MayTruncate", :id => "AAAAAAGJiYdOQ6voNuQ="
        property "source", :type => "Gui_Builder_Profile::Code", :id => "AAAAAAGJiYd7ga2cfL0="
        property "data_type_varies", :type => "Boolean", :default_value => "false", :id => "AAAAAAGJiYeVe69Qpvk="
        property "description", :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJiYf0g70OOd0="
        property nil, :type => "HL7::V2::Field", :upper => Float::INFINITY, :id => "AAAAAAGJdXyczjR4imI="
        property nil, :type => "HL7::V2::DataType", :lower => 1, :is_navigable => true, :id => "AAAAAAGJdXw0siwsyHI="
        property "definitions", :type => "HL7::V2::DefinitionText", :upper => Float::INFINITY, :aggregation => :shared, :id => "AAAAAAGJiZ+vkzwLLkA="
      end
      klass "DataType", :implements => ["HL7::V2::Referenceable"], :id => "AAAAAAGJdXsBKxkea8g=" do
        property "name", :type => "String", :id => "AAAAAAGJiYg6o8FZqWs="
        property "withdrawn", :type => "Boolean", :id => "AAAAAAGJiYhYZMPQ++E="
        property "code", :type => "String", :id => "AAAAAAGJiYh2icWEhKA="
        property "description", :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJiYiN/Mc4/wY="
        property "definition", :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJiYixOMjsvCU="
        property "notes", :type => "String", :upper => Float::INFINITY, :id => "AAAAAAGJiYjeNMqg1T0="
        property "html_source", :type => "Gui_Builder_Profile::Code", :id => "AAAAAAGJiYkBesxUwNU="
        property "array_type", :type => "Boolean", :default_value => "false", :id => "AAAAAAGJiYkh784I8Oo="
        property nil, :type => "HL7::V2::DataElement", :upper => Float::INFINITY, :id => "AAAAAAGJdXw0siwrgSk="
        property "type_for", :type => "HL7::V2::Component", :upper => Float::INFINITY, :id => "AAAAAAGJdX603VDvtQs="
        property nil, :type => "HL7::V2::Component", :upper => Float::INFINITY, :is_ordered => true, :aggregation => :composite, :id => "AAAAAAGJ5XTm0Z3EtRc="
      end
      klass "Component", :implements => ["HL7::V2::BoundToVocab"], :id => "AAAAAAGJdV5WxCgo6hg=" do
        property "name", :type => "String", :id => "AAAAAAGJiYpPYekyatI="
        property "sequence_number", :type => "Integer", :id => "AAAAAAGJiYqGmOuppgw="
        property "example", :type => "String", :upper => Float::INFINITY, :id => "AAAAAAGJiYqoM+1dmlM="
        property "definition", :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJiYrdnO8RTa8="
        property "must_support", :type => "Boolean", :id => "AAAAAAGJiYsJQvDF17Q="
        property "min_length", :type => "Integer", :id => "AAAAAAGJiYs77vJ5/2U="
        property "max_length", :type => "Integer", :id => "AAAAAAGJiYttHvQtfTI="
        property "c_length", :type => "String", :id => "AAAAAAGJiYuOqfXhUSE="
        property "may_truncate", :type => "HL7::V2::MayTruncate", :id => "AAAAAAGJ3Hrpn6bdqoA="
        property "comments", :type => "String", :upper => Float::INFINITY, :id => "AAAAAAGJiYuxjveV8nc="
        property "usage_notes", :type => "String", :upper => Float::INFINITY, :id => "AAAAAAGJiYvypflJhiM="
        property "requirements", :type => "String", :upper => Float::INFINITY, :id => "AAAAAAGJiYw0Sfr9uTY="
        property "optionality", :type => "HL7::V2::Optionality", :id => "AAAAAAGJiYxmr/yxwRw="
        property "flags", :type => "String", :id => "AAAAAAGJiYyOUP5l48M="
        property "legacy_tbl", :type => "String", :id => "AAAAAAGJiYytDAAZIhc="
        property "legacy_ref", :type => "String", :id => "AAAAAAGJ5XXsXs82fuU="
        property "legacy_dt", :type => "String", :id => "AAAAAAGJiYzYCQHNnwY="
        property "table_row_source", :type => "Gui_Builder_Profile::Code", :id => "AAAAAAGJiY0hhgUHv9o="
        property "definition_source", :type => "Gui_Builder_Profile::Code", :id => "AAAAAAGJiY1Zjwa7ACI="
        property "type", :type => "HL7::V2::DataType", :is_navigable => true, :id => "AAAAAAGJdX603VDw5QI="
        property "owner", :type => "HL7::V2::DataType", :id => "AAAAAAGJ5XTm0Z3FO3M="
      end
      klass "DefinitionText", :id => "AAAAAAGJdXtdoyM0VRw=" do
        property "definition", :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJiZ63iQeaEvg="
        property "description", :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJiZ7oMQqh6aI="
        property "chapter", :type => "String", :id => "AAAAAAGJiZ8Jfgy4L0g="
        property "original_container", :type => "String", :id => "AAAAAAGJiZ8mmQ7Pycs="
        property nil, :type => "HL7::V2::Field", :upper => Float::INFINITY, :id => "AAAAAAGJiaDjXJO9560="
        property nil, :type => "HL7::V2::DataElement", :id => "AAAAAAGJiZ+vkzwK09Y="
      end
      enumeration "Optionality", :id => "AAAAAAGJiZrgkFKfEJM=" do
        property "value", :type => "UML::String"
        literal "R", :id => "AAAAAAGJiZsBI1Vt/oM="
        literal "RE", :id => "AAAAAAGJiZsYaFgUB84="
        literal "O", :id => "AAAAAAGJiZslFlnpJtM="
        literal "Cab", :id => "AAAAAAGJiZsyolu+H2I="
        literal "X", :id => "AAAAAAGJiZuxxmAzDIM="
        literal "B", :id => "AAAAAAGJiZvGNGLal8Q="
        literal "W", :id => "AAAAAAGJiZvP22SvtbM="
      end
      enumeration "MayTruncate", :id => "AAAAAAGJiY2jaQmAjU0=" do
        property "value", :type => "UML::String"
        literal "not applicable", :id => "AAAAAAGJiY3Tigzh+e4="
        literal "true", :id => "AAAAAAGJiY3/Vg9Yyok="
        literal "false", :id => "AAAAAAGJiY4MTxEMP4Q="
      end
      interface "BoundToVocab", :id => "AAAAAAGJiY6ZTx4g4P4=" do
        property "binding_strength", :type => "HL7::V2::BindingStrength", :id => "AAAAAAGJ3HQMK1lUHz0="
        property "binding_type", :type => "HL7::V2::BindingType", :id => "AAAAAAGJ3HTDTl19IOY="
        property nil, :type => "HL7::Vocab::ConceptDomain", :id => "AAAAAAGJjwDV/m4j1xg="
        property "vocab", :type => "HL7::Vocab::ValueSetDefinition", :id => "AAAAAAGJ3ImNnXmQ6mg="
      end
      enumeration "TableType", :id => "AAAAAAGJiZkEsT6bY8M=" do
        property "value", :type => "UML::String"
        literal "hl7-defined", :id => "AAAAAAGJiZkq7UFpiXw="
        literal "user-defined", :id => "AAAAAAGJiZlMU0QQgJw="
        literal "externally-defined", :id => "AAAAAAGJiZll80XlwOs="
        literal "imported", :id => "AAAAAAGJiZmHtUe6qjE="
        literal "external", :id => "AAAAAAGJ3G0hY1Iphv4="
      end
      enumeration "TableStatus", :id => "AAAAAAGJjbSN3dT24rY=" do
        property "value", :type => "UML::String"
        literal "active", :id => "AAAAAAGJjbSvHdiE3oE="
      end
      enumeration "MessageStatus", :id => "AAAAAAGJehU5hZSWX/A=" do
        property "value", :type => "UML::String"
      end
      enumeration "AckType", :id => "AAAAAAGJrSY9i2sx+/U=" do
        property "value", :type => "UML::String"
        literal "Never", :id => "AAAAAAGJrSZcNWtffk0="
        literal "Always", :id => "AAAAAAGJrSZvi2tmD4k="
      end
      interface "Origin", :id => "AAAAAAGJrTFXvgGHPuU=" do
        property "origin", :type => "String", :id => "AAAAAAGJ5YF1pKjwq9M="
      end
      interface "Referenceable", :id => "AAAAAAGJrTVigR4JISM=" do
        property nil, :type => "V2Web::Reference", :upper => Float::INFINITY, :id => "AAAAAAGJrGrZmdAvPL4="
      end
      enumeration "BindingStrength", :id => "AAAAAAGJjwGCOHLqfMQ=" do
        property "value", :type => "UML::String"
        literal "extensible", :id => "AAAAAAGJjwGrrHQ4BYY="
        literal "example", :id => "AAAAAAGJjwHO0XVfWPA="
      end
      enumeration "BindingType", :id => "AAAAAAGJ3HUH62CdrYQ=" do
        property "value", :type => "UML::String"
      end
      enumeration "CLD_Type", :id => "AAAAAAGJ5oxI1INTufc=" do
        property "value", :type => "UML::String"
      end
      klass "MessageType", :id => "AAAAAAGLAFptPJnGMTY=" do
        property "code", :type => "String", :id => "AAAAAAGLAFqnOqS5f8A="
        property "name", :type => "String", :id => "AAAAAAGLAF98qjp0HEE="
        property nil, :type => "HL7::V2::Message", :upper => Float::INFINITY, :id => "AAAAAAGLAFsw+cIPNM8="
      end
      klass "SegmentGroup", :id => "AAAAAAGLY0QASpDjyz0=" do
        property nil, :type => "HL7::V2::SegmentChoice", :id => "AAAAAAGJdWdb7HTo79Q="
        property "segments", :type => "HL7::V2::AbstractSegment", :lower => 1, :upper => Float::INFINITY, :is_ordered => true, :aggregation => :composite, :id => "AAAAAAGLY0UYOcM6vGU="
      end
    end # package HL7::V2
    package "Vocab", :id => "AAAAAAGJjviCP1DKusw=" do
       # Association # HL7::Vocab::Concept::children <-> HL7::Vocab::Concept::parent
      association :properties => ["HL7::Vocab::Concept::children", "HL7::Vocab::Concept::parent"], :id => "AAAAAAGJjv3rTVL9riA="
       # Association # HL7::Vocab::Concept::<unspecified> <-> HL7::Vocab::ValueSet::<unspecified>
      association :properties => ["AAAAAAGJjv7sq1exuO8=", "AAAAAAGJjv7sq1eym2w="], :id => "AAAAAAGJjv7sq1ewWN4="
       # Association # HL7::Vocab::Concept::<unspecified> <-> HL7::Vocab::CodeSystem::<unspecified>
      association :properties => ["AAAAAAGJjwImsHvxZHQ=", "AAAAAAGJjwImsHvyons="], :id => "AAAAAAGJjwImsHvwnq4="
       # Association # HL7::Vocab::ConceptDomain::<unspecified> <-> HL7::Vocab::Concept::<unspecified>
      association :properties => ["AAAAAAGJjwJ0kIUEQN4=", "AAAAAAGJjwJ0kIUFZQ4="], :id => "AAAAAAGJjwJ0kIUD1Nw="
       # Association # HL7::Vocab::ConceptDomain::<unspecified> <-> HL7::Vocab::CodeSystem::<unspecified>
      association :properties => ["AAAAAAGJ5oXaWi4rIAA=", "AAAAAAGJ5oXaWi4sYdo="], :id => "AAAAAAGJ5oXaWi4qZcU="
       # Association # HL7::Vocab::ValueSetDefinition::<unspecified> <-> HL7::Vocab::CodeSystem::<unspecified>
      association :properties => ["AAAAAAGJjv/RKWC4fR4=", "AAAAAAGJjv/RKWC5wd4="], :id => "AAAAAAGJjv/RKWC3OBI="
       # Association # HL7::Vocab::ValueSet::<unspecified> <-> HL7::Vocab::ValueSetDefinition::<unspecified>
      association :properties => ["AAAAAAGJjv6sJ1Y4kHk=", "AAAAAAGJjv6sJ1Y5D8w="], :id => "AAAAAAGJjv6sJ1Y3SB8="
      klass "CodeSystem", :implements => ["HL7::Vocab::HasV2TableID"], :id => "AAAAAAGJjvjvWlFQRh0=" do
        property "name", :type => "String", :id => "AAAAAAGJ3FPfoQhZnEQ="
        property "table_id", :type => "Integer", :id => "AAAAAAGJ3FQJYgngdX8="
        property "table_type", :type => "HL7::V2::TableType", :id => "AAAAAAGJ3FQvWwrvNxs="
        property "v3_harmonization", :type => "String", :id => "AAAAAAGJ3FRRSAv+tlk="
        property "v3_equivalent", :type => "String", :id => "AAAAAAGJ3FSBJQ0NBxI="
        property "where_used", :type => "String", :id => "AAAAAAGJ3FSpCw4cJ0o="
        property "status", :type => "HL7::V2::TableStatus", :id => "AAAAAAGJ3FTmMQ8rM+8="
        property "values_are_suggestions", :type => "Boolean", :id => "AAAAAAGJ3FUTRBA6u4c="
        property "text", :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJ3FWIFCxLSiQ="
        property "version", :type => "String", :id => "AAAAAAGJ3FWnZS1aUjE="
        property "field_names", :type => "String", :id => "AAAAAAGJ3FXHyC5puXI="
        property "table_oid", :type => "String", :id => "AAAAAAGJ5ocRqkQlecI="
        property "description", :type => "String", :id => "AAAAAAGJ3FYfrDCHAyo="
        property "cs_oid", :type => "String", :id => "AAAAAAGJ3FZDqjGWNU8="
        property "vs_oid", :type => "String", :id => "AAAAAAGJ3FZrnTKlZ3U="
        property "cs_uri", :type => "String", :id => "AAAAAAGJ3Fc+/jTDu8g="
        property "vs_uri", :type => "String", :id => "AAAAAAGJ3FcJrTO0I2M="
        property "where_used_legacy", :type => "String", :id => "AAAAAAGJ5ofHCEfaw4g="
        property "binding_type", :type => "HL7::V2::BindingType", :id => "AAAAAAGJ5omKqG3hlWA="
        property "version_table_introduced", :type => "String", :id => "AAAAAAGJ5ogxgUkay44="
        property "version_csvs_introduced", :type => "String", :id => "AAAAAAGJ5oh69EopX1Q="
        property "cld_type", :type => "HL7::V2::CLD_Type", :id => "AAAAAAGJ5o2Qe6rNr3E="
        property "codes_table_comment", :type => "String", :id => "AAAAAAGJ5okgcGvDFXE="
        property "note", :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJ3FX2Fi94Gwc="
        property "utg_version", :type => "String", :id => "AAAAAAGJ5olT3GzSBIw="
        property "owners", :type => "HL7::WorkGroup", :lower => 1, :upper => Float::INFINITY, :id => "AAAAAAGJiZ2i17Kajdc="
        property nil, :type => "HL7::Vocab::Concept", :upper => Float::INFINITY, :is_ordered => true, :aggregation => :composite, :id => "AAAAAAGJjwImsHvxZHQ="
        property nil, :type => "HL7::Vocab::ConceptDomain", :lower => 1, :id => "AAAAAAGJ5oXaWi4rIAA="
        property nil, :type => "HL7::Vocab::ValueSetDefinition", :upper => Float::INFINITY, :id => "AAAAAAGJjv/RKWC4fR4="
      end
      klass "Concept", :id => "AAAAAAGJjvkQhFF62k0=" do
        property "code", :type => "String", :id => "AAAAAAGJjv0D8VLFKuI="
        property "definition", :type => "String", :id => "AAAAAAGJjv1bPlLMJsY="
        property "display", :type => "String", :id => "AAAAAAGJ5YjMwtzpVrQ="
        property "status", :type => "HL7::Vocab::ConceptStatus", :id => "AAAAAAGJ5Yjsqd3XC54="
        property "version_deprecated", :type => "String", :id => "AAAAAAGJ5YkPJt7FaEI="
        property "comments", :type => "String", :id => "AAAAAAGJ5Yk5BN+zQ9w="
        property "comments_as_published", :type => "String", :id => "AAAAAAGJ5YlXuuChnfk="
        property "usage_notes", :type => "String", :id => "AAAAAAGJ5Yl/t+GP1b0="
        property "children", :type => "HL7::Vocab::Concept", :upper => Float::INFINITY, :id => "AAAAAAGJjv3rTVL+dG8="
        property "parent", :type => "HL7::Vocab::Concept", :id => "AAAAAAGJjv3rTVL/Jx0="
        property nil, :type => "HL7::Vocab::ValueSet", :upper => Float::INFINITY, :id => "AAAAAAGJjv7sq1eym2w="
        property nil, :type => "HL7::Vocab::CodeSystem", :id => "AAAAAAGJjwImsHvyons="
        property nil, :type => "HL7::Vocab::ConceptDomain", :id => "AAAAAAGJjwJ0kIUEQN4="
      end
      klass "ConceptDomain", :implements => ["HL7::Vocab::HasV2TableID"], :id => "AAAAAAGJjvkofVGkPak=" do
        property "description", :type => "String", :id => "AAAAAAGJjvxqclKw9Vc="
        property "identifier", :type => "String", :id => "AAAAAAGJjvyfNVK3kNg="
        property "comment", :type => "String", :id => "AAAAAAGJjvzB0lK+kck="
        property "code", :type => "String", :id => "AAAAAAGJ5ZBTp+vtR2c="
        property nil, :type => "HL7::V2::BoundToVocab", :upper => Float::INFINITY, :id => "AAAAAAGJjwDV/m4ih0Q="
        property nil, :type => "HL7::Vocab::Concept", :id => "AAAAAAGJjwJ0kIUFZQ4="
        property nil, :type => "HL7::Vocab::CodeSystem", :upper => Float::INFINITY, :id => "AAAAAAGJ5oXaWi4sYdo="
      end
      klass "ValueSetDefinition", :id => "AAAAAAGJjvlnX1H4N/k=" do
        property "users", :type => "HL7::V2::BoundToVocab", :upper => Float::INFINITY, :id => "AAAAAAGJ3ImNnXmP7eY="
        property nil, :type => "HL7::Vocab::CodeSystem", :lower => 1, :upper => Float::INFINITY, :id => "AAAAAAGJjv/RKWC5wd4="
        property nil, :type => "HL7::Vocab::ValueSet", :upper => Float::INFINITY, :aggregation => :shared, :id => "AAAAAAGJjv6sJ1Y4kHk="
      end
      klass "ValueSet", :id => "AAAAAAGJjv2YmFLTZj8=" do
        property nil, :type => "HL7::Vocab::Concept", :lower => 1, :upper => Float::INFINITY, :aggregation => :shared, :id => "AAAAAAGJjv7sq1exuO8="
        property nil, :type => "HL7::Vocab::ValueSetDefinition", :id => "AAAAAAGJjv6sJ1Y5D8w="
      end
      enumeration "ConceptStatus", :id => "AAAAAAGJ5Y587uhM2Pc=" do
        property "value", :type => "UML::String"
      end
      interface "HasV2TableID", :id => "AAAAAAGJ5ZEDt/HdLYA=" do
        property "table_id", :type => "Integer", :id => "AAAAAAGJ5ZE4NvZMR0c="
      end
    end # package HL7::Vocab
  end # package HL7
  package "FHIR", :id => "AAAAAAGJjt4KVf6kuAU=" do
     # Association # FHIR::Resource::entries <-> FHIR::Bundle::<unspecified>
    association :properties => ["FHIR::Bundle::entries", "AAAAAAGJjuHKjgESqwA="], :id => "AAAAAAGJjuHKjgEQduQ="
     # Association # FHIR::Section::<unspecified> <-> FHIR::SectionContainer::parent
    association :properties => ["AAAAAAGJjuaQ9hDqhKs=", "FHIR::Section::parent"], :id => "AAAAAAGJjuaQ9hDptF4="
     # Association # FHIR::Narrative::text <-> FHIR::Section::<unspecified>
    association :properties => ["FHIR::Section::text", "AAAAAAGJjuT11guH3fQ="], :id => "AAAAAAGJjuT11guFs1o="
    klass "Resource", :is_abstract => true, :id => "AAAAAAGJjt7Et//VLqY=" do
      property nil, :type => "FHIR::Bundle", :id => "AAAAAAGJjuHKjgESqwA="
    end
    klass "Basic", :parents => ["FHIR::Resource"], :id => "AAAAAAGJjt861QADf1M=" do
      property "text", :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJjt9ZsgAt87o="
      property "uid", :type => "String", :id => "AAAAAAGJjt+P1wA08vQ="
    end
    klass "Bundle", :parents => ["FHIR::Resource"], :id => "AAAAAAGJjt/fhgA8kbs=" do
      property "type", :type => "FHIR::BundleType", :id => "AAAAAAGJjuCP4wCekhU="
      property "entries", :type => "FHIR::Resource", :upper => Float::INFINITY, :aggregation => :shared, :id => "AAAAAAGJjuHKjgERHOQ="
    end
    enumeration "BundleType", :id => "AAAAAAGJjuAwzwBpXas=" do
      property "value", :type => "UML::String"
      literal "document", :id => "AAAAAAGJjuBpKgCXD0c="
    end
    klass "Composition", :parents => ["FHIR::Resource"], :implements => ["FHIR::SectionContainer"], :id => "AAAAAAGJjuDJiAClRBc=" do
      property "status", :type => "FHIR::CompositionStatus", :id => "AAAAAAGJjuD/VQDQsNg="
      property "title", :type => "String", :id => "AAAAAAGJjuEgEgDXJ0I="
      property "chapter", :type => "String", :id => "AAAAAAGJjuE6TgDe+a8="
      property "v2", :type => "V2Web::Section", :id => "AAAAAAGJju8MHy2yhJ8="
    end
    interface "SectionContainer", :id => "AAAAAAGJjuF5nwDlDWs=" do
      property nil, :type => "FHIR::Section", :upper => Float::INFINITY, :aggregation => :composite, :id => "AAAAAAGJjuaQ9hDqhKs="
    end
    enumeration "CompositionStatus", :id => "AAAAAAGJjuLVuwXXiwk=" do
      property "value", :type => "UML::String"
      literal "preliminary", :id => "AAAAAAGJjuM1CgZfS4c="
      literal "final", :id => "AAAAAAGJjuNdeAaWY3U="
      literal "amended", :id => "AAAAAAGJjuNsoga+rBc="
      literal "entered-in-error", :id => "AAAAAAGJjuN+Cgbmaz4="
    end
    klass "Section", :implements => ["FHIR::SectionContainer"], :id => "AAAAAAGJjuPt9wgDC5o=" do
      property "title", :type => "String", :id => "AAAAAAGJjuQK8QhdqRk="
      property "code", :type => "String", :id => "AAAAAAGJjuQoOQiUyt4="
      property "entry", :type => "String", :id => "AAAAAAGJjuRBGgi8Fx8="
      property "focus", :type => "String", :id => "AAAAAAGJjuRmKQjkNcs="
      property "v2", :type => "FHIR::SubsectionContent", :id => "AAAAAAGJju/2dDOiI60="
      property "parent", :type => "FHIR::SectionContainer", :id => "AAAAAAGJjuaQ9hDrhrw="
      property "text", :type => "FHIR::Narrative", :aggregation => :composite, :id => "AAAAAAGJjuT11guGqmo="
    end
    klass "Narrative", :id => "AAAAAAGJjuSstgqIer0=" do
      property "status", :type => "FHIR::NarrativeStatus", :id => "AAAAAAGJjuVj8wzuSxM="
      property "div", :type => "Gui_Builder_Profile::Code", :id => "AAAAAAGJjuV4ug1VOLg="
      property nil, :type => "FHIR::Section", :id => "AAAAAAGJjuT11guH3fQ="
    end
    enumeration "NarrativeStatus", :id => "AAAAAAGJjuWnIw2226E=" do
      property "value", :type => "UML::String"
      literal "generated", :id => "AAAAAAGJjuXiNA5E7OY="
      literal "extensions", :id => "AAAAAAGJjuX7CQ6rbCU="
      literal "additional", :id => "AAAAAAGJjuYUgg70w+s="
      literal "empty", :id => "AAAAAAGJjuYlLQ898iU="
    end
    interface "SubsectionContent", :id => "AAAAAAGJjum6Eh+sJJI=" do
      property "fhir", :type => "FHIR::Section", :id => "AAAAAAGJju/2dDOjdMA="
    end
  end # package FHIR
  package "V2Web", :id => "AAAAAAGJjuhFuB2MxOo=" do
     # Association # V2Web::Content::content <-> V2Web::Box::<unspecified>
    association :properties => ["V2Web::Box::content", "AAAAAAGJrHCJVvSbnk8="], :id => "AAAAAAGJrHCJVvSZk2I="
     # Association # V2Web::Content::items <-> V2Web::List::<unspecified>
    association :properties => ["V2Web::List::items", "AAAAAAGJrHUhKxKytog="], :id => "AAAAAAGJrHUhKxKwb0k="
     # Association # V2Web::Content::content <-> V2Web::Cell::<unspecified>
    association :properties => ["V2Web::Cell::content", "AAAAAAGJrITHH7siq30="], :id => "AAAAAAGJrITHH7sge4k="
     # Association # V2Web::Content::content <-> V2Web::Tab::<unspecified>
    association :properties => ["V2Web::Tab::content", "AAAAAAGJrI2ZmAk9xdI="], :id => "AAAAAAGJrI2ZmAk7RAU="
     # Association # FHIR::Composition::fhir_composition <-> V2Web::Section::v2
    association :properties => ["V2Web::Section::fhir_composition", "FHIR::Composition::v2"], :id => "AAAAAAGJju8MHy2wrag="
     # Association # V2Web::Reference::<unspecified> <-> HL7::V2::Referenceable::ref
    association :properties => ["AAAAAAGJrGrZmdAvPL4=", "V2Web::Reference::ref"], :id => "AAAAAAGJrGrZmdAuC+E="
     # Association # V2Web::SubsectionContent::content <-> V2Web::Section::parents
    association :properties => ["V2Web::Section::content", "V2Web::SubsectionContent::parents"], :id => "AAAAAAGJrGvupNGwBqg="
     # Association # V2Web::Footnote::<unspecified> <-> V2Web::Content::for
    association :properties => ["AAAAAAGJrHSeeg061nE=", "V2Web::Footnote::for"], :id => "AAAAAAGJrHSeeg05wOY="
     # Association # V2Web::Column::cols <-> V2Web::Table::<unspecified>
    association :properties => ["V2Web::Table::cols", "AAAAAAGJrIWAfL5kvQE="], :id => "AAAAAAGJrIWAfL5irJo="
     # Association # V2Web::Cell::<unspecified> <-> V2Web::Row::<unspecified>
    association :properties => ["AAAAAAGJrIdxwdS3IDA=", "AAAAAAGJrIdxwdS4NWM="], :id => "AAAAAAGJrIdxwdS2YCk="
     # Association # V2Web::Row::<unspecified> <-> V2Web::Table::<unspecified>
    association :properties => ["AAAAAAGJrIZyZclfTyI=", "AAAAAAGJrIZyZclgjQA="], :id => "AAAAAAGJrIZyZcleU3I="
     # Association # V2Web::Tab::<unspecified> <-> V2Web::TabSet::<unspecified>
    association :properties => ["AAAAAAGJrIztRwd29AM=", "AAAAAAGJrIztRwd3IO0="], :id => "AAAAAAGJrIztRwd1lq0="
     # Association # FHIR::SubsectionContent::v2 <-> FHIR::Section::fhir
    association :properties => ["FHIR::Section::v2", "FHIR::SubsectionContent::fhir"], :id => "AAAAAAGJju/2dDOhAFQ="
    interface "Content", :parents => ["V2Web::SubsectionContent"], :id => "AAAAAAGJrFv8+szeWmY=" do
      property nil, :type => "V2Web::Box", :upper => Float::INFINITY, :id => "AAAAAAGJrHCJVvSbnk8="
      property nil, :type => "V2Web::List", :id => "AAAAAAGJrHUhKxKytog="
      property nil, :type => "V2Web::Cell", :id => "AAAAAAGJrITHH7siq30="
      property nil, :type => "V2Web::Tab", :id => "AAAAAAGJrI2ZmAk9xdI="
      property nil, :type => "V2Web::Footnote", :upper => Float::INFINITY, :aggregation => :shared, :id => "AAAAAAGJrHSeeg061nE="
    end
    klass "Section", :implements => ["V2Web::SubsectionContent"], :id => "AAAAAAGJrGal+89Oj8Q=" do
      property "title", :type => "String", :id => "AAAAAAGJrHG7KQDqGBY="
      property "render_as", :type => "V2Web::SectionRenderingType", :id => "AAAAAAGJvT2oOuE4OCc="
      property "version", :type => "String", :id => "AAAAAAGJrI9/Th8whRA="
      property "remarks", :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJrHIcRAJOCmo="
      property "original", :type => "Gui_Builder_Profile::File", :id => "AAAAAAGJrHI/nwK4grk="
      property "original_number", :type => "String", :id => "AAAAAAGLpaVKbWeErdM="
      property "fhir_composition", :type => "FHIR::Composition", :id => "AAAAAAGJju8MHy2xdg0="
      property "content", :type => "V2Web::SubsectionContent", :upper => Float::INFINITY, :is_ordered => true, :aggregation => :shared, :id => "AAAAAAGJrGvupNGxGks="
    end
    klass "Table", :implements => ["V2Web::Content"], :id => "AAAAAAGJrF+ais0Lvow=" do
      property "caption", :type => "String", :id => "AAAAAAGJrHk3RkIWuVw="
      property "width", :type => "String", :id => "AAAAAAGJrHlczUOFzh0="
      property "cols", :type => "V2Web::Column", :lower => 1, :upper => Float::INFINITY, :is_ordered => true, :aggregation => :composite, :id => "AAAAAAGJrIWAfL5jTT8="
      property nil, :type => "V2Web::Row", :lower => 1, :upper => Float::INFINITY, :is_ordered => true, :aggregation => :composite, :id => "AAAAAAGJrIZyZclfTyI="
    end
    klass "Figure", :implements => ["V2Web::Content"], :id => "AAAAAAGJrGA7us01r9M=" do
      property "caption", :type => "String", :id => "AAAAAAGJrIr0tvzXr+M="
      property "file", :type => "Gui_Builder_Profile::File", :id => "AAAAAAGJrIst9gUFAbA="
    end
    klass "List", :implements => ["V2Web::Content"], :id => "AAAAAAGJrGBR4c1fhXU=" do
      property "title", :type => "String", :id => "AAAAAAGJrH1BOooBtic="
      property "level", :type => "Integer", :default_value => "1", :id => "AAAAAAGJrH1mkYr4Z8E="
      property "item_indicator", :type => "V2Web::ListIndicator", :id => "AAAAAAGJrH2qrYxJtsU="
      property "ordered", :type => "Boolean", :id => "AAAAAAGJrH38rY2av0A="
      property "items", :type => "V2Web::Content", :lower => 1, :upper => Float::INFINITY, :is_ordered => true, :aggregation => :shared, :id => "AAAAAAGJrHUhKxKxlqI="
    end
    klass "Text", :implements => ["V2Web::Content"], :id => "AAAAAAGJrGBo9c2J3OI=" do
      property "content", :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJrH75dZKsvf0="
    end
    klass "Reference", :implements => ["V2Web::Content"], :id => "AAAAAAGJrGCRFc2zH3M=" do
      property "render_as", :type => "V2Web::ReferenceRenderingType", :id => "AAAAAAGJrImnEu4YK50="
      property "ref", :type => "HL7::V2::Referenceable", :lower => 1, :id => "AAAAAAGJrGrZmdAwJ9c="
    end
    klass "TabSet", :implements => ["V2Web::Content"], :id => "AAAAAAGJrGDO+M3ex24=" do
      property "title", :type => "String", :id => "AAAAAAGJrH9MwpQq5p8="
      property nil, :type => "V2Web::Tab", :upper => Float::INFINITY, :is_ordered => true, :aggregation => :composite, :id => "AAAAAAGJrIztRwd29AM="
    end
    klass "PageBreak", :implements => ["V2Web::Content"], :id => "AAAAAAGJrGKQYc5nAeU=" do
    end
    klass "Code", :implements => ["V2Web::Content"], :id => "AAAAAAGJrGTcE861kgY=" do
      property "title", :type => "String", :id => "AAAAAAGJrH5JJo9jjfI="
      property "code", :type => "Gui_Builder_Profile::Code", :id => "AAAAAAGJrH52opDEf/o="
    end
    interface "SubsectionContent", :id => "AAAAAAGJrGXPL88KpkI=" do
      property "styles", :type => "V2Web::Style", :upper => Float::INFINITY, :id => "AAAAAAGJrG4AEuqIOu0="
      property "ooxml", :type => "Gui_Builder_Profile::Code", :id => "AAAAAAGJrG/KS/BS+uQ="
      property "parents", :type => "V2Web::Section", :upper => Float::INFINITY, :id => "AAAAAAGJrGvupNGyUIc="
    end
    klass "Standard", :parents => ["V2Web::Document"], :id => "AAAAAAGJrGbISM949JU=" do
      property "ansi_designation", :type => "String", :id => "AAAAAAGJrHPLqQfwCnY="
      property "chapter", :type => "String", :id => "AAAAAAGJrHQBKwiH8eU="
    end
    klass "Document", :parents => ["V2Web::Section"], :id => "AAAAAAGJrGbkqM+iG+Q=" do
    end
    enumeration "SectionRenderingType", :id => "AAAAAAGJrG6lLOtK+M4=" do
      property "value", :type => "UML::String"
      literal "linked_page", :id => "AAAAAAGJrHFFc/eZhrY="
    end
    enumeration "Style", :id => "AAAAAAGJrG7Q9ewCKCc=" do
      property "value", :type => "UML::String"
    end
    klass "Box", :implements => ["V2Web::SubsectionContent"], :id => "AAAAAAGJrG8ume2N/XE=" do
      property "content", :type => "V2Web::Content", :upper => Float::INFINITY, :is_ordered => true, :aggregation => :shared, :id => "AAAAAAGJrHCJVvSaSXU="
    end
    klass "Footnote", :id => "AAAAAAGJrHRd/Amcpvo=" do
      property "content", :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJrH0M94h0aLU="
      property "for", :type => "V2Web::Content", :upper => Float::INFINITY, :id => "AAAAAAGJrHSeeg0759Y="
    end
    klass "Note", :parents => ["V2Web::Text"], :id => "AAAAAAGJrHX4sSEmer0=" do
      property "note_type", :type => "V2Web::NoteType", :id => "AAAAAAGJrHhjBS5FWeo="
    end
    klass "Example", :parents => ["V2Web::Text"], :id => "AAAAAAGJrHYRcSIxM1s=" do
    end
    enumeration "NoteType", :id => "AAAAAAGJrHZcbCNLcNs=" do
      property "value", :type => "UML::String"
    end
    enumeration "TabType", :id => "AAAAAAGJrHax8SRpVC0=" do
      property "value", :type => "UML::String"
    end
    enumeration "ListIndicator", :id => "AAAAAAGJrHbrTSW0fBA=" do
      property "value", :type => "UML::String"
      literal "bullets", :id => "AAAAAAGJrHce5SbS2m4="
      literal "letters", :id => "AAAAAAGJrHdAYCfJV/s="
      literal "numbers", :id => "AAAAAAGJrHdacih12tY="
    end
    klass "Column", :id => "AAAAAAGJrHqYJ1G/GEc=" do
      property "styles", :type => "V2Web::Style", :upper => Float::INFINITY, :id => "AAAAAAGJrICG1rKiw5Q="
      property "width", :type => "String", :id => "AAAAAAGJrIC4GbOZzyA="
      property "ooxml", :type => "Gui_Builder_Profile::Code", :id => "AAAAAAGJrIDX2bRFa88="
      property nil, :type => "V2Web::Table", :id => "AAAAAAGJrIWAfL5kvQE="
    end
    klass "Cell", :id => "AAAAAAGJrHq6RlLKzsE=" do
      property "styles", :type => "V2Web::Style", :upper => Float::INFINITY, :id => "AAAAAAGJrIO7trsDuz0="
      property "colspan", :type => "Integer", :default_value => "1", :id => "AAAAAAGJrIPwvrsKIgs="
      property "rowspan", :type => "Integer", :default_value => "1", :id => "AAAAAAGJrIQjWrsRLAs="
      property "ooxml", :type => "Gui_Builder_Profile::Code", :id => "AAAAAAGJrIRQx7sYqEA="
      property "content", :type => "V2Web::Content", :upper => Float::INFINITY, :is_ordered => true, :aggregation => :shared, :id => "AAAAAAGJrITHH7sh+OM="
      property nil, :type => "V2Web::Row", :id => "AAAAAAGJrIdxwdS4NWM="
    end
    klass "Row", :id => "AAAAAAGJrHrfv1PkVds=" do
      property "styles", :type => "V2Web::Style", :upper => Float::INFINITY, :id => "AAAAAAGJrIGPKraHerE="
      property "header", :type => "Boolean", :default_value => "false", :id => "AAAAAAGJrIgUI9rXbgI="
      property "ooxml", :type => "Gui_Builder_Profile::Code", :id => "AAAAAAGJrIg+7ttiV5c="
      property nil, :type => "V2Web::Cell", :lower => 1, :upper => Float::INFINITY, :is_ordered => true, :aggregation => :composite, :id => "AAAAAAGJrIdxwdS3IDA="
      property nil, :type => "V2Web::Table", :id => "AAAAAAGJrIZyZclgjQA="
    end
    enumeration "ReferenceRenderingType", :id => "AAAAAAGJrIoEAu+Gmj4=" do
      property "value", :type => "UML::String"
    end
    klass "Tab", :id => "AAAAAAGJrIxQkQc2mNY=" do
      property "type", :type => "V2Web::TabType", :id => "AAAAAAGJrIxvtgdgvLw="
      property "title", :type => "String", :id => "AAAAAAGJrIyaKAdnVI8="
      property "file", :type => "Gui_Builder_Profile::File", :id => "AAAAAAGJrIy3DAduOyA="
      property "content", :type => "V2Web::Content", :upper => Float::INFINITY, :is_ordered => true, :aggregation => :shared, :id => "AAAAAAGJrI2ZmAk8TaU="
      property nil, :type => "V2Web::TabSet", :id => "AAAAAAGJrIztRwd3IO0="
    end
  end # package V2Web
  profile "Gui_Builder_Profile", :id => "AAAAAAGJiYH0HVJPv9A=" do
     # Association # Gui_Builder_Profile::User::users <-> Gui_Builder_Profile::UserRole::roles
    association :properties => ["Gui_Builder_Profile::UserRole::users", "Gui_Builder_Profile::User::roles"], :association_class => "Gui_Builder_Profile::RolePermissions", :id => "AAAAAAGJiYH0GlC4nGw="
     # Association # Gui_Builder_Profile::UserRole::roles_granted <-> Gui_Builder_Profile::InvitationCode::invitations
    association :properties => ["Gui_Builder_Profile::InvitationCode::roles_granted", "Gui_Builder_Profile::UserRole::invitations"], :association_class => "Gui_Builder_Profile::GrantedPermissions", :id => "AAAAAAGJiYH0HFIYMFw="
     # Association # Gui_Builder_Profile::File::<unspecified> <-> Gui_Builder_Profile::BinaryData::<unspecified>
    association :properties => ["AAAAAAGJ4JLg7G7wc64=", "AAAAAAGJ4JLg7G7xpl0="], :id => "AAAAAAGJ4JLg7G7v2fk="
     # Association # Gui_Builder_Profile::RichTextImage::images <-> Gui_Builder_Profile::RichText::<unspecified>
    association :properties => ["Gui_Builder_Profile::RichText::images", "AAAAAAGJiYH0GlCoUr8="], :id => "AAAAAAGJiYH0GlCpq/o="
     # Association # Gui_Builder_Profile::Organization::<unspecified> <-> Gui_Builder_Profile::InvitationCode::<unspecified>
    association :properties => ["AAAAAAGJiYH0HFIPUzU=", "AAAAAAGJiYH0HFIQEOE="], :id => "AAAAAAGJiYH0HFIRmJI="
     # Association # Gui_Builder_Profile::InvitationCode::<unspecified> <-> Gui_Builder_Profile::Perspective::<unspecified>
    association :properties => ["AAAAAAGJ9PXQ5wlpjOg=", "AAAAAAGJ9PXQ5wlq01g="], :id => "AAAAAAGJ9PXQ5wlo5Pw="
     # Association # Gui_Builder_Profile::Person::<unspecified> <-> Gui_Builder_Profile::Organization::<unspecified>
    association :properties => ["AAAAAAGJiYH0HFIdbT4=", "AAAAAAGJiYH0HFIeZGs="], :id => "AAAAAAGJiYH0HFIfM+o="
     # Association # Gui_Builder_Profile::StringCondition::email_requirements <-> Gui_Builder_Profile::ProjectOptions::email_requirement_for
    association :properties => ["Gui_Builder_Profile::ProjectOptions::email_requirements", "Gui_Builder_Profile::StringCondition::email_requirement_for"], :id => "AAAAAAGJiYH0HVIt5UM="
     # Association # Gui_Builder_Profile::StringCondition::password_requirements <-> Gui_Builder_Profile::ProjectOptions::password_requirement_for
    association :properties => ["Gui_Builder_Profile::ProjectOptions::password_requirements", "Gui_Builder_Profile::StringCondition::password_requirement_for"], :id => "AAAAAAGJiYH0HVIwv00="
     # Association # Gui_Builder_Profile::StringCondition::additional_email_requirements <-> Gui_Builder_Profile::InvitationCode::additional_email_requirement_for
    association :properties => ["Gui_Builder_Profile::InvitationCode::additional_email_requirements", "Gui_Builder_Profile::StringCondition::additional_email_requirement_for"], :id => "AAAAAAGJiYH0HVIz7JY="
     # Association # Gui_Builder_Profile::Perspective::<unspecified> <-> Gui_Builder_Profile::User::<unspecified>
    association :properties => ["AAAAAAGJ9PXdPRDDh8w=", "AAAAAAGJ9PXdPRDEmxU="], :id => "AAAAAAGJ9PXdPRDC0Ro="
     # Association # Gui_Builder_Profile::Perspective::<unspecified> <-> Gui_Builder_Profile::MultiVocabularySubstitution::substitutions
    association :properties => ["AAAAAAGJ9PXr7RaCvCk=", "Gui_Builder_Profile::Perspective::substitutions"], :id => "AAAAAAGJ9PXr7RaBdds="
    stereotype "change_tracked", :id => "AAAAAAGJiYH0GlCWv3Y="
    stereotype "options", :id => "AAAAAAGJiYH0GlCY2G4="
    klass "BinaryData", :id => "AAAAAAGJiYH0GlCdjpA=" do
      property "data", :type => "ByteString", :id => "AAAAAAGJiYH0GlCcR+0="
      property nil, :type => "Gui_Builder_Profile::File", :id => "AAAAAAGJ4JLg7G7wc64="
    end
    klass "Code", :id => "AAAAAAGJiYH0GlCgJ58=" do
      applied_stereotype :instance_of => "Gui_Builder_Profile::complex_attribute"
      property "language", :type => "Gui_Builder_Profile::LanguageType", :id => "AAAAAAGJiYH0GlCeEhY="
      property "content", :type => "String", :id => "AAAAAAGJiYH0GlCfpOY="
    end
    klass "File", :id => "AAAAAAGJiYH0GlCjkJ0=" do
      applied_stereotype :instance_of => "Gui_Builder_Profile::complex_attribute"
      property "filename", :type => "String", :id => "AAAAAAGJiYH0GlChVHs="
      property "mime_type", :type => "String", :id => "AAAAAAGJiYH0GlCiWgU="
      property nil, :type => "Gui_Builder_Profile::BinaryData", :aggregation => :composite, :id => "AAAAAAGJ4JLg7G7xpl0="
    end
    klass "RichText", :id => "AAAAAAGJiYH0GlCmGes=" do
      applied_stereotype :instance_of => "Gui_Builder_Profile::complex_attribute"
      property "content", :type => "String", :id => "AAAAAAGJiYH0GlCkZjE="
      property "markup_language", :type => "Gui_Builder_Profile::MarkupType", :id => "AAAAAAGJiYH0GlClOu0="
      property "images", :type => "Gui_Builder_Profile::RichTextImage", :upper => Float::INFINITY, :aggregation => :composite, :id => "AAAAAAGJiYH0GlCni1I="
    end
    klass "RichTextImage", :id => "AAAAAAGJiYH0GlCr7+s=" do
      property "image", :type => "Gui_Builder_Profile::File", :id => "AAAAAAGJiYH0GlCq8gc="
      property nil, :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJiYH0GlCoUr8="
    end
    klass "User", :parents => ["Gui_Builder_Profile::Person"], :id => "AAAAAAGJiYH0GlCzhHk=" do
      property "login", :type => "String", :id => "AAAAAAGJiYH0GlCsRAs="
      property "password_hash", :type => "String", :id => "AAAAAAGJiYH0GlCtYek="
      property "salt", :type => "String", :id => "AAAAAAGJiYH0GlCu15Y="
      property "use_accessibility", :type => "Boolean", :id => "AAAAAAGJiYH0GlCvTzY="
      property "password_reset_token", :type => "String", :id => "AAAAAAGJiYH0GlCwJfc="
      property "password_reset_time_limit", :type => "Datetime", :id => "AAAAAAGJiYH0GlCxCm8="
      property "email_confirmation_token", :type => "String", :id => "AAAAAAGJiYH0GlCymOE="
      property "roles", :type => "Gui_Builder_Profile::UserRole", :upper => Float::INFINITY, :id => "AAAAAAGJiYH0GlC3QrQ="
      property nil, :type => "Gui_Builder_Profile::Perspective", :upper => Float::INFINITY, :id => "AAAAAAGJ9PXdPRDDh8w="
    end
    klass "UserRole", :id => "AAAAAAGJiYH0GlC1DkU=" do
      property "name", :type => "String", :id => "AAAAAAGJiYH0GlC010g="
      property "users", :type => "Gui_Builder_Profile::User", :upper => Float::INFINITY, :id => "AAAAAAGJiYH0GlC2YKs="
      property "invitations", :type => "Gui_Builder_Profile::InvitationCode", :id => "AAAAAAGJiYH0HFIXau4="
    end
    klass "RolePermissions", :id => "AAAAAAGJiYH0GlC7awY=" do
      property "role_manager", :type => "Boolean", :default_value => "false", :id => "AAAAAAGJiYH0GlC6VJU="
    end
    klass "InvitationCode", :id => "AAAAAAGJiYH0HFIVwW4=" do
      property "code", :type => "String", :id => "AAAAAAGJiYH0HFISkgU="
      property "expires", :type => "Datetime", :id => "AAAAAAGJiYH0HFITZ+Q="
      property "uses_remaining", :type => "Integer", :id => "AAAAAAGJiYH0HFIUr5I="
      property nil, :type => "Gui_Builder_Profile::Organization", :upper => Float::INFINITY, :id => "AAAAAAGJiYH0HFIPUzU="
      property nil, :type => "Gui_Builder_Profile::Perspective", :upper => Float::INFINITY, :id => "AAAAAAGJ9PXQ5wlq01g="
      property "roles_granted", :type => "Gui_Builder_Profile::UserRole", :id => "AAAAAAGJiYH0HFIW4ls="
      property "additional_email_requirements", :type => "Gui_Builder_Profile::StringCondition", :upper => Float::INFINITY, :aggregation => :composite, :id => "AAAAAAGJiYH0HVIxN80="
    end
    klass "GrantedPermissions", :id => "AAAAAAGJiYH0HFIbMrI=" do
      property "role_manager", :type => "Boolean", :default_value => "false", :id => "AAAAAAGJiYH0HFIaMbU="
    end
    klass "Person", :id => "AAAAAAGJiYH0HFIkLFY=" do
      property "first_name", :type => "String", :id => "AAAAAAGJiYH0HFIgW9Y="
      property "last_name", :type => "String", :id => "AAAAAAGJiYH0HFIh8ws="
      property "email", :type => "String", :id => "AAAAAAGJiYH0HFIi47w="
      property "email_verified", :type => "Boolean", :id => "AAAAAAGJiYH0HFIjPaU="
      property nil, :type => "Gui_Builder_Profile::Organization", :upper => Float::INFINITY, :id => "AAAAAAGJiYH0HFIeZGs="
      property "co_chairs", :type => "HL7::WorkGroup", :upper => Float::INFINITY, :id => "AAAAAAGJjvb3P0u7/tk="
      property "work_groups", :type => "HL7::WorkGroup", :upper => Float::INFINITY, :id => "AAAAAAGJjvZF8kiTKlY="
    end
    klass "Organization", :id => "AAAAAAGJiYH0HFIo1Cc=" do
      property "name", :type => "String", :id => "AAAAAAGJiYH0HFIl4Ow="
      property "description", :type => "Gui_Builder_Profile::RichText", :id => "AAAAAAGJiYH0HFIm7fM="
      property "org_user_limit", :type => "Integer", :default_value => "2", :id => "AAAAAAGJiYH0HFInpN8="
      property nil, :type => "Gui_Builder_Profile::InvitationCode", :upper => Float::INFINITY, :aggregation => :shared, :id => "AAAAAAGJiYH0HFIQEOE="
      property nil, :type => "Gui_Builder_Profile::Person", :upper => Float::INFINITY, :aggregation => :shared, :id => "AAAAAAGJiYH0HFIdbT4="
    end
    klass "StringCondition", :is_abstract => true, :id => "AAAAAAGJiYH0HVI2S8s=" do
      property "failure_message", :type => "String", :id => "AAAAAAGJiYH0HVI0eoI="
      property "description", :type => "String", :id => "AAAAAAGJiYH0HVI1vQE="
      property "email_requirement_for", :type => "Gui_Builder_Profile::ProjectOptions", :id => "AAAAAAGJiYH0HVIsLHc="
      property "password_requirement_for", :type => "Gui_Builder_Profile::ProjectOptions", :id => "AAAAAAGJiYH0HVIvRyo="
      property "additional_email_requirement_for", :type => "Gui_Builder_Profile::InvitationCode", :id => "AAAAAAGJiYH0HVIyCXw="
    end
    klass "RegularExpressionCondition", :parents => ["Gui_Builder_Profile::StringCondition"], :id => "AAAAAAGJiYH0HVI4kVc=" do
      property "regular_expression", :type => "RegularExpression", :id => "AAAAAAGJiYH0HVI3sRo="
    end
    klass "ProjectOptions", :id => "AAAAAAGJiYH0HVI63B0=" do
      applied_stereotype :instance_of => "Gui_Builder_Profile::singleton"
      property "user_registration", :type => "Gui_Builder_Profile::UserRegistrationType", :id => "AAAAAAGJiYH0HVI59DQ="
      property "email_requirements", :type => "Gui_Builder_Profile::StringCondition", :upper => Float::INFINITY, :aggregation => :composite, :id => "AAAAAAGJiYH0HFIrBXY="
      property "password_requirements", :type => "Gui_Builder_Profile::StringCondition", :upper => Float::INFINITY, :aggregation => :composite, :id => "AAAAAAGJiYH0HVIuqLg="
    end
    stereotype "singleton", :id => "AAAAAAGJiYH0HVI8Wdk="
    stereotype "complex_attribute", :id => "AAAAAAGJiYH0HVI+C/Q="
    enumeration "LanguageType", :id => "AAAAAAGJiYH0HVJFGF4=" do
      property "value", :type => "UML::String"
      literal "Ruby", :id => "AAAAAAGJiYH0HVI/Us8="
      literal "JavaScript", :id => "AAAAAAGJiYH0HVJACTA="
      literal "XML", :id => "AAAAAAGJiYH0HVJBwgY="
      literal "HTML", :id => "AAAAAAGJiYH0HVJCOSI="
      literal "ASN.1", :id => "AAAAAAGJiYH0HVJDkIE="
    end
    enumeration "MarkupType", :id => "AAAAAAGJiYH0HVJK2PE=" do
      property "value", :type => "UML::String"
      literal "Markdown", :id => "AAAAAAGJiYH0HVJGteM="
      literal "HTML", :id => "AAAAAAGJiYH0HVJH4D0="
      literal "AsciiDoc", :id => "AAAAAAGJiYH0HVJI+oM="
      literal "PlainText", :id => "AAAAAAGJiYH0HVJJPI8="
    end
    enumeration "UserRegistrationType", :id => "AAAAAAGJiYH0HVJOtnc=" do
      property "value", :type => "UML::String"
      literal "Open", :id => "AAAAAAGJiYH0HVJLYRw="
      literal "Email", :id => "AAAAAAGJiYH0HVJMP0I="
      literal "Invitation", :id => "AAAAAAGJiYH0HVJNpUE="
    end
    klass "Perspective", :id => "AAAAAAGJ9PRKhcz/RSo=" do
      property "name", :type => "String", :id => "AAAAAAGJ9PRrOc7ZOAw="
      property nil, :type => "Gui_Builder_Profile::InvitationCode", :upper => Float::INFINITY, :id => "AAAAAAGJ9PXQ5wlpjOg="
      property nil, :type => "Gui_Builder_Profile::User", :upper => Float::INFINITY, :id => "AAAAAAGJ9PXdPRDEmxU="
      property "substitutions", :type => "Gui_Builder_Profile::MultiVocabularySubstitution", :upper => Float::INFINITY, :aggregation => :composite, :id => "AAAAAAGJ9PXr7RaDIzY="
    end
    klass "MultiVocabularySubstitution", :id => "AAAAAAGJ9PSYwtEyi0k=" do
      property nil, :type => "Gui_Builder_Profile::Perspective", :lower => 1, :id => "AAAAAAGJ9PXr7RaCvCk="
    end
  end # package Gui_Builder_Profile
end # project v2web
