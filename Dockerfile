# Use the official Microsoft Windows Server Core image
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Set environment variables
ENV NODE_VERSION 14.17.3
ENV NPM_VERSION 6.14.13

# Install Node.js
RUN powershell -Command `
    Invoke-WebRequest https://nodejs.org/dist/v%NODE_VERSION%/node-v%NODE_VERSION%-x64.msi -OutFile nodejs.msi; `
    Start-Process msiexec.exe -ArgumentList '/i', 'nodejs.msi', '/quiet', '/norestart' -NoNewWindow -Wait; `
    Remove-Item -Force nodejs.msi; `
    npm install -g npm@%NPM_VERSION%

# Create app directory
WORKDIR /app

# Copy app files
COPY . .

# Install app dependencies
RUN npm install

# Expose the port the app runs on
EXPOSE 3000

# Start the app
CMD ["node", "index.js"]
