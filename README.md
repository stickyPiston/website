# Jobbel.nl

To run locally on a server, run docker with the Dockerfile.
```bash
docker build -t jobbel.nl .
docker run -dp 3001:3001 jobbel.nl
```

To develop, install node.js and run `npm start` which will start the development environment that recompiles everything as it's being changed.