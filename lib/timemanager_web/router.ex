defmodule TimemanagerWeb.Router do

  use TimemanagerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TimemanagerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug Timemanager.PlugAuthenticate
  end

  scope "/api", TimemanagerWeb do
    pipe_through :api
    post "/users/sign_in", UserController, :sign_in
    post "/users", UserController, :create
  end


  scope "/api", TimemanagerWeb do
    pipe_through [:api, :authenticated]

    resources "/users", UserController
    get "/users/current", UserController, :current

    resources "/clocks", ClockController, except: [:create, :show]
    post "/clocks/:userID", ClockController, :create
    get "/clocks/:userID", ClockController, :show

    resources "/workingtimes", WorkingtimeController, except: [:create, :show, :update]
    post "/workingtimes/:userID", WorkingtimeController, :create
    get "/workingtimes/:userID", WorkingtimeController, :show
    get "/workingtimes/:userID/:id", WorkingtimeController, :showbyid
    put "/workingtimes/:id", WorkingtimeController, :update

    resources "/roles", RoleController

    resources "/teams", TeamController





  end

  # Other scopes may use custom stacks.
  # scope "/api", TimemanagerWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:timemanager, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: TimemanagerWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
