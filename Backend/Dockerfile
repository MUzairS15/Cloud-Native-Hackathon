FROM node
WORKDIR /app
COPY ["package.json", "package-lock.json", "./"]
RUN npm install
COPY . .
CMD ["node", "index.js"]
EXPOSE 8080