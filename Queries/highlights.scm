(comment) @comment

[
  "if" 
  "then"
  "else"
] @keyword.condition

[
  "rec"
] @keyword.modifier

[
  "or"
] @keyword.operator

[
  "let"
  "inherit"
  "in"
  "with" 
  "assert"
] @keyword

((identifier) @value.boolean
 (#match? @value.boolean "^(false|true)$")
)

((identifier) @value.null
 (#eq? @value.null "null")
)


((identifier) @identifier.core.variable
 (#match? @identifier.core.variable "^(__currentSystem|__currentTime|__nixPath|__nixVersion|__storeDir|builtins)$")
)

((identifier) @identifier.core.variable
 (#match? @identifier.core.variable "^(__add|__addErrorContext|__all|__any|__appendContext|__attrNames|__attrValues|__bitAnd|__bitOr|__bitXor|__catAttrs|__compareVersions|__concatLists|__concatMap|__concatStringsSep|__deepSeq|__div|__elem|__elemAt|__fetchurl|__filter|__filterSource|__findFile|__foldl'|__fromJSON|__functionArgs|__genList|__genericClosure|__getAttr|__getContext|__getEnv|__hasAttr|__hasContext|__hashFile|__hashString|__head|__intersectAttrs|__isAttrs|__isBool|__isFloat|__isFunction|__isInt|__isList|__isPath|__isString|__langVersion|__length|__lessThan|__listToAttrs|__mapAttrs|__match|__mul|__parseDrvName|__partition|__path|__pathExists|__readDir|__readFile|__replaceStrings|__seq|__sort|__split|__splitVersion|__storePath|__stringLength|__sub|__substring|__tail|__toFile|__toJSON|__toPath|__toXML|__trace|__tryEval|__typeOf|__unsafeDiscardOutputDependency|__unsafeDiscardStringContext|__unsafeGetAttrPos|__valueSize|abort|baseNameOf|derivation|derivationStrict|dirOf|fetchGit|fetchMercurial|fetchTarball|fromTOML|import|isNull|map|placeholder|removeAttrs|scopedImport|throw|toString)$")
)

[
  (string_expression)
  (indented_string_expression)
] @string

[
  (path_expression)
  (hpath_expression)
  (spath_expression)
] @string.special.path

(uri_expression) @string.special.uri

[
  (integer_expression)
  (float_expression)
] @value.number

(interpolation
  "${" @bracket
  "}" @bracket) @string-template.value

(escape_sequence) @value.entity
(dollar_escape) @value.entity

(function_expression
  universal: (identifier) @identifier.argument
)

(formal
  name: (identifier) @identifier.argument
  "?"? @operator)

(select_expression
  attrpath: (attrpath (identifier)) @identifier.property)

(apply_expression
  function: [
    (variable_expression (identifier)) @identifier.function
    (select_expression
      attrpath: (attrpath
        attr: (identifier) @identifier.function .))])

(unary_expression
  operator: _ @operator)

(binary_expression
  operator: _ @operator)

(variable_expression (identifier) @identifier.variable)

(binding
  attrpath: (attrpath (identifier)) @definition.property)

(inherit attrs: (inherited_attrs attr: (identifier) @definition.property) )

(inherit_from attrs: (inherited_attrs attr: (identifier) @definition.property) )

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @bracket