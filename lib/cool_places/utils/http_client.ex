defmodule CoolPlaces.Utils.HTTPClient do
  @type method :: :get | :post | :put | :patch | :delete | String.t()

  @callback get(
              url :: String.t(),
              body :: String.t() | nil,
              headers :: list(),
              options :: Keyword.t() | []
            ) ::
              {:ok, body :: String.t()} | {:error, reason :: any}
  @callback post(
              url :: String.t(),
              body :: String.t(),
              headers :: list() | [],
              options :: Keyword.t() | []
            ) ::
              {:ok, body :: String.t()} | {:error, reason :: any}

  @callback request(
              method :: atom(),
              url :: String.t(),
              body :: String.t() | nil,
              headers :: list() | [],
              options :: Keyword.t()
            ) ::
              {:ok, body :: String.t()} | {:error, reason :: any()}

  @callback process_reponse(response :: any()) ::
              {:ok, body :: String.t()} | {:error, reason :: any()}

  @optional_callbacks [process_reponse: 1, get: 4, post: 4]

  require Logger

  defmacro __using__(_opts) do
    quote do
      @behaviour CoolPlaces.Utils.HTTPClient
      require Logger
      import CoolPlaces.Utils.HTTPClient, only: [process_reponse: 1]

      @impl true
      def request(method, url, body, headers, options) do
        default = [
          http_client: CoolPlaces.Utils.HTTPClient.Finch
        ]

        config = Application.get_env(:cool_places, __MODULE__)
        config = Keyword.merge(default, config)

        :timer.tc(fn ->
          http_client = Keyword.get(config, :http_client)

          method
          |> http_client.request(url, body, headers, options)
          |> process_reponse()
        end)
        |> show_timer(url)

        # TODO: send logs to telemetry
      end

      defp show_timer({time, response}, url) do
        time =
          time
          |> Timex.Duration.from_microseconds()
          |> Timex.Format.Duration.Formatters.Humanized.format()

        Logger.info("HTTP request to #{url} took #{time}")

        response
      end

      defoverridable request: 5
    end
  end

  def process_reponse({:ok, %Finch.Response{status: 200, body: body}}) do
    Logger.info(IO.ANSI.magenta() <> "HTTP request successful |#{inspect(body, pretty: true)}|")

    with {:ok, response} <- Jason.decode(body) do
      {:ok, response}
    else
      error ->
        {:error,
         "Error decoding response. \nresponse: #{inspect(body, pretty: true)} \nerror: #{inspect(error, pretty: true)}"}
    end
  end

  def process_reponse({:ok, %Finch.Response{status: status_code, body: body}})
      when status_code in 200..209 do
    Logger.error(
      "HTTP request didn't succeed. Status code: #{status_code} and body: #{inspect(body, pretty: true)}"
    )

    {:error,
     "Error: request failed with status code #{status_code}.\nbody:#{inspect(body, pretty: true)}"}
  end

  def process_reponse({:error, %{reason: reason}}) do
    Logger.error("HTTP request failed with reason #{inspect(reason, pretty: true)}")
    {:error, reason}
  end
end
