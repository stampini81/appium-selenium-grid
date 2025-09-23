FROM ruby:3.3

WORKDIR /tests

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD ["ruby", "calculator_test.rb"]
