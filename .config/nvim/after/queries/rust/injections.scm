; extends

; sqlx macro highlighting
(macro_invocation
  macro: [
    (scoped_identifier
      name: (_) @_macro_name)
    (identifier) @_macro_name
  ]
  (token_tree
    (raw_string_literal
      (string_content) @injection.content))
  (#match? @_macro_name "query(_as|_scalar|)")
  (#set! injection.language "sql"))

; Check for comment
(
  [
    (line_comment)
    (block_comment)
  ] @_comment
  (#match? @_comment "language\\=(Postgre|)SQL")
  .
  [
   (let_declaration
    value: [
        (string_literal
          (string_content) @injection.content)
        (raw_string_literal
          (string_content) @injection.content)
      ]
   )
   (string_literal
     (string_content) @injection.content)
   (raw_string_literal
     (string_content) @injection.content)
   ]
   (#set! injection.language "sql")
)

; Taken from go.nvim
; (
;   (string_content) @injection.content
;  (#match? @injection.content "^\\s*(SELECT|INSERT|UPDATE|DELETE|CREATE|DROP|ALTER|WITH|GRANT|select|insert|update|delete|create|drop|alter|with|grant)")
; (#set! injection.language "sql"))
