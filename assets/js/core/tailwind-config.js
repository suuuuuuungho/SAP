// Shared Tailwind CDN config. Load AFTER the Tailwind CDN <script> tag on every page.
// "Luminous Glass" design tokens (glassmorphic, high-contrast, pink/purple/coral palette).
// Font stays Pretendard per user preference — Inter from the source spec is not used.
tailwind.config = {
  theme: {
    extend: {
      colors: {
        surface: '#fcf9f8',
        'surface-dim': '#dcd9d9',
        'surface-bright': '#fcf9f8',
        'surface-lowest': '#ffffff',
        'surface-low': '#f6f3f2',
        'surface-container': '#f0eded',
        'surface-high': '#eae7e7',
        'surface-highest': '#e5e2e1',
        'surface-variant': '#e5e2e1',
        'on-surface': '#1c1b1b',
        'on-surface-variant': '#594046',
        'inverse-surface': '#313030',
        'inverse-on-surface': '#f3f0ef',
        outline: '#8d6f76',
        'outline-variant': '#e0bec5',
        'surface-tint': '#b9045e',
        primary: '#b9045e',
        'on-primary': '#ffffff',
        'primary-container': '#ff4b91',
        'on-primary-container': '#5a002a',
        'inverse-primary': '#ffb1c6',
        secondary: '#6e4f9c',
        'on-secondary': '#ffffff',
        'secondary-container': '#cca9fe',
        'on-secondary-container': '#583985',
        tertiary: '#aa3524',
        'on-tertiary': '#ffffff',
        'tertiary-container': '#ee6650',
        'on-tertiary-container': '#5b0400',
        quaternary: '#146b3a',
        'on-quaternary': '#ffffff',
        'quaternary-container': '#4fd18b',
        'on-quaternary-container': '#003919',
        error: '#ba1a1a',
        'on-error': '#ffffff',
        'error-container': '#ffdad6',
        'on-error-container': '#93000a',
        background: '#fcf9f8',
        'on-background': '#1c1b1b'
      },
      borderRadius: {
        sm: '0.5rem',
        DEFAULT: '1rem',
        md: '1.5rem',
        lg: '2rem',
        xl: '3rem'
      },
      fontFamily: {
        sans: ['Pretendard', 'ui-sans-serif', 'system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Roboto', 'Helvetica Neue', 'Arial', 'sans-serif']
      }
    }
  }
};
