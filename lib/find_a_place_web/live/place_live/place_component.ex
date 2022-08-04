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
        src="https://images.unsplash.com/photo-1554995207-c18c203602cb"
        class="object-cover w-full h-56 rounded-md"
      />

      <div class="mt-2">
        <dl>
          <div>
            <dt class="sr-only">
              Price
            </dt>

            <dd class="text-sm text-gray-500">
              Kshs. <%= @place.cost %>
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

        <dl class="flex items-center mt-6 space-x-6 text-xs">
          <div class="sm:inline-flex sm:items-center sm:shrink-0">
            <svg
              class="w-4 h-4 text-indigo-700"
              xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"
            >
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 14v3m4-3v3m4-3v3M3 21h18M3 10h18M3 7l9-4 9 4M4 10h16v11H4V10z" />
            </svg>

            <div class="sm:ml-3 mt-1.5 sm:mt-0">
              <dt class="text-gray-500">
                <button to: Routes.place_show_path(@socket, :show, @place)>Show</button>
                  <!--%= live_redirect "Show", to: Routes.place_show_path(@socket, :show, @place)%-->
              </dt>
            </div>
          </div>
          <div class="sm:inline-flex sm:items-center sm:shrink-0">
            <svg
              class="w-4 h-4 text-indigo-700"
              xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor"
            >
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z" />
            </svg>

            <div class="sm:ml-3 mt-1.5 sm:mt-0">
              <dt class="text-gray-500">
                <button phx-click="delete" phx-value-id={@place.id} data={[confirm: "Are you sure?"]}>Delete</button>
              </dt>

              <dd class="font-medium">

              </dd>
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
              <dt class="text-gray-500">
                <%= if is_list(@place.likes), do: Enum.count(@place.likes), else: 0%>

              </dt>
            </div>
            <div class="sm:ml-3 mt-1.5 sm:mt-0">
              <dt class="text-gray-500">
                <button phx-click="upvote_place" phx-value-id={@place.id} phx-value-vote={1}>Upvote</button>
              </dt>
            </div>
          </div>
        </dl>
      </div>
    </a>
    """
  end
end
