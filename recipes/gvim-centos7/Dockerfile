FROM centos:7
ADD https://github.com/fusion809/AppImages/raw/master/recipes/geany-centos7/Recipe /Recipe
RUN bash -ex Recipe && yum clean all && rm -rf /dependencies && rm -rf /out && rm -rf /AppImage* && rm -rf /AppDir
