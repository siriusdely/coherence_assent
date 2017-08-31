defmodule CoherenceOauth2.Oauth2 do
  @doc false
  defp get_config!(provider) do
    case CoherenceOauth2.config(provider) do
      nil     -> raise "No matching provider configuration available for #{provider}"
      options -> options
    end
  end

  @doc false
  def authorize_url!(provider, params \\ []) do
    config = get_config!(provider)

    OAuth2.Client.authorize_url!(client(config), params)
  end

  @doc false
  def get_token!(provider, params \\ [], headers \\ []) do
    config = get_config!(provider)

    OAuth2.Client.get_token!(client(config), params, headers)
  end

  @doc false
  def get_user!(provider, token) do
    config = get_config!(provider)
    user_uri = config[:user_uri] || raise "No :user_uri has been set for provider"

    OAuth2.Client.get!(client(config), user_uri)
  end

  @doc false
  defp client(config) do
    OAuth2.Client.new(config)
  end
end
