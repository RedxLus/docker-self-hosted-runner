FROM redxlus/docker-self-hosted-runner:latest-selenium-chrome

# Install Google Chrome
RUN curl -sS https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - &&\
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update && apt-get install -yqq google-chrome-stable

# Install Chromedriver
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip && unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/ && rm /tmp/chromedriver.zip

# Set display port to avoid crash
ENV DISPLAY=:99

# Install Selenium
RUN pip3 install selenium
