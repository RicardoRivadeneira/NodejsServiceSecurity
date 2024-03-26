const express = require('express');
const app = express();
const PORT = 3000;

const ipRequestCount = {};

app.use((req, res, next) => {
    console.log(`Solicitud recibida en: ${req.url}`);

    const clientIP = req.ip;
    ipRequestCount[clientIP] = (ipRequestCount[clientIP] || 0) + 1;

    const threshold = 100;
    const windowMs = 60 * 1000;

    if (ipRequestCount[clientIP] > threshold) {
        console.log(`Ataque DDoS detectado desde la dirección IP: ${clientIP}`);
        return res.status(429).send('Demasiadas solicitudes. Por favor, inténtelo más tarde.');
    }

    setTimeout(() => {
        delete ipRequestCount[clientIP];
    }, windowMs);

    next();
});

app.get('/', (req, res) => {
     res.send(`
        <!DOCTYPE html>
        <html lang="es">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Interfaz Chevere</title>
            <style>
                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    background-color: #f8f9fa;
                    margin: 0;
                    padding: 0;
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    height: 100vh;
                }
                .container {
                    text-align: center;
                }
                h1 {
                    color: #343a40;
                    font-size: 3rem;
                    margin-bottom: 20px;
                }
                p {
                    color: #6c757d;
                    font-size: 1.2rem;
                }
            </style>
        </head>
        <body>
            <div class="container">
                <h1>¡Hola mundo!</h1>
                <p>¡Bienvenido a la Interfaz Chevere!</p>
            </div>
        </body>
        </html>
    `);
});

app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).send('Hubo un error en el servidor.');
});

app.listen(PORT, () => {
    console.log(`El servidor está escuchando en el puerto ${PORT}`);
});
