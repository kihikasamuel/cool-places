defmodule FindAPlaceWeb.PlaceLive.PlaceComponent do
  use FindAPlaceWeb, :live_component

  def render(assigns) do
    ~H"""
    <a
      href=""
      class="col-span-3 block p-4 m-2 rounded-lg shadow-sm shadow-indigo-100 bg-white"
    >
      <img
        alt="123 Wallaby Avenue, Park Road"
        src={Routes.static_path(@socket, "#{Enum.fetch!(@place.images, 0)|> Map.fetch!(:url)}")}
        class="object-cover w-full h-56 rounded-md"
      />

      <div class="mt-2">
        <dl>
          <div>
            <dt class="sr-only">
              Price
            </dt>

            <dd class="text-sm text-gray-500">
              Kshs. <%= Decimal.to_integer(@place.cost) %>
            </dd>
          </div>

          <div>
            <dt class="sr-only">
              Address
            </dt>

            <dd class="font-medium">
              <%= @place.address %>
            </dd>
          </div>
        </dl>

        <dl class="flex justify-between items-center mt-6 space-x-6 text-xs">
          <div class="sm:inline-flex sm:items-center sm:shrink-0">
            <div class="sm:ml-3 mt-1.5 sm:mt-0">
              <dt class="text-gray-500">
                <button data-to={Routes.place_show_path(@socket, :show, @place.id)} data-method="get">
                  <svg class="w-6 h-6 stroke-rose-600" fill="none" stroke="" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                  </svg>
                </button>
                  <!--%= live_redirect "Show", to: Routes.place_show_path(@socket, :show, @place)%-->
              </dt>
            </div>
          </div>
          <div class="sm:inline-flex sm:items-center sm:shrink-0">
            <div class="sm:ml-3 mt-1.5 sm:mt-0">
              <dt class="text-gray-500">
                <button phx-click="delete" phx-value-id={@place.id} data={[confirm: "Are you sure?"]}, disabled>
                  <svg class="w-6 h-6" fill="none" stroke="gray" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path>
                  </svg>
                </button>
              </dt>
            </div>
          </div>
          <div class="sm:inline-flex sm:items-center sm:shrink-0">
            <!--svg
              class="w-4 h-4 text-indigo-700"
              xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"
            >
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 14v3m4-3v3m4-3v3M3 21h18M3 10h18M3 7l9-4 9 4M4 10h16v11H4V10z" />
            </svg-->
            <div class="sm:ml-3 mt-1.5 sm:mt-0">
              <dt class="text-sm font-bold">
                <%= if is_list(@place.likes), do: Enum.count(@place.likes), else: 0%>
              </dt>
            </div>
            <div class="sm:ml-3 mt-1.5 sm:mt-0">
              <dt class="text-gray-500">
                <button phx-click="like_place" phx-value-id={@place.id} phx-value-vote={1}>
                  <svg class="w-6 h-6" fill="violet" stroke="red" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
                  </svg>
                </button>
              </dt>
            </div>
          </div>
        </dl>
      </div>
    </a>
    """
  end
end
