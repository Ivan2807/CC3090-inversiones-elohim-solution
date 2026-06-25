FROM node:20-alpine

WORKDIR /app

RUN npm install -g pnpm

COPY package.json pnpm-lock.yaml .npmrc* ./

RUN pnpm install

COPY . .

EXPOSE 3001

CMD ["pnpm", "start", "--port", "3001", "--host", "0.0.0.0"]
