<% module_namespacing do -%>
class <%= class_name %> < <%= parent_class_name.classify %>
  # Scope macros

  # Concerns macros

  # Constants

  # Attributes related macros
<% if attributes.any?(&:password_digest?) -%>
  has_secure_password
<% end -%>

  # Association macros
<% attributes.select(&:reference?).each do |attribute| -%>
  belongs_to :<%= attribute.name %><%= ', polymorphic: true' if attribute.polymorphic? %>
<% end -%>

  # Association through macros

  # Validation macros

  # Callbacks

  # Other

  private

end
<% end -%>