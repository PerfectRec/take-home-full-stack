module.exports = {
  eslint: {
    dirs: ['src', 'tests'],
  },
  async redirects() {
    return []
  },
  async headers() {
    return [
      {
        source: '/images/:slug*', // recursive match
        headers: [
          {
            key: 'Cache-Control',
            value: 'public, max-age=86400, must-revalidate', // 1 day cache
          },
        ],
      },
    ]
  }
}
