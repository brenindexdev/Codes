/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      colors: {
        brand: {
          500: '#700ea8',
          900: '#1e3a8a'
        },
        dark: {
          900: '#121212',
          800: '#1e1e1e',
          700: '#2c2c2c'
        }
      }
    },
  },
  plugins: [],
}