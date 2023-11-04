# Use an official Ruby base image
FROM ruby:3.0

# Set the working directory in the container
RUN mkdir /app
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the image
COPY Gemfile ./
#COPY Gemfile.lock ./

RUN gem install bundler -v 2.4.21 --no-document
RUN bundle config git.allow_insecure true

# Install project dependencies
RUN bundle check || bundle install

# Copy the rest of your application code into the image
ENTRYPOINT ["bundle", "exec"]