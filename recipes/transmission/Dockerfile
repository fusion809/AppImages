FROM centos:7
ADD https://github.com/fusion809/AppImages/raw/master/recipes/transmission/Recipe /Recipe
RUN bash -ex Recipe && yum clean all
COPY /AppDir .
