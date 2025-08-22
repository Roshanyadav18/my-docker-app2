# Use official nginx image
FROM nginx:alpine

# Copy HTML file to Nginx default location
COPY app/index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
