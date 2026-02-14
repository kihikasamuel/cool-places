defmodule CoolPlacesWeb.CTALive.TermsOfService do
  use CoolPlacesWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Terms of Service")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="bg-white min-h-screen">
      <!-- Header -->
      <section class="relative py-20 px-4 overflow-hidden border-b border-slate-50">
        <div class="max-w-4xl mx-auto text-center relative z-10">
          <h2 class="text-cool-blue font-black uppercase tracking-[0.2em] text-sm mb-4">Legal</h2>
          <h1 class="text-5xl md:text-6xl font-black text-slate-900 mb-6 tracking-tighter">
            Terms of Service
          </h1>
          <p class="text-slate-500 font-medium">Last Updated: February 14, 2026</p>
        </div>
      </section>
      
    <!-- Content -->
      <section class="py-20 max-w-4xl mx-auto px-6 md:px-4">
        <div class="prose prose-slate prose-lg max-w-none">
          <p class="lead text-xl text-slate-600 mb-12">
            Welcome to CoolPlaces. By using our services, you agree to the following terms and conditions. Please read them carefully.
          </p>

          <div class="space-y-16">
            <div class="section">
              <h3 class="text-2xl font-bold text-slate-900 mb-4">1. Acceptance of Terms</h3>
              <p class="text-slate-600 leading-relaxed">
                By accessing or using CoolPlaces, you agree to be bound by these Terms of Service and all applicable laws and regulations. If you do not agree with any of these terms, you are prohibited from using or accessing this site.
              </p>
            </div>

            <div class="section">
              <h3 class="text-2xl font-bold text-slate-900 mb-4">2. Use License</h3>
              <p class="text-slate-600 leading-relaxed mb-4">
                Permission is granted to temporarily download one copy of the materials on CoolPlaces for personal, non-commercial transitory viewing only.
              </p>
              <p class="text-slate-600 leading-relaxed">
                This is the grant of a license, not a transfer of title, and under this license you may not:
              </p>
              <ul class="list-disc pl-6 text-slate-600 space-y-2 mt-4">
                <li>Modify or copy the materials.</li>
                <li>Use the materials for any commercial purpose.</li>
                <li>Attempt to decompile or reverse engineer any software on the website.</li>
                <li>Remove any copyright or other proprietary notations.</li>
              </ul>
            </div>

            <div class="section">
              <h3 class="text-2xl font-bold text-slate-900 mb-4">3. User Responsibilities</h3>
              <p class="text-slate-600 leading-relaxed">
                Users are responsible for maintaining the confidentiality of their accounts and passwords. You agree to notify us immediately of any unauthorized use of your account.
              </p>
            </div>

            <div class="section">
              <h3 class="text-2xl font-bold text-slate-900 mb-4">4. Intellectual Property</h3>
              <p class="text-slate-600 leading-relaxed">
                The content, organization, graphics, design, and other matters related to the Service are protected under applicable copyrights and other proprietary laws. The copying, redistribution, or publication by you of any such matters or any part of the Service is strictly prohibited.
              </p>
            </div>

            <div class="section">
              <h3 class="text-2xl font-bold text-slate-900 mb-4">5. Limitation of Liability</h3>
              <p class="text-slate-600 leading-relaxed">
                CoolPlaces shall not be held liable for any damages arising out of the use or inability to use the materials on our website, even if we have been notified of the possibility of such damage.
              </p>
            </div>

            <div class="section border-t border-slate-100 pt-16">
              <h3 class="text-2xl font-bold text-slate-900 mb-4">Governing Law</h3>
              <p class="text-slate-600 leading-relaxed">
                These terms and conditions are governed by and construed in accordance with the laws of the jurisdiction in which CoolPlaces operates, and you irrevocably submit to the exclusive jurisdiction of the courts in that location.
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
    """
  end
end
