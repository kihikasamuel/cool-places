defmodule CoolPlacesWeb.CTALive.PrivacyPolicy do
  use CoolPlacesWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Privacy Policy")}
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
            Privacy Policy
          </h1>
          <p class="text-slate-500 font-medium">Last Updated: February 14, 2026</p>
        </div>
      </section>
      
    <!-- Content -->
      <section class="py-20 max-w-4xl mx-auto px-6 md:px-4">
        <div class="prose prose-slate prose-lg max-w-none">
          <p class="lead text-xl text-slate-600 mb-12">
            At CoolPlaces, we take your privacy seriously. This policy outlines how we collect, use, and protect your personal data in accordance with global standards including GDPR and CCPA.
          </p>

          <div class="space-y-16">
            <div class="section">
              <h3 class="text-2xl font-bold text-slate-900 mb-4">1. Information We Collect</h3>
              <p class="text-slate-600 leading-relaxed mb-4">
                We collect information that you provide directly to us when you create an account, make a booking, or communicate with us.
              </p>
              <ul class="list-disc pl-6 text-slate-600 space-y-2">
                <li><strong>Identity Data:</strong> Name, username, and social media identifiers.</li>
                <li><strong>Contact Data:</strong> Email address and phone number.</li>
                <li>
                  <strong>Usage Data:</strong> Information about how you use our website and services.
                </li>
                <!--li>
                  <strong>Technical Data:</strong>
                  IP address, browser type, and location data (hashed and anonymized where possible).
                </li-->
              </ul>
            </div>

            <div class="section">
              <h3 class="text-2xl font-bold text-slate-900 mb-4">2. How We Use Your Data</h3>
              <p class="text-slate-600 leading-relaxed mb-4">
                We process your personal information for the following purposes:
              </p>
              <ul class="list-disc pl-6 text-slate-600 space-y-2">
                <li>To provide and maintain our Service.</li>
                <li>To manage your account and bookings.</li>
                <li>To comply with legal obligations.</li>
                <li>To provide personalized travel recommendations.</li>
              </ul>
            </div>

            <div class="section">
              <h3 class="text-2xl font-bold text-slate-900 mb-4">3. Data Sharing and Disclosure</h3>
              <p class="text-slate-600 leading-relaxed">
                We do not sell your personal data. We may share information with trusted third-party providers (such as hosting services or analytics partners) only to the extent necessary to provide our services.
              </p>
            </div>

            <div class="section">
              <h3 class="text-2xl font-bold text-slate-900 mb-4">4. Your Rights (GDPR & CCPA)</h3>
              <p class="text-slate-600 leading-relaxed mb-4">
                Depending on your location, you have the following rights regarding your data:
              </p>
              <ul class="list-disc pl-6 text-slate-600 space-y-2">
                <li>
                  <strong>Access:</strong> Request a copy of the personal data we hold about you.
                </li>
                <li><strong>Correction:</strong> Request that we correct inaccurate information.</li>
                <li>
                  <strong>Deletion:</strong>
                  Request that we erase your personal data ("Right to be Forgotten").
                </li>
                <li><strong>Opt-Out:</strong> Object to processing for marketing purposes.</li>
              </ul>
            </div>

            <div class="section">
              <h3 class="text-2xl font-bold text-slate-900 mb-4">5. Security and Retention</h3>
              <p class="text-slate-600 leading-relaxed">
                We implement robust security measures to protect your data. We retain personal information only for as long as necessary to fulfill the purposes outlined in this policy or as required by law.
              </p>
            </div>

            <div class="section border-t border-slate-100 pt-16">
              <h3 class="text-2xl font-bold text-slate-900 mb-4">Contact Us</h3>
              <p class="text-slate-600 leading-relaxed">
                If you have any questions about this Privacy Policy, please contact us at: <br />
                <a
                  href="mailto:privacy@coolplaces.co.ke"
                  class="text-cool-blue font-bold hover:underline"
                >
                  privacy@coolplaces.co.ke
                </a>
              </p>
            </div>
          </div>
        </div>
      </section>
    </div>
    """
  end
end
