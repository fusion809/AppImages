FROM centos:7
ADD https://github.com/fusion809/AppImages/raw/master/recipes/gvim-centos7/Recipe /Recipe
RUN bash -ex Recipe && yum clean all
COPY /AppDir .
COPY /AppImageAssistant .
