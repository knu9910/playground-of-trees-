import type { NextConfig } from 'next';

const nextConfig: NextConfig = {
  /* config options here */
  images: {
    formats: ['image/avif', 'image/webp'],
    remotePatterns: [
      { protocol: 'https', hostname: '**' },
      { protocol: 'http', hostname: '**' },
    ],
    unoptimized: true,
  },
  experimental: {
    reactCompiler: true,
  },
  output: 'standalone',
  // async rewrites() {
  //   return {
  //     beforeFiles: [
  //       {
  //         source: '/:path*',
  //         has: [
  //           {
  //             type: 'host',
  //             value: process.env.NODE_ENV === 'development' ? 'admin.localhost' : 'admin.gumiucc.com',
  //           },
  //         ],
  //         destination: '/admin/:path*',
  //       },
  //     ],
  //   };
  // },
};

export default nextConfig;
