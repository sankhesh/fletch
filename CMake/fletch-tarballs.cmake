#+
# Adding a module, xxxx, to fletch is fairly straighforward.
#
# First, add a stanza to this file that defines:
#   xxx_version - the version of xxx that you'll be using
#   xxx_url - the url from which to download the associated tarball
#   xxx_md5 - the expected md5 checksum for the tarball.  cmake -E md5sum can
#   be used to obtain this.
#
#   At the end of the stanza for xxx, add xxx to the list
#   fletch_external_sources.
#
#   Then, in the CMake directory, add the file External_xxx.cmake, and write
#   the ExternalProject_add command that will download, configure and build
#   the package
#
#   At the end of the External_xxx file, you should set any values that would
#   be used by Findxxx() in order to find your build of XXX within the
#   fletch build directory.  You'll also need to add the appropriate
#   commands to the fletchConfig.cmake file (see existing
#   External_foo.cmake files for examples)
#-



# Boost
set(Boost_major_version 1)
set(Boost_minor_version 55)
set(Boost_patch_version 0)
set(Boost_version ${Boost_major_version}.${Boost_minor_version}.${Boost_patch_version})
set(Boost_url "http://sourceforge.net/projects/boost/files/boost/${Boost_version}/boost_${Boost_major_version}_${Boost_minor_version}_${Boost_patch_version}.tar.bz2")
set(Boost_md5 "d6eef4b4cacb2183f2bf265a5a03a354")
list(APPEND fletch_external_sources Boost)

# OpenCV
set(OpenCV_version "2.4.9")
set(OpenCV_url "http://downloads.sourceforge.net/project/opencvlibrary/opencv-unix/${OpenCV_version}/opencv-${OpenCV_version}.zip")
set(OpenCV_md5 "7f958389e71c77abdf5efe1da988b80c")

list(APPEND fletch_external_sources OpenCV)

# EIGEN
set(Eigen_version 3.2.1)
set(Eigen_url "http://bitbucket.org/eigen/eigen/get/${Eigen_version}.tar.gz")
set(Eigen_md5 "a0e0a32d62028218b1c1848ad7121476")
set(Eigen_dlname "eigen-${Eigen_version}.tar.gz")
list(APPEND fletch_external_sources Eigen)

# jom
if(WIN32)
  # this is only used by the Qt external project to speed builds
  set(jom_version 1_0_16)
  set(jom_url "http://download.qt.io/official_releases/jom/jom_${jom_version}.zip")
  set(jom_md5 "4e88c6378c039f4a2786a4e72129b6d7")
endif()

# Qt
set(Qt_release_location official_releases) # official_releases or archive
set(Qt_version_major 4)
set(Qt_version_minor 8)
set(Qt_patch_version 6)
set(Qt_version ${Qt_version_major}.${Qt_version_minor}.${Qt_patch_version})
set(Qt_url "http://download.qt-project.org/${Qt_release_location}/qt/${Qt_version_major}.${Qt_version_minor}/${Qt_version}/qt-everywhere-opensource-src-${Qt_version}.tar.gz")
set(Qt_md5 "2edbe4d6c2eff33ef91732602f3518eb")
list(APPEND fletch_external_sources Qt)

#+
# Iterate through our sources, create local filenames and set up the "ENABLE"
# options
#-
set(fletch_files )
foreach(source ${fletch_external_sources})
  # Set up the ENABLE option for the package
  option(fletch_ENABLE_${source} "Include ${source} version ${${source}_version}")
  set(${source}_file ${${source}_url})
endforeach()