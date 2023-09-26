// const express = require('express');
// const { createProxyMiddleware } = require('http-proxy-middleware');

// const app = express();
// const port = 3000;

// // Create a generic proxy instance
// const proxy = createProxyMiddleware({
//     target: 'https://example.com',  // Default target (will be overridden dynamically)
//     changeOrigin: true,
//     on: {
//         proxyReq: (proxyReq, req, res) => {
//             // Log the request information
//             console.log('request')
//         },
//         proxyRes: (proxyRes, req, res) => {
//             // Log the response information
//             console.log("response")
//         },
//         error: (err, req, res) => {
//             /* handle error */
//             console.log('error')
//         },
//         onProxyReqWs: (proxyReq, req, socket, options, head) => {
//             console.log('wired')
//         }
//     }
// });

// // Use the proxy for all requests
// app.use('/', async (req, res, next) => {
//     // Override the target with the requested URL
//     proxy.target = req.protocol + '://' + req.get('host');
//     if (proxy.target === 'http://gateway.icloud.com') {
//         return
//     }
//     console.log(proxy.target)
//     proxy(req, res, next);
// });

// app.listen(port, () => {
//     console.log(`Proxy server listening at http://localhost:${port}`);
// });








// import http from 'http'
// import httpProxy from 'http-proxy'
// import url from 'url'

// const proxy = httpProxy.createProxyServer();

// const server = http.createServer((req, res) => {
//     const targetUrl = 'https://' + req.url;
//     console.log(req)
//     const target = url.parse(targetUrl);
//     console.log(targetUrl)
//     console.log(target)

//     // Proxy the request to the target URL
//     proxy.web(req, res, { target: targetUrl });

//     // Intercept responses and log information
//     proxy.on('proxyRes', (proxyRes) => {
//         console.log('Received response from', target.host);
//         console.log('Response status code:', proxyRes.statusCode);

//         // Log any additional information about the response headers if needed
//         console.log('Response headers:', proxyRes.headers);
//     });
// });

// server.listen(3000, () => {
//     console.log('Proxy server listening on port 3000');
// });





// const express = require('express');
// const { createProxyMiddleware } = require('http-proxy-middleware');

// const app = express();

// // app.use('*', (req, res, next) => {
// //     // Intercept requests and log information
// //     console.log('Received request for', req.originalUrl);
// //     next();
// // });

// app.use('*', createProxyMiddleware({
//     target: (req) => {
//         // Construct the target URL using the original request URL
//         const targetUrl = req.protocol + '://' + req.headers.host + req.originalUrl;
//         return targetUrl;
//     },
//     changeOrigin: true,
//     on: {
//         proxyRes: (proxyRes, req) => {
//             console.log('Received response from', req.originalUrl);
//             console.log('Response status code:', proxyRes.statusCode);
//         },
//         proxyReq: (proxyReq, req, res) => {
//             // Log the request information
//             console.log('request')
//         },
//     }
// }));

// const PORT = 3000;
// app.listen(PORT, () => {
//     console.log(`Proxy server listening on port ${PORT}`);
// });







// let http = require('http')
// let httpProxy = require('http-proxy');

// let proxy = httpProxy.createProxyServer({ target: 'http://localhost:9000', selfHandleResponse: true }).listen(3000);

// proxy.on('proxyReq', function (proxyRes, req, res) {
//     console.log('request')
// });

// proxy.on('proxyRes', function (proxyRes, req, res) {
//     console.log('response')
//     console.log(proxyRes.headers)
// });

// http.createServer(function (req, res) {
//     res.writeHead(200, { 'Content-Type': 'text/plain' });
//     res.write('request successfully proxied!' + '\n' + JSON.stringify(req.headers, true, 2));
//     res.end();
// }).listen(9000);












const http = require('http');
const httpProxy = require('http-proxy');

const targetServer = 'http://www.google.com';

const proxy = httpProxy.createProxyServer({});

const server = http.createServer((req, res) => {
  // Handle CORS preflight requests
  if (req.method === 'OPTIONS') {
    res.writeHead(200, {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE',
      'Access-Control-Allow-Headers': 'Content-Type',
    });
    res.end();
    return;
  }

  // Proxy request to the target server
  proxy.web(req, res, { target: targetServer });

  // Intercept response
  proxy.on('proxyRes', (proxyRes, req, res) => {
    // Log response information
    console.log('Response status code:', proxyRes.statusCode);

    // Log response headers
    console.log('Response headers:', JSON.stringify(proxyRes.headers, null, 2));

    let responseData = '';
    proxyRes.on('data', (chunk) => {
      responseData += chunk;
    });

    proxyRes.on('end', () => {
      // Log response data
      console.log('Response data:', responseData);

      // Set CORS headers for the client
      res.setHeader('Access-Control-Allow-Origin', '*');

      // Forward the response to the original client
      res.write(responseData);
      res.end();
    });
  });
});

server.listen(3000, () => {
  console.log('Proxy server listening on port 3000');
});