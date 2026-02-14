defmodule CoolPlacesWeb.CTALive.About do
  use CoolPlacesWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <!-- ABOUT US VIEW -->
    <div class="bg-white">
      <!-- Story Header -->
      <section class="relative py-24 px-4 overflow-hidden border-b border-slate-50">
        <div class="hero-blob top-0 left-0 opacity-50"></div>
        <div class="max-w-4xl mx-auto text-center relative z-10">
          <h2 class="text-cool-blue font-black uppercase tracking-[0.2em] text-sm mb-4">Our Story</h2>
          <h1 class="text-5xl md:text-7xl font-black text-slate-900 mb-8 tracking-tighter">
            Travel curated <br />for the <span class="italic text-slate-400">curious.</span>
          </h1>
          <p class="text-xl text-slate-500 leading-relaxed max-w-2xl mx-auto">
            CoolPlaces was born out of a simple frustration: the internet is full of "best of" lists that are anything but. We set out to build a platform that values quality over quantity.
          </p>
        </div>
      </section>
      
    <!-- Values Section -->
      <section class="py-24 max-w-7xl mx-auto px-4">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-16">
          <div class="space-y-4">
            <div class="w-14 h-14 bg-blue-50 text-cool-blue rounded-2xl flex items-center justify-center mb-6">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="w-7 h-7 lucide lucide-eye-icon lucide-eye"
              >
                <path d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0" /><circle
                  cx="12"
                  cy="12"
                  r="3"
                />
              </svg>
            </div>
            <h3 class="text-2xl font-bold text-slate-900">Zero Algorithms</h3>
            <p class="text-slate-500 leading-relaxed">
              We don't use bots or trends to suggest places. Every spot on CoolPlaces is hand-picked by our network of local scouts and travelers.
            </p>
          </div>
          <div class="space-y-4">
            <div class="w-14 h-14 bg-indigo-50 text-cool-indigo rounded-2xl flex items-center justify-center mb-6">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="w-7 h-7 lucide lucide-heart-icon lucide-heart"
              >
                <path d="M2 9.5a5.5 5.5 0 0 1 9.591-3.676.56.56 0 0 0 .818 0A5.49 5.49 0 0 1 22 9.5c0 2.29-1.5 4-3 5.5l-5.492 5.313a2 2 0 0 1-3 .019L5 15c-1.5-1.5-3-3.2-3-5.5" />
              </svg>
            </div>
            <h3 class="text-2xl font-bold text-slate-900">Sustainable Travel</h3>
            <p class="text-slate-500 leading-relaxed">
              We prioritize places that respect their local environment and culture, helping you travel with a smaller footprint and a bigger heart.
            </p>
          </div>
          <div class="space-y-4">
            <div class="w-14 h-14 bg-slate-50 text-slate-900 rounded-2xl flex items-center justify-center mb-6">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                stroke-width="2"
                stroke-linecap="round"
                stroke-linejoin="round"
                class="w-7 h-7 lucide lucide-users-icon lucide-users"
              >
                <path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2" /><path d="M16 3.128a4 4 0 0 1 0 7.744" /><path d="M22 21v-2a4 4 0 0 0-3-3.87" /><circle
                  cx="9"
                  cy="7"
                  r="4"
                />
              </svg>
            </div>
            <h3 class="text-2xl font-bold text-slate-900">Community Driven</h3>
            <p class="text-slate-500 leading-relaxed">
              CoolPlaces is a community of travelers who believe that the best parts of the world are meant to be shared, not gatekept.
            </p>
          </div>
        </div>
      </section>
      
    <!-- Manifesto Section -->
      <section class="py-24 bg-slate-900 text-white overflow-hidden">
        <div class="max-w-7xl mx-auto px-4 grid grid-cols-1 lg:grid-cols-2 gap-20 items-center">
          <div class="relative">
            <div class="aspect-square bg-slate-800 rounded-[3rem] overflow-hidden">
              <img
                src="https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?auto=format&fit=crop&w=1200"
                alt="Adventure"
                class="w-full h-full object-cover opacity-80"
              />
            </div>
            <div class="absolute -bottom-10 -right-10 bg-cool-blue p-12 rounded-[2rem] shadow-2xl hidden md:block">
              <p class="text-3xl font-black">2026</p>
              <p class="text-blue-100 font-bold uppercase tracking-widest text-xs">Launching Soon</p>
            </div>
          </div>
          <div class="space-y-8">
            <h2 class="text-4xl md:text-5xl font-black tracking-tight leading-tight">
              The CoolPlaces Manifesto
            </h2>
            <p class="text-lg text-slate-400 leading-relaxed">
              We believe travel is more than ticking off items on a bucket list. It’s about the smell of rain on hot pavement in a new city, the taste of a family recipe you can’t pronounce, and the feeling of being exactly where you are supposed to be.
            </p>
            <ul class="space-y-6">
              <li class="flex items-start gap-4">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  class="w-6 h-6 text-cool-blue mt-1 lucide lucide-circle-check-icon lucide-circle-check"
                >
                  <circle cx="12" cy="12" r="10" /><path d="m9 12 2 2 4-4" />
                </svg>
                <div>
                  <h4 class="font-bold text-xl">Never Average</h4>
                  <p class="text-slate-400">If it’s basic, it’s not here. We look for soul.</p>
                </div>
              </li>
              <li class="flex items-start gap-4">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  class="w-6 h-6 text-cool-blue mt-1 lucide lucide-circle-check-icon lucide-circle-check"
                >
                  <circle cx="12" cy="12" r="10" /><path d="m9 12 2 2 4-4" />
                </svg>
                <div>
                  <h4 class="font-bold text-xl">Always Local</h4>
                  <p class="text-slate-400">
                    The best guides aren't in books, they're in the coffee shops.
                  </p>
                </div>
              </li>
            </ul>
            <button
              @click="currentView = 'home'"
              class="bg-white text-slate-900 px-10 py-5 rounded-2xl font-bold hover:bg-slate-100 transition shadow-xl"
            >
              Start Exploring
            </button>
          </div>
        </div>
      </section>
      
    <!-- Team Section -->
      <section class="py-32 max-w-7xl mx-auto px-4 text-center">
        <h2 class="text-3xl font-black mb-16">The Team</h2>
        <div class="flex justify-center gap-12">
          <!-- grid grid-cols-2 md:grid-cols-4 gap-12 -->
          <div class="flex  flex-col justify-center items-center space-y-4">
            <div class="w-20 h20 aspect-square bg-slate-100 rounded-3xl overflow-hidden grayscale hover:grayscale-0 transition-all duration-500">
              <img src={~s"/images/samcodes.jpeg"} class="w-full h-full object-cover" />
            </div>
            <h4 class="font-bold text-lg">Sam Kihika</h4>
            <p class="text-slate-400 text-sm">Founding Member</p>
          </div>
        </div>
      </section>
      
    <!-- NEW: Join the Team Section -->
      <!--section class="py-32 bg-[#F8FAFC] border-t border-slate-100">
        <div class="max-w-7xl mx-auto px-4">
          <div class="text-center mb-20">
            <h2 class="text-cool-blue font-black uppercase tracking-[0.2em] text-sm mb-4">Careers</h2>
            <h3 class="text-4xl md:text-5xl font-black text-slate-900 mb-6 tracking-tight">
              Be part of the mission
            </h3>
            <p class="text-xl text-slate-500 max-w-2xl mx-auto">
              We're looking for nomadic souls, creative designers, and engineering wizards who live for the next adventure.
            </p>
          </div>

          <div class="grid grid-cols-1 lg:grid-cols-3 gap-8 mb-20">
            <div class="bg-white p-10 rounded-[2.5rem] shadow-sm border border-slate-100 flex flex-col items-center text-center group hover:shadow-xl transition-all duration-300">
              <div class="w-16 h-16 bg-blue-50 text-cool-blue rounded-full flex items-center justify-center mb-8 group-hover:scale-110 transition-transform">
                <i data-lucide="map" class="w-8 h-8"></i>
              </div>
              <h4 class="text-xl font-bold mb-4">Travel Scout</h4>
              <p class="text-slate-500 mb-6">
                Uncover hidden gems in cities around the world and verify them for our pro members.
              </p>
              <button class="text-cool-blue font-bold flex items-center gap-2 mt-auto">
                Learn More <i data-lucide="chevron-right" class="w-4 h-4"></i>
              </button>
            </div>
            <div class="bg-white p-10 rounded-[2.5rem] shadow-sm border border-slate-100 flex flex-col items-center text-center group hover:shadow-xl transition-all duration-300">
              <div class="w-16 h-16 bg-indigo-50 text-cool-indigo rounded-full flex items-center justify-center mb-8 group-hover:scale-110 transition-transform">
                <i data-lucide="code-2" class="w-8 h-8"></i>
              </div>
              <h4 class="text-xl font-bold mb-4">Product Engineer</h4>
              <p class="text-slate-500 mb-6">
                Build the tools that connect travelers to their next favorite memory using AI and modern tech.
              </p>
              <button class="text-cool-blue font-bold flex items-center gap-2 mt-auto">
                Learn More <i data-lucide="chevron-right" class="w-4 h-4"></i>
              </button>
            </div>
            <div class="bg-white p-10 rounded-[2.5rem] shadow-sm border border-slate-100 flex flex-col items-center text-center group hover:shadow-xl transition-all duration-300">
              <div class="w-16 h-16 bg-slate-100 text-slate-900 rounded-full flex items-center justify-center mb-8 group-hover:scale-110 transition-transform">
                <i data-lucide="palette" class="w-8 h-8"></i>
              </div>
              <h4 class="text-xl font-bold mb-4">Experience Designer</h4>
              <p class="text-slate-500 mb-6">
                Craft the visual stories and interfaces that make planning travel as fun as the trip itself.
              </p>
              <button class="text-cool-blue font-bold flex items-center gap-2 mt-auto">
                Learn More <i data-lucide="chevron-right" class="w-4 h-4"></i>
              </button>
            </div>
          </div>

          <div class="bg-white rounded-[3rem] p-8 md:p-16 shadow-2xl border border-slate-100 max-w-4xl mx-auto overflow-hidden relative">
            <div class="absolute top-0 right-0 w-64 h-64 bg-cool-blue opacity-[0.03] rounded-full -mr-32 -mt-32">
            </div>
            <div class="relative z-10">
              <div class="flex items-center gap-4 mb-8">
                <div class="w-12 h-12 bg-cool-blue rounded-2xl flex items-center justify-center text-white">
                  <i data-lucide="send" class="w-6 h-6"></i>
                </div>
                <h3 class="text-3xl font-black">Drop us a line</h3>
              </div>

              <div v-if="careerStatus !== 'success'" class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div class="space-y-2">
                  <label class="text-sm font-bold text-slate-400 uppercase tracking-wider px-2">
                    Full Name
                  </label>
                  <input
                    v-model="careerForm.name"
                    type="text"
                    placeholder="John Wanderlust"
                    class="w-full bg-slate-50 border border-slate-100 rounded-2xl px-6 py-4 outline-none focus:border-cool-blue transition-colors"
                  />
                </div>
                <div class="space-y-2">
                  <label class="text-sm font-bold text-slate-400 uppercase tracking-wider px-2">
                    Vibe / Role
                  </label>
                  <select
                    v-model="careerForm.role"
                    class="w-full bg-slate-50 border border-slate-100 rounded-2xl px-6 py-4 outline-none focus:border-cool-blue transition-colors appearance-none"
                  >
                    <option value="scout">Travel Scout</option>
                    <option value="engineer">Product Engineer</option>
                    <option value="designer">Experience Designer</option>
                    <option value="other">Something else</option>
                  </select>
                </div>
                <div class="md:col-span-2 space-y-2">
                  <label class="text-sm font-bold text-slate-400 uppercase tracking-wider px-2">
                    Why CoolPlaces?
                  </label>
                  <textarea
                    v-model="careerForm.message"
                    rows="3"
                    placeholder="Tell us about your most memorable travel story..."
                    class="w-full bg-slate-50 border border-slate-100 rounded-2xl px-6 py-4 outline-none focus:border-cool-blue transition-colors"
                  ></textarea>
                </div>
                <div class="md:col-span-2 pt-4">
                  <button
                    @click="applyForRole"
                    :disabled="isCareerLoading"
                    class="w-full bg-slate-900 text-white py-5 rounded-2xl font-black text-lg hover:bg-slate-800 transition flex items-center justify-center gap-2"
                  >
                    <span
                      v-if="isCareerLoading"
                      class="animate-spin rounded-full h-5 w-5 border-2 border-white border-t-transparent"
                    >
                    </span>
                    <span v-else>Send Application</span>
                  </button>
                </div>
              </div>

              <div v-else class="text-center py-12">
                <div class="w-20 h-20 bg-green-50 text-green-500 rounded-full flex items-center justify-center mx-auto mb-6">
                  <i data-lucide="check" class="w-10 h-10"></i>
                </div>
                <h4 class="text-2xl font-black mb-2">Application Received!</h4>
                <p class="text-slate-500">We'll review your vibe and get back to you soon.</p>
                <button @click="careerStatus = null" class="mt-8 text-cool-blue font-bold">
                  Submit another
                </button>
              </div>
            </div>
          </div>
        </div>
      </section -->
    </div>
    """
  end
end
