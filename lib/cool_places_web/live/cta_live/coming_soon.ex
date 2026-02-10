defmodule CoolPlacesWeb.CTALive.ComingSoon do
  use CoolPlacesWeb, :live_view

  alias CoolPlaces.Newsletters

  @impl true
  def mount(_params, _session, socket) do
    chnageset = changeset(%{}) |> to_form()

    socket =
      socket
      |> assign(submitted: false, form: chnageset, subscription_error: nil)

    {:ok, socket}
  end

  @impl true
  def handle_event("join_waitlist", %{"email" => email}, socket) do
    case Newsletters.subscribe(%{"email" => email, "type" => "waitlist"}) do
      {:ok, subscription} ->
        # TODO: send to a que and then notify from queue
        {:ok, _} = Newsletters.maybe_send_subscription_email(subscription)

        {:noreply,
         socket
         |> assign(submitted: true)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
         socket
         |> assign(:error, "Email already subscribed!")
         |> assign(form: changeset |> to_form())}
    end
  end

  defp changeset(params) do
    %{}
    |> Map.put("email", Map.get(params, "email", ""))

    # |> Ecto.Changeset.validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "is not a valid email")
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="relative min-h-[calc(100vh-80px)] flex flex-col items-center justify-center px-4 overflow-hidden bg-white">
      <div class="hero-blob top-0 left-0"></div>
      <div
        class="hero-blob bottom-0 right-0"
        style="animation-delay: -12s; background: radial-gradient(circle, rgba(59, 130, 246, 0.1) 0%, rgba(99, 102, 241, 0.15) 100%);"
      >
      </div>

      <div class="max-w-3xl text-center z-10">
        <div class="inline-flex items-center space-x-2 bg-indigo-50 text-cool-indigo px-5 py-2 rounded-full text-sm font-bold mb-8">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="24"
            height="24"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
            class="w-4 h-4 lucide lucide-sparkles-icon lucide-sparkles"
          >
            <path d="M11.017 2.814a1 1 0 0 1 1.966 0l1.051 5.558a2 2 0 0 0 1.594 1.594l5.558 1.051a1 1 0 0 1 0 1.966l-5.558 1.051a2 2 0 0 0-1.594 1.594l-1.051 5.558a1 1 0 0 1-1.966 0l-1.051-5.558a2 2 0 0 0-1.594-1.594l-5.558-1.051a1 1 0 0 1 0-1.966l5.558-1.051a2 2 0 0 0 1.594-1.594z" /><path d="M20 2v4" /><path d="M22 4h-4" /><circle
              cx="4"
              cy="20"
              r="2"
            />
          </svg>
          <span>New: CoolPlaces launching next week</span>
        </div>
        <h1 class="text-6xl md:text-8xl font-black text-slate-900 mb-6 tracking-tighter leading-none">
          The world's best <br /><span class="text-cool-blue">curated.</span>
        </h1>
        <p class="text-xl text-slate-500 mb-12 max-w-xl mx-auto leading-relaxed">
          Join the top 1% of travellers on the waitlist for CoolPlaces. Unlock hidden gems, and custom AI itineraries.
        </p>

        <.simple_form
          for={assigns[:form]}
          id="waitlist-form"
          phx-submit="join_waitlist"
        >
          <div
            :if={!@submitted}
            class="flex flex-col sm:flex-row items-center gap-3 p-2 bg-slate-50 rounded-3xl border border-slate-200 max-w-lg mx-auto shadow-sm justify-between"
          >
            <input
              type="email"
              name="email"
              placeholder="Enter your email address"
              required
              class="flex-1 w-full px-6 py-4 bg-transparent border-0 active:border-0 focus:border-0 focus:ring-0 outline-none text-lg"
            />
            <button
              type="submit"
              phx-disable-with="Joining..."
              class="w-full sm:w-auto bg-slate-900 text-white px-8 py-4 rounded-2xl font-bold hover:bg-slate-800 transition-all disabled:opacity-50 flex items-center justify-center"
            >
              <%!-- <span
                v-if="isWaitlistLoading"
                class="animate-spin rounded-full h-5 w-5 border-2 border-white border-t-transparent mr-2"
              > </span> --%>
              Get Early Access
            </button>
          </div>
          <div class="flex justify-center">
            <span :if={assigns[:error]} class="text-sm text-red-500 mt-2">{assigns[:error]}</span>
          </div>
        </.simple_form>

        <div
          :if={@submitted}
          class="bg-blue-50 text-cool-blue p-8 rounded-3xl border border-blue-100 transition-all scale-110"
        >
          <svg
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
            class="w-12 h-12 mx-auto mb-4 lucide lucide-party-popper-icon lucide-party-popper"
          >
            <path d="M5.8 11.3 2 22l10.7-3.79" /><path d="M4 3h.01" /><path d="M22 8h.01" /><path d="M15 2h.01" /><path d="M22 20h.01" /><path d="m22 2-2.24.75a2.9 2.9 0 0 0-1.96 3.12c.1.86-.57 1.63-1.45 1.63h-.38c-.86 0-1.6.6-1.76 1.44L14 10" /><path d="m22 13-.82-.33c-.86-.34-1.82.2-1.98 1.11c-.11.7-.72 1.22-1.43 1.22H17" /><path d="m11 2 .33.82c.34.86-.2 1.82-1.11 1.98C9.52 4.9 9 5.52 9 6.23V7" /><path d="M11 13c1.93 1.93 2.83 4.17 2 5-.83.83-3.07-.07-5-2-1.93-1.93-2.83-4.17-2-5 .83-.83 3.07.07 5 2Z" />
          </svg>
          <h3 class="text-2xl font-bold mb-2">You're in the inner circle!</h3>
          <p class="font-medium">We'll be in touch via email soon..</p>
        </div>

        <div class="mt-20 grid grid-cols-2 md:grid-cols-3 gap-8 items-center justify-center opacity-40 max-w-2xl mx-auto">
          <div class="flex items-center justify-center gap-2 grayscale">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="w-5 h-5 lucide lucide-globe-icon lucide-globe"
            >
              <circle cx="12" cy="12" r="10" /><path d="M12 2a14.5 14.5 0 0 0 0 20 14.5 14.5 0 0 0 0-20" /><path d="M2 12h20" />
            </svg>
            <span class="font-bold">Global Guides</span>
          </div>
          <div class="flex items-center justify-center gap-2 grayscale">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="w-5 h-5 lucide lucide-zap-icon lucide-zap"
            >
              <path d="M4 14a1 1 0 0 1-.78-1.63l9.9-10.2a.5.5 0 0 1 .86.46l-1.92 6.02A1 1 0 0 0 13 10h7a1 1 0 0 1 .78 1.63l-9.9 10.2a.5.5 0 0 1-.86-.46l1.92-6.02A1 1 0 0 0 11 14z" />
            </svg>
            <span class="font-bold">AI Itinerary</span>
          </div>
          <div class="flex items-center justify-center gap-2 grayscale md:col-span-1 col-span-2">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class="w-5 h-5 lucide lucide-shield-check-icon lucide-shield-check"
            >
              <path d="M20 13c0 5-3.5 7.5-7.66 8.95a1 1 0 0 1-.67-.01C7.5 20.5 4 18 4 13V6a1 1 0 0 1 1-1c2 0 4.5-1.2 6.24-2.72a1.17 1.17 0 0 1 1.52 0C14.51 3.81 17 5 19 5a1 1 0 0 1 1 1z" /><path d="m9 12 2 2 4-4" />
            </svg>
            <span class="font-bold">Verified Places</span>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
