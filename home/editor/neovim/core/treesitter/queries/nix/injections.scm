;; extends
(binding_set
  (binding
    attrpath: (attrpath) @_key (#eq? @_key "type")
    expression: (string_expression) @_value (#eq? @_value "\"lua\""))
  (binding
    attrpath: (attrpath) @_keys (#eq? @_keys "config")
      (indented_string_expression
        (string_fragment) @lua))
)

(binding
	attrpath: (attrpath) @_key (#eq? @_key "extraConfig")
	(indented_string_expression
		(string_fragment) @vim)
)
