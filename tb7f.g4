// Basic grammar for parsing TB7 filter conditions (see https://github.com/Microsoft/threat-modeling-templates)
//
// This grammar 
// - Parses conditions in isolation
// - May not (yet) be complete, especially for special names like 'crosses' and 'source', 'target' etc.
//
grammar tb7f;

entity_flow: 'flow';
entity_target: 'target';
entity_source: 'source';

special_entity:  entity_flow | entity_target | entity_source;

entity_literal_name: QUOTED_STRING;

// e.g. source.Myproperty
special_entity_with_property: special_entity ENTITY_PROPERTY;

// Entity is any special built-in OR a literal string
entity: special_entity | special_entity_with_property | entity_literal_name;

op_crosses: 'crosses';
op_is: 'is';

// Entity operations
op_entity: op_crosses|op_is;

op_and: 'and';
op_or: 'or';

assertion: entity op_entity entity;

expression: 
    bracketed_expression |
    expression op_and expression |
    expression op_or expression |    
    assertion ;          

bracketed_expression: '(' expression ')';

ENTITY_PROPERTY: '.' [a-zA-Z_][a-zA-Z_0-9]* | '.' GUID;
QUOTED_STRING: '\'' .*? '\'';

WHITESPACE : [ \t\r\n]+ -> skip ; 

GUID: GUID_BLOCK GUID_BLOCK '-' GUID_BLOCK '-' GUID_BLOCK '-' GUID_BLOCK '-' GUID_BLOCK GUID_BLOCK GUID_BLOCK;

fragment GUID_BLOCK:
    [A-Za-z0-9] [A-Za-z0-9] [A-Za-z0-9] [A-Za-z0-9];