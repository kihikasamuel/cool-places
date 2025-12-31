defmodule CoolPlacesWeb.Partials do
  use CoolPlacesWeb, :html

  embed_templates "partials/*"

  def is_logged_in?(nil), do: false
  def is_logged_in?(current_user) when is_map(current_user), do: true
end
