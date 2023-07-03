defmodule FindAPlaceWeb.PageLive do
  use FindAPlaceWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, query: "", results: %{})}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <section class="relative bg-white">
      <img
        class="absolute inset-0 object-[75%] sm:object-[25%] object-cover w-full h-screen opacity-25 sm:opacity-100"
        src={Routes.static_path(@socket, "/images/cool-places-little-governors.jpg")}
        alt="Little Governors Lounge Nature at its best"
      />
      <div class="hidden sm:block sm:inset-0 sm:absolute sm:bg-gradient-to-r sm:from-white sm:to-transparent"></div>

      <div class="relative max-w-screen-xl px-4 py-32 mx-auto lg:h-screen lg:items-center lg:flex">
        <div class="max-w-2xl sm:text-left">
          <span class="text-2xl font-extrabold sm:text-3xl">
            Find your <span class="font-extrabold text-rose-700"> next destination.</span>
          </span>

          <p class="max-w-lg mt-4 sm:leading-relaxed sm:text-xl">
            We help you find a place you should visit next.
            With a growing collection of amazing, heartwarming and scenic destinations in Kenya,
            you can be sure that you'll find the best.
          </p>

          <div class="flex flex-wrap gap-4 mt-8 text-center">

              <%= link "Let's Go", to: "/places", class: "block w-full px-12 py-3 text-sm font-medium text-white rounded shadow bg-rose-600 sm:w-auto active:bg-rose-500 hover:bg-rose-700 focus:outline-none focus:ring"%>

            <a class="block w-full px-12 py-3 text-sm font-medium bg-white rounded shadow text-rose-600 sm:w-auto hover:text-rose-700 active:text-rose-500 focus:outline-none focus:ring" href="/about">
              Learn More
            </a>
          </div>
        </div>
      </div>
    </section>
    """
  end
end
