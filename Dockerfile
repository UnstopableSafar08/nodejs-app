FROM node:20-slim

# Create non-root user
RUN useradd -m appuser

# Switch to non-root
USER appuser

WORKDIR /app

# Copy package files and install dependencies in one layer
COPY package*.json ./
RUN npm install

# Copy only necessary app files in one layer
COPY index.js ./
COPY public ./public

# Expose port and run app
EXPOSE 3000
CMD ["npm", "start"]

