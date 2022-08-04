# FindAPlace

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


  <div class="col-span-4 shadow-xl border-2 rounded-md text-center mr-3">
        <div id={@place.name} class="flex flex-col pb-3 p-5">
          <h3 class="text-xl"><%= @place.name%></h3>
          <p><%= @place.description%></p>
          <address><%= @place.address%></address>
          <span>Min Charges: <%= @place.cost%></span>
        </div>

        <div class="flex flex-row p-5 justify-between">
          <span><%= live_redirect "Show", to: Routes.place_show_path(@socket, :show, @place), class: "bg-blue-400 px-3 py-1 rounded" %></span>
          <span><%= live_patch "Edit", to: Routes.place_index_path(@socket, :edit, @place), class: "bg-green-400 px-3 py-1 rounded"%></span>
          <span><%= link "Delete", to: "#", phx_click: "delete", phx_value_id: @place.id, data: [confirm: "Are you sure?"], class: "bg-red-400 px-3 py-1 rounded" %></span>
        </div>
      </div>
