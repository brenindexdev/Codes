import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { VitePWA } from 'vite-plugin-pwa';

export default defineConfig({
  plugins: [
    react(),
    VitePWA({
      registerType: 'autoUpdate',
      manifest: {
        name: 'PraxisEvo | Gerenciador de rotina de exercícios',
        short_name: 'PraxisEvo',
        description: 'WebApp para gerenciar sua rotina de exercícios, treinos e progresso.',
        theme_color: '#121212',
        background_color: '#121212',
        display: 'standalone',
        orientation: 'portrait',
        icons: [
          {
            src: 'https://cdn-icons-png.flaticon.com/512/2964/2964094.png', // Ícone genérico provisório
            sizes: '512x512',
            type: 'image/png'
          }
        ]
      }
    })
  ],
});