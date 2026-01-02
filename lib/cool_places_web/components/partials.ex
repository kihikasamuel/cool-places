defmodule CoolPlacesWeb.Partials do
  use CoolPlacesWeb, :html

  embed_templates "partials/*"

  @doc """
  Check if current user is set
  """
  def is_logged_in?(nil), do: false
  def is_logged_in?(current_user) when is_map(current_user), do: true

  @doc """
  Checks if a user has set an avatar
  """
  def is_avatar_set?(nil), do: false
  def is_avatar_set?(%{avatar_url: nil} = _current_user), do: false

  def is_avatar_set?(%{avatar_url: avatar_url} = _current_user) when not is_nil(avatar_url),
    do: true
end
