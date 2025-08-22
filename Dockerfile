# Base image lelo (tere tech stack ke hisaab se badal lena)
FROM node:18-alpine

# App ka directory banao container ke andar
WORKDIR /app

# Pehle package files copy karo ( caching ke liye better hai)
COPY package*.json ./

# Dependencies install karo
RUN npm install

# Ab poora code copy karo
COPY . .

# Port expose karo (jo bhi port use kar raha hai app)
EXPOSE 3000

# App kaise start hogi woh command do
CMD ["npm", "start"]