FROM centos:7
ADD Recipe /Recipe
RUN bash -ex Recipe && yum clean all
COPY ./AppDir .
