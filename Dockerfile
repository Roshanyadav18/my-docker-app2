FROM node:18-alpine

WORKDIR /app

# Pehle ONLY package files copy karo
COPY package*.json ./

# Dependencies install karo (production ke liye)
RUN npm ci --only=production --silent

# Ab baaki code copy karo
COPY . .

# Port expose karo
EXPOSE 3000

# Start application
CMD ["npm", "start"]