FROM public.ecr.aws/lambda/python:3.8 as base

ENV PIPENV_IGNORE_VIRTUALENVS=1
ENV VIRTUAL_ENV=/opt/venv

FROM base as dependencies

RUN python3.8 -m venv $VIRTUAL_ENV
RUN python3.8 -m pip install pipenv
COPY Pipfile Pipfile.lock ./
RUN python3.8 -m pipenv install --deploy

FROM base as runtime

COPY --from=dependencies $VIRTUAL_ENV $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
ADD hello_world/ .

# Command can be overwritten by providing a different command in the template directly.
CMD ["app.lambda_handler"]
