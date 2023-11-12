import { fileURLToPath, URL } from "node:url";
import { VitePWA } from "vite-plugin-pwa";
import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    vue(),
    // VitePWA({
    //   mode: "development",
    //   base: "/",
    //   // srcDir: "src",
    //   registerType: "autoUpdate",
    //   includeAssets: ["favicon.svg", "robots.txt"],
    //   // strategies: "injectManifest",
    //   devOptions: {
    //     enabled: true,
    //   },
    //   injectRegister: "auto",
    //   manifest: {
    //       //Manifest file similar to that given at the start of this blog
    //     name: "TimeManager",
    //     short_name: "TimeManager",
    //     description: "TimeManager",
    //     theme_color: "#ffffff",
    //     icons: [
    //       {
    //         src: "pwa-192x192.png",
    //         sizes: "192x192",
    //         type: "image/png",
    //       },
    //       {
    //         src: "pwa-512x512.png",
    //         sizes: "512x512",
    //         type: "image/png",
    //       },
    //       {
    //         src: "pwa-512x512.png",
    //         sizes: "512x512",
    //         type: "image/png",
    //         purpose: "any maskable",
    //       },
    //     ],
    //   },
    //   workbox: {
    //     // Cleans up outdated caches during the service worker's activation.
    //     cleanupOutdatedCaches: false,
    //     // Automatically activates the new service worker when it is updated.
    //     skipWaiting: true,
    //     // Allows the service worker to immediately take control of all pages under its scope.
    //     clientsClaim: true,
    //     runtimeCaching: [
    //       {
    //         // Caches Google Fonts with a Cache First strategy.
    //         urlPattern: new RegExp(
    //           "^https://fonts.(?:googleapis|gstatic).com/(.*)"
    //         ),
    //         handler: "CacheFirst",
    //         options: {
    //           cacheName: "google-fonts",
    //           expiration: {
    //             maxEntries: 30,
    //           },
    //           cacheableResponse: {
    //             statuses: [0, 200],
    //           },
    //         },
    //       },
    //       {
    //         // Caches images with a Cache First strategy.
    //         urlPattern: /\.(?:png|gif|jpg|jpeg|svg)$/,
    //         handler: "CacheFirst",
    //         options: {
    //           cacheName: "images",
    //           expiration: {
    //             maxEntries: 60,
    //           },
    //         },
    //       },
    //       {
    //         // Serves static resources from cache with a Stale While Revalidate strategy.
    //         urlPattern: /\.(?:js|css)$/,
    //         handler: "StaleWhileRevalidate",
    //         options: {
    //           cacheName: "static-resources",
    //           expiration: {
    //             maxEntries: 60,
    //           },
    //         },
    //       },
    //       {
    //         // Fetches API data from network first and caches subsequent responses with Network First strategy.
    //         urlPattern: new RegExp(
    //           "^http://localhost:4000/api/workingtimes/1"
    //         ),
    //         handler: "NetworkFirst",
    //         options: {
    //           cacheName: "api",
    //           expiration: {
    //             maxEntries: 60,
    //           },
    //           cacheableResponse: {
    //             statuses: [0, 200],
    //           },
    //         },
    //       },
    //     ],
    //   },
    // }),
  ],
  // resolve: {
  //   alias: {
  //     "@": fileURLToPath(new URL("./src", import.meta.url)),
  //   },
  // },
});