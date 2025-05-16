FROM node:20.9.0
WORKDIR /app
COPY package*.json ./
RUN npm install
RUN apt update && apt install stress --yes
COPY . .
HEALTHCHECK --interval=5s --timeout=3s --retries=1 CMD ["curl", "-f", "http://localhost:3000/health"]
EXPOSE 3000
CMD ["npm", "start"]