# Use official Nginx image
FROM nginx:stable-alpine

# Remove the default nginx static content
RUN rm -rf /usr/share/nginx/html/*

# Copy your site files into the html directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx (default command in image)
