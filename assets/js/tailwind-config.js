// Shared Tailwind CDN config. Load AFTER the Tailwind CDN <script> tag on every page.
// Color tokens are canonicalized from "Web UI.txt" — keep in sync across breakpoints.
tailwind.config = {
  theme: {
    extend: {
      colors: {
        'sidebar-bg': '#f7f7f8',
        'sidebar-hover': '#e5e5e5',
        'sidebar-active': '#e5e5e5',
        'border-color': '#e5e5e5',
        'text-primary': '#111827',
        'text-secondary': '#6b7280',
        'accent': '#10a37f',
        'pink-line': '#e23d70'
      },
      fontFamily: {
        sans: ['Pretendard', 'ui-sans-serif', 'system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Roboto', 'Helvetica Neue', 'Arial', 'sans-serif']
      }
    }
  }
};
