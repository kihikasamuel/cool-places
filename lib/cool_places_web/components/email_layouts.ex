defmodule CoolPlacesWeb.EmailLayouts do
  use CoolPlacesWeb, :html

  embed_templates "layouts/email*"

  @doc """
  Renders the layout as a string for use in Swoosh.
  """
  def render(template, assigns \\ %{}) do
    assigns = Map.new(assigns)

    # Call the template function (e.g., email_confirmation/1)
    template_name = String.to_existing_atom(Path.rootname(template))
    content = apply(__MODULE__, template_name, [assigns])

    # Wrap in the main email layout
    email(Map.put(assigns, :inner_content, content))
    |> Phoenix.HTML.Safe.to_iodata()
    |> IO.iodata_to_binary()
  end
end
