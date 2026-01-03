defmodule CoolPlaces.Utils.HTTPClient do
  @callback get(url :: String.t(), headers :: list(), options :: Keyword.t()) ::
              {:ok, body :: String.t()} | {:error, reason :: any}
  @callback post(url :: String.t(), headers :: list(), body :: String.t(), options :: Keyword.t()) ::
              {:ok, body :: String.t()} | {:error, reason :: any}

  @callback request(method :: atom(), url :: String.t(), headers :: list(), body :: String.t(), options :: Keyword.t()) :: {:ok, body :: String.t()} | {:error, reason :: any()}

  @callback process_reponse(response :: any()) :: {:ok, body :: String.t()} | {:error, reason :: any()}

  @optional_callbacks [process_reponse: 1, get: 3, post: 4]

  require Logger

  def process_reponse({:ok, %Finch.Response{status: 200, body: body}}) do
    Logger.info("HTTP request successful |#{inspect(body)}|")
    {:ok, body}
  end

  def process_reponse({:ok, %Finch.Response{status: status_code, body: body}}) do
    Logger.info("HTTP request successful with status code: #{status_code} and body: #{inspect(body)}")
    {:ok, body}
  end

  def process_reponse({:error, %{reason: reason}}) do
    Logger.error("HTTP request failed with reason #{inspect(reason)}")
    {:error, reason}
  end
end
