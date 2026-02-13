defmodule CoolPlacesWeb.Plugs.TrackVisitor do
  import Plug.Conn
  alias CoolPlaces.Visitors
  require Logger
  def init(opts), do: opts

  def call(conn, _opts) do
    if track?(conn) do
      Logger.info("CONN: #{inspect(conn, pretty: true)}")
      # Run tracking in a Task to avoid blocking the request
      ip = get_ip(conn)
      user_agent = get_user_agent(conn)

      Task.start(fn ->
        Visitors.track_visitor(ip, user_agent)
      end)

      put_session(conn, :visitor_tracked, true)
    else
      conn
    end
  end

  defp track?(conn) do
    # Only track if not already tracked in this session
    # and if it's a GET request (to avoid tracking every POST/API call if not needed)
    is_nil(get_session(conn, :visitor_tracked)) and conn.method == "GET"
  end

  defp get_ip(conn) do
    conn.remote_ip
    |> Tuple.to_list()
    |> Enum.join(".")
  end

  defp get_user_agent(conn) do
    case get_req_header(conn, "user-agent") do
      [ua | _] -> ua
      _ -> nil
    end
  end
end
