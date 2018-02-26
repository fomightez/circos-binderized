FROM rocker/binder:3.4.2

# Copy repo into ${HOME}, make user own $HOME
USER root
COPY . ${HOME}
RUN chown -R ${NB_USER} ${HOME}
USER ${NB_USER}

# Trying to add circos, and the important dependencies
ENV version 0.69-6

ADD http://circos.ca/distribution/circos-${version}.tgz /tmp/

RUN     cd /opt/ \
        && tar xzvf /tmp/circos-${version}.tgz \
        && mv circos-${version} circos \
        && apk add --update --no-cache perl gd jpeg freetype \
        && apk add --update --no-cache --virtual=deps make gd-dev jpeg-dev freetype-dev apkbuild-cpan gcc  musl-dev perl-dev \
        && wget -O - http://cpanmin.us | perl - --self-upgrade  \
        && cpanm Math::Bezier Math::Round Readonly::Tiny Readonly Config::General Params::Validate Font::TTF::Font Regexp::Common Math::VecStat Text::Format SVG Clone List::MoreUtils  \
        && cpanm -force GD Number::Format \
        && cpanm Statistics::Basic Set::IntSpan \
        && cpanm -force Try::Tiny \
        && rm -rf /var/cache/apk/* /tmp/circos-${version}.tgz \
        && apk del deps
