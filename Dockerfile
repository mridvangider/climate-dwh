ARG PYTHON_VERSION=3.12.12-slim-bookworm
FROM python:${PYTHON_VERSION}

ARG DBT_VERSION=1.10.17
ARG DBT_SF_VERSION=1.10.6

RUN apt-get update && apt-get install -y --no-install-recommends git

RUN pip install --no-cache-dir dbt-core==${DBT_VERSION} dbt-snowflake==${DBT_SF_VERSION}

COPY --exclude=profiles.yml ./ /usr/app/dbt/
COPY ./profiles.yml /root/.dbt/profiles.yml

WORKDIR /usr/app/dbt
ENTRYPOINT ["dbt"]