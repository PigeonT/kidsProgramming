FROM ubuntu

RUN apt-get update

RUN apt-get install -y ruby-full build-essential zlib1g-dev git

RUN echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc && \
    echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc && \
    echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc && \
    . ~/.bashrc

RUN gem install jekyll bundler

RUN mkdir -p /jekyll/site

COPY Gemfile .
COPY Gemfile.lock .
COPY freelancer-theme-jekyll.gemspec .
COPY Rakefile .

RUN bundle install

EXPOSE 4000 80

WORKDIR /jekyll/site

ENTRYPOINT ["bundle", "exec", "jekyll serve --host 0.0.0.0 --watch"]
