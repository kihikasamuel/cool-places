defmodule CoolPlacesWeb.Router do
  use CoolPlacesWeb, :router

  import CoolPlacesWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CoolPlacesWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :public_facing do
    plug :put_root_layout, html: {CoolPlacesWeb.Layouts, :public}
  end

  ## information & status pages
  scope "/", CoolPlacesWeb do
    pipe_through [:browser, :public_facing]

    get "/coming/soon", PageController, :coming_soon
  end

  # Other scopes may use custom stacks.
  # scope "/api", CoolPlacesWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:cool_places, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: CoolPlacesWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication & registration routes
  scope "/", CoolPlacesWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    # ## oauth request and callback routes
    get "/auth/:provider", UserSessionController, :request
    get "/auth/:provider/callback", UserSessionController, :callback

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{CoolPlacesWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/", PlaceLive.Index, :index
      live "/users/register", UserRegistrationLive.Index, :index
      live "/users/log_in", UserLoginLive.Index, :index
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
    end

    post "/users/log_in", UserSessionController, :create
  end

  ## Authenticated users routes
  scope "/", CoolPlacesWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/log_out", UserSessionController, :delete

    live_session :require_authenticated_user,
      on_mount: [
        {CoolPlacesWeb.UserAuth, :mount_current_user},
        {CoolPlacesWeb.UserAuth, :ensure_authenticated}
      ] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new

      scope "/account" do
        live "/listing", DestinationsLive.New, :new
      end
    end
  end
end
